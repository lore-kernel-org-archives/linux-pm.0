Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F347D952
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261302; cv=none; b=svUqRUTYh9AoQXWiTMbX3e1OVRRr9mJC/7TTnGVm7HbOQ+5FsxiLW6qU0WT/hsOzt2RXDbF49INrCYeg39/nVs4jCFcSxyic/MG+AK8sIYD9DxkJj/IRi9hJ2Gm+hs3K9EQqhgAbYAetu9YSXJGT92bXAs3rF5BmBZkAC1zihr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261302; c=relaxed/simple;
	bh=XMnpwKZrNARuXZb6puLfbaYUBZOhDXc1LgZgzOf5kdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRj49vRmR18IKAlGKHm6b6i8brv3kIlG4QxCQ2OMPXc7xAP4rjbXfzR4tXRdoROCdOe6dZcd1LIBV968ltYb9nEG6ACxOW7etheWW/aMJ8h1Ncuxt7WvDcyocqm4zpt74r5gA/KQcKLiKyEpOmfmieqh88m1wkQTVZb+tlLJLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQWeNZEo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fxDnqXvN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQWeNZEo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fxDnqXvN"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJbJb2406393
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 11:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rKQIdRf0x1m
	9XiJr/mtJMCpV7S0ghyR6HfmB0sQ4tyA=; b=hQWeNZEoayrCfa//QNEezARTFOn
	vwX/dlRWTSftRMLJMPQufjxr6nIccwl4dxUf6m87K2+3TCETs5sNFVi1EA2A1scL
	5sla7q3BGFtPwI0e8U0KEojXE31LrXxBK2jvjCy++ZNA4ikqdXgEtcPNJ4sd2QYx
	RSLfYxmGHV8jZmxAXgl/KZS3jJ0v15+xew1Qs/fXWtPIWPwHWdaheiILiii0Lhci
	pMonreXTnYqbaf+rP7zZrZW+ob/aFImkU/dbc5FImBghV7NzIEYSwkQvDGklEK6W
	oattx9BDsdEaOZ2sfEQgubJo/eax4p8vD8aUN3+9OAqXV200dEnjodJKrOA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7r207e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 11:14:59 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-9394ad7f64aso195063785a.3
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 04:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788261299; x=1788866099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rKQIdRf0x1m9XiJr/mtJMCpV7S0ghyR6HfmB0sQ4tyA=;
        b=fxDnqXvNC8LXiepeZfwnaUnynIUscmWugFR6lZrKNSdpUzE0/OuOQkMtwov2n5LVKU
         LhKAZ9jM9My/E4uM4pK4L8QUhTNsuR220W2iFcWf3OYtIPJkl3sahR2xxI5ytFGCatni
         2nYc3l42gMcMSu06mIUfvv17XL3lvZR8uLsqUSGaDz09i1z9Iql4CEzYKXdOKPHpLUDX
         UU1VYvjA/bKBwARDZndfqipsr3BU9sXaZ6Zqk9G6nqndrJBgy/93Jr7nAkYNCWvySY5J
         8jOJdwqoHWxvoVmeLV1iI+xNpoXsSZAo3domyZLYIzrSLdP/2F8TqTMODQVAOGbKM1DP
         Y8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788261299; x=1788866099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rKQIdRf0x1m9XiJr/mtJMCpV7S0ghyR6HfmB0sQ4tyA=;
        b=q8cnLZWqMViZMDK8d2SVPoNs/GNTRB8p8LmoosMlw6ctZOFwGCAXOTaKW6KBF0lkZs
         Y4apeKMHKY2sRtknYttzT8kKhwjyNnt+N9LoHtdfeZuv6XFDG26rPBAI9dSm8v8t+JTZ
         pU3zPLcg4N3lWRlbQvkJLOpHtdUPChfl4Gvj4ZrRBRxNKCvKWunuLVSbpOTdh2RJPZeu
         hgaXtFi/RD+vpHUSlSH2BTH0/nbqOZ+OWJMPM0myAXkKdrjSYba7WDMcZF+36qLpNQOc
         2PqcSfHXx990nwVaeaum/INVWjlFgPGo8rf8AaE9vNuCxj1rTUBNpA63KCR4dDvoBacW
         kB+A==
X-Forwarded-Encrypted: i=1; AHgh+Rpxny53TOo+8jony1XcdHsWP+xouotf2DgdlSym/ErXDGyLaAxwB41sKcNXiZzaw6m025lmsXnr7A==@vger.kernel.org
X-Gm-Message-State: AFuF++nsMQRQw2ITwq/6pE8ITgD6cHzIlL2ThGylz5tqHkXuB0fI9Jqh
	qohFhawWUQ91uHcETaG4SHc54XkUXpQmSoY0zrwFZoMSyc02dy99ErN4QaSdC0xER3zMLLHj9YQ
	/mj6z5YpNwN+n8ATOT20eI9F6pcE9qhlnMrUrrKjILnr7A0SLw5WoCS8J2w6sJQ==
