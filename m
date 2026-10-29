Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293060;
	b=G9rKnypso2zne/HqoEv72NaBXi5a6Fgi5PXilc3V3bw1v2YquX13f3rF+w6mv4YF1aV+
	 NcY/t8E5U0MHio0VQbr07keDkSSdrK5SL71u2/J8bZjpqvUMnyy7V5vxxfzlsdi5C9XoS
	 iAWOnQi4zqHDJlOE9NW+BUz3z5+g8Qe9jXJqILVH16ByvryrVbVBTUemLzOr0IXvqQ7bG
	 14HppgflT7yDddqbRe3CfPUvY8ErdGlat9WpTpZQfUY9fnhyJhhkOOXE8m4MkzdFHSPjH
	 aoYEijzo4BT+c3Kh3jMyMPLHyxJVZJSKwtMAcTaSqgK6G5nXDzdglHXqxq3TozFiP4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293060;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+xV1RGjg5KU41r+LCzwCOMC6Im+qEpwWkzwUNymeeJg=;
	b=N9uBt2va1Rk4MzO+lYQHekNLXDdx7E68ciyKAPyKCTnDOK03geqH1HV0lm64phIymICT
	 XYAJw25NCnuL6oLTz2eN9jrCJamkvPykMmAVerOtUuJLpuFW773uWodMhy86bQArx1Q+q
	 9ZveIEmgAayMNUNMKJny9Uth7ByG9/jmkWOkBeAt9pzCdcPhrdLFhgLgDEy18Ws39ga8I
	 ctO6L/ypVVpgHekNhTRpJJg93fTYsFsFYKpg9LnoK+bq9HnICY0l84mBZSrZMgbfidOuW
	 xh+mIj6u/Dp2C+ADomfaRjiQvmiDG223ezmhqRbctL4oHL5wNZ7Qi8LZQQeNgDH9ewg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mmlqFbrV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLFA90Dt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169B606A32F
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4169B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mmlqFbrV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XLFA90Dt
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGCxTj1619586
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+xV1RGjg5KU
	41r+LCzwCOMC6Im+qEpwWkzwUNymeeJg=; b=mmlqFbrVGnojNptRIp2Y0FfR73/
	wVV/o5gTl0sCSMYCHjuF3Dx6l0i5+dOf8jR6p65QP1QMFMPWqGx0EMXVgd6dbauH
	gdakoBqo/m9dYUGh5xACXlDUC4wCrqj39o2uJq7laJlMZUyh7kOcGa0InIpCK165
	6WlNbRcScA8H2Sjc/YpxU4HfKK8QEXNqvo77ljPo43uBpqhXz5cAhR9QkF4qQxMX
	5svf28nfmCH6fqPn7+p8M49RKPZmG7OQ7HilRO3lwccPNt/JQ28mwIbGboEUWZDF
	xEd7ajB1dSy8HHKOBP6FSUd4j8X9GrXE2IGybfIwRnCbmvDY8UBT9I6lL5g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm44q9nua-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:38 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-99063f4065eso564370241.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293057; x=1793897857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xV1RGjg5KU41r+LCzwCOMC6Im+qEpwWkzwUNymeeJg=;
        b=XLFA90DtsV8ao0O1g1TGR8ZaeW+WCt5ubT7HTmtPEAqL8PY9W3Lco3ryBst5C8B8Ub
         A7iGnNGPdCESMKfg5SYe5LKaEzRGz1TzQEVQgUDYlw0DsxKwOrGsjF+JrOgSoNewKwmF
         WbmpwdaR7eIRHiGsRTYuQL5nomcxJ+YE+aE7GMZ+VMmoWZ7x1TtIksALO26lvzEPU96A
         YAndJ3IntHxwNhehGYsOTPR+jFoHJL21mKWqnLuiXbBRh5NQ0XnodZxPe2UhVG4I34/E
         c7afvCcaMiU3SbO02J6zc61gNut9JlrOsSCvctp8eZYlMPijwJ2sRC0wjDPEeNm5mUBn
         xepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293057; x=1793897857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xV1RGjg5KU41r+LCzwCOMC6Im+qEpwWkzwUNymeeJg=;
        b=U54n5lzByl8Z0RGU4K2uSTKGC8r8lzIpQK1bkg6DAY65JDpscvm3AiYq+SF95+nNjM
         BzIJQ31mvgrFjKeW+agHjyYAsF11oGCxhdlRy9zPzIicd6LLfSrRL3m1YxKXk3ss32xx
         DVm0zRj4q+x9QVevDz+BXcVUcSxAVQYISB1dmg9vZu0mW2yhEfrWBxI/hUTy88shq0iS
         eB6cuvMYESKmGMfMCZoIJdITk0VxvIbzgE1gVCh1AtYkcokPMF92nQFxP1YLaFdq8fCm
         UsW6IbkHsssCAgTohCEzapFw/tv5y3M5Zy3VcHIBk4VkPDyhd8qf7ctg8FyhVXQu5yg6
         Z0Pw==
X-Forwarded-Encrypted: i=1; AKwUvBxTqvtp1lxDjEGrPOBxBuwaWaWpJ/OOUnTDbnW2Cd72n/sN8nqpeHwew5xC4V4yOAJAGlTc+19FOg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJZbm38fBMmMk0mzRmJWlPrzmeGQ+Rf5gVrBSQDErcOS+GJ6NYP
	j5jRlhH3qSVXBs7ls4Fl2yhXSHC363JIB3qXj33vRC6Q1qXn2LvSIxJ7+nN4USaRqV9rcOqEplu
	2VJYaFIaAjXS5mSIzxPotKtQORubWOPd5+/PV/I1hF2oUeIQpFexlvBJwkUKxKg==
