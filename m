Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BC46AF2C
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 11:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788779843; cv=none; b=kMJSe+aWkr7r+tD4W2KtIFAZeAiUXlgoxabmEhZzVaHPsGwzSZru22jW75m0i0bv5lVdEnZMTfKj6qT5/qYWndXa6UqyncqV1o3iWBtgCbshKELMaWtOJ5iRuGqbsIj9H+OeZvrMuzdEbzUx5fGPQEVPoPpnMKhEVUCbDNAnNAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788779843; c=relaxed/simple;
	bh=hqlT9anTRmD3gqufcOooFJjBVMwFzMEzazIesH8QlhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQbzn+NRrwP8U0yLlm4mjUgi4Vsx4SvqLErSW8mZRGIoYaHn9KxYTm1t5zhT0Noff0y0zCj90RNFieMLVOW9sFB4bmHyII3mzo4I0ahZiFsECPXn30t9t6nIU3BXs5yizjs86fsLw65xHC0Heqwasgm0upjl8BK8j1xHQ2Z7wmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzwKXE1r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvtNgbs5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzwKXE1r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvtNgbs5"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687AmscB3180789
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 11:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=V/gIsitsveU
	0a1AR6GJ+0ZzNVuCwkMUNDvqqmLHk98k=; b=BzwKXE1rj6fatD+luaFzb1NGkJC
	rUjn1tioQPU4HRl8eyhJhqXWXcsAFvfq+1VG3hbGpaABhG+NaGqvStlNhkgOdstm
	OvMUTIQJSZM0p1Dk29+xBEITPnsN5ebGi4oyT/cWJWDiYJMU6/7djULGMbfijDar
	ALdH2muZyC9JvdoBClIH6vqOs0KAR6o65YWuq/xPlBU3GvLFQF0uoel3cLSxA6XR
	t2nXGGVm+sMEKnHBZj0DAK5pt00eioc0Xuh406B2aFvyzHqdrIXhvVz/hHFiF/Bp
	eurgZu+sH/MQeTpaVUnlvpazenRNchNj/RyhHL85uGaZzWDoKiNCWK2lhoA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghsw20ny6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 11:17:18 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c405d3e18eso4609675e0c.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 04:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788779838; x=1789384638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V/gIsitsveU0a1AR6GJ+0ZzNVuCwkMUNDvqqmLHk98k=;
        b=gvtNgbs5BkNefs3rMRKX/V3QWvy8T0CAGYrGG+5Mj+z3rLHnWzLA1f5wz4gsMmekWB
         DUpcnZQKVazSm2ADuCxDLllyP4SNxFw0ZH9H7DVkwVr/V10dZEYjDD2s7MLf+wqvCkbm
         2QWVN63qJnnke1WgIHoGkG/C9oQZLQU/gQ0ErW8Jnwsa8teB+i+6mNqpKtSq0j329K8V
         aqU4qki8tQN0UEqGBB/IngHdwQg4GxGK3Xb3zRxUV1ZLnzFObo8B7dKvSnhn4i8gLMAJ
         eQzwD5cUS+xBcgqcl2IzIbk0GjktESdmE/WZr4S0xDJwpqZhEm5SpdGFDIRRHXFmJ2Ma
         Yi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788779838; x=1789384638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V/gIsitsveU0a1AR6GJ+0ZzNVuCwkMUNDvqqmLHk98k=;
        b=ozH6CFncHGiQ4iT9rxgrt4lABe9Vt2DIgEgIUj7RAWBJ6XltDHa2ugIwovs6Af6f5e
         Ojsell2KekiMbom7yImt6XmVUeVzRbhGgTJ5T4P1OmqPO4y4y8c9W7WJEj34z+rIFAeX
         OVWG2sjLtzUj7oz9X1TUHfb0kDI05ucHNn7tiZGjxt76fxgduZfQItcRMQBQ7cY09XTC
         IJy6ng78WmnrKtfJ4XG5bkJ2iJ/J8+pLMStz+t30VvSVNoPuhNV+9T4S7YuaX5Oq94Ja
         e1ZsFkHn9VCZGfno7odknO9PjILALY2r+w23hq8u0Tddk6U2km2SixVcqxG+IJZtncnN
         AwtQ==
X-Forwarded-Encrypted: i=1; AKwUvByh3wOGaVYPhKkosli58XRk3XC02nNCt3lt7XzwMy+GBUvFzRuxDo0dh8VNYGnWCOu4zZ0FpVVq5Q==@vger.kernel.org
X-Gm-Message-State: AFuF++lv9p77BJ3S37cALm6SQO7ByDtv/A2q2I/JQEab+ZeHIgdJb7a/
	7EE5SLIru6GLvZnJFl9dTdIw7k4RZxJb28hl13z0WNpyjBCt1jh1dn/FwFh9JDNoLf+8oEMCIuS
	vB5fcLXpulXoAYHlVdVoGnqLE2Z2IXj7ZafLrdK4NRupbqs7hc9xdaGnkTy7Fgg==
X-Gm-Gg: AYBFou1J7I2Eyq9emuvNMUNh/CIflMFa7qzAge5sXxOlq2urqXXZsi1i8L6Jh4GKrvA
	uj4B+o9j1h6rJtnWFodIxSgiRSBfB8Lp61E6zr54+8Sr1iR8loSq5ADgY2PtpGHQ1YeCMuZzt4h
	Vm8fNu758Xv2NuV9ZnhV+3FjTEe19KyuPe0zAtj5pyjFIsAMfcT0sHRx+p/eM36r+vxKV6OKAv1
	YxV8w+2fSYvMvrud/EmnDButW3tGqw0XeALSeKeSRbqhaB6Q5chA2SGYaaEPuDKdhwt1R+9yf+v
	4HHcOcpz06q6A+iKo4CFxt4g4NLKAIEU44mKBRbeZTRCwF4YKJQE1KhIt8PcM20lMeGhBwCe9RM
	tsPro4PoEPIh3RrlQr+LHNra+Or1a63AAfemVWNTsJUl/dsmcYQlrA5vGhg==
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id ada2fe7eead31-78a4a87d391mr9129623137.6.1788779837801;
        Mon, 07 Sep 2026 04:17:17 -0700 (PDT)
