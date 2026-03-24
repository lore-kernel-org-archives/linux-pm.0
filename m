Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABD13DA7F5
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343075; cv=none; b=HC5lQIEbnQ8ntiCjemM9WD8UF/oZ4Le8smlQHWqrEDZBkfN9KeRGnrlfAUIVhzleBkV2MtC+2s4t6sUVZLg+mHDxDpUywAxrPT8U3ZZ7zlI1KfOqx3KODE+Gw2QzFKdGwA+xNa6g7bgFhjgZ3Z6WE54Dx4msLrTzgBdDv+ZLyC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343075; c=relaxed/simple;
	bh=jsWgh1Ti4adaFW3/HADaqw2MCIKnBpjGviAHd/Q/Jb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjSnZvp/J05cUi1b7Js5wDfD8lxf8JnKJ4/1R2V7OzCKnJDupuXZ7+PldgpPFVSMLY+7hvWNhr0tnJHbqc+giT+jPvRHj2fNdzBq3FR7ZP4TCkmIxx8okzwv8v6rCCliLU2wC2MbTiqzeKllOEQomRXa1JflVT2DJ3VjY9tFu0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eobWxcRq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pdcz4TQ2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eobWxcRq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pdcz4TQ2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O3ocxR3170682
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WPfigo46/ROFQ4N/tJ88i4ZYjoNiquVe9blKzLVTqFw=; b=eobWxcRqzLnx6L7E
	Sf1sa9GOx1ymukjiv7nmvyorMZyFEEEIWs5RIwb9MhQ6f2z/otzZBsq8jJkDb1uN
	rVybLrcZFmWgBaVQEKfGaGdmCjqIkTL/rfzcAy60xjCyyad/DpMXyVq6ZdoG+0Ia
	wEQMp0mCSpTNigow6FiwQ4SnRpux5RaoBsg3nhVrZjRIxswYoMCF30A9N/gR2UrV
	nNnicvThy2P2BYx3zvbu6YRcY63WHOOlQBb48RRhCsPT5JbQaRR0lW1OF6ZzCZE5
	rnqUWAbSs+lrAlApu0Io40IGtc6+u0BehQY9LiRi21gOw2zrXLE0Ym/0KUY5enIi
	Bxz+2Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r23wkh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 09:04:28 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5091327215dso245659401cf.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774343068; x=1774947868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WPfigo46/ROFQ4N/tJ88i4ZYjoNiquVe9blKzLVTqFw=;
        b=Pdcz4TQ2A8JQo+sQADgNLJlPzAqPdNE1x5+fvHArq4z4q3KEqF8naQR+hesVMHlhqg
         9XU7GmhdSBLMg4ISD7t1slg3D6kGELGeUpoHfC7mGjCEsh72ICQ8u/TGJ7l2gv/MWeLL
         pTACFBAAZztElujiZIwbztD0phsFJ680zXxULpg9u0xpazpokwbIOusQidvRo3Gj+9GX
         GMaXJZgDMA7jIHNTx6yJ8U4sufoaYeLhi1GOMegbgq+1MF6evk5e5kQsYw3uJwesmiGd
         rOjyeMCUn3A2TLPcNR+xqpGNL3qepEXtJrgw9uoQ7wtQp+/mYuzwvJnZnhmrFqiJSidn
         ovbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774343068; x=1774947868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WPfigo46/ROFQ4N/tJ88i4ZYjoNiquVe9blKzLVTqFw=;
        b=b93Dg1srJezGuBapzL/vUY9HZReV7/I6UPj7ZYnLigRTsyJXmqmQOn6cqws3fRlQ2E
         nm4WTPIKs/cFCZ3PEukSHo1nMa1ArMydHyYU35Q9MtuWdl+rm6hWXEnu40wIYfDtCvgk
         u2eGxeQHoT7NROHfwEMkKcTbCSx9e6gi4C/FQJlmSnwEcOfiNGQK/sC+NmlQpfIO20zr
         55G2I6NA/GPQaah8DJvXq6yw3hOFNOBVtrUcXhHtomun2eyfZ7qSKHqNeEJnq+5an2JU
         sA3o4uKG25z09I1Z6n/lPUKZABKlNtvl13pH9mfWcVP9mxQy0+YqK8NtQhDiNED9LhIa
         Iokw==
