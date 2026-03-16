Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3A939151C
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654361; cv=none; b=C0kUyN8CXOH4/cy1mXqqV+MRc2Rp6UQ+KvezbmV7o7ZLaaBxW87tL0BYuWXYrV9vZ0LjJ5zoZxDf9mfU5UIRaEX9N/pMDyMQrQM1JTcvbFNbJCeHI8Pp7De56OtWbe2BFtsjaX731Mhj5yeRHVKHggULbThOecyrnPmjMsHJKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654361; c=relaxed/simple;
	bh=F9ytT2vvzgyeiU8WNksbCaFX6Hz61vWU6GkVZMPweL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alOYVMWnmaNUCJPZ3NZZoKaJPWV7RX6OuzPPQeoVUh/DGm+KNJ+G3MF2xjG2pLT3nELgR+rVH1cNGMiXPMYeuDR8L3r1pWrhyZ2SwNTAp48yEbeqPyB8ki+P8X5kw3qBFuRnvvB3SVkJQ6iK0FgyoiH4ctmrVOiReGdvURt5Abw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hl+Lf4vz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M93Wp13i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hl+Lf4vz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M93Wp13i"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64mLW323708
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=; b=Hl+Lf4vzQn30io76
	uYKe/wekuPGHSCD0rDQuZCjaU4RRXLKlEdbTTQyBHIVcqcX7dyBk7/HSVyrShVuR
	VpFWb9CW5spylabrF+lL1RbHl3MOTCqyRaxjBGQbOSEdN0SnwIEmh2sm5PzLsa62
	wYsvkO5v03lh9l8NjrOoLRMHnWFZtqP9u1mRYS6I32QEan4yCXrDMbYVHRcqQ/9D
	3c/4TD5TMX4Em6ADmMb0SSLht8CvklmVQKEtoKxytufUza4m0b/FKpSXKadcJUzh
	M9rDc/soWG2pmcCGTGsJbllAYOym+wWcoRi07/Ric2/y8qIrlp9fgqcU44T8B2PP
	rAd+xA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qn6gd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd84943c76so3973282585a.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654359; x=1774259159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=;
        b=M93Wp13iGsvelwKMc/qfujoHdwXW/nphRoiJOqh/X/HBVeir7t++E5F/oTUlbSVkd7
         u5CAqXzSamFq8+0bp/wEXrsQjOzTH8dDAGGeLkGUkMYz01VUqqPKGDwflJHmLyRzf9B0
         /QrSmm54+dffDPw6cTWzyYYeCsp7TqEvKVjaImGoOb/cPoW5m32Ed1lNlDs4zfJW4BCb
         jTKP3xQsurOb7Y7qL+JKoUT2tlfbW7f7suh7V136PMLe2lGSpr3wNYiI5IqDSY7fQ9G7
         s/EeF4jYDiFsTsbXwhvokZ64hKIvbI8Z2MSqvOnYN3L+S0c264n6evgU0GJwGI5P3e9N
         PzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654359; x=1774259159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y0W/aAHjyOJ2UAuyH9PergzDfCRCX5QEy6ZK0Vjabsc=;
        b=Rcm+wDCTuNE9/YOEuZx29y4atSY5vmjkFYzVewOhH2026D4bhHc4o16KT36wZmTnq/
         118McHRlqGp9Tfi/YhUvEfq8b1wNEMiQ0iW9Hi+FV99CklBBwNTuwggkJRrqueIokw+R
         BRpVipH9tdNJAYnZD3AdP5Hkz1lp2OvE5AotV+cGDDuyEDFCxUjCz4clZaOBysUuGc0q
         uaHbjSuhLbO1DlH6PtPTatX3k8TLuo2beNwHboBce9ZgGb6BrSgl68Q7wagvxLgaX2g7
         +nYOFQ8wq+AKycsHPZcoSiogFWw1vNdCavrpmckc+dhlnz9yNDXM9WoAZ7LqtUlsrDp2
         QLfA==
X-Forwarded-Encrypted: i=1; AJvYcCWbhOc1lofx9oyvKPfT+tcpPu736TLC7gos5S7vPSLiQaEFb+7+EKQrHSjleCgbmicmnXT5w0cfzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyU3WjFYinSE6LzrtBnvfqqDyCA/he1GNcDyuiD2JaKgy24ez
	vaT+S8jUn138MS9KOjXiXRg8qcXCVansZSfXKZhaoOPmg+URfRHvi3izJzwaLMllLH0GgcJIn63
	vbHzRd3EMfzLISNJruvilF3wFeIvcA1TfgP5GBA/aNdFn6/Y+OUVgpc2jKZItfA==
X-Gm-Gg: ATEYQzwincRZ3unUesC34odX0ms9U4tXOovAECEzHsM3MFgkbD30JU+6nFp4H5MR3Hh
	dPg3vfDrxNhn4MMAfyuWQiOgbWb5pqy7Zfhyi1r1MFyoZ94gZhr3/LCK//vv9AvttgSS1kVE1Bt
	lcO7Wd8lqmQVpjl34CEmH2qF8FPUrFA3CJiGOJ1Zpv4EtMWmifhTeLTEDCFBkuRZeec8fEpRLjt
	mLYK53/eeIq5T3Va4aDEER4m0/avYQI3VoPpti7xs6G3FpsE2ZPS963AWMqDDc2HKuDu9lj/hre
	EcZROiN7919AA0v64HmBaOCDFc9ZYVl1UshsiIvth7lsEvpZExzQig8mPbMOzvLWfIRJ7OAxUhs
	tKWL7AgniYJfK5tE1UjcpkzTXSw4C9ZJrNTHlMDTq8z+zJn0T3fjb
