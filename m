Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135A838E101
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654356; cv=none; b=uspfnk680u1ub6ZMsELQAnNmJsXQDglIgoSdzFJrr45Axx4GbG7EnC/AGBTJ+ybOquyVLCoFwGupjitwuza8GmYpcy64XscpGD2k4UJGJFddwL5HQhrFC0Y27/K4mUQpauNEd0TV1qgyT7vC/MuRuWq43YC/Mgm1bqhdirf1nfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654356; c=relaxed/simple;
	bh=zJiRRZHOn7YqYQ+LwAzSJIAhBCW3qgcwJUw7el36TcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a5GYdpGl6VSYCIS5BHdL/CLfHGKOzPXzd5cG5srNPZUxwssG/zd1258WEIoSPdilFsTgKPdsk6Rh1cGJcupJpY8uApF4uJQ3qNdlZEHEOQVlT3MDxYwxCj1t6szrC3yQWXOacONu0cePx++Qma9a/U68QBMEeBGEV0n7NX5YTG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ah6jhUXp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dIGSgYyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ah6jhUXp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dIGSgYyt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64gm12672206
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=; b=Ah6jhUXpoBakze2y
	2w8SGxWQtyIX1qayUBDXigwddz8W/9QJhjLlUh0bV3q18J80OrfPQMFWSdfoGXGK
	Qq+AVFJJUFKI/dIkiFwNpqLSh9yBZ46GlXE7CP7SeHZ2e/aLjXodfZorqDK5nRPf
	OuA85HORY8DDw3pzGERKU26bAV9rzBW8eKmq6Q8+CQMYf6KKb7KnuWRGHT6llzy0
	MRWGzlwyQbJC2SYHpN97KCRd+NgvsnIPQim1aXWSOCoqdF052iOQaMGxU4W/gpqX
	qoBAsxcuRca9afQbM32Nec2Ro1LaXlML3mqQOHfb10aznyfePYELWQ5VIGmGpaOk
	Rig9RA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03xn4ba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7c4ab845so2121296985a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654353; x=1774259153; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=;
        b=dIGSgYytIRfVS0iwzabuXeyCJKcZFtDWjdWTsb+8m+JYx9eADOaqwi8TkGo05wM77f
         Z4XX+o2kjU5ZRoovKAse93YOG/PBV7CY+Sm1YfMeD9+t4vNzCwDZDhY440pba7jYfBD3
         BNsh2WlfSO3fZfrDydTrsCLU2xeiDDLce1tGPkJl5uP+c9/cMi2QeWG0INjWnk5/2CMD
         GHFGtVvsTNZ/RUaipTc8AeEH1Bk7bm0B3yjgSKYcgGANXdjSjuTvXhbSBVLFTFAn8dN9
         954gR4WIqqY32bAiEpMDE17enOR5SMn+OafmICOIt64hPnkf5pQxRsXW/qVBat5ufxgG
         EeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654353; x=1774259153;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V77ZeRO5gkyRLxJmGfiVvPBzaaSm4qWfHkN94gbvCVQ=;
        b=sr5Yk+VeWGD5SUBPb5l1AsqxAo8cTvmQLtd4EIgRBy5imeGxnqge/LUVXG+W598Pme
         91MWp5gQNDO9WJQrNBWLzO0s8bSYJzX8DpHeGLNVp/EZ1C7eAI5b2I+lCxwg5M3dD4QD
         +uNYBpzvkXSfG5HEFjetJVuK3gItJmM+4kg1PqkWtmgxkei7a0ymuL1oYBQHsdy68MsT
         OVhm5bUxjlfFAyZBxzwoc5q8Q+6+7neGArrWstRN2mza5Xk8JfsowqJS2ygQHU1Ty4eO
         9wVvlkE4Hc9+oFoRLmF73IRJ/PLxVfxQ4IiM630BMHZ1rKtBf/8633BrdiQaMWUpISUm
         rJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWlAMniYHn+vaXpYBOb5Pyb0LVY/Ql5v1w2o3yG5uExRnQjVNKI5z+A3EZuVb5NvcxKvq4L+Dwvhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWPm17DA+AxKNhTktu1T7srhuAtfQLnjJkgodACii3b7rykkd
	slYvRWy/YOrPKpwwJxhmoGPg3dLdO0DQlPpTaXktnUAVsywL46Q4IDNZpwaZnV1HgjDL79KCzUF
	MYcK1oqmSTIpmgCahYBkgBBr0FYlMfMbnW3XHb40njRHbC+EyZHHgt7bZrM1Wyg==
X-Gm-Gg: ATEYQzwtUlfm2HXgVE5JF9VVhluvI0igQlcC8DIrKzB/XDBl5EGabk6xN2v0ovQ4jCT
	T25QtWET6fbAwPrz09KPTXhbk3VZBah1kOpLzC4UI2CxMqgoNYRF3Gt12KGtivIIDV86NvNsKrN
	3LEe6Fl+nNkHdaUvrILCdA4vGU1evin506yKqQgU19PsCZk2+4ExbNnPnYZhyfE7inAFGha62lP
	/QjsGuWrawzRzJ+iWIhmxPSZn0FDa/fxM20Aq6i3UvT2MSGYIpPeQxGMKLUVHdUz3EW2dIJUKfE
	fxbg5nKNeP40XmahU6iP5YO+a/bKLNetkN2KD9pZDdd6PMkYKNBzRCc7PD5Okhgg9dQDs9DEeNR
	PE1V7gYhj4zWqTysVK/MsJ1/psht2oU7/Wu1wJ1Esh7Kn/UZTMyPM