X-Forwarded-Encrypted: i=1; AJvYcCWadGmfYQ2wGPhu/1/h1l+jcxpoY3slrffSItZS29ec6rSv7arAVMFsea4bpAiv4VagQJIby+zlag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhc0rIUBH/r2/g628IrvtLOUgd45LWZBpfw667ZO71YChucEsd
	J9kD1vTijNGpKzug2lFAGotNYPtpF8gGrqtv4PJhRbEBcjoWvpWZGV6DSefXf3dO82l7bfkCA8k
	tqpxRPLOyQUi8sRUCiDXKi0pRn5RvVoCDfKHW9BNdxCC3ddVLWGNzLNgfrtCsGw==
X-Gm-Gg: ATEYQzxAO4VHaMKEZSDqNHyWCI8iQ2YLM7QoATntBrO9sBKZFFLY6DZEz5pGG/DhbsS
	7nVUe1uYamg+HPcr1MiJoRbvSXGIi8m0+rEqgztHVSoL69B8OiJh9vYqrByzqsJEjccjtiZbdfk
	wVpqTy1t7w2AczWJ346IvM8JfOu9psdlhxzeAPYb44Oq/hdLokO3jxbRsJ+RMI4M9wQUXEz6qhu
	53XvecCEes86VFXwj1t5rZbePHTR3PG7GqXYbQUBN+jSUyoHFanjDCGPlYW3XuCZAONTarOM7cQ
	gP6eMn+nQY6czoL+diFzu99MxQ66KiNzuLSsR+HyK6kXKJDCk/AzJFlQtDBKck6QSfVvvwVPia6
	lP3oS3HtU/tgaGqrtiW04FJHcB0MGUQrVlyuPX1/nF3kkaBPxg/4=
X-Received: by 2002:a05:622a:154:b0:50b:51e9:2e8b with SMTP id d75a77b69052e-50b51e9310emr133853201cf.11.1774343067825;
        Tue, 24 Mar 2026 02:04:27 -0700 (PDT)
X-Received: by 2002:a05:622a:154:b0:50b:51e9:2e8b with SMTP id d75a77b69052e-50b51e9310emr133852721cf.11.1774343067138;
        Tue, 24 Mar 2026 02:04:27 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:99ae:5c2c:ddf7:d77a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-487116c086dsm40007565e9.8.2026.03.24.02.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 02:04:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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
        Sebastian Reichel <sre@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/9] gpio: remove uneeded Kconfig dependencies on OF_GPIO
Date: Tue, 24 Mar 2026 10:04:24 +0100
Message-ID: <177434305814.8385.4412622204610388581.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c2539c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_HlkyUIfcI8kue4dcD0A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: M-gIgF0dV6DGek5FVOj57mtfqpyGBzUc
X-Proofpoint-ORIG-GUID: M-gIgF0dV6DGek5FVOj57mtfqpyGBzUc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDA3MSBTYWx0ZWRfX35CwfaeeqyHd
 etRhHbkRZWVin3COZlO2TlovslK+A/j2KxqgY0rx0kdf5lxbtlltxYXRgvpEbUzc7Djhq0aXqXP
 hz+2M78Mq1Gd3LvmwIrk3Y5RlumNERHw9nVqsM2i8mN1nRnqlbbYUU8lLb6nNTN1Jxr5IIIbFlE
 3rDy89F+jAnAwIA3edi6dVKhwYRyzVccPOVqbcLTIOy7fFfSI1I/2jYWXG6Q3yDCGHffPZ8kqmr
 LzufRhlQhVdILUzd6a8RklwIpyvaGwEAcWrBSn6adrhPKNRqQVNGv3cz1Gh1qw9yX96lsD3dAds
 Nhg8kYgYcNgx8HLH/5oZYZU1eSw85xQRaORb6p30+FiD9BW6I/Xaa4rBRbsW5qa/eHFq1GNeS6C
 Epp0PdUqRq/RSl4OG+camVpKAVvVL5d+1iGrshIElMOK4P26sTYXju36n0Ue8zuAXQXJGIN0+sE
 5rdxd8D8gZH4jTqGydQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_02,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240071


On Mon, 16 Mar 2026 10:45:20 +0100, Bartosz Golaszewski wrote:
> NOTE: Each patch in this series can be picked up independently into
> maintainer trees.
> 
> CONFIG_OF_GPIO is a switch that enables the compilation of the gpiolib-of
> module. The module itself handles GPIO lookup via the OF-node tree and
> is automatically enabled on all OF systems. It does not export any
> public symbols to drivers. There is no reason for them to select or
> depend on it in Kconfig.
> 
> [...]

Applied, thanks!

[3/9] gpio: drop unneeded Kconfig dependencies on OF_GPIO
      https://git.kernel.org/brgl/c/7803501e5754dc4b295ab22b20562e2b965358ba

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
