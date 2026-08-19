Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0953B8950
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152530; cv=none; b=s1PGf4NgTAXe10Z0UqjVEQ6QWLVTYO37f3vobCO6Bk6vJaq8JHxVz6/53MT++ixHHWBFstJJ1o1z5RR3h8KjlpV1JJItrnUJTJpbTLYIejzAszUSY9KI8Y7vk1HmlMGKXzKlfP/94A4ZHtgglzboXTHMpAIWZ2YsfLpG3IzYLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152530; c=relaxed/simple;
	bh=UqLHAb5jkXZAS+tzMNPWmBKOx/DrwxVipmhYZV2c+2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNnJ3jrxjd5zFjhazg0pISRHFpBOCBzA/teSY6a4X36YitGCIAdFiniVA7JnJOJcvOFClUKng/R2WkPafkB77yGN+kiWcH49pjr+WlFabSmQUlhHVQcUqTE44SHqAQ8srGrBriOx7LvbJ2Wytn5XaBjEl+Rf3lhmDe1h3B+tN2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FbRVP3+W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZLBxoMjG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FbRVP3+W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZLBxoMjG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF264A3606046
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Vv//GFttk3q
	YBPU7mvMr/By4VJqy5iyji7k+koecDb0=; b=FbRVP3+W6IIApSK1NLeoMk8lg3n
	C08s7YVSJikjatnQYKiIG+YWoD2jRZSm1L+yM3NUwiSVpjs3zU4ryY2XDxmtiCFF
	e+Nlqeqt3qXoJUURz/IRsv2YhK/VLWbZ19liu9u+S/JS+2TRk51kzAdS60++VLmj
	hmihvb4sKU4WNWM6+NwPCXZedIicyQ7gumcf10hngMaIodpnlH53/yhfb0xq4Yvd
	PP8MyrUTLJMEe8WnYo7P8+A1tr7tgVeVTnoBMRYLUhQOnJHQoRgRbGpPU8ApI20U
	3g2uiU/zhWbU75HuOvXQVYYJkJ+tNxZXCULwDvDPtiEeMUvS/OvbOpJHSLg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esar23x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e8004d60eso216242685a.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787152526; x=1787757326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vv//GFttk3qYBPU7mvMr/By4VJqy5iyji7k+koecDb0=;
        b=ZLBxoMjGxVAJukPYpz46kxXPUe25dzNErCBgeXL15i17CSAKK/C1aKdvvtDecky+zl
         nSxIna0FyuTOovQp5raCd0Aw9IqT3PUVBpmMjIw9henGD/hwGr1rnbUafVpMmhWGGtsQ
         oDSUUwVplt86r9H8/3Z+xA4pHZ8JzPiufV+eN5n6n5kxIY6f1VesFYIwF8DbqMCUBXec
         3gC4BYAIJFqJhJ3q3doZy3Q66N6hisL0o/k2P7le5P/OBJO9q/o3fGfLKV1z3OVt4yYr
         XpicB8vkHaqmBzwwD3Q/wlnXJX8ldcMzOW95U+yRmwTYgMvH8fsMlkgmJBx8/A5SyySg
         BE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152526; x=1787757326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vv//GFttk3qYBPU7mvMr/By4VJqy5iyji7k+koecDb0=;
        b=gLRFktBUrO/bK1YPHlNacgm8Ka1q+RlnfjwG3sUKTxBvCXcxh0fiLbQNJbUYJ14rtL
         Ri3FtIx3PRcloMcMBH4MJ0isPGNdA5yoDt2kjH7N7jclTLvcNIiqGuHI1eV2RXDwKeI6
         n3rxH/U2lrL0F8OhL3la6vpCptPrkWxl/Esnkcl4nDY1M0GQlF4ZJRurbNYlq7GyMRmr
         FELqKsKhQVvckqnPTibbmv1s0z2PXUhEGDrrhruER2kTiBSAw7iUhyWX4f5oMBtAenAZ
         cZAafuSLzepVzaH4PC5w6bq7dfK5espgMyB5HxzZJQ+ly+5G5ZtddtOj0gzaqXekwpBm
         jWQQ==
X-Forwarded-Encrypted: i=1; AHgh+RpMvJyQRv3x5ZOVNuoobav5ov8eIthpI1cCzmW6XtChaTEz+0Pt15w+TSGTf2qOFRjXvMxXKYGgFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvV+hHQYJhIFGnsPEeOewdTBLMFbDwmSgzAolFt1mb6KSFoPCc
	/FY6MAWh/QjNhKIUG9ojs5tRexnycoONMIfSJWJkIPAacWL3i3RgRr9BLye/qyTXD3KFz9+DI32
	McOBXyzuXiS5XQVoGGY/kW8FmypokGQXv00wC4sPWPbmAJU1grdx06u+dwkBgxw==