X-Received: by 2002:a05:620a:4044:b0:8cd:8447:2438 with SMTP id af79cd13be357-8cdb5ac4741mr1453871985a.36.1773654353312;
        Mon, 16 Mar 2026 02:45:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4044:b0:8cd:8447:2438 with SMTP id af79cd13be357-8cdb5ac4741mr1453868485a.36.1773654352832;
        Mon, 16 Mar 2026 02:45:52 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:25 +0100
Subject: [PATCH v2 5/9] watchdog: convert the Kconfig dependency on OF_GPIO
 to OF
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-5-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zJiRRZHOn7YqYQ+LwAzSJIAhBCW3qgcwJUw7el36TcQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E9Wjg25U44jwuhf3siwRv6gc1FrTGrZYCag
 DWx38GqUKiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPQAKCRAFnS7L/zaE
 w8FnEACjGpR8zaC1w1NeBaLCJvktzj4NhYyW2Td8DUd/H42BEdQFLueq4ukzXtCUXnHdHSdYlxX
 5u85kdqwdApTbieFxlcUadqplP0P27zARAEwj8BjR6bXmDtxbyL9zA5AskPF15evHuAhtsb0vLp
 rWJ/hPriZFRMOTvoiz306zGosgjHeo5b7IFdBRXQKj9pWZu9KC+6nj5Dde/Ek3mIsw7+7RlR+uL
 QLlJnoVNjOKlMMbwrMF8wLuyGxcetuCLacwTtrAUIPDb8Wvg+XSlQ61HFsVAI+6edYFrdWNBKZO
 qAuA/aWE+2oLqr2TcjOEd9gTRLahdebgddcpyr3CudMSPfCe0ZsfO7omWEYO+mh4eu4gObaIOFi
 rSbIFdwsXpTDZyGm8d1I5QasUJ3+T+m5Xxx3yz/Xnw5U+5ch1XQ2oj8rtwYXR4/xPwKE+PhAyev
 EfAmjkak0AwcGfVxvGVwN2Hsn+3MujSJYtzJKGNWR7FqZcI4vanexFwbfhQUBEab+O3yPbi9B8A
 /L20/ccFo1EBkUthx1vFD1wCRe5aIuUQ6rQ3XskhBK7QPd07CNiGavrvpP18ZsC13Tt+iPg8Gd3
 9cZ+OAZ9R7FbhBlqGEwWzhdvmPW/KCw3MbJmuyMjozO0JiauqgeMASM0B722UCBXMoO1nFINRbo
 DDxY+Xizi+tKYMw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX76LMrhvT23Oo
 he7vLb6NMDYh2XdmWHBXUpC08kLFMkSSmV2z7qaVjF4P23FR8rarwJkFdFGFwi83YjSgze+Fhrv
 Pb/0HswjBgoRTnP5zhU7Gj36ydVqKUokchq38ljfmzIcuAqnBpa2ckNAVRybtfVkbF113kxGjgH
 OFrWqufyTVjTlMVMPd5/Z1zTaPbN7KzTgx+diKIT4hvSEWez1ymchIiuh6w6tpHhxyzPWDSLKk0
 GNx/Uq4YUJ5IsEUmeQGjsLjos9GubaVsbBr10Jlzc/+ep3Cuk3BYDtECk5MTAm5qEmLwosO/mvW
 Gh5PX6B2a4Nv3Pi1B3vZDIncFKUaRf3Wc4mJf4+lge2rgor+uENdi9TkcqnCz8X0qaLGRULGIId
 Nv39EORmIFmuexag61dwkn+lF71FDZhmXnoCPaMUPaf9Q9wo7XzuO1LurB7ASJpOENlbJh7/KBM
 qdBlCg8xcK4UD6I1x+w==
X-Authority-Analysis: v=2.4 cv=YLOSCBGx c=1 sm=1 tr=0 ts=69b7d151 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=_jlGtV7tAAAA:8
 a=EUspDBNiAAAA:8 a=KiQ1yeRyPa_UOXqLYlIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=nlm17XC03S6CtCLSeiRr:22
X-Proofpoint-ORIG-GUID: BYbetA4PneKecxh1cvFVdst7xrzWJi37
X-Proofpoint-GUID: BYbetA4PneKecxh1cvFVdst7xrzWJi37
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly. We could simply remove the dependency but in order to avoid
a new symbol popping up for everyone in make config - just convert it to
requiring CONFIG_OF.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ab1d5d6df5f32f084c893a7af54d040082a3b6f3 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on OF && GPIOLIB
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device

-- 
2.47.3

