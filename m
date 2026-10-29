Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793293066;
	b=fHutuunDoYkDPSIT0LiMA4pW8vm6lKeOvULFbA+EKCg2cG0k+UpE6j5Otf548GoZRTns
	 RU3+Dtc57bXLRkbKLBdnH/TMgOpZOqSY7iys08AIU4MjF9GSVflhWU4/8a0eTDlFe1YWx
	 +NBouj3pCrqMTi8+zKsKNkpI2M5VRo459bMt+UeQ6D8xx+SmPdv3/0TsoGXOoUonZnVko
	 3WFfrsF0dPFNiBPZq7wsk25C/ynEhOvtfiFlGqTWHATcDlEVPlyAAoOv25A578HXHsRX6
	 h3mfB6qHZGYSpSHMiCqEgd3lZFs984dnGli4NpWEmDCPb0P0HLAU5tA2YGtF+L6LfMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793293066;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=hTV/3nn/Rkcmn0hRyZbdsZoeAcUIyL6tsSbtRE9aXY0=;
	b=sLugmGromC85KDZTMwTsATo02e3/18f7bqy2jTr+KBd+L6bGX602Srr3DXTRQQVtqg8a
	 E16uiMgIDZJ41dvXDOuGYbHaDtCkpNA1fqFClHLQpsda6Uv/YTJonrSowB49MdB32TQ5l
	 4ryTge/kMlPJpCNNGwK5ya6BQOXNR/QZ/2ODNoCBxdbgdblhjjWkAnjnVjIR3o1S/lpxx
	 267b9+s+bG08/vBBmEaY/zn5hI7hJKRZhrLftw4JPtWH25vJ/qoLqP8TBZI0e8+kerbHq
	 ewNknz7IPMlLNKUk52hCYxVt5vMdM7cAylzAdWrq+5Oh49y7IGnwi85btFAJ3o7Oj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXs86wpK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aGrGC1H0;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD25260A2611
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD25260A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GXs86wpK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aGrGC1H0
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69TGDJVR1654956
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=hTV/3nn/Rkc
	mn0hRyZbdsZoeAcUIyL6tsSbtRE9aXY0=; b=GXs86wpKTuJaEtB7IvbsrQaIJiD
	Vzau5SA5Ip+Va4Mf7Yqhhf2vXf1VBswh8RUkDV6XmXP4UTiDz83JhUF+8vSeo+Fl
	SIxDn4xWqgvL126WPyWvXV31hOW1RV9v3jnDpX/7UDRCeP7qR0c97qiVWXf5HEFc
	tD/swatm7oFrd2gPzLbFoMU1FyoI9OTwCeprbTcqlsSzoiqUukoqjDDju6Q6CrpU
	uLNUnGdd+69JCAh4/HgijN6/8kUn+oiYlhFekVGKj5hfMFiTK5vO3LLWUtD0fA6/
	ymfcWcqp4hGlkl3kp1PsW9LTPKvtkyJiIm3nt3868LpR3rnGO/ombmT9hQg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm4a21nk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 16:57:45 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-988bc0ef0easo515422241.1
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 09:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793293064; x=1793897864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hTV/3nn/Rkcmn0hRyZbdsZoeAcUIyL6tsSbtRE9aXY0=;
        b=aGrGC1H0Ao2Iynuo0mhrxET4tY1TvMZ+XtrCZum1T2gtXc4f3AzCJLOAxQgSvte8nt
         A8eBI3CHaoTw0F2OxeCM3lgdj7qohG3Uoqpz1o0xdFustRtaVi2eedXVRlieQX4IOxi2
         9w3owQHPOxDDlfz0jNC2zH9b1ZEmmBNwIybGjWvPqSBUR+VNQs5nb5XXwNemTdnWjwpV
         TvjHuH63sEHDqykOtRHzKXPFWPpva+tA2ORjPiG5z7CmPnMGbANYJzWE6Lw1Tih9acuT
         1UguC0MNCwfyJHGNgbIVNGn29wJUOj6G9T18OShHTBC5vlVCgURTpk9NnvWhCI+SIy9D
         72fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793293064; x=1793897864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hTV/3nn/Rkcmn0hRyZbdsZoeAcUIyL6tsSbtRE9aXY0=;
        b=N8nk9Px9n5ap6vIY9iCyfUjkvo1voA06OTtcguoeNiZikamd98a0jWK2K2CqP0UvDa
         4I8KDcAX/E2wkVI75XDe60+d3TWOAb7fKRLbbncPldxI/CCx0/GAEpOrbfy9Yh4Mx7iq
         LhkA5hdy22HAFuBTUYyxrhiiv/LCHhr3kSNk0vbNr/cA8ei9JYDRegCmoLSw1jv0c2nR
         GE++smXKQWmT0ATniTEG7mpX9JIIiOtXlVoY58/ZNljFF6lnLy9gU+BnF3JMUGF39gkA
         PGC+hIiXQgtac5Oo1nKcsle41/Ar8q8FE5iQ5+KxZEU4+/S8UZYqgs0tzTzSns0I8lKs
         zxLg==
X-Forwarded-Encrypted: i=1; AKwUvBycGwIfSAJ6NTQrJmw0TZT6kXgAXppcGX0DiiL4GfFdo5PEs/lwRrmIIvoEvrOWRC/7sWul6sEXyg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLnHdt4goZIaqEzuYwkKMeFK5BibgkZYerfSG5tRrFeeJ2CFShy
	wxDRe49c4VOZLR5skLarcr/xVXQyUyHiuBFJMNBB6HDh9Or/SJaAk13GzqHptN23Bn+d8D9tNz+
	ypdh9joSZKtM11LTLvI03TF2fJAmlSpQKJudvrt+7MZzQGrJi3RdGYeMt03/oNQ==
