Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A7148A2B1
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158582; cv=none; b=bgFF+UD6fBwLo+V7WOrvkbjgLMQnZ0Wr0FqUwB6Ll/37XfjA/YoGUpuRLylUw1leURCQPuThiwAU3922IOV0zzBQhNWNFytDhwPTi52QODnFJf2lz2JKt66G8xWBCmsPbZb4Mxyjo75opZbIGjlGxy5dBf76jCpr/34vA6gJOIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158582; c=relaxed/simple;
	bh=CY567MCLIdasyZt9otNfmyFtYDpAdo+YL1MezVk7ykE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy4t5xKQnTtaxg4EFHtKftltNKn5DbH8eu1zARp0HX35Xej6p5dDRW28SdOiwEt18SG8hmUdIFX7KjzCleeGZhblGDR494cIH5T9paOnffizkR1B3jjLc3L5XLWI5cqBhrqh37MYmNAVr2LMI/xhAOA3KIYEG8feO+cMzstiX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z2Roh0xe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYoncfpC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z2Roh0xe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYoncfpC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF2C70190670
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v7zL2wJAHhF
	GLcCrZcZjlmgVvoWga7A2Naov48OSiWI=; b=Z2Roh0xelbvUw122QTFIXsBPSLE
	xpPmNs5BM+R20RP+24mKHEYqTfYL2j9HSbDwtVJouwVgsk3sPbzNdBGyTsxOKxK4
	4idcXzOs1EoF1FU06mp/IkKbMSb8z7pOuScwRPcWlM67ks4XKT8Pn5kz/gSogzun
	S+BofAWpT9em/AhetfuD5PEcfOdMCplXHMszH/RGcnZjAfCwqZK8wH49uCrhfzq5
	UYP30arvb4vRjbUjld2QfPaMvmk1zqbpXzbCSRapEdLsf5wAXpx2RsYMucM5FOg9
	C+OMibQ3UY+Zwjx1JofOzB/vVTmNpWqIRxYlLduu+Q8OAU0LoOYIEfc7xSA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esc0mpf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 16:56:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e695a3b28so10487585a.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 09:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787158578; x=1787763378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7zL2wJAHhFGLcCrZcZjlmgVvoWga7A2Naov48OSiWI=;
        b=aYoncfpCP0lVHFSLltsAtghtpPkl4/qO8BIVPUb77hu46vPJwJX173tvSJan7CFZAJ
         R7vU8h9mheQ+HORq/zsOfZhkRfmr9HhaJ+DjuBzMPHZnrYADADRXe0ESAaq8M4IPSA2F
         uN3vlR1b0084iLkyaiZr0SZ/BrWnoEq6DUnak+O0sSiLI7T7oXRzWj3vHkI1eFRI/yj1
         pSPz3kdyt1rFwWqMy956g6H97mTHCOd9BZrqC/KhrTeQu4mipxESpuIUO/ctHpT2g9kb
         X/BmBe/T4aCq3DeX1mu6fAwYkHWr+VKEZD2fOsDpM1SONNXGy+4SjnLJK7PUhjqCr0aD
         dwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787158578; x=1787763378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7zL2wJAHhFGLcCrZcZjlmgVvoWga7A2Naov48OSiWI=;
        b=QqSKo44qmF3Z7tQM902C2M+2y/87Om14fxz0wIREUiOy7IrGbAbctz+aaN92u4p2xa
         xPjLWZNDixbzVBZkIh1cGwkffoO5GpN4TGk6zsYRHMnIjTzCTYq8fu371++urXtlnNJI
         6nYPCkc7eF3IQfAjHsKVKqOaqDZUrKjrC5TjTl91zDvtv9PHp4egFsdoah6O5ZsjKfWo
         sXgm/yho7AJw31ykTJmWSYROVjo0/bYUeMXXfc334iuZMn34uvSop7iK2nljc7VdOLGa
         nssqE2Ia3wBaPAhgLp5i7e2AtPFiNcJkT35MXzQ8XwQqxRCDn0+0HXLCGSXhgS2vf89g
         /Gvw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/6g/bgJI5QoKUSUL2vdJbPImaDmxx0r09JTTBmCOwzCXA3LP1WELSRe/WeckQu4pnuPQQE9Ih4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/0GO/lWLdD0tamUwdblvo/iK7VdOrVPAvMoA3pIdx4yiIf+CD
	McqSMRfELyB6sL/eHG5LpDy+9bZwRDvefVt862wTsJeNrexMjb+LG5WbkKvue0UUYcj+o9ZD8LL
	mI0sL5oIEi6ib8ide4jpqW8gr0YLglvQBixucUEarmKS6NGLPpSwmIaF/wKZmAQ==
