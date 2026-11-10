Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794306575;
	b=ZEzhC8ZYQCmbbHZTmqaDXPtP+oSS9ocYYzSP0jd2wV4RF1NEXEf7yVQH0R+L/rr261vW
	 vjBVCL/xo8tEIqXw9Rf4INjR/1YE1msCiHmuUpLmB03fxuZd4slLRgUCL2eemiAtciAeQ
	 HWzDTbbC0ca57VDQjV6AYNEFUQ6VL/R78VQGxu5b8JaMT4CiurFjCZejPdlJz92yyXkhT
	 jeT6nsDhX9IYuO5VZJL1zu9yXlwjCO/JRSLPMGjG/X4J1Vvg849GFZmHuIzDYr+MaWIpI
	 xaCjjTBSprSVN5Ge6XPYs6N8ray3ukIYZc3QSBVcxEG154sn4wDS2lBPu0qXbNkyC1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794306575;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
	b=ylbI9cQJtVmK6+woON7uERcZATEHQqL+0/XB2PTMZMvvG751y+Xl/dFP2onTFYmncpVV
	 KlI9Brw4DJrwqdSfwdMc/lZmVg6YgfNxBHlgx7I+7j8VPlxJJ04qxi9Yey2SVdFD7QT8Q
	 IwZ1BHGVEB2sOHK+fR/uYh6suZlAKSRRpqKDHoyUWbu7Q3QvmKQZ3oGKZBpUin4MzakY4
	 H9cBcYfFpxw6/Pp11oY+cDEO0YgQyqJrzVDhnaebxIjSBpBEq1aBrj16DbBRyGMY5U+Lr
	 VkGCePHb3cuMob3jd0aw4AbwgPBHq/6nk56lcEGf3+EzLTuQASzP58RAoyAJC78p8qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="bDueU7W/";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920A3606A326
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 920A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDueU7W/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Q+g24FZT
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7klwd2779819
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=; b=bDueU7W/JI6jwGLN
	ZOUmqB+utVWSdOUpxhz9dOE3rK7LMcX0hOIEsmN0ZZZWhHKqmBxzZZ1CNU0ltor2
	vcu9GQTbEZJXv2h2tm74wzdPrljskM2MecQnyWLKeuL1EwCbhGGp4uUaoMcKfGl0
	sP5eUDR0NNLvJa/VcMgd1RZShikqgwMRIPVjlp/eVFjf84uCnBBvnsnRfcEZ8Zbf
	22rX++tHWmyxU6PShVpwBGow3UggUQycXO5/DZxE7XAJ4fkhwGyS3uEmsDDLIGHj
	wViyKL1KC7+D+ViUb2MMKaiuGSsVyH8/STmrt4Y8EHYR3eriLYQJOq94hZOmNxUD
	oAM5GA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8mdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 10:29:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-947a607ec40so21534685a.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 02:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794306573; x=1794911373; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=Q+g24FZTmOYxIIE47+dlBYfIyC0J5BCPWmjo73l8rbJxOD+f9TRASBGPbq0Sy3YLxa
         dSVKMjaxmsF3+u94NHxhTA2ze2gbJaAgytsQfyMJYJKKobVJPP+hNt1jXw1zFxteqXOJ
         NWWgRPMO4EGXkPqkyQTTn/r4q/E+1qvEeecglRgGCQZWq3yhjfkJnnieYCdwBo2/JxoY
         FX5bezTlau+Y2qAEM/19Nw/wuTi1WkAfSIiPEwJegvOnVfdYJfXgphJiOFiOU6/xw7hI
         c1LIuP7EXx4VoDXg183hXpEnW6H8N2ce4eOk9LVRJCubz6FDjcPiljG3ibwUGwF0RbFo
         puRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794306573; x=1794911373;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dILZ68T7wp/M0o8943hftgoIWcEo2YDH5FXujf4WAwU=;
        b=fQdlM8RrTDTu6vIzshRXbsbqf5Dqpq4fmJtG4y24R3kWoodhFLeWvsVDtTME2aicig
         toLVKqUnUezCf4tMLcgVK2B79pyCo8rFML07HLaYYdbAWSaUwCOZwiH4mnjcDVvLeD6o
         /zapUgxmmIdm021IeBuLuRemXYA+8TXRMVU3fzyTCwC8aA7ECuq/h1MLo6M4y5kLSSg5
         1Hf/kKb5jrp77BZDksOa7Trs3TbINgT0vraGtvuagL5S90APNkg/6cyVy/3qvAMg5AxO
         lpXQCOfWl0Ix8fpw/xKEwnFPH1BnX8OoYMpO/9F4kXVohyxqgZKOgTsbaJVJxmAJVjOD
         +cRw==
