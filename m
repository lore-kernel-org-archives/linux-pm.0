Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9A5328D0
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174076; cv=none; b=EqdHbWAV3EEjbp7ywNXNVql9gAXmgwr8z32LQg5LD6xdjyfvsXHBX4dErbiwWM+RjIWSTvtO1JYCtkpNOwpTpO65Uaw3QmQcjbL9eYKulJC6ktdAmEpb+ZRaCUuf/sXu25Ik/iGDjdtkZ7LZ8M4csCKt7cfW4PIb+51P9RExKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174076; c=relaxed/simple;
	bh=CY567MCLIdasyZt9otNfmyFtYDpAdo+YL1MezVk7ykE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGZXAeeMEg8qpDD/+J5C4aZ0sxhFLcoucJ6ujTtkg4WDpKHz4JsfJtTcMsAMbyVSGgJ/e/PtKdP4bctnCQodZZtkYC+isJnQrz6MQhEGqQOpiTWZbb+lkrsj5YCKX7HzpmrpT/0Fzam+COzv79mlK2N2H35Cfh6IPCSPsOlHdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eaZ/ScfY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Yb7L8M90; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eaZ/ScfY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yb7L8M90"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NBbU0i3027942
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v7zL2wJAHhF
	GLcCrZcZjlmgVvoWga7A2Naov48OSiWI=; b=eaZ/ScfYfliAaZXpspu/BuDpUtt
	meFY5L6U5Ut9G7fwr4gBButR3qELHJMKP8ZrMCU24Kf59sKX0Cc5r+Yqu9upMUX9
	9gpGhIKYgG/4MtEsFeC2QxBpkLySuFbi6elcEgGkNuxCkn+dy0MNZFcvq1r2OwXi
	Mx2xivPZZhPtbO3SWpY9bodh5vE+5dw89wP9v8RPFnreMkuLkf2q7SHq1KuCOStE
	RAmZpXbIXeu02meqDdDQHiUXU2A5+AL0sh6FKaKlnzDcSi0Znt3OO4IIOPzqGIxs
	W2nkiDt33ghx8jp0iVs+M3jA+3neD6/TcdHEf4K4HqEY5p9TSy91Ohe9fYQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwasaw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 14:34:33 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-79129463bb2so399029137.0
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790174073; x=1790778873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7zL2wJAHhFGLcCrZcZjlmgVvoWga7A2Naov48OSiWI=;
        b=Yb7L8M90mk5Kr0RpRG71SirqwHG+LbdFoYDkpgQUXcRIxlcrXLpFz3OjKD5XU4D8Pd
         gedFG4ssjhiiLyJZu7iTTAPyprrOg1KZR7CcL1iSshJ5U4PZ9ajWzpu91O2L7GMD5I7+
         uRLLO4VTmm+6xqpS3xkd24EB3p3z8sFRQ4RTJsbhUA4ShK6itHCHIRwpuJv6e6Nf5WNI
         k17mAq6NmMMnylRjbOJ5MTz2Ni6aY8X9wWQPQqroECWsmxgQCA+6c5nK1bPvMrJpqJ0j
         wjFGwb/Cxvkiy2bJdi15c3biV8CdwKomEtSYd20TcMfEMRCIexRj4v0IgtTLrQZ6tzkl
         P57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174073; x=1790778873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7zL2wJAHhFGLcCrZcZjlmgVvoWga7A2Naov48OSiWI=;
        b=iAkHicvuYBwuRkdooEa0l7/9wylK6G7R8ysJjVW9Nc0bm/caG5wYHw6cTX8Ifi0pR7
         LHANAS4ro4uPxPufst4BlClPkMWkxk8DNZ0vMRV/OO6zrVbUK3k+FydD+z6NFGKwidjt
         Yhm1x6ZDodyCpZuz8y3i9xMVhnJzHv8POiZe34Kd5WAayQSrc4+n8XVjMcgYtV1NyMkP
         h8w5ZuVBj36bDL8ivCFy9BNO6/u1C3tzV+10nBG2anfoeUy31WBfrbPu+/ADsw8JMNg8
         abewb3xAmjwwyaQ+FRDKOyQbCvcCEjOib+N9htUFJ9Mp8hg/IpYFOuFz5uTQpg1rUKi6
         gtzw==