X-Gm-Gg: AR+sD12hjYxaulOhTvPcwc+ALFBtirFKPNm2/N6QSLKdVEgSid/bske9JasjI6GnC92
	5C8bUSci+8T1cNuVokB2/L/HkNfaKZBh53VBxwMS4lPTNm2CpJLzyy7R7MrboggKG6OrhYBE/R4
	9xxJ5ABaKVQRcrPgUd0JpsFYKn9ehCbpfsJ9bt1TnlmDJEaLiDcmRauP+DBu5TpaRSwHvmOhw1Z
	RCBfvf04tvIN0SPDbNNAi8WcS64ymj6c28p6ZPw/yYdCIHMPoCgKhwXz74vRT5QEpCQhxy8/wFO
	LqwSTnU3mHDv3Mo9POqpwzibvlU5SXCgPPV6mbSpq9d5vl3eWzZK8vDFIf0e3x7Blf2mz+O4VHK
	HrFLEcQniLuHGvQOU1iyJeFM11OWv
X-Received: by 2002:a05:620a:1a29:b0:915:29cd:306c with SMTP id af79cd13be357-9372840cf5fmr48968885a.9.1787158578308;
        Wed, 19 Aug 2026 09:56:18 -0700 (PDT)
X-Received: by 2002:a05:620a:1a29:b0:915:29cd:306c with SMTP id af79cd13be357-9372840cf5fmr48964885a.9.1787158577810;
        Wed, 19 Aug 2026 09:56:17 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:2e33:a343:bae0:905b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b1441c78sm6952317f8f.2.2026.08.19.09.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:56:17 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: daniel.lezcano@oss.qualcomm.com, rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v1 4/4] powercap: dtpm: Add RK3588 hierarchy
Date: Wed, 19 Aug 2026 18:56:05 +0200
Message-ID: <20260819165605.1398880-5-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
References: <20260819165605.1398880-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JR-Z4NbeutUpNMpUVVq4RHIeEZtFR2HC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfXysYyp/DZ715c
 fH4yeyit5aR3YnbGlM25YIoRXLBrOVhSZOzhcASEdaY5y233+QsINgy9kYxXZYb7JeTznnNSl3P
 csX6V6/aPJsqDwjQX5q78uocrcmBtr4=
X-Proofpoint-ORIG-GUID: JR-Z4NbeutUpNMpUVVq4RHIeEZtFR2HC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDEzMSBTYWx0ZWRfX6psJegbbF5om
 ViYfdeDvPieL5MYvFYODngw7nTqzeEs9a4MXDZhlNccssitBZEiz+s6w4OuwRAkCB76zahtUofW
 renbsMvTzA0LZNlcF+YQ/WuKFC1TuzbDxoSeIKwACUFsumkPiIvvB8myUOazp1bcxOnaUEgAp5Z
 yjYRA9t5yS2i/vP+JeYTWlYs5BqUjRfpiUQKdiuSs2NxqCVl3q8o+ONCfZMViS5MVDXAuWDN/8a
 uC5tRQ0HrkaTCAiCeo5jGgWmIF5afXt9kE8DU90j40gk//6wRgx4apTl2005H0sFdGn98+/W83a
 f2QOqbuE74LEIQLT1H5YYr89BKUWj4oFRqOFZGO0SZ97f0rdqySJdafqgbeoa9RqkirYaTnEzwd
 gSB4Ezogsm5uEANWnm/9UN1bp89I2+yLYYEQw06KiafwIC7qtizV2Y54NxKeddvCOjlfWz9HBob
 zjpIgyrlQdAOh06RPsQ==
X-Authority-Analysis: v=2.4 cv=b6uCJNGx c=1 sm=1 tr=0 ts=6a85e033 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=8Fys3Dm6xgAeGQ2jRPYA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190131

The RK3588 has three CPU frequency domains, with CPUs grouped into
three cpufreq policies.

Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
domains under a virtual package node attached to the RK3588 root node.

Add the RK3588 compatible to the Rockchip DTPM match table to select
the new hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/soc/rockchip/dtpm.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 5f7f238a15fe..3d9367d05803 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -62,8 +62,56 @@ static struct powercap_hierarchy __initdata rk3399_hierarchy = {
 	.nr_nodes = ARRAY_SIZE(rk3399_nodes),
 };
 
+static struct dtpm_node rk3588_cpu0 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@0",
+};
+
+static struct dtpm_node rk3588_cpu4 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@400",
+};
+
+static struct dtpm_node rk3588_cpu6 = {
+	.type = DTPM_NODE_DT,
+	.path = "/cpus/cpu@600",
+};
+
+static struct powercap_node __initdata rk3588_nodes[] = {
+	[0] = {
+		.name = "rk3588",
+		.data = &rockchip_virtual,
+	},
+	[1] = {
+		.name = "package",
+		.parent = &rk3588_nodes[0],
+		.data = &rockchip_virtual,
+	},
+	[2] = {
+		.name = "cpu0-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu0,
+	},
+	[3] = {
+		.name = "cpu4-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu4,
+	},
+	[4] = {
+		.name = "cpu6-cpufreq",
+		.parent = &rk3588_nodes[1],
+		.data = &rk3588_cpu6,
+	},
+};
+
+static struct powercap_hierarchy __initdata rk3588_hierarchy = {
+	.nodes = rk3588_nodes,
+	.nr_nodes = ARRAY_SIZE(rk3588_nodes),
+};
+
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
         { .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
+        { .compatible = "rockchip,rk3588", .data = &rk3588_hierarchy },
         {},
 };
 
-- 
2.43.0