X-Gm-Gg: AR+sD102Mdc85O1Eq2Q+m18YC7GPM7F1u4B+G1Skvwx1V6VMa4gjxwCHUw0H1K7nP4i
	H4q0GhwEcCLQPCNGur+esLUNd6rxQI+lU5atvC37eWYodrii906e71Udp/Fiolwk/ZgT5/jUbIX
	YU4/Srkjo9JiliQyuMQDUa+XSOnnpQyBUFVlk+Z0aU95tRhJs03wkq0JHzPVoMJ3DK+ME7//vy6
	aNzgxRJ1eI6d2/8cY4BCKCL/5eHhJAF1u/lJrnnNKDUX5iXMBuy81AHuI+5yUptg9gfwMtFkEdT
	kLSEKO12kN6dj5XmB0+abNMtc1fR/achHmKIR7qAUb4cxAIH2E1qzAsRjH9kvc7Wd8j0GtPs16B
	hEv14pJi8oLBo2Cc7yl5IpMm0BdwMwGeIwknC29Ab/jDE5LtC7dl/Gsl98Q==
X-Received: by 2002:a05:620a:4086:b0:936:d360:2eb7 with SMTP id af79cd13be357-939480e7077mr922190885a.20.1788261298600;
        Tue, 01 Sep 2026 04:14:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4086:b0:936:d360:2eb7 with SMTP id af79cd13be357-939480e7077mr922183985a.20.1788261298122;
        Tue, 01 Sep 2026 04:14:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25878ba94csm380686366b.47.2026.09.01.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 04:14:57 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] cpuidle: psci: Initialize the PM domains in powered off state for OSI
Date: Tue,  1 Sep 2026 13:14:07 +0200
Message-ID: <20260901111441.122436-5-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
References: <20260901111441.122436-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=beZbluPB c=1 sm=1 tr=0 ts=6a96b3b3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GddhhVl5-a8N4MGu71oA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5OSBTYWx0ZWRfX4lHiq+tCL1XT
 gV7BgMfEkL51Dyw2+asyY4a44jCgOjda1EKG4FsviC0PisBHoWmMr99QZwgcI3Jpk2CP+3iLYmC
 W6PhaW5xvpxD3/txr9gJib5q9Wl9bA0PGZz51wRgId0v8GWa4zj8Am+TH+ZCGbJ3dHqO3+4CPuO
 /8hI4Ij2F9iGA2roFuaMozoQZY3rWXnz1T+4n4RAdGZZxvV4Ru9dCS3TGw+S+SbehWH3FzQ19RK
 bk76YD3AqYLcXXa6a9xbDhEIac0bQdY7fqLpj7MqhaDUeNLKnWvfzV3kTRaXp6x9ySa4RNlr6qc
 gVjN8NJTUWlS6OJj+Dt7oUTaVlC4CEFR1X0y7MN87rYS1LxVWuqiTC0OS5jkjJrOD4H+K92bFm2
 wMgWzRSKv8fapbYDYOGV6Iu9jD3/0F3MkQ+hiFnqcdloW0nPuy7N+t82J9ZVNvJJWl78jLG9DvP
 K2wzlHe+2ZB0WhcKtwg==
X-Proofpoint-GUID: KUwSI0lF23SurZS4Ap5svM1zexjaLP9W
X-Proofpoint-ORIG-GUID: KUwSI0lF23SurZS4Ap5svM1zexjaLP9W
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5OSBTYWx0ZWRfX5iWyjfG/NdpE
 H2Xa30Gb8nO1zSrtynhIHYGrvEXFLLU7L8cBnb5CPTLI85dkgNlZt0XMCqoFjDpemB+wyUx+8zV
 l+G+okJjNJ95GBbEqZailM7syBvzU/U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010099

At the point when the PM domain and the topology are registered through the
genpd subsystem, it's not really known whether corresponding CPUs are
online and thus if the PM domain should be initialized as powered on or
not. Instead this information becomes available when the CPU devices gets
attached to their respective PM domain through dt_idle_attach_cpu().

This is a problem when using PSCI OS-initiated mode, as we may end up with
a PM domain that has the genpd's status indicating it to be powered on,
while it in fact may not be the case. In the less severe scenario, this
leads to selecting a shallower domain idle state for the PM domain than
necessary. A more critical problem is when a non-CPU device shares the PM
domain, leading to their corresponding drivers not being able to trust the
status of it.

Let's fix these problems by initializing the state for the genpd's to be
powered off and in the deepest possible domain idle state, when using
OS-initiated mode. The support for ->sync_state() is maintained by setting
the GENPD_FLAG_POWER_UNKNOWN for the genpds in question.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v2:
	- Fix a bug in the call to pm_genpd_init().

---
 drivers/cpuidle/cpuidle-psci-domain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3..4d8c63d329c2 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -68,7 +68,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	 */
 	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
-		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP | GENPD_FLAG_POWER_UNKNOWN;
+		pd->state_idx = pd->state_count ? pd->state_count - 1 : 0;
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
 	} else {
@@ -78,7 +79,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	ret = pm_genpd_init(pd, pd_gov, use_osi);
 	if (ret)
 		goto free_pd_prov;
 
-- 
2.43.0