X-Received: by 2002:a05:6102:509f:b0:785:e444:15e4 with SMTP id ada2fe7eead31-78a4a87d391mr9129592137.6.1788779837379;
        Mon, 07 Sep 2026 04:17:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5cfaa2sm456120066b.59.2026.09.07.04.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 04:17:16 -0700 (PDT)
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
Subject: [PATCH v3 3/5] pmdomain: core: Add a genpd config to support unknown initial status
Date: Mon,  7 Sep 2026 13:16:53 +0200
Message-ID: <20260907111659.263324-4-ulf.hansson@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: oa1eL-fDgHrfO-9lBMcV_g_WXchGzO1x
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX9/WlL+siv8gC
 IY/lDA6YZIKluYZZBYHswyXmQsrObrY3jmZFuIwBYFOev/YVu+rKv/guqUDKvbq81AUzqrKOPSs
 XJB5ZrICSY5Lliw7wAG3ul3+n6Pgru0=
X-Authority-Analysis: v=2.4 cv=eKwjSnp1 c=1 sm=1 tr=0 ts=6a9e9d3e cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EPyTabgPSFAr6pNicGcA:9 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEyNCBTYWx0ZWRfX8zzEz9MyzzA2
 wEuwGpnY2xGP2u47wFwG8cgR3hVNkayUWNi6SCHiHN82BaOP0pwzdwRmnXTaAcSYrzilQtwNGNr
 HW8UAP0OTWtV0vQiIavWB/fuUxc7nMePkdnjhrEIrtdvCDraAGjCFMUguCmEoeoqLovvwF5ZFip
 kLc01u1UkINIf1ldNvjmbOZknQHAZmm++69H4mRnPhxi4BoWej51u/GWU/4fDoGZEeMb/EZc4gX
 vQkzT9vxu4N6/vro2NrVcZ7aWoIGxhR5p40Ne55uN2AwVVy9XsYJxD7bkU++BZZCdflEBsOZi+P
 MnZBe/2Q8PttfRE14N2hMl6HbZpRUG8S5yZBbvmYW9sZN6IHY8OGd95wfRxV/3kOKsIr6Y62OW+
 w1xAqlPqudOZM9gEtN0AuWIoU5cFh4uz4Kyd6VR/q2/wVKFowmMd9YMG1D0M5P7RaAI17EHXY//
 JZMv7BkQ0cPHLkwdMCA==
X-Proofpoint-GUID: oa1eL-fDgHrfO-9lBMcV_g_WXchGzO1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070124

It's not always possible for a genpd provider to know the initial status
for its corresponding PM domain(s). To register the PM domain in a safe
state, the genpd provider driver may therefore have to initialize the
genpd's status to be powered off, as a way to prevent the PM domain from
being used when it actually could be powered off.

In these cases we may end up to power on a PM domain through the genpd
subsystem, while from the HW point of view it may already be powered on.
Under these circumstances, it may also be required to keep the PM domain
powered on until all the consumer devices have been probed. In other words,
until the ->sync_state() callback for the genpd provider in question have
been called.

To support this behaviour for a genpd provider, let's introduce a new genpd
configuration, GENPD_FLAG_POWER_UNKNOWN.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Tested-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
---

Changes in v3:
	- None.
Changes in v2:
	- Rename the config to GENPD_FLAG_POWER_UNKNOWN.
---
 drivers/pmdomain/core.c   | 6 +++++-
 include/linux/pm_domain.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index b62d4e544bc5..5b31ed47d3f1 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 #define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
 #define genpd_is_no_stay_on(genpd)	(genpd->flags & GENPD_FLAG_NO_STAY_ON)
+#define genpd_is_power_unknown(genpd)	(genpd->flags & GENPD_FLAG_POWER_UNKNOWN)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2445,7 +2446,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
 {
-	genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
+	if (genpd_is_power_unknown(genpd))
+		genpd->stay_on = is_off;
+	else
+		genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
 }
 #else
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f925614aebdb..14e0e346c610 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -121,6 +121,14 @@ struct dev_pm_domain_list {
  *				powered-off until the ->sync_state() callback is
  *				invoked. This flag informs genpd to allow a
  *				power-off without waiting for ->sync_state().
+ *
+ * GENPD_FLAG_POWER_UNKNOWN:	Use this flag to inform	genpd that its initial
+ *				status for the PM domain is set to powered off,
+ *				which may not correctly reflect the state of the
+ *				HW, as it's unknown. If the PM domain becomes
+ *				powered on during boot, genpd will prevent it
+ *				from being powered off until the ->sync_state
+ *				callback is invoked for it.
  */
 #define GENPD_FLAG_PM_CLK	 (1U << 0)
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1)
@@ -133,6 +141,7 @@ struct dev_pm_domain_list {
 #define GENPD_FLAG_DEV_NAME_FW	 (1U << 8)
 #define GENPD_FLAG_NO_SYNC_STATE (1U << 9)
 #define GENPD_FLAG_NO_STAY_ON	 (1U << 10)
+#define GENPD_FLAG_POWER_UNKNOWN (1U << 11)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.43.0

