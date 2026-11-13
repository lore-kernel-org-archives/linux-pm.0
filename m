Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794545752;
	b=YBVjd+X6T0iBNqpOwneE2FHB20zlQ4oO3MSqH8GFN72ctch/hDjyad993qwVs41YbVTS
	 zms4jhmhuyJxVFudSSdmzxppmADU0zuMlD32MoBcP2+yge9zCplMSWhPg07Ogo1isH8w9
	 iI2q/T5GNm3rlrXkomItUJxgtJdfsRqgNAgnErSm6s/ntR5iclpXIwtMBR8Q6HzxxhIOi
	 deCA3kDZxLWUzBZxfoSb/6xNADEzZozWXyKNP9QY8t112Y5+rSOu15wqPKsjeQ8bnY2+W
	 ShEtYmoRI32POS7W97G4uONiKijnNDzC2cBecs2xpwDo3m16x2iGDDXtxcCw0xk9PvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794545752;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=iMbHWmtPSkJsblSxkOw1DQa9fks2pTafNZVkV2m2C1c=;
	b=r6nlqdRNz3h9YM3BmriBpcDg1mivnvvL8xymz6Qhfn3DeC50qfq4eNKnubYvoEOZAgJU
	 42ySNQH+DhVR1gCYoxujPOmXSX8woOw5qcx5sGCBHyJ098OzGm0owbBiibWBC09ownRpB
	 d6SgKbMx69fy3d+Mxq9ztWE8f4pg1/hLJCsUp1y/w+jMZfVNtW4RtKfJwe2AxIrlmU6yv
	 dDBn5cZuN1rdsYsoL0FqzpYDBxcQrft0GzwwIElHzDFKhGX6Y6x1AIORxS4nM8XdyGohE
	 SVgkhu4hPyuW8/X3ZLzV6sfqRMvoIfbbJnB5unfJ8XmWsZG+E79qNuAe4KQFoHwXf1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nzrXUVnn;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E1SFlVLA;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66A6606A33E
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A66A6606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nzrXUVnn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E1SFlVLA
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD2K8mm3826164
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMbHWmtPSkJsblSxkOw1DQa9fks2pTafNZVkV2m2C1c=; b=nzrXUVnnT6/HJmmi
	SdT1vf7pGZnIpU2ViVZaQOljsNKmBFwAlvCYgjnVI2aDic1YyeQx3TR7wVg2wVDY
	Po20IlAiHDF7cxxiT72xwx6hEkSEmix2N09OaQuN7DzokhLT6Z3B9rZosdqU5MYl
	7XBOTeiDBMTBsy5V+Le0m63MFWyyKmSvsb6HjA0jJCScDx94wEKMB3lVyyFCHagu
	VbQfjgmR7SMiC/lXLt4ppALNWg31YFfC+ZcbBQ4WU3cUlPXcLr62CLnAN6fdEbX/
	TkLsXp3UI9KRi0rbXL0ZL+THToatp75xGByhfgGYNIM9tt6PR8Rn5NAh5rGrzPJT
	Cfd0gA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwbs03fw8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 04:55:50 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ed077a15c3so5036325ad.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 20:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794545750; x=1795150550; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iMbHWmtPSkJsblSxkOw1DQa9fks2pTafNZVkV2m2C1c=;
        b=E1SFlVLAdhIXdAHLo5dn29nhqcsqtpVy5+gLskr2bk/ULq93paSsrIepRaFE4TkSXU
         VcDh0w0OmoeGtgHQLtoMctPXh0AdbbJsB778HpSutBqTgu+7P43y3OlmVZXpb6jWaI48
         /m2PTvK5UK6D51uGXD7bMkrOP0CH1QCKt/oEHiKOBUzgXoUWxi9N8QwVTriTVHwhibHt
         1W5/Sc0hazRGec4rbtLBhpUtrB1N+XolnDb2oYxTGc2E6n/Bvq1jfGMA2qWzAfwTLoHY
         L8+cLR89ijAQylRNgfpd6HSYUaczJs7spdAR5ck9vD20rYS6DMDdCbVHNUk5t68XOLIY
         OBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794545750; x=1795150550;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iMbHWmtPSkJsblSxkOw1DQa9fks2pTafNZVkV2m2C1c=;
        b=zD5wgOq7gOG1V3fk6ZGnILQdbilUgt2JTZEiCUsosUmcird3rkze/1qMcszRO4cStJ
         t49AqEEkDxFtPAP4ENorVUDlEHZeoTbURi/6MASH//HayaSQwb/r4L9CB5fFxwc5q9hh
         ocCX3z2FxUkRTvQGPKwGh4S0ctjUmhgEnJV9S2d7YupMnUJTmao7WVJfckuVfJQD2o6T
         DLFstbziI600bokM4lN+vzSfNQt2c4WEJioDp4VQDUhMovIr4uI5dHwigPtQO1iifSmL
         p1uwKsY4FQHCpzG9D9vnl0TxjYzrzBVyf6HlXh+ABgQaabHtHxb5D13qCvQVqxyVCc8a
         iiUQ==
