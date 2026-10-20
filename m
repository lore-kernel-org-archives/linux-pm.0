Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792505863;
	b=VglAhYgCo7kdw1MWiQ0+K+ilx3KdAqsE+0u2BUMW99GITVmhGgicH3AqUDVvnBJkaEwV
	 R/VGzWHK8+fw/QuMdUnP4A+PSIeUposJncQw6f4rh2vmjRMFVwA4Wtsiavzg2WXmzEyJR
	 YuOBWPvgAokowdQS+sgkHxupE11AgSYJneXo9NlsIgX8O3XI3N3fQSoYDodd2uwT/mq8C
	 Tn1i+216xWHx22YhWnN+i7Qg9YhgkSGvmn8obno00qyq2F9pfzvs3BLcM3YR382igAIc9
	 mN8JVFjHAu6DglNtM8/+8aQpAkwVhICxR9aXmR4+b+iPUfLv7ERb/a3YYUCp66aelHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792505863;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8J4j0djyVVFC/C1z8k5Rma/HbptDjpjZS/vt1pUoijY=;
	b=tpeUwgluzZqRGQyZbRwh6s75MTrl6Q495n0oNaDVT9PchFBzNag96KEGeEEK0ktMrIKL
	 VildQpqec+jlmIgcdWdYX2Xa1HJggoxZcvtBCoFwuQeRYMXi3WijGqllQ+2ffboVKxiCC
	 Edc1F+G71cu30jRGCuxD4B0LeVhQn6+HWtmG+M4r1EyyTM/uRU2hiHnpowj5sUC9Gaemf
	 gbO8jMHaACgnzXZBMCIVH9E8lyH0Bo04xVHSJe12dNTWNQyYs80SHIyQ3cKDGAki1ciF1
	 /TUSdE2RjxVEsDHj0MaRXWb0ZR7djD3N5uCN2KJ7gzrgkC0lUr44Jd0WMHlb6Iw+TiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O1u6Asj4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Otjz7Zmt;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB9D60A5BCC
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEB9D60A5BCC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O1u6Asj4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Otjz7Zmt
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KDA4OR882252
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8J4j0djyVVF
	C/C1z8k5Rma/HbptDjpjZS/vt1pUoijY=; b=O1u6Asj471qzv8lGc4di8WmrEup
	+DJtLvvwD5gLoCj0Kfqmwnbvj3SUqfuDtfGq5rWZaSa66O9VGQ8X4SmJHkSiJYcd
	2Tq9bPtyIAW/W6XskJSCNhA1aEivFnqcx3B1Aji9aLbEtoMOyeoz1J2YoZsKxlOL
	F1Zb+KQAlT3+xZT5TPU/oXEi09LqG8zy/klXnsdRHnRI2bsS9ywkeZn7fzIMfloQ
	P1K/NN71OHE5VlZE5//45yBAQcPTWFLp8zqo8sUUB3P+EzH5DMwgyN4d679N0pus
	LJhb/IiXkgx9RGeS7LIbvn+NYcRWjO0cHZhPb8PudVNbMUopp8DLb4sGcbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5n2u02-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 14:17:42 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93ce7a85f04so657977485a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792505861; x=1793110661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J4j0djyVVFC/C1z8k5Rma/HbptDjpjZS/vt1pUoijY=;
        b=Otjz7ZmtW/ncop9r2eRGMHnmCkLJEvlWSwiozhxk8iY7ztV+6ZMYx7nnotCur1OWxX
         PY0q8wLC+Wv+G3CtDFVWwmgXdHpcIrqpsxP+a+Ke0CpaPVAXpAF8sNW2pOhF4vjRh6VA
         0mQX1qi37Wf15PY78PKEY2Y/kmSwcJr1Ubz+XeKMzakr0TY4w7pofw/lNtQMvGRypGCR
         8ugN9oaOOGvUZRp4EWiz/zXmPr1noAsa4+uWyrLjjmOapQlp0w4lRBq1QV94EociZuiX
         Ho/dQtwdcM5UuGxEU4SwImipZP4BhKUh28mFNG/jYBvjkMOOVe4Lg3k/mWb4c0eGfPlw
         8G9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792505861; x=1793110661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J4j0djyVVFC/C1z8k5Rma/HbptDjpjZS/vt1pUoijY=;
        b=x+qTP5oXaW6f/+nkzf92QwbAu6dhg7hzEa9h2H0B8usGPiiQe2HUXnpSb9CWcMBiyL
         niOeL9OTRoYxt2UJE04V9DwsKwTt6b/ayEQgFB3gBgsY3j2VY1xmzuOFMAg8nbKoAVaT
         579wZmlz64NlS8y1ujh3CyPepC1WTjth4xD9XySIVboC/6in2NR4PFLPisXVlbGTKofh
         Zu9oqyDQuzMlielnKHu68LD6Jw+thbH72fy5KmRs/G3HQbjUUYAbDhm2ioyhwchYgP1C
         2l/fNI900wHPwjBwmYWmmOGbEssXxFe3DFL06sGrEFvJB5e+tYe3/rdCov82mm1JU+7M
         euaA==