X-Gm-Gg: AYBFou2795giiP3rfv3/2Zw8h02arrhBQCdVgYN+8KSLnRkp58S0AD0sCNRbQuW1bmC
	o9GBf1XnuWX44//484MiR6XANMUtJuAXJGjZUZ6CawC0wWp3rWvYulDcQ8AeLWpL63N2EtS5skH
	WiUXIw4hTBbQNf49UTLMCPvlV9p1zJ7xQHwoc0W3ypUXw+05DndJyaxucBaiORXcxDshxtQQ/Ac
	cLeVrg6Qs+SemH1/ZU84as0p03x3BGDfVT7OrvWaiWdbtUrp6REdl2oI7y1r9L3EatveKbP+7lg
	BQTvgU3/GK3cqbMLxXNgOEeq3bzqp+clpoddOzYBSrZCIHZofAYibGDbEPnaoFg84xjQ79j+nJ8
	KwQjWPLFKFzzrWiI6iBloMs8llCrYQQhpHySABCB5Jf90Hr/PCuklU8A8xlKiIOHvu1Ti9Usm05
	MD
X-Received: by 2002:a05:6102:80a5:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7d03a651783mr2367410137.33.1793293063968;
        Thu, 29 Oct 2026 09:57:43 -0700 (PDT)
X-Received: by 2002:a05:6102:80a5:b0:7a7:19aa:f0d4 with SMTP id ada2fe7eead31-7d03a651783mr2367399137.33.1793293063416;
        Thu, 29 Oct 2026 09:57:43 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6df961dasm325669f8f.23.2026.10.29.09.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:57:42 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4 6/6] powercap: dtpm: Add RK3588 hierarchy
Date: Thu, 29 Oct 2026 17:56:50 +0100
Message-ID: <50f06fc06f0e83ee59ecf9037071e02344ecd15b.1793288783.git.daniel.lezcano@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX3XuXiUf6WyAY
 6TCz/FHMG9txR2vxhWLfT+o2bwUuWuNlJWUXSoek8IvJHZmXKRnVRuRIG3zI1N4UvRVOjuj1PrI
 ErMS0Dqg8WGUVSuLRHYZtPfjjOH1lFPzBzsgshqEt4UWKguEa0Q6Cn2SSc+7UFgQPcXcKUlJbaf
 SMVYByTYf5M3Q4A1OUZAWbxaDlc8f5P9pPoKUsmmLICevmiWK5RrVS1gL6WEyDK4+ExcPgq3uAZ
 80beS7ftRX6TO9t+gVsvpNQmG0vgWpv/HZlEhJ2aDxgDroVMezWiwdEw8+54RYJc3fipN+UPm1S
 vWSru4lMW+id7PJAiwmZsW3dlvgfiHlhCR4TMXK6NcS92vQ/gEN0WFMFTamT9Opc+e0MQft64uX
 /z/AQvQnRGICmtrlgBgZUvE2XKL8trWnjQkIW5Gt2Wp0FHvwLBBhpar5lKjP72JPtNQmyS/PDXF
 lvBaSmT5KG9Raa8eupw==
X-Authority-Analysis: v=2.4 cv=E8tYNqdl c=1 sm=1 tr=0 ts=6ae37b09 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=8Fys3Dm6xgAeGQ2jRPYA:9
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NiBTYWx0ZWRfX6Ndj3vv9GItP
 7NmTIDQnQP7wvFfw22b0tNRVqckk7WJId7kklfTAtEF+fM6CsCFu9QZK2GtbC0+tD6c01f7A6IN
 9vIdrM0nBoBUrCD/djAictOte3r9dgU=
X-Proofpoint-ORIG-GUID: nc-3a2r5wQ6QiSphawV57IgIAqncSJ1c
X-Proofpoint-GUID: nc-3a2r5wQ6QiSphawV57IgIAqncSJ1c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290066

The RK3588 has three CPU frequency domains, with CPUs grouped into
three cpufreq policies.

Add a DTPM hierarchy for the RK3588 with one CPU node per cpufreq
policy, represented by cpu@0, cpu@400 and cpu@600. Group the three CPU
domains under a virtual package node attached to the RK3588 root node.

Add the RK3588 compatible to the Rockchip DTPM match table to select
the new hierarchy.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v4 (since v3):
- Rebase on v7.3; no code or commit-description changes.

Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix __initdata placement and the RK3588 match-entry indentation.
- No functional changes.

 drivers/soc/rockchip/dtpm.c | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
index 5ae00680602f..664764f4b460 100644
--- a/drivers/soc/rockchip/dtpm.c
+++ b/drivers/soc/rockchip/dtpm.c
@@ -62,8 +62,56 @@ static struct powercap_hierarchy rk3399_hierarchy __initdata = {
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
+static struct powercap_node rk3588_nodes[] __initdata = {
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
+static struct powercap_hierarchy rk3588_hierarchy __initdata = {
+	.nodes = rk3588_nodes,
+	.nr_nodes = ARRAY_SIZE(rk3588_nodes),
+};
+
 static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
 	{ .compatible = "rockchip,rk3399", .data = &rk3399_hierarchy },
+	{ .compatible = "rockchip,rk3588", .data = &rk3588_hierarchy },
 	{},
 };
 
-- 
2.43.0