X-Forwarded-Encrypted: i=1; AL+hErH+fnQvCCsF637jF/2f996myBHA+NCPKn4biBOXeamUKFcRk3vTK/U/AwZxGjuOW0hWXplkct9yEg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9O+bzxt95oK3vfZ62DiQYWByarGFD4NsbfemQ1bFEDybqBEd+v
	v8NBa4WimjUbXtbmVOBLbJOEGqvY3vgz1QzYWdkZw4fLkavixh76artwa2dVbeTGB7TyzlvcnDZ
	9Ifu5fwwp4ejUQJDht19v/vfGL70abka+MkzFIJmSZrxRU9PZ0jMCAhZOGcm1vQ==
X-Gm-Gg: AYBFou1YqV30xWlzbFi46WRxn+u1Xlshbl9vWErC9q366erk7AJPOQ1vdAKNNkkCuOw
	ANL5f9iq7augETvaw9P8QRhZNEH1TEvJIv9bBTkJheeo9lvAKULaLl7bBX57XFzmmO2ZjCp9Fmd
	rU5p8zd6LSzTahLp8Rg/e4cpR9/65vgmS2sXCrfHz5IcenwH2wMlaG+HPC5MljjPnsqSUeS/ATD
	aurS5YRNzxmtCzdOGWQDUO6lSDY9qPJUHdiTVuYcOFwm5r9LHnvw922WrBHSKvVMuwOOD3nYMRi
	YrMRZ6qOjm1EZ8vwJGxOibUqT7MPqRukAGQS7UuXF6zX80xBvDQe6O6yaRVadriMgO7BzFJfyqD
	M6L+G8MUl2MIYcNDymPrhJtlz6zxa2/4UDP2VGoo1abGQHYh0lt88cVs6BOMLOJNPRsJT1KA+RT
	/h
X-Received: by 2002:a17:90b:1644:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b1b0597ca7mr1229862a91.0.1794545749558;
        Thu, 12 Nov 2026 20:55:49 -0800 (PST)
X-Received: by 2002:a17:90b:1644:b0:3a8:5fd6:cb6 with SMTP id 98e67ed59e1d1-3b1b0597ca7mr1229846a91.0.1794545749067;
        Thu, 12 Nov 2026 20:55:49 -0800 (PST)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0fdbdsm7739875a91.10.2026.11.12.20.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 20:55:48 -0800 (PST)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 10:25:26 +0530