X-Gm-Gg: AR+sD12LXU2ktlVErlOT8BQ+m4txJlFQPt7JiOsT0X+tcmV6LS+pp1RiubpYvGohiLI
	ooEKklVaeNNwl9SUODWH8lPmAJfhY6KNeLOIN/ltOvgqLwDQnj9A3PT/9QxGuyR5DzhzfD1OMYC
	YNlp95D43JMdZiHEUewLv+eo4i+85OSwd10fk70gl3FQ5rNNlLgGeAgyrcmvYEjnEaph6S51rp4
	B55lYskRJ46ckFNcWTMGikt3lAlF9tRfVi/Jo4KHsLWU1F51uHhxCceGo7Uc+kbqAIA9Uf+PZxF
	qQLSaY4MTlne1WHAZDlMcXIPVCXngXjGkBNAfdAJu9IQAB5EJ3xJ5tDvifA6ZhbVvAjYL2XuAMX
	rX/KVz5g1KTwpvEsj8W41+i40u6jxklAWpMeFd215tr7Pj6o6xgX21B24Ig==
X-Received: by 2002:a05:620a:1d0d:b0:937:1710:f839 with SMTP id af79cd13be357-9371e79aceemr569267985a.47.1787152526075;
        Wed, 19 Aug 2026 08:15:26 -0700 (PDT)
X-Received: by 2002:a05:620a:1d0d:b0:937:1710:f839 with SMTP id af79cd13be357-9371e79aceemr569252785a.47.1787152525350;
        Wed, 19 Aug 2026 08:15:25 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c4ac06asm94124666b.33.2026.08.19.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:15:23 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulfh@kernel.org>
Subject: [RFC PATCH 3/3] cpuidle: psci: Initialize the PM domains in powered off state for OSI
Date: Wed, 19 Aug 2026 17:14:53 +0200
Message-ID: <20260819151457.256959-4-ulf.hansson@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
References: <20260819151457.256959-1-ulf.hansson@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX/G5wi7WKY50J
 JgQRd6oiEZvhf6QDGA1GWBzMUSAeLE2lpuenSWdIpLnXzewJcMyY436jU4JJshhec+mDtYuq8UE
 LbOtmatfA7EGdOZ+fpZCYnjsy3MZpeI=
X-Authority-Analysis: v=2.4 cv=fKcJG5ae c=1 sm=1 tr=0 ts=6a85c88e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=GddhhVl5-a8N4MGu71oA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: E0Z-Rf-dFXFB_zdNHYi7NaKn4Np590cB
X-Proofpoint-GUID: E0Z-Rf-dFXFB_zdNHYi7NaKn4Np590cB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX/tiELoxKOn/n
 uVN4+jIR5zDgUTRPi4m9e3M1gHgZS7Ywmz4ZYKXF33hT8SBPIw8EiWYooPK1exDEXPYPvX+0tYO
 DC+R1GYGK/xwpRCZ+0Iq+B84LLalpTTVRw+dA/l00pND9slnciN2NQKGzXlZb6u/JzkqKpXRBR3
 mJF+On81BW5RHCk4//jlfPgatveoPWiQqsQk/XcmoKSOptsZk76zdhY3h6aWzJLDTJyoMwbv6mU
 5mK0royTk6IlHnss09Fnkw1M50prz7Py+EIX9u/ieXC6Jkr5oYU4ZZ0ADmV6xi/hlhhlwItixH5
 EfVW9PKZ8GqiAN9T2SKyVRDogNAtAl+BMLV0b/QjSV6HdshqiXONDrDmT3TtI6v0HHi4Aj/aMa1
 8qE7wOxlvFimpLBJTPUSG//HNlQ6m/DblsLbWlH2Kc11/xj5HACpnT1BcoOKr8XN3AIZNLaKBMz
 leSDv5BuOh/XATUnKYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190118

From: Ulf Hansson <ulfh@kernel.org>

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
the GENPD_FLAG_OFF_STAY_ON for the genpds in question.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/cpuidle/cpuidle-psci-domain.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
index b9e4ad7d43a3..29caf3114185 100644
--- a/drivers/cpuidle/cpuidle-psci-domain.c
+++ b/drivers/cpuidle/cpuidle-psci-domain.c
@@ -68,7 +68,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	 */
 	if (use_osi) {
 		pd->power_off = psci_pd_power_off;
-		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP;
+		pd->flags |= GENPD_FLAG_ACTIVE_WAKEUP | GENPD_FLAG_OFF_STAY_ON;
+		pd->state_idx = pd->state_count ? pd->state_count - 1 : 0;
 		if (IS_ENABLED(CONFIG_PREEMPT_RT))
 			pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
 	} else {
@@ -78,7 +79,7 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
 	/* Use governor for CPU PM domains if it has some states to manage. */
 	pd_gov = pd->states ? &pm_domain_cpu_gov : NULL;
 
-	ret = pm_genpd_init(pd, pd_gov, false);
+	ret = pm_genpd_init(pd, pd_gov, !use_osi);
 	if (ret)
 		goto free_pd_prov;
 
-- 
2.43.0

