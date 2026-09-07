Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E139C46EF89
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779845; cv=none; b=qHx8htYk7GQ12yrfj8drWGI4v9/FnAThgTIFCWKGA/CfOmw2TjuYIKx7hW8MM/IZMagSHVLuCkhkaaPRNjrhuWd848oJeZEIETK9FnpmtsFymymYY9tCeJ0bKCT68TMIakOHLsrB3Bi/qYVEfSpwnqa/CREk/WIs4wo7IEFQWxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779845; c=relaxed/simple;
	bh=JtqgtDd2Rh6o3JXJUkEK1dOiQ9UhEEkpFWR+pRyPsVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U1tOBb91QqbGwnP648mI9D09dbzxhXXOlyu6m0gYE3hjlO3SE0QIv7H1quUu6WpvzEKLh2sWMhBsTTUKEZfd/k5Q/PmbZOyq59WcAhxoYEgc7Efpu6QKaSux7kDWAuJSyOUE4cHdvXihyQe1ggUFQddIdAzDLl1U4pewtYUxxvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnzZioYA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RnUEswDi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnzZioYA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RnUEswDi"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687Amn4n2652020
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=If4KmujJICE
	2NXAFfEbDRw+d56OpcwRKDELWSYebh9w=; b=KnzZioYA94fARoHLzS0nDuRDl1p
	7mYHCgrsxYB+pnvwjMCgn1DLfIKLb2bzB7GgFdDKURkslOrDyrtwXDYoTO9+O8QW
	xur2qtmoxBz7wIUIP4n3XWjcmVnehFWYYFOvzlxdDeHQBxZF4X+s6LfzGxeJ3mAn
	T7eUGGUmG2fOehnsGRBYXyyUXNxFZzgAMrjS5zNELXcNuS6akrJUAegQuQTFB1Yl
	IA5k9wewNj2wWfpyfSPIsx94NI0LiO8vTOoUG9x5K2qKYfPrzgdaQVBo/un6OqMv
	ihJPhTUVJ8vn64K5U6nWR26aPQSBFouJett9DPLSojdQMjPb4EvYDCRYgcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghtty0caf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:17:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-930b571432fso531411685a.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779841; x=1789384641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=If4KmujJICE2NXAFfEbDRw+d56OpcwRKDELWSYebh9w=;
        b=RnUEswDim6qHcs2LoETjfVWA9cKc8VynPu4X28/53Hp5sgI0RD65BO/0K1NHLeyKgr
         GRISzZQ6SOwMlbMFdfko6brhjrvBH+CVbwBJL21p/PWBp1Ui2J+ns8S5K8s8fn+qgXFZ
         NGKnpKly0mWTSgmuqbP7mERaELm+jX6gT8D5ODDQMhjIb0neCLp67PA30QLDcU6lWR1I
         a9BSa8nhqX664OnsONLnQEPBxhQG3Rezn7u0CUQEiEPKbVQZzw0ZmITDPyUnYz3hUMHY
         NIvzPTwOUwsAcW64GgXKAH4D/a6Zk6R6+ZMUzcirgvcii0ZvnIV5051VgYswtiX78msN
         bqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779841; x=1789384641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=If4KmujJICE2NXAFfEbDRw+d56OpcwRKDELWSYebh9w=;
        b=fr4yQwhMsjTqhSeCi1nr/numRG9tltykWyfqhbzuUVNda+o0+twL/JR5bsXkkCK7nQ
         m3IlZND499bJJaa4ZTKdOtLXcdgqJX10WlB4AREr/YxEhY2DzcocjUccQdAZB3T6TkgM
         wKkqUN2q0qvtPDg38lCOtiYMSCfvRtROqMnM3g61vQHJ3YVrvqyXGHVddhUF4JBe6D3T
         apQ2VDOkjWdI5aob8k/j5dLwSJQtWSJwDV+KDH8AjAbxLsr9fAeUuVZVD74YuU9AhgMx
         3FyrzHsKooSkIYW9nbQYmyt7iNKzsQodVnoAJUAsQ+NXtU6m6xbdUvSULQK8ZGpwV/mt
         f/Iw==
