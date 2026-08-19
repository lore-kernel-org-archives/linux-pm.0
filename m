Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E276247AF5C
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152526; cv=none; b=m1oAbCLttCQqZjf1kwL8LaJiEFvFHCTwHRBj1BNQLbRZT/srCbORy3N1xldbCgF1KQOyhx/NhK+9rp+06NkkOUAaBV0b4V7R0cXmbjo8p6Z8762LFWUDtJa4aJ6r2ULAWG7MXWRIypPASjGxYiDTgEQGLrWsz8oIRpXhYVMi7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152526; c=relaxed/simple;
	bh=t9RKPwKIuF9czTJyUtLXrPmSVsdrAZssYJ6svQqtCmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCpSMqkf5lVw/yL8L4B1Bp8Ekoz/yw5ceZjfna2PpoMp3VcxWZGVbwR7HrdJaGatg1Cq+gwTPJQxDBQ07HXUtxXm4dHjO3r4T225WexMf0Zyv5+xD6u4v1cSDmeBEHwwnUgNNGJJdHuVlrlfTvsPGqL/B4OAC7T/9q7v+4kDuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4YS5b0u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c53jOteA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4YS5b0u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c53jOteA"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JF26Dm3606037
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bNB08OhPcvO
	dZDBtMLi9pQZN5MeRm7mGZFlCO0ycw6Y=; b=l4YS5b0upWHmz3bitOLRZsxZVt2
	N+jadfMhE52oSSq6PPJjAN90EIa8zNEmMnS5eCE1o5+s1AzuMX66A1t9EXQEMl0W
	huWgW7tWUGmZqXS+QMPF25X3mDrWB9jDk33cb4jCJf9PeF9XEdB9iSj0ji9Q9sq1
	Xdw/nwFNnY4VPNphMuxuPRLf7PD4p+DaxfrLOQkHQbnYa3BmOvDbmFdPAGjVst3N
	YMY4TY/+J/0PGWjlMDpM6s/IQs8jeYOOyxEM1TkURgkr2M5wAKI9R3XhLqEaGZaD
	dSmMYKqfagwm5wclwrSp0JMDqxG6Ncbgm54UDHFCmSCMP+zKSAwemVE3NqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5esar23p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 15:15:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936d067836eso145010485a.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787152523; x=1787757323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bNB08OhPcvOdZDBtMLi9pQZN5MeRm7mGZFlCO0ycw6Y=;
        b=c53jOteAut7ZZwIK1MUaAsYekBk7OC48g06zxtd4hJ9N7sWAlISStPmyH5x7/JpGlb
         KikKkFiUcokXw4tN9mumPBzuo78Pk787BedOHxTE7BN+ygnC2plt6DnvHVJEipEX1Z+J
         sEyvXORe0K+cf+GfxpoDCppqXmFNujqBxSpkm2LAeCX4rWm8jlMzNO2Pm/zU83Lhdw8h
         mGe5jttLDmisJhzGGtTGAhgGoqKwBBrCGGx5OocaZM4wgiQsyDvww20cKupW+HRo6l+Q
         dcLxZZBlOQhEWttAYnHuabhDaqc84iUqqAGwZdHVOtmmTSbkCw+9a2OkQTGrcn/OJfg8
         pgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152523; x=1787757323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bNB08OhPcvOdZDBtMLi9pQZN5MeRm7mGZFlCO0ycw6Y=;
        b=VtU/sBRjwWSEjCqHWLQlFgHY6dgCmTS0JemUuGWV5BNpusAJtCRQ6xFap3dZP2VAYb
         jAsQMNaO59OW5+aHoW+QBLDVjn7mIvRiTjA710ZUNlgVr77vILO17PpCQlxbd75kzCBl
         eeoJ4qtwP6UxdaFXkGvFcYatFGWdKwk1UKT2AetHnfva2USDWGqsfMXNdSnUL92iX64J
         QAX7+lA8fzJk8gNJm8LF70I07Jxzav2VNhVxhg7qZ9dt9FSGURPHxF1t+gz6+rP2q9A8
         RvdVbsu9OT4dqCD5DtCRFrhbZ18qqAP1jd14HUvM/5WcZmbzly01PmeU24DLUvyssZCd
         2AyA==
X-Forwarded-Encrypted: i=1; AHgh+RpLu9MYfgBFhJyBNwryP4zDm4ROyec1z7ughuzv0ooXWBQIcz7khMVFu5U2HpYy3YhSUbcJ7ETqgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6y+wWCW1adlLt9Nix6h+VNQltYkCEw6NiEZp+rUL3Ot/0Lix
	5uQtwkEOEeQvqyF/wOidJo4d1gC/ExDg0JdDId6ey1JyuPuYi+kdZZknMEqTLYF3qZkp0rswv3m
	2Xco5tdCZ11rHFL40V8taTvoIBum/8aI2mm73SECfZlD+71eQPcXK7NRlWjOVhUvdW4r7Wg==