X-Received: by 2002:a05:620a:4414:b0:8cd:8c3f:af1 with SMTP id af79cd13be357-8cdaa77964emr1854273485a.1.1773654358722;
        Mon, 16 Mar 2026 02:45:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4414:b0:8cd:8c3f:af1 with SMTP id af79cd13be357-8cdaa77964emr1854269485a.1.1773654358246;
        Mon, 16 Mar 2026 02:45:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:27 +0100
Subject: [PATCH v2 7/9] staging: media: max96712: drop unneeded dependency
 on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-7-de2f4b00a0e4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=833;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=F9ytT2vvzgyeiU8WNksbCaFX6Hz61vWU6GkVZMPweL4=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9FArM50N/90ynxEVRSFS/NTT+j+yQ+OqAswC
 54EDd8PnAaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRQAAKCRAFnS7L/zaE
 w2ctD/9MKhohFhmRczPRr/AMx2JLdR9z7oMk+n5G8a1FtSDO5CTL607Gw7uz2zxKSciC11ogeJr
 3zFe8JsK1XRF2Nu24Z+zpR/oPpteX5Wq4AbVhT9cpLvZ0xGhjDiRzGQ+DO2Tftfq/Wx9WThBg/l
 68zbOWyVB4guzZaqOR0Wabb2NW05sEPwZKD6OafKLL16116FzD3ed/5tRszdwWGmzWghLrXyFZ3
 0fuw+qk16knXb6E7eaesQ77axJsF1A4t9mcd57UQhz8w0XqtI/A5HPeIwyh0rB1QtIEqn2HRkr+
 1X/UAyAvVzsMY6Kl+rRhcm3Iq1Br4Bo8pTWdK+O7H0GVcD07EiyubKif8CfMj23d0yW+5Gtrj84
 P3tWw046hxsNQmDgqURd+8t2r9qYc9pAPjheMlmmRat9AaWR3wQ3KHTVIRR4Z3ERwYLL8laOclW
 ldVMK5v6r4kdzJ5TjZqaIaIEkEyz1qbAaBAFLD7wdpMFowt6LxzNSYgo0Bifuv4Ig2+mx4vAIUj
 hvzS38tFSOVfpvLaY7UvDrqXefDEVp+dLdreYmr4FST6+bS0CiB1OU06jOioi2zTNZfjAN2EwgA
 UTLqBZ2xh2wNrOyFKAkzkfa/7pA7VZ8GaC3f6FI9qcfZtKSnSTO6w8LzFzW1YhHntTCAf2cf/Ql
 qVTwHDK48HzVnWQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: xntpuJwJlC7XURc-E66N7KOKCsVnx9Kt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfXxMyfeoBcilWs
 mnCAKAeT5/ur/1k5FYe1XF+kDdFo3vrRaW0hvQtdUBgQGh46fUAmBV7pzyO0NLdWk1sm37I0WAj
 1okWoUyrMNWBe0PwtXlsC8aXgKzSZHgqBuAVOLT4SZFfU06S43jZExp8XW1hbBprTLVRCtsWJIz
 Lnr4V4Qno8dF32Y8Ow7LkumSOVm4Tlnhk1nflZPLF/hsHq/f3vK+kXSqcBVilwj0ClNdOEwrL3i
 TAPnOd0crnRk+tMz0XsyvlHJZk9kWWbfA41AXCrmHFxmQ88UZ+h4syTgO9tYbJ5dbUxK/26nhyP
 Bn5nb66eMtpNncdC5Lg276zUmwiDSJyPcYGjcrTXRJUB1ZQRZJicbuloTJwDS7Xqv+DyFNAIo8R
 pFTVbMV9qXWDLANTNIuFpQ7b2E9sEevtKUmgWHUyfCnDc788J7LX6c/v85Y5KZEnXyh6jen//wF
 jY4C2kyNjUmwGjfiLPA==
X-Proofpoint-ORIG-GUID: xntpuJwJlC7XURc-E66N7KOKCsVnx9Kt
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7d157 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lbdJfbWXG8Zdtkr9XfcA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/staging/media/max96712/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/media/max96712/Kconfig b/drivers/staging/media/max96712/Kconfig
index 117fadf81bd086cc3e5e95210503000d9e4d8738..93a2d583e90ddb2b797c5167a6d3373836e88126 100644
--- a/drivers/staging/media/max96712/Kconfig
+++ b/drivers/staging/media/max96712/Kconfig
@@ -2,7 +2,6 @@
 config VIDEO_MAX96712
 	tristate "Maxim MAX96712 Quad GMSL2 Deserializer support"
 	depends on I2C
-	depends on OF_GPIO
 	depends on VIDEO_DEV
 	select V4L2_FWNODE
 	select VIDEO_V4L2_SUBDEV_API

-- 
2.47.3

