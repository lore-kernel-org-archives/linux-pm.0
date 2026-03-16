Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F438E101
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654359; cv=none; b=lQIII/BYp1mf7/qt5iDaT5AaN/TEbu7t9+y90ecyrUrGlnOGHDu5vCbkvsK2oSwIu//zUlycgzkD9axt8/l8NHRXKKN0IcyoLak670lKA8wfGfWhUUKUrgJTusWskjdzmM1yVklGBLQWL5TxXIuQ8p1MMcqfp0y48F72rIIi8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654359; c=relaxed/simple;
	bh=Vpj7XblcOBfhTzLdpL+R0P+2mUUD1VQIJTUYQBBtQPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgry+yXbWN1gsTnSIR+09d3NGD8v+IwqEpzkVs97AvXtOmgVGYhb05/Y5yzT/uEc0oFnbLHcQr3bVS3vXUdhsGmq9NJsgX+ULvUDygb0LL0afj4MylXW/LCG81Qy01ikPngn0RBay+5pPreen8b84grVcvIjWuGmeDiWYLE4zww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F52FR0Eh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GcE4tAGG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F52FR0Eh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GcE4tAGG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G652Hr664264
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=; b=F52FR0EhvI080Bw6
	ZAJNJx0a8UcwiT3pF4CZaST6zvv6FC8R2WEUPwGU+gRdeFs0uVCgYR0x2hqAuiLq
	GIJPeQG7Jo58rFBq3l6pxK1KOXmL1nNKvQp2X4lK1ud+bBmUI2E1pj7K4OrxUUj8
	EreZJmGtfRbMrEwQsViN3qglzA3t43jI+pdjhZ1Y/0y4aDYlRKhDWWGw6X/9f3gL
	EImt+siXIOQQXUd0q6gCYCKY7EXGXlB2sCDkSi9xP1qBslke5TS+K6Qogxl/lb0F
	fxkLqOuUO8xl6aXBNz+gJU0vXnhRPkgLnhTM2E4mq5EuExlAd303cZSBrKJuyyj8
	uiS9pw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw043n2q8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cd7fec8d44so3137489085a.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654356; x=1774259156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=;
        b=GcE4tAGGZeIog+4coq/V6Ug4a1STpB7r7KS6ot5m/8Eskya3G+x9ed7zDcNnKGm9UU
         /dNaG54RwcqZq0SOy6LrOJXiLnUZVVjDXkzCgr//WKnJh+9IvD4QmJApxnQul/Im/oT2
         jMIhWW6qRppXxo6PYJMKg9gYTzCgJPLx7LzAHPX8xXoKQhTTPoss35OO2S7mi24xBqMg
         7tJVhbB0wFnIPIxSfpef9oQNL+8u+rK/p5nxvJxve8dG2DO8xTLpEQlDwQnBBtlGbs2V
         h1oQiDCbGK8D66RiUJmflHJmy91R9DO391hNSpD3Se0Ywm1jqeY03QEl51AR2MzB2DEj
         NDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654356; x=1774259156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aWPerG47//Rh0t217I+PdOiAOICa6opjKtGqqyPqftY=;
        b=qgTevhllSHKcxyj58ndkB8kjpEbzekCVj0O/oGApTtHOpTyO+t+LOxxkGzSL40XAAp
         vd0qDrysCJaREad5R2QVNqGT+oRKxNyubvcdzhBW7h9ZlAAymYFZIU8grGGAFWke7Yp/
         qPPUnXWZc4bZGRiggZTqziRXFZ6WFP5pOUz6RQOnRIdy1jyeUI9N5eQEb0HRnuIzmeAK
         ra/KjzYUSnjXApKM6qx2KRKPtNWISYTYQ6JFWegNeB9vQWdVIf8VEXXKNsJ2AWGpsahV
         hM+qg4i6qFQvrFStsk6ET/9hro5CMn9CFWitGxDRPfh8bWHSZZxjy4szkC373/maZ58V
         JW4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUbsH1G63qVhR1uLq6utrXPRtJyh/96NIXMEZL4H2iALfDy6EJgjz4/WpxrGQZN6dJSNLzfCWGZTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcElbqk7sEJwfy2sQRYyFLUepGmjrsKDBA/QaDZ+v7XIFRR3DJ
	jCHwN4vEhYGLGQ+9BTTM6AWbAZuykkdlA9iPn6eOkXDWnPmGtFSbbfuQh7DSd2JvORKDQNCu83Q
	OHgBjj9DEfN3W328bhHuwrZLU3UGQUEIm9k6ng+MdgZpVcKzgD9zNUWvX+2xyjw==
