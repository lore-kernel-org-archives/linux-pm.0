Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DF390213
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654355; cv=none; b=V2+ESEcKDytiEYxGIU3cxcHtLVExZKgcEusMotDSaVCJGTGnWUZjnVfBFmUV8bF7OIQ3yaD+S9+O0D+Upi7fsYftAMW5XGEJN0+jHsEmpYi9bdB5k6UuPvbiYMrCjhweF8B6k42o6cVnSE9KD382nVFzBsEikCMTHiUZVwiiHBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654355; c=relaxed/simple;
	bh=esqrcU2iBVY8ci/hzt1UovcnezFcilbxILgA7vFytvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJQ44vLQfFdIartu86S56yxEcgy4LVsKwrTWOn8XN7091JJpcatJ5nDUob+Fc777/wAsdGR4RsVNcyOb31lnjNzlIe6HtpPyNBPyscsgRGhucdPgzWG0pY68o1/DWSjvTi64MtyV7KL0+I+OWnj9xgADFV5qM0xgMnwih+Jt0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jNm9uV8w; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Koa7Ox7T; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jNm9uV8w";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Koa7Ox7T"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64cs5323556
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=; b=jNm9uV8wa7esxl23
	r9DP5HoqaYHcDUIqlxJHYWwY1Fp3Jy6Wi0qaxhB/TZ1RCg/NH1fXtASxjZs8D0rG
	NvE6y938E9UPgqduAJ7tocNKi3+OTDm/wE+wYT6ywH5m9dgZ3srcq3I8+d64pzvU
	svwgMKlCJKEEiOJ7MxFht8CYa2STD7z2OmO1EW/RXaLq6hyxZp62tTeX8xWs1A/H
	95qD7oyG1nHjMJv+CVZmUVNW9yrEC2WGIQdE5WcX7Qze5CIaHqokyJernc4tNBmo
	w7DEh0EurOSrrjn7+E4qw8gA2PAUb1rO5HM5GEfcgqjbsTgVxYLdyeYjTXVn0VAu
	IiL0yw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw03qn6fw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd81be6f05so2754717285a.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654351; x=1774259151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=;
        b=Koa7Ox7TwZSlaIOYMAy4dR9Jw6DESTj45d6sBtCCM9o6cs8QLC4ijrBFsu1CyU+KnB
         Vgz3eiW2JrXqs/Kqi8JpX4Htwh9LCYj8gIPkU9Iy8b+9DwlXpjBpNAJPmDAJwI/bQYMZ
         FZtZ3ETiHFzM6/V7aASNcw24X54c8izsAGzdb08OvgIOa+cHBlLkUKVzn2ut023kwcM4
         CRdjHzPGP0//4JfqR5uI3kBHZ/4OBwwbDB4EcsojzMA92H4t9oZCoD3ErGL82pAyag8y
         u9M7R+WRb2970VphAwN7m4vDWJYcpJURyxx81BshwibVMDiyOi1h9zkZv8DsNgxP5XY9
         kwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654351; x=1774259151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m25Evgz+upNl8LtXZ2aO7wMuzsie8zywScFsKF98g7Q=;
        b=AI1voJlAIWGLucV2vubYeO304p2oAxziKyclmPfmidATRG8+GgSB8rL6N1cZsSKTyI
         O/n0RLHivCKTsbuE27ThVKlRvMeTicnxkus0p9cE5+iRciPY/vQzefCCC6Ha5JAb3c9X
         4239yk/NphIWTIqbB7Wc5oTBDLPgteHLiO47Cjo026nE1dBPrTSebszm9HeYnm6Bixk2
         tjjkJXhP+jLutoTNyBMcQ/JJFzpenDXBmmU0gMlfeD4gd7gvW8SFd5Lt29S7TmHB4Xy/
         dtnqyebu10Y7rf/QH9odwNiSkJyCec8RxMd1vT8LwTa2L93kS7+Vbj+gmaKMUFHv9hyh
         zRcA==
X-Forwarded-Encrypted: i=1; AJvYcCXBQaCMD+GYmTT71oHBU/OZOD2Ai0o2unMbtCH/awE8CF0X27z6T2RNCpez64YS1zzNcFJwKu8V1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywetf553lOIzcukT3pBuWq1OIeRlFnEiinD452UndEkGKtM1BYH
	ONMmBUfBdeqXYkPrYW0ohygkIELUwqMLuLTRT1spyVGI9BJ3H7/J9h+wFZY35OzkG+d6LDLgdXP
	pWwXTVzb2Uv7P5a8oD8SzXD6xnoGa+9qDldanOVD6OcEB8i4RDgkKy9zEoD8bcw==