X-Gm-Message-State: AFuF++lAE8ghYLpzbJYYanCOcZenukuo2EaDQ71SLWZVH/3AQVMc0P4+
	zdE4Nv5YEviaPdvVPdit1zBZurl2Xgpn/dL0Yjzfm1JDkTVGdr3+TNB6PSEdLTJLI4Vp0bGhIQR
	1wA1rdRy7qRbOLduYDI18nzSGFfypQs8xY19KwcKwbeL9W3IV04nONVkw8S7sxg==
X-Gm-Gg: AYBFou3O34Oh37KlqRf+YR0LoA98Eq/MPZhN5GHrC8d/2Aw9vVd7iiMe70J8QrkWpz+
	yya2zJtM47VNhjBt/6W1y5Dl9473r1Gwcdk4utOFjBMe+K4Oujn4umeo+Bs/gC2/ax0jN63VZLB
	LnTv+4M4Tjo7jXt/vmg/pGpTrncMlt3USE3H77F/2+9HWQGqol621wTVUPa6HnaG2NG7vgr4XFW
	LCM0jR/1isaEucfrDf4PdTlNUatqyVdxzAyvV8BEQfKJIiRy9y7yVMswxdYVr0eczolac6zezOC
	v2S6ZVD2EWeOONzWhezg9yM1NvFE7hx9fRJxOr7bGH4Cy5IVOy0Luy8eMiTprVz9H1zMvV3txmb
	Ug7HMuLm8K6j576HE9zXdhS38gSA=
X-Received: by 2002:a05:6102:32cd:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7ac1aad3498mr2384660137.8.1790174073280;
        Wed, 23 Sep 2026 07:34:33 -0700 (PDT)
X-Received: by 2002:a05:6102:32cd:b0:790:c7bb:43fd with SMTP id ada2fe7eead31-7ac1aad3498mr2384639137.8.1790174072762;
        Wed, 23 Sep 2026 07:34:32 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:a913:ba43:96d7:743c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdf158147sm58213905e9.0.2026.09.23.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:34:31 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: [PATCH v2 6/6] powercap: dtpm: Add RK3588 hierarchy
Date: Wed, 23 Sep 2026 16:34:16 +0200
Message-ID: <20260923143416.3713485-7-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX78c3yXFIVVTu
 5xNOAaTM8cvu9La9EDgcFuyi955vdfE3Y2jzz1bUYt/H18ZWdT2+5hzxkNQd9f7IlqQpfhmtHpl
 UkZhW731sTC9XLjpqko3buvPe0Dr1kgbO0cZ//ZopJLf+3+VfMsL7sF+hFXPTxelfEbPcyZGH20
 l8l5D8twDdgk1DlW3ssws6nB2oEFSlmfEQmGW4BBwHehH8IeG3ijqmLqKqlEQVk27m6tt8s8h3E
 +HX4qjT8r/VSnDMoTRDV8Ax1Q5lWnpuxgq+xHdXaXryqc8gxH78p3bIWvz/SH+TkG+RsRyoVO6r
 n8ILUCtSh35OY0G8ii7r0hJXcaRoAuw6TyOsA54mMT3lc3wuNjf/WVWXnym4mqrJLWHVKeVjfyM
 Xfp+78/pv45ZsIse8TtodQenQuAivB9ahVJOuAFz/31XuR+2hdw6H4MYJgPa7HH5R7WAdG8FghK
 A/DuiRRXZ1ffNEWyHFg==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3e379 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=8Fys3Dm6xgAeGQ2jRPYA:9
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: jl1juX36b2cv9eJL5nJ5KFcDhvtS0Azg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1OCBTYWx0ZWRfX7UJEQ1wxlQjY
 Ta9A7sD0KZ1IeFzdnti3pDpnHQ7f4uApJUJBK19zJh1UXiWiQ+1NZlyuTARKNStjXQbCtIulH9C
 hzqT9BHb9G0ZtsisBQ9NYCeaFNT5G6Q=
X-Proofpoint-ORIG-GUID: jl1juX36b2cv9eJL5nJ5KFcDhvtS0Azg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230058

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