X-Forwarded-Encrypted: i=1; AKwUvBwLcrI1fABGt+yWZ7PRt2jAW/ApcZBKDB5P/aPh5WxiK/hVgU4qQdxyj4kJilxpLq6bRhs7YyK/8Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1HFeA37pk5t92H+08sVK1siwbc3A5Ivs29mL5L2K0+gStQ23N
	SQjxKa1tqF4I3Oxoy/DZ+T78IetfP+iXL9dNFpO/4XAhQGVrh1JBjxtB3TUcV1aWmLzmVF99ZAu
	caHdGBv1G1NdS7FK3eMgiYwxxR1sSM0padKOLGyCzJmkwWbbnm5Jq8HUtrp7D5g==
X-Gm-Gg: AYBFou3ZT1HWHuJJSH6yBYhvtLo6XOgxj3O2FtT8N4/7BztDRyGhE/vmSCcXUJocwH2
	amjfXxrDerREx7idx/sIyNcG6i2BNvol+aZXy1HS9SAlmXp9121YhQNGZ8B/s6ycm84UbNZdVU8
	5k5GN7cHkU1wK1ztQfItJyfxRKDaPmw+2U68wkY9BGevlGQHnYefA4TElT52k51Gkww3eV4jzYD
	PzXIUQADcMbp+cFWoHz2i+jHY46weKlzsqrU4GrvCxoH+YQ69QBGDz6RA6HCQooVAFKp9tFaPMR
	I2N9s0UpM4ZpufHXIfYRHx1emeKvIi5ma/4v0qII0T1mz2a53redkV7v1Hp53sdbMwy9rSDIdKn
	EtfeYggLKv4mr/Sa9WW/gD48g7PY=
X-Received: by 2002:a05:620a:19a5:b0:93e:b0c3:388d with SMTP id af79cd13be357-93f29b7f65cmr1936775285a.11.1792505860706;
        Tue, 20 Oct 2026 07:17:40 -0700 (PDT)
X-Received: by 2002:a05:620a:19a5:b0:93e:b0c3:388d with SMTP id af79cd13be357-93f29b7f65cmr1936767785a.11.1792505860129;
        Tue, 20 Oct 2026 07:17:40 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:4884:6e9a:d9ff:9fa6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d810043sm6642276f8f.16.2026.10.20.07.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:17:39 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 3/6] powercap: dtpm: Remove duplicate RK3399 CPU hierarchy nodes
Date: Tue, 20 Oct 2026 16:16:53 +0200
Message-ID: <38f5964cadd33f8b03afaf9ff740653258367d72.1792504834.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
References: <cover.1792504834.git.daniel.lezcano@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aIplOr9m c=1 sm=1 tr=0 ts=6ad77806 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=EpzjDTW3ywHV2UopgxgA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXxMogudbi5Agy
 tulZvAi2PcShUd4v1NIhSOibjpz6E6KzQkk050yK5rivbHZsL23kb1oNPb+fHmCPssXFqVZc+yE
 vrdvBkovVciaAC1IIH3ohAZ6CiN0ycs=
X-Proofpoint-GUID: WoIuQPnRX2mhApnOKwAebajeFgJgsf7b
X-Proofpoint-ORIG-GUID: WoIuQPnRX2mhApnOKwAebajeFgJgsf7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1NiBTYWx0ZWRfXzv1iTtWEgzxd
 AzsbfAyyequkegOvpA/xHCMpQjANzznlqwiQD9zvU2nCH67BWxg2MpaymgSoBmg8FCWNqQ10EKq
 elg4oBfOOC1sEwrb+uO1v6ykQNUhd1HtRm/xiuJSzjgXFsdnT6jJMKdxmRXGwpcA9Ro6UAq5jCm
 DfNwfLRQ53DyoTufDm9cAM02YDSldAjpXXBPc4NKdC6SfqLkX30Q2Kb164ThSnv65N2IGMLE/SE
 4iX0/KpJ84bVvh7qHGi3YBpDroayuQQkETvreZ36X5A2LFfcRaj1v4eze3lCUatkENArVUmY1Tg
 gH2HSB5QBzZGxvIm187UjV4Wb7+xEu9MQDKq5+LeNWR8vfV+PXWTPWJt6ei4+CBteoWDsm2d42M
 tgpuWUroGSz7/Znl9m4aqndJVF+QnEz9JrM7QW4IVAjsKNj3D4SuPYnQKTPBCFoETFsksl7mfc+
 arvE1AkVAL7UDJs2U7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200056

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

Assisted-by: LLM
Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
Changes in v3 (since v2):
- Rebase on v7.3-rc7.
- Fix Rockchip match-table indentation here rather than in patch 1.
- Clarify that the existing backend suppresses duplicate registration.
- Add Assisted-by attribution.

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