Subject: [PATCH v2 2/3] pmdomain: Add support for system-suspend-only
 states
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-s2idle_state-v2-2-ad604182e7e7@oss.qualcomm.com>
References: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
In-Reply-To: <20261113-s2idle_state-v2-0-ad604182e7e7@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794545733; l=2420;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=zLzmWla1eE4cZjRAIYhpKVJwqHFJ8WiKdzFMzj9uB2E=;
 b=rvhcPu1xJ1lcFOXWFywbCb7prw5OTabSQiwsUPq92R1r9apAzpDONPggy+TWZicvSkRGi5WvS
 SUW7KHUKWebBBb+61zgtstKHbs2WDHEKd3X34LZIX16klNqJJQaX97/
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfXx24Og2+khDID
 X6fr/2lW8/UB3J8+PTGDGf/FYVFNJSaFSp40jrCF1UbiDhr2Y67WKaG40hRlZcoBvjO36kt3Wd+
 GMuztOunarBb0ds5zK9fob4bacslJ78RNLcji5kvX2IoxyXiNF4M9OeljgtehnfZt1Wsk3LS7qW
 wK0zHAXLHQUYLMrMcRRUy/t6zvTgTWwcwf9Th4g6P0uR8zkzTYBpbnjtiPEVoj8FprouzcGy4IG
 LZ4ttukb8JNGP4844z17C7qtWpFt9lTrYG1AIQPvxl0jA7WUyMQkwWavA5KND4ULpZaJYMoAliQ
 izz4oEhkbhuriHnzVAiSMS1P7Auh7VUspJBmXFfPfaGx3Esr3NMITVuC6cnCUe7xWNYvxKrR75W
 qUz1NICzsgjUus/c9dSCK9R9wUMfBu9l1gV+9gZqCcH0lSaVs4+RphlrNfiLv4NZtYXL21zP3ek
 JN1JUxPeCZ4fPC/DVNQ==
X-Authority-Analysis: v=2.4 cv=AsF7T+9P c=1 sm=1 tr=0 ts=6af69856 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=IpJZQVW2AAAA:8 a=EUspDBNiAAAA:8 a=XIWP2vTyFktR7zITobcA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAxOSBTYWx0ZWRfX6+7sq28PIHZ5
 OQUtwfm0oUmMEGQt3qivncTEnuAks9muoOLDBB+f5dGOUStXNlBjKsHBf0FhwIZ3qLdU3IzDbL0
 Mj9gvUx9gcUsP3iKBwbZISLHbClWwhs=
X-Proofpoint-GUID: LWce4DDqnvBgDiLAWjrnMxLZ87EATVTw
X-Proofpoint-ORIG-GUID: LWce4DDqnvBgDiLAWjrnMxLZ87EATVTw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130019

Some domain idle states require system-wide coordination and should not be
selected during regular CPU idle. However those states remain valid for
system-wide suspend like s2idle.

Add a per-state system_state boolean and populate it from the system-state
property. Make the genpd governor skip these states during CPU idle. Leave
the system wide suspend path unchanged so s2idle can select them.

Acked-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 drivers/pmdomain/core.c     | 2 ++
 drivers/pmdomain/governor.c | 6 ++++++
 include/linux/pm_domain.h   | 1 +
 3 files changed, 9 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 964e44c2f78f..288c0deb2340 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -3701,6 +3701,8 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
 	if (!err)
 		genpd_state->residency_ns = 1000LL * residency;
 
+	genpd_state->system_state = of_property_read_bool(state_node, "system-state");
+
 	err = of_property_read_string(state_node, "idle-state-name",
 				      &genpd_state->name);
 	if (err)
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 38bba24ec26e..7684f9eecf85 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -185,6 +185,9 @@ static bool __default_power_down_ok(struct dev_pm_domain *pd,
 	s64 min_off_time_ns;
 	s64 off_on_time_ns;
 
+	if (genpd->states[state].system_state)
+		return false;
+
 	off_on_time_ns = genpd->states[state].power_off_latency_ns +
 		genpd->states[state].power_on_latency_ns;
 
@@ -407,6 +410,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
+		if (genpd->states[i].system_state)
+			continue;
+
 		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) &&
 		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 14e0e346c610..d9b3e67042e5 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -188,6 +188,7 @@ struct genpd_power_state {
 	s64 power_off_latency_ns;
 	s64 power_on_latency_ns;
 	s64 residency_ns;
+	bool system_state;
 	u64 usage;
 	u64 rejected;
 	u64 above;

-- 
2.43.0

