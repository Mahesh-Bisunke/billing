package com.SimpleProject.SpringCrud.Controller;


import com.SimpleProject.SpringCrud.Model.UserModel;
import com.SimpleProject.SpringCrud.Service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class LoginController {

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserService userService;

    // show login page
    @GetMapping("/login")
    public String showLoginPage() {
        return "login"; // JSP page
    }

    // process login
    @PostMapping("/login")
    public String loginUser(@RequestParam String username,
                            @RequestParam String password,
                            HttpSession session,
                            Model model) {

        UserModel user = userService.findByUsername(username);

        if (user != null && user.getPassword().equals(password)) {
            session.setAttribute("loggedInUser", user);
            return "redirect:/dashboard"; // after login go to dashboard
        } else {
            model.addAttribute("error", "Invalid username or password");
            return "login";
        }
    }

    // logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login?logout=true";
    }

    // show signup page
    @GetMapping("/signup")
    public String showSignupPage() {
        return "signup"; // signup.jsp
    }

    // process signup
    @PostMapping("/signup")
    public String registerUser(@RequestParam String username,
                               @RequestParam String email,
                               @RequestParam String password,
                               Model model) {

        if (userService.findByUsername(username) != null) {
            model.addAttribute("error", "Username already exists!");
            return "signup";
        }

        if (userService.findByEmail(email) != null) {
            model.addAttribute("error", "Email already registered!");
            return "signup";
        }

        UserModel newUser = new UserModel();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(passwordEncoder.encode(password)); //password encoded
        userService.registerUser(newUser);

        model.addAttribute("success", "Registration successful! Please login.");
        return "login";
    }

}