X-Forwarded-Encrypted: i=1; AL+hErHHo23j46NJQHjJCmJ8iUewc6PKT/Ar8GcQefB/oL4yIo1vqTnssssgiReQV0rVKJmgNQ7sgOnoZQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8pNECWT8sTwBZXeuMrKKV2J+EYHLCxDTK1gDl/y4J9LJ16RCpR
	Mg212A93duUHRvWRgGwg7WTKZlg3eO23P8QnEBXustn2DWsZid0mX1rbuk9+5fnHkKNayjoUK/5
	4eDF66Zd5GK7yee50M7zzSR5iEnfVTGhhen2E5bVaPDk4q5kqUdT341VUt+FXZg==
X-Gm-Gg: AYBFou21nGa/Ym6qVfffx0khRx6IG81BCo+SsyCRN+V/ypOIieMs3OAFA9ANwq7QspP
	1Xk5b21gnd8VZXod5bwTPxpxgP5vuyolJu2qZT8cmRi6BArnWidySy2/Y63eIagQg5PsMFfQK1a
	Tj1H7JuFwfDK7/+baQ6WKO0furUbZsEKz0bjvN+TcQYHMS9qkOonaI9oMERVDt/fZ/F5AnIqgmv
	6b7l9aix2seH5FLPpNUodpkt0MFm457I7W24RQCuOf7pIwvJ8DAmuP0uFMr+g4oKKrPpjrvZh60
	wacUHQTyLKZYOdj+N6fjtC/OC6y1Pj3NWkKOFgWQOAGaYajHRaOgcAUFIMkhO5YUgdpBpNfvpqy
	f5A9Mj5NpO0PLoXoHsALYs3WNc2dyMdgeabxnzhUwyI/jT53x7xIGZGrgEIyncJiAqtT48cGCRE
	d6lWA8qfgQpcKHDpuX3+o1Fcu/TgzLLgv0ZkwqgRj++/yJLpYex5kvBdtZierrrQ==
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351213685a.29.1794306572776;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:93f:211b:a7a with SMTP id af79cd13be357-9479f2c42b0mr351210785a.29.1794306572282;
        Tue, 10 Nov 2026 02:29:32 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm54994175e9.2.2026.11.10.02.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:29:31 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: fix serdev controller reference leak
Date: Tue, 10 Nov 2026 11:29:29 +0100
Message-ID: <179430656698.56244.5559839363678053917.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-serdev-ref-leak-v1-1-e2e022ca17ec@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: f_nENQ9wCMCX0ODNSFtT4u99bQ604LX8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfX4UGVmwEbmhxA
 gmJqCbvxue4Ey9gXAS6iAF4xmXbEMQhsesi7Exv5Bn0C2jZtj3zZs1bnwnMPv+iPUL03gmjPlYF
 tOsAU5B04rK0CjvNgYPJN6+NnhXWUSs=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2f20d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=heQ8kAePCfxZzHD31_sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: f_nENQ9wCMCX0ODNSFtT4u99bQ604LX8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MSBTYWx0ZWRfX7jgKf3ZDAtQX
 ojh6RA8+xuD6NfuD77IACQX4M4dCSGjUvv5NXiE7m3e2wmrZ1CVKIVS4JY3MdgxDaH9Oh917KMh
 UF3zJpgcRzNB3dixE3FP3qObL/WfumTlaGr5lgJhD087uGmIPsgbaqqUUAjUjSbI5ChqpQ/4A4g
 C0OY5WlCFmwaH5Lby3+RcG1VxpWb0lLKRRlMFrtwbO62KQiYN2O11dOd3IL8r07h5V3NxXFe9/f
 EEx6X+lWAV0znXSYReT1EyOf4ZIzJkcG6UTbLfHoHZjQEuyfprMMX4LZ8R8XJSF7u/0+NPDjHKO
 kN8o8zA1epgGHkF5+IF3aA/nG41JaA2fVzifNqhGPTjvP2B1UXJOFThlfLpjbsb8aHobKCOtayA
 ixASi/2YyQa6c8bncUgmYbXjsLlZzQo26KHrAmixOF784fSAnjqMNLzEd8GCJNcrhaaRkXcVqdj
 c05xj7uO+tB1Pv3on2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100041


On Thu, 05 Nov 2026 16:46:45 +0100, Bartosz Golaszewski wrote:
> In pwrseq_pcie_m2_create_serdev_one(), if serdev_ctrl->serdev is NULL but
> pdev is already tracked in ctx->pci_devices, we return early from the
> loop and skip the serdev_controller_put(), leaking the reference.
> 
> Initialize ret to 0 and jump directly to the label that ensures the
> reference is released.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: fix serdev controller reference leak
      https://git.kernel.org/brgl/c/073f01043e79fd76f4fa648e58061c80329a6eef

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
