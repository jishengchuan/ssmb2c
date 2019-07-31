import com.oaec.ssm.service.Impl.UserServiceImpl;
import com.oaec.ssm.service.UserService;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.Map;

public class HelloWorld {
    public static void main(String[] args) {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserService bean = context.getBean(UserService.class);
        Map<String, Object> map = bean.queryByTel("1122");

        System.out.println("map = " + map);
    }
}
