package com.oaec.ssm.util;


import java.net.URLEncoder;

/**
 * 短信API发送
 * @author JiangPengFei
 * @version $Id: javaHttpNewApiDemo, v 0.1 2019/1/23 11:42 JiangPengFei Exp $$
 */
public class SmsApiHttpSendTest {

	/**
	 * 短信发送(验证码通知，会员营销)
	 * 接口文档地址：http://www.miaodiyun.com/doc/https_sms.html
	 */
	public String execute(String tel) throws Exception{
		String rod = smsCode();
		System.out.println("rod = " + rod);
		StringBuilder sb = new StringBuilder();
		sb.append("accountSid").append("=").append(Config.ACCOUNT_SID);
		sb.append("&to").append("=").append(tel);
		sb.append("&param").append("=").append(URLEncoder.encode("","UTF-8"));
		//sb.append("&templateid").append("=").append("1251");
		sb.append("&smsContent").append("=").append( URLEncoder.encode("【生川商城】您的验证码为：" + rod + "，该验证码5分钟内有效。请勿泄漏于他人。如非本人操作请忽略此短信","UTF-8"));
		String body = sb.toString() + HttpUtil.createCommonParam(Config.ACCOUNT_SID, Config.AUTH_TOKEN);
		String result = HttpUtil.post(Config.BASE_URL, body);
		System.out.println(result);
		return rod;
	}
	// 创建验证码
	public static String smsCode() {
		String random = (int) ((Math.random() * 9 + 1) * 100000) + "";
		return random;
	}

}