X-Gm-Gg: AR+sD13k9mNu2zH6PBiiAITr+EajY1QxwqF3QU6FldlgZiI/SMcgx/HROdYrstsZAO4
	w6snm4Fpzf0qMNM2xxuTv5NxhXYLAc5ldOJR7yYURM/v0iBRIpbH+mMxz7upok3QOqmMgemmYVg
	iF7mlO3cJxBMRIGcL2za3fQUjrAdMAW4yTVVpU9GVnk6VgOq5JiI610ttZlX5+55u2LaD1ZjCdv
	sNjSv8/X3+vdua2YtKV3EWH8TLedVvGFkuMRrO1dBMjBmOODV78nF012sENumWjqa4O2cAhApaQ
	hsw7b2RUsUmMMpHPkW7VZb9y+GKftaoywViG3VvhEZi29mNBXiiexBxVAaT+ebcSmJwAhNw0kaF
	GSUOoTxeNTvZuJXJZ1gzFQdbhgJqkOxv6yBlrNzwa+TCS0kMNrf4G2rALQA==
X-Received: by 2002:a05:620a:46a9:b0:936:befe:42a4 with SMTP id af79cd13be357-9371e6b710bmr500317485a.42.1787152522982;
        Wed, 19 Aug 2026 08:15:22 -0700 (PDT)
X-Received: by 2002:a05:620a:46a9:b0:936:befe:42a4 with SMTP id af79cd13be357-9371e6b710bmr500301685a.42.1787152522169;
        Wed, 19 Aug 2026 08:15:22 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c4ac06asm94124666b.33.2026.08.19.08.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:15:20 -0700 (PDT)
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
Subject: [RFC PATCH 2/3] pmdomain: core: Add a genpd config to support unknown initial status
Date: Wed, 19 Aug 2026 17:14:52 +0200
Message-ID: <20260819151457.256959-3-ulf.hansson@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfX5yQyMm/fJqWO
 2LA/lVq4YhkW0pbP7bpEdKFfcadq6kpyPzBVV6CxrXMiClpF23ElEyLfGelYhWnZzQTodkkoHK/
 FeSOnDxl0FiNUdnSBhwsFyV323j1A9M=
X-Authority-Analysis: v=2.4 cv=fKcJG5ae c=1 sm=1 tr=0 ts=6a85c88b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=h7aNHqOhPKB91FvYUefsSA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=EPyTabgPSFAr6pNicGcA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: cur_ZEhwim2nfXyKUb6HPP7-i9dW4CMN
X-Proofpoint-GUID: cur_ZEhwim2nfXyKUb6HPP7-i9dW4CMN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDExOCBTYWx0ZWRfXxKEMRnWJxkXr
 vTMoZnTERT2xpafRdAoQ3OZ03CDNDQ5LVs4NjfRVwqyoqAUjoRtHwKrVdC5oxwpN92241atp2yh
 1NzMt4a3dC7RlA1qJ1DkZwPuUMc3Ey3S+SATnHSHs1vkH5IPHXrL08EfWI/T2c7K0mQd9tA3Mwx
 S+S9pKbjUrxmICx/RlN3GUNXxT3pubdtIxHLgekQDnUDt9FFzowgMbqNpeEltyQ2SFGvg877Y5G
 3nRf/Y5AhFwOrGlttB4Na/IeJiWYsGAxv7Vy7nULxO3e1sytwcllCJCQyoR+CcwcvN4/BjjntoG
 eudowgldX/6aqflauPkxH504tTw04rWb/JS3HnNam57dHqhU1d3Fqf2f64FTKcFj267zAJmCQ4u
 W89LZjJgO9AkMrkHkrj/QUXTEb+3e6HL4gECKDocAnzao05VQN139OMMh6oH/8MuiNKRDuO231b
 Om+P4LCabjQGJWGhadw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_04,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190118

From: Ulf Hansson <ulfh@kernel.org>

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
configuration, GENPD_FLAG_OFF_STAY_ON.

Reported-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Link: https://lore.kernel.org/all/20260811-domain_off_ss3-v1-0-6a0a0fc023f5@oss.qualcomm.com/
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
---
 drivers/pmdomain/core.c   | 6 +++++-
 include/linux/pm_domain.h | 9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 7345c06f1d55..be4fff2f4664 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -189,6 +189,7 @@ static const struct genpd_lock_ops genpd_raw_spin_ops = {
 #define genpd_is_dev_name_fw(genpd)	(genpd->flags & GENPD_FLAG_DEV_NAME_FW)
 #define genpd_is_no_sync_state(genpd)	(genpd->flags & GENPD_FLAG_NO_SYNC_STATE)
 #define genpd_is_no_stay_on(genpd)	(genpd->flags & GENPD_FLAG_NO_STAY_ON)
+#define genpd_is_off_stay_on(genpd)	(genpd->flags & GENPD_FLAG_OFF_STAY_ON)
 
 static inline bool irq_safe_dev_in_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -2445,7 +2446,10 @@ static void genpd_lock_init(struct generic_pm_domain *genpd)
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
 {
-	genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
+	if (genpd_is_off_stay_on(genpd))
+		genpd->stay_on = is_off;
+	else
+		genpd->stay_on = !genpd_is_no_stay_on(genpd) && !is_off;
 }
 #else
 static void genpd_set_stay_on(struct generic_pm_domain *genpd, bool is_off)
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f925614aebdb..9929347e1d7f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -121,6 +121,14 @@ struct dev_pm_domain_list {
  *				powered-off until the ->sync_state() callback is
  *				invoked. This flag informs genpd to allow a
  *				power-off without waiting for ->sync_state().
+ *
+ * GENPD_FLAG_OFF_STAY_ON:	Use this flag to inform	genpd that its initial
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
+#define GENPD_FLAG_OFF_STAY_ON	 (1U << 11)
 
 enum gpd_status {
 	GENPD_STATE_ON = 0,	/* PM domain is on */
-- 
2.43.0

