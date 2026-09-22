Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4563E437130
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067201; cv=none; b=nqkOs+H3iUdopJeXD30YMFFas+NuFYgm7v7Ph+b//cUquWlqO0Qfu4IOrBR8qO8Kn6Fk6dPZ8NrCy064JFLJyol3V0geabdmnoOfGK5PBFBXUGvPMtgxH9Thfcy+9tyh5JKO7pVCKdIwgCnxqLQmz0CJHrB3f1U6pws4xc1pP0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067201; c=relaxed/simple;
	bh=I2JRMPVr3nHR3zuplvqZ7DTDb5odemX0IPdrnYGeqe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXvI2oYlhRELFRmlLCp8vN95+b8aH0uG4Lx1zRcL8c3uNuCpPkjQFxf7iv3gwgeKtRxYuAkbxrIpH8tDvTea1HcYIW6+AbmArHTF69Fd9Mo/hYM7FFQOEJM8T0TCTMJooC+CbS/Apbe76KqCFBqWR2GkD5C7f9T/STjxVV/pLWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X3DLA54i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fi/TR0OP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X3DLA54i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fi/TR0OP"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M6skSh2166099
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 08:53:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=; b=X3DLA54i9cE/Yl/U
	ccEGr8/tKOWhVsj+bOt4aUFbBwhyF75FH4g88Sd9KtIoORorLiJ3CVnvWnnjuJoK
	LfX5bj8p0Wi9u0J/SS8ANRtOZTPB9QiXXf7aovIh8qoGkmy1gyRi61Po4H0mxC8i
	Gyg0gL8itp4WjoAm8YhGaptJNtZ5/gEHMvfsLVc+Ipkg/4oXwke1luVsQC/3ri7s
	klm+wWs87rclhvUuGf4w1He2QaQ4/YysyiVtSUQuxCJo4p/qGa9ao3dODa+yCMZ2
	Q4ZP09FnsPMtVugFc1h25SfaAsohcgjC1t2WJeyhgFawuNPgaJAG0yx0r461kqDC
	fG/7yQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu8xeu4js-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 08:53:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9390a2c895bso438731185a.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 01:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790067197; x=1790671997; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=;
        b=Fi/TR0OPMc7aia93LkSqKL9M7bobCaWJO3xphzM0N1Bp9GlTAX3hiCoi8NDE0xcjD1
         oVENspzgwfuQFSDAkOZzQFuDNez8BNtWS5GXkP/x2eybhUWT0eK63Idl7ussx15FVR/y
         mS+uqRvaiic05AnyCyURcgVjLnPIayFUFgY5LlLPQUrvsZ4xRTs3ubk7hAW3PM8uPEbd
         i6b2PN1yuELxW3ReuhGwlCFcBKi4PxU/G6aeotw7baP4a/fkwtncV1JsPRyyZ8jmYjp0
         u/OeUTNU+JL0269l4k8lAluABIKH/fAaQPWKpbPH4uUiri+rFfDfI+hx2kjzfCzdocyR
         gLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067197; x=1790671997;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xnc6jTGctPVsSGz9lBRdlGXpkuVeyawg5glHzY7DM1o=;
        b=T+8Nzxn0fsqbMVHRJ67Uj7xNPysAiUlKUgpeJ97G7y+44au0VDU6tJXOHhhMqxdhcC
         QKid2Sfc1fZvyeTw0CVtalSVKbRUDJiouWPYSjcfzSbpxVDXVGUTvxss6JAajms0Hewz
         XUxn4jwJWZnsaYOFTzRl/Z7qbUqHd4ytf3I8nIOEJ9shlCETqXCC3xrUvjbyji/KWLZq
         /e+/DqyV2E8/rkS4rm3zBTZNZ/A2+47YHxPWBZjIWxjwORpciiMkGtgWjsMbagGjemag
         whPJ0lhxwmh2FK7V9vrjLQRJQ8YHJp4OiIqYmk8T5MBgUbWnTqrPCzh/ZQI0pKhE/Rrh
         d+ag==
X-Forwarded-Encrypted: i=1; AKwUvByrk6DO6YoCGMRxg8PEZ06nNI6QKtZkF+cJhwLIsatEEf2zcG9mD5clVo83GEZkFaHPtLf/jBlx9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lVyMhYV0FVpGRp8q7HqXp9BhFUlpk73Unh7mOcF3OKXaI1Lnv0
	EzlOAO1G+uGLr998+w9QOv7SbAY5EoBL6mrI5faWmMvtCgPb4gROy3Vw5SYrBvNHpCFw9Mbw1cp
	hA6mO1jMDQ97stjm53CaV1JJKSLEB0T99Ic8WRka6hiM1IAbLAox/7oFeIjGpDw==