X-Gm-Gg: ATEYQzykzRTjVO5iAVZW8V5P2DSg9NBJEAUfOlDzLqhLOtarTplIkqTaH73IsxyX276
	VDx1QRdQmzkDuJFXrBkmD9OdA5FW1UYL9nvH9DuDCqjim5r0UKCiZZOGlzgzjiUR0+Wr4FdQoXY
	hRbnJKRIXT8cfnEO/Db7jMXJ8T12cirY87iHECIK/FItU9kgdEl3oWwNXuLon82qmnjv6BB53Jw
	ZB6i9jUoIJu/5UKBBJcnJesrw2+EinIOZUzPpmye/vLFoR6JT3RdV2iI+46lqwZmP46whRJXm4A
	0vDGMxw5/6e62mq6jA0MwWOyvO17VFy91ZAgqeZnpMe+usFBunyljzaCB463h9g0LsuIgHQnyEZ
	yutGLvOvu+KBM4Q0fy5QmL/JPP2HPD61HcBwZICXr4gHCjiZI2D56
X-Received: by 2002:a05:620a:4153:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-8cdb5b2598emr1635911385a.53.1773654351023;
        Mon, 16 Mar 2026 02:45:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-8cdb5b2598emr1635907985a.53.1773654350529;
        Mon, 16 Mar 2026 02:45:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:24 +0100
Subject: [PATCH v2 4/9] leds: Kconfig: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-4-de2f4b00a0e4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=808;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=esqrcU2iBVY8ci/hzt1UovcnezFcilbxILgA7vFytvo=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E8i6aEL4piTNPBuxvNyhkggWe1e3NVYraN7
 Ks7jiQgHs+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPAAKCRAFnS7L/zaE
 w/ZAD/9owgYgilZp+MsY55UDQRktGsR/H7gu25ynf1yhU4AxMzntmbgKtI8ceNacGdL80sij1rd
 BC1afcEdcSeocPHYhV8XrTHz09iBj+gnuOx806Aztjp7T2dAIN+2iEIjUM3kaBCEgSnqgV4zQr6
 KP800070rOt+5F9egqM0Lv6yiQUDNMAn8zKj1lHgWzcRAX+/m+tJCaOTvMQ+lfYmN8RwfNOnafG
 cDonwS9X74nEm1gLh3vwBangOT0m6NA/CaV9RZH8/DXyYqAIvvCpV8Jz3U2D1pRdGxSrHe9eRup
 cbjzFzq/LgbVkxDXxoTu4i4o1iNuhn4k1/feicc2rZzuUySztakWwWWSm5acHzKR6Ptz1WMQI89
 Hai2+hXihj3LpxTO/VnuyrqwkfChDWqcIYxw3Vsn9nZdRi4NraVQGY/AjuFi4NDRw8E0I0oIZ0V
 bqrdOjurKqeApM8B3x+pdjk3MGTlDbhn/AQrLzGeiWpOHr5yNZeuN+E8BiBQFvka6LJRALRFKtN
 lpy5tTKnZuANqh+kbu8XfvN1aim+wXkG0r+mrAX66Sm6PuUCfDKrXHz5NKSMBkBfTvAtGmGzu0s
 L0qw3k6k3RvIxBjnOdCxgcNf83bKNrudGRNJ53TXD5F7++vEy53ZASRmatk5lcOn2fdcam0C7NF
 v/S76FvWP49WAfg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: VSZBktm1oQOYbJVgHr1-XRsGKKpqA9NN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX4LGyXt5cjBtO
 NUfnxWWqV3wK1TkXBLqsEkV69IPyPC9C9UYPWSBe03i5QLJ6Flglr66JED9GeBqG1Soe5H3tppI
 6OOHbyKZ67O4huKCgN2ahrrxwlOl3iUtzuEjPfVAq7L0HzbYuQ1QO/T5/op/Oo32npAVlQ+ejWt
 FaZk/gsCsIC2krwh1Cfi6ZzIbMH+dTlZHM3zwzxNtq0jSWRaktCQn7xUdgTvqRZRXi/DSRP+dwc
 N0Mi2/w+9Ka4zJd/Gx9U+uaccS6+E8yGrjncNcE0AKAloeK/EBo52bK3ywo0UTa2LJPtr4BuLMS
 657D/4up2CgVnVjBCL0vEg7NJ2wXcf9n4gmKgY3HfKy5xvBfIjhv8RGLacL3dUxelCoPudVkEMO
 CouZe+X4G893jrW3BNM4kKgYkCv/LTwC0PD6uC2u3ujlK5bV/fTfupwaoLlIht1O5Spdd+cBOi2
 EyTOn8n9ZQhrmNl2Ksw==
X-Proofpoint-ORIG-GUID: VSZBktm1oQOYbJVgHr1-XRsGKKpqA9NN
X-Authority-Analysis: v=2.4 cv=ZbQQ98VA c=1 sm=1 tr=0 ts=69b7d14f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ULgK7OEL32dECu8VbM0A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
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
 drivers/leds/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 597d7a79c988b35f304e953e873af3afe2ae04b8..f4a0a3c8c8705e0f10ba26584277dbb2d5eac5b5 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -765,7 +765,6 @@ config LEDS_NETXBIG
 	tristate "LED support for Big Network series LEDs"
 	depends on LEDS_CLASS
 	depends on MACH_KIRKWOOD || COMPILE_TEST
-	depends on OF_GPIO
 	default MACH_KIRKWOOD
 	help
 	  This option enables support for LEDs found on the LaCie 2Big

-- 
2.47.3