X-Gm-Gg: ATEYQzxNl09sFeSc1AzVlTmy85ZxBEkKB3/lXx9QrsPQi8I2rbHn4oacqWV+myX3UZX
	qy+UzSnSVkUuQEFmsixdSBv/fVBdHYvn0ODlI5nCptzw59EW9eKsItcxyGEkfNQi4QV+ACDX44w
	Bs3MPtOL8KDfKgzCveuysNyqxqgJX3s6veRfFtmH6yn0Bb5nPGKZovYrfrSw3DX9lasGvg4VOpg
	ezdJuC3mqziQskLi7lo5YuajXtA2v8wGVWe8amkxPdB0QXokvH0iMyUivLdL34l/E7EsOgL8xk2
	O1WmiiYV9cc8Baev0IhLWfwelu2yVRwWqogGKEWmPaX3i+zs014Va07AquC5lIfi1ejrzl2dPJb
	8foFU5KyYXuillaNDrenlV/rq+frGCzYIKc8XvAEAXeXlKRxnGP2k
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1624639085a.17.1773654355854;
        Mon, 16 Mar 2026 02:45:55 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1624637685a.17.1773654355478;
        Mon, 16 Mar 2026 02:45:55 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:26 +0100
Subject: [PATCH v2 6/9] bus: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-6-de2f4b00a0e4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Vpj7XblcOBfhTzLdpL+R0P+2mUUD1VQIJTUYQBBtQPc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E/BPk3re52ZJWSY5xhnCOBbXVxjU7260Fk+
 srsoMcqMFmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfRPwAKCRAFnS7L/zaE
 w7ebD/9C5UxsVXbQ5n7GRcwj3aymQcwnmyJt5yL4Rjo3loecX6xlAIkCw6qE4wVvwlikpDiMICH
 Hlu6BqVViA68+gFZjra+HVX4cOzmIN5Etdo2UQVZnpgLkbtFl0aVyfjMXq/KEzefEF1MQ5xW+V0
 8P/5vVxEo/wTwSEUeXu91SjctdqANe9rV+yw8Y7yvO7/VxdJs97L7trXK51vWRpKzzeBGFLwgSM
 6BvxbcfOouG1wqurT5mzb8ndXlGrBBwkK3bL1VwPLaOpprLSCibrFFUHcr/Z+qWyYQOxPjfipIK
 C1PYQRPoXpfYokNYx/wtSlLunVdWAgJUBCbli+AGoHcqL+7B016/ejjMfBXYAMj3ez9oY+Nx2lX
 g63HzmI5tbWpMzltRMaOqJvZ742jn6tUPwfmbzhUwRKb/vZd2F9cQ7xcL5JS5j7QO9OXDQW7Kwb
 bm3sTzDWsRqJLEgbM2zLYkSo5Pm2sUoTFTndNwjNCY1r0+ltSAz2Lty0J+erC8vlj2FyHUIORQu
 4morlORo1RMu3RvdZ1tDEpXN4wof4XKnugvEhbsmPlsYqNKUt5XbyCFJP0/LFquiiQWRfXgPI+i
 Kzs+Uv2OCTkDZo9Oq6IwDVn/idGa4h6W7vMhuxVUixG0QCg5T46K09qvQCgBXcwz06G15PzWuDb
 Pd1gyza78ZAtsXA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX8rlwdGoXaeZs
 15RiOjvPfDo1dVDRp2cP4ZVmMfiv9fSLbKE4NRZJZzlhWRpwajLTRJk+bqZqrY4Yhj1ilRUizJw
 5OIcr58L9altus9+jant0Z3WDG8UeE/2JnQ4l35h9rp94kvLAd/5/5fMO14lbsyD1tN5RRoBRmO
 4MYnrwOy4Ef9tZ05fD4ivZokqr8Z68gbTNd4qbUlp264gA+x3TVWx7fhHmWlSNFqm9sm61E5oPd
 9TMPdaGBXuvnMmRNVe7tv4W8Nz5vKPyniUsxpcPVRGX97a+khfYdlm942/qMiCyVMCaEndkLgU5
 fIMIEUC1tgg/U+zmIyM622Vz8K9CP2z2mp4cs27vhZB5ipcpcqZY41gUR5QqyAQdY5PL3j4x0B7
 cbM3KNY1wKa9ZyKf5BjpSSsCHjfBSWSs6b1wNe61oN5tAx5aaTh75awFwSSIYqwuQEcKqGNzJGI
 noOoKUybQOErgV09Liw==
X-Proofpoint-GUID: o4D6hTCYi9jGIIaSkbx57GBXtj3TCZOQ
X-Authority-Analysis: v=2.4 cv=fLs0HJae c=1 sm=1 tr=0 ts=69b7d154 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=tMvFuq0QiVTRqkuSJkEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: o4D6hTCYi9jGIIaSkbx57GBXtj3TCZOQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 3181d8aa32a3e3ec26935afdbde1ef647f425fd5..e4b1db809187fc5f8b39e3950776df94005476ad 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -216,7 +216,7 @@ config TI_SYSC
 config TS_NBUS
 	tristate "Technologic Systems NBUS Driver"
 	depends on SOC_IMX28
-	depends on OF_GPIO && PWM
+	depends on PWM
 	help
 	  Driver for the Technologic Systems NBUS which is used to interface
 	  with the peripherals in the FPGA of the TS-4600 SoM.

-- 
2.47.3