X-Forwarded-Encrypted: i=1; AKwUvBzolR2KIeUZWlwo6FJfK0drpapSVd78sfm2Pw2fz0zA3Y7rYRdR9XlRpAZlcj6phksd6GVki0dR4w==@vger.kernel.org
X-Gm-Message-State: AFuF++mCSMcHFZOV3Tmlj0oXrJhZMmt1WkG/psOEHHHeNP23w8co5wbR
	tYnjtHL7tQKfSBXR9Wn1pE5YchVSFdyhupNhOHMatUCjBW4Xgwto1QttA0gCql5BFsjaWGFQmcD
	YP4oVed0Gs+hpv60LJ+is1U8lKjZuCL7JeOLgk6R7vcMnU1XAa1kM894qoGEfTA==
X-Gm-Gg: AYBFou0EiloQfHKDVBQIvD6l/9C4VjP+Gx8EvPiItSgBaFCyEWMkcLIQ0xcw8jPLgf2
	GC3YOo5zldPiiPlJdBVfpGUPjtM6YCAPqVUqZEDDl6XXEWktWzjq1lT43dpri1+fB/SHjy09bRe
	a0L3jGVRYi4V6xUIka9CWr2tgpLYmWm4h/srZE/NHRUQocI0L6clJvTrU/8MdPiVa+Lk92BM3w9
	5Fg9+aOkjPOFFg8QpYvrkYKeQFBUfPszNtDOfSkTZ3VwYSGu6KBOvbrt/M77ekrmD92uUy2vZxp
	WG78Lv8GAdOLGq1LmYZIXwzY/FYsAyjW0HkL+NwwDD1OIc+IQzRnAkQVypKI0TFiCCNuqDIWj1X
	tiNvq4AXMaeb1dmjwcLrHqeFX2Mx2DUJoa83YMgJO5IyjtQV4XeE+y2h4ew==
X-Received: by 2002:a05:620a:a90b:b0:939:319f:d6e3 with SMTP id af79cd13be357-9396deadfa0mr1869564685a.5.1788779840502;
        Mon, 07 Sep 2026 04:17:20 -0700 (PDT)
X-Received: by 2002:a05:620a:a90b:b0:939:319f:d6e3 with SMTP id af79cd13be357-9396deadfa0mr1869560885a.5.1788779839979;
        Mon, 07 Sep 2026 04:17:19 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm456120066b.59.2026.09.07.04.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:17:19 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Dhruva Gole <goledhruva@gmail.com>, Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] cpuidle: psci: Initialize the PM domains in powered off state for OSI
Date: Mon,  7 Sep 2026 13:16:54 +0200
Message-ID: <20260907111659.263324-5-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
References: <20260907111659.263324-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QNBYgALL c=1 sm=1 tr=0 ts=6a9e9d41 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GddhhVl5-a8N4MGu71oA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: t-9XsrX5PB6dhCdkqRJN3sKZKwGePj69
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX2wvAd9RtFKuk
 Ndhw+N7Zlp9DWnQyt066d+E7OZiwcNb+k0vHSA+sgVKS36vyaEA2sbMBkH7DQnigQIW0jilQ6uO
 lTk7Bohj7b+oksobM3XuCVMmu5f6Oyk=
X-Proofpoint-GUID: t-9XsrX5PB6dhCdkqRJN3sKZKwGePj69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX9Q2/uEn4x18l
 f1YtU46M6ECZb0Az7GzC+rVXN19QxDlvtBId1qdEorA7Vx1l5vSKG0gnrDAuEXt10OLbRU4E4m+
 wmtfT45uHG5Ggzr/p0WdiWsJ/QfIkExEzSuytKph0Hp5RWfHVYY3ddUCTAGz/nShj+4p8cfbxMt
 2/zLaxvUWJJ6eaVBu2xPAVsMt3d8qQ+jXDA57Vcx0Y6ZNoiqZd7nYbo9OkW1hG8+BvVvXgZgYsw
 gDBNMqvAlw7ByQ+C1ZGWREDueXlrTmI9p9pBT8xT+kbSUwf+JIiV8FXDS+fj8tejX8IbXZ7fvCN
 FZqPSH1ARs9yAFHMF+qb38AnpUOkbhISeZ9mMWmgh5zIFyNu9HBn2Hp/eQHrjMTy/4Ly9tQqKX9
 G/Rb4uE3SfQSTBlKYncaheFAGP6CGSuH8omZRk7XKu8gSiE96/MzB5CBnuLq9TonR6YyPOSlXRV
 jAMN1Jkx/5zfkwEL5Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070124

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
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v3:
	- None.
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