X-Gm-Gg: AYBFou3LMF/DJWG3jETmr9Xehw0hiYx5/vZfCIpyasXgnu6AGoAOUTi/yR4MGX2LTrs
	ES9eJdrY2BPMMrQh63uPUP7hkwFKjalBzB/3VjKgBYRl+x+3VaP4HSwpfwsTUpTaP0qbk0EMv3Z
	oNoTQd3TE2DDufdmDX7MBOkF92+/21qx2pn3A7ByNbfCZc5FMjmV8i5ACgu3KewthdosMdgjIuo
	jI8KqxiYYiNn4PU3TApxVFcm4wt9E1/Bsm4laqypdwVlhT3INyY4xlnQTzCFVI7TH7oi9LXahf8
	KH2Ba54vGPXRBvPbeBOL3Dp//eUlBFlU97ScFCgFTPKUF2Zq7Io+ZohDoJ7y3C3cZnjae32dTVd
	AKEtA0v97JadSp5WZIAADNLjKUQZAKjFi3RJ8yXu+5eUuc+pUQUOHQwL9u6nPTWmEiPf1ztGy0f
	Xk
X-Received: by 2002:a05:6102:1483:b0:7cc:9d82:61e2 with SMTP id ada2fe7eead31-7d03a4bec64mr3117849137.13.1793293057018;
        Thu, 29 Oct 2026 09:57:37 -0700 (PDT)
X-Received: by 2002:a05:6102:1483:b0:7cc:9d82:61e2 with SMTP id ada2fe7eead31-7d03a4bec64mr3117824137.13.1793293056511;
        Thu, 29 Oct 2026 09:57:36 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:35 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 3/6] powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
Date: Thu, 29 Oct 2026 17:56:47 +0100
Message-ID: <141ad25a137cb50516bd92f9a13dda7ec940f6da.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfXx7hKhIHZtEE4
 wBLkz6sYz5RlC3jbEcM4iqLzO8sZBIPMemrwu1wIPbeCeey6rJIK8b1z0M4CUXYm+4B1vTyOnQE
 SbhtZiVgACEIle9Yajo8sU9p1duU7gY=
X-Proofpoint-ORIG-GUID: 4LTmO0XeGIuDwYA-WZSX99yC6kBTfN-6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX/XSZt/A+v/3/
 +cpEVzlvO8wcuMMCusBb1snrROvcbg9zH0xTKM37MyzE46WwQ/svBLrldf5LVEjecNsyT//nd1U
 3AERhxWm/xkh5Jmc0SDzTl0UunFZXFYop/n7pQMX9/Lomh+Eq/+pNIHfbF9dSe7m1fWGtTTDtbt
 t8Q1nJZ9OPVMsDBqE3zORv1PL1bRcGBZmdjjLFe8S1ebEayQ0npRNYvYQEJm2L+RMXmlIXU+mra
 nyGBi7KQX37unErmIoKr6rlzxCOV5ZY00OdsKpxXgp1rYMGRoBrAC9Wh41UWYtBHyxyQF+dUsYP
 7wDjb5tFegzzi6VP+B4UTDo+0TyitTkoPSowAu79LCcgGgdYUPi03Hws8bxyIHKZastxfLQ5dtQ
 t6uUhrfHII5IjV0rVUzh/4bPqojywQTWGyyUxiL7Q9bOrLAy+l9en+swtULbez22UZEBn6LH4d7
 uxaPPOVpB/PjDxoZ9VA==
X-Authority-Analysis: v=2.4 cv=CYmdd7rl c=1 sm=1 tr=0 ts=6ae37b02 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=EpzjDTW3ywHV2UopgxgA:9
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 4LTmO0XeGIuDwYA-WZSX99yC6kBTfN-6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290066

The DTPM CPU backend registers one powercap zone per cpufreq policy,
not per CPU. On RK3399, CPUs sharing the same cpufreq policy therefore
map to the same DTPM zone.

Remove the redundant CPU nodes from the RK3399 hierarchy and keep only
one CPU node per cpufreq policy. The backend already suppresses duplicate
registration through its per-CPU state, so the removed entries are
redundant descriptions of the same zones. Keep both CPU policy domains
and the GPU in the hierarchy, preparing for one created zone per generic
hierarchy node.

Also fix indentation in the Rockchip device match table.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix Rockchip match-table indentation here rather than in patch 1.
- Clarify that the existing backend suppresses duplicate registration.

 drivers/soc/rockchip/dtpm.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index b36d4f752c30..e71f315fbb6b 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -20,30 +20,18 @@ static struct dtpm_node __initdata rk3399_hierarchy[] = {
 	[2] = { .name = "/cpus/cpu@0",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[3] = { .name = "/cpus/cpu@1",
+	[3] = { .name = "/cpus/cpu@100",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[4] = { .name = "/cpus/cpu@2",
+	[4] = { .name = "/gpu@ff9a0000",
 		.type = DTPM_NODE_DT,
 		.parent = &rk3399_hierarchy[1] },
-	[5] = { .name = "/cpus/cpu@3",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[6] = { .name = "/cpus/cpu@100",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[7] = { .name = "/cpus/cpu@101",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[8] = { .name = "/gpu@ff9a0000",
-		.type = DTPM_NODE_DT,
-		.parent = &rk3399_hierarchy[1] },
-	[9] = { /* sentinel */ }
+	[5] = { /* sentinel */ }
 };
 
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
-        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
-        {},
+	{ .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+	{},
 };
 
 static int __init rockchip_dtpm_init(void)
-- 
2.43.0