X-Gm-Gg: AYBFou1b3fGAuiTKYCBNV6OCrM9ddGCeYwwRkJG2/gFROAk8/bULmiVuadiWxDbamjf
	o5+cKuz9M+4jaArzJejRcyFuJkThpoQlR9caDhE50FIF4NJIIuBhI5xk7ot248HzDAasGlvfdFP
	Tk+rgFnH+CaTgoVgj8jj2+oEI8ibLjY3Y81EtOiLCLMQdm+VhX4FumxvhB6MJzPaT9UjpGRF3me
	g0eGZO+INI/uERrRRibeW6MmZLfA+Oje1PdjeXOPHXXO+Ox0OoTUlixP23YGJh2lo5+ZoN6E6AF
	X/JDrckeUsvA21Y/yuHWH4FgtqpXu/Ec9mAfDfdzsZbOFsC4kPxlIs+5gRkPpuNPxX1ydiclXhe
	X379lMFxw4lxnHWnPwBsAceJ1gQ==
X-Received: by 2002:a05:620a:2617:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c15dc15cbmr468080485a.25.1790067197534;
        Tue, 22 Sep 2026 01:53:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2617:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c15dc15cbmr468078385a.25.1790067197170;
        Tue, 22 Sep 2026 01:53:17 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdab8ae6dsm76956285e9.0.2026.09.22.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:53:16 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
Date: Tue, 22 Sep 2026 10:53:14 +0200
Message-ID: <179006719183.26594.10755646806419123465.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
References: <20260918093838.6645-1-johannes.goede@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: r3hJrliPjkS1zus0jqsyCfhhp_e6qxcU
X-Authority-Analysis: v=2.4 cv=PZhqFShd c=1 sm=1 tr=0 ts=6ab241fe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=enETrG2LyzngRCULhKsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: r3hJrliPjkS1zus0jqsyCfhhp_e6qxcU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfXynP5aC+Cj+XX
 rd3ZajBPpavtoU0xRnRjkyjRAtBL7UEuS8v1fpEkvjlSxVRo9O3k6f1NrUIYLfjg8T5iZmQoDcZ
 f8Wk4pcVP7oadRqY1H3ugr4VWn35KHN4KHwqBXZVryJqyTtoViwzyWrOKPWJasWponuBUgJwnqJ
 ITHw1EX+cB4YA0vmUpuPDl7m/DNDkkB33iQ7OGgtXtmcV6BDmErH7Cx8NWJKXTZTyFBtToplZFv
 qi7Ae1Rv43dWM5M4kN8k01Cl9L7lLgH1ILHEIvUjBTQKBn02vWYSoVPsm8WAiFO4Eo0EIw5VZIX
 3Ruj7GVe4WaWPApOJOmhnBjqtP6oiSQGJFY3fvM4b9AfpjrmycwLzQE1ciPWR4OD05kC6rhNvv9
 lSvja/PvCkOr3UV4V08l6lIuHczwUv7bvKgYplM9wutZyef9TXTYo6M0c4HLpcAuhe7v9fdRX6b
 nijv8RQpp9bJ2pJVdmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNiBTYWx0ZWRfX5vLyvd11gtQR
 9wuI4xfJJHEp3+LP3TiTutMb2aFonM2K4rE1YceBjVbeFKUaeM1X3ak69ZDiB0gCvvsvniUgGfK
 G68R7jrRalrK5zv1R+60EWGEiazkMmc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220126


On Fri, 18 Sep 2026 11:38:38 +0200, Hans de Goede wrote:
> Commit a39ac4651e3b ("power: sequencing: pcie-m2: Match WCN6855 and WCN7851
> UART BT variants by subdevice ID") has caused the serdev for the WCN7850 on
> the Lenovo ThinkPad T14s gen6 WCN7850 no longer getting created.
> 
> Add a new match using the PCI subdev ids from the T14s gen6 to fix this.
> 
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Add Lenovo ThinkPad T14s gen6 WCN7850 subsystem PCI ids
      https://git.kernel.org/brgl/c/58a00330248154461c52a6f3bd5c01e5b67f9560

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
