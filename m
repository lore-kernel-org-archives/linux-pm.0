Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCFA494819
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787783014; cv=none; b=l0S8FVXNOFv0pA9r1zpClh+KIQwKH72nIKZe7sGoRlIgAhwWXTjg1OTzupaMCJqO5AFP+qsef1otJ3Gk8TPYdYCDF2hvQBDVSD21qB1KktVkzMyFtEI1YfeU+IpBpeBtsfidZba0DwaPFLT0ijYSgyLvZUleCdCH+a/OPhd+EqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787783014; c=relaxed/simple;
	bh=qhCmIzp/0FT1HMjgFAUTckPFBnGHIlkyocQYAr+qsWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JroGfnaIroBXN0+gKu38FKd/WYuSziFkz3kMqGiL5v7MkG5j0etJj+MsCRaGsx8f7plPyO9IZh0uc1DtIR3OR4we2Sx5zkSqY7eRIJWY2ErjraLzbAdYMvYSMLMQPuXqF6xSoPyOW1kHJXncz4OuEvRmCyT4c2RK1R0K5Q2xQiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jx2yrz1x; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jx2yrz1x"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1342915a12.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787783009; x=1788387809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YCxM69mybT560xdAeAhYtpvxwftOy/Pc4vdQDPlFYCQ=;
        b=jx2yrz1xUyqqVIhq07Bdq5FWXVFLAtuiLrWwQmxynD07tbfLIMagIIvdXaQZeTYx9M
         lDFA9PfqTY1+5861TgVNoan8KtHjddlHOPDrzUTSMzRGc0DkMF5AYgxeByCv5Iq/nNko
         EvIsAMB4G9+3ZjmTeiRLDKMfZWQ6QZ96IPQLPxY4O2wijV52Zd8mQEoQ1+PTV8zcNCzg
         cspucb+5v3Ej+WfoColiiVFJltykaMzXLPQiT7iL1Rkmnrw09p+VPmngBo//PnFC/pN+
         HtLmQOY8KLnmKDLiAgWYFYTnDiEQjaAPvwxPu8d9ZCwEW3sO+ejQC81XNKnbRHM7aE3l
         KoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787783009; x=1788387809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YCxM69mybT560xdAeAhYtpvxwftOy/Pc4vdQDPlFYCQ=;
        b=lC45WaKsJ9W3A+5/eWl3jlad5Mm6iY/xEOv7LbLI3adbHyCdkOV5jua6NNDceIYQWE
         2yiuuyMfiKKkKeypGEmP8CTOaJIbO2UbCeCz08Zdev9r64/cUkPkU2UZeJCCBm8LlVkL
         s5CW+6zETc/y29WwDHKXY2LWPMPvlgE2SBmOGVkFfK9f5Ofl1cEtoFJdPhhUDOi1fhdu
         lf7kvKQzJck3vk5SkErTO+UY9uoZkDBhKku/DEF9MR6a0S/g8Viu5EIJ7xM0L4/i9nvD
         UyGNCJ+ObB70n1nQV/MhpmoX9h8TTu2GagjHge5fzYJAcDFF/Yg2aL2pADZB8Z+cHltx
         N2wg==
X-Forwarded-Encrypted: i=1; AHgh+RolC+tiIbWkxDfiM9w46amYNEOQjG5L+T2Njj/eLf1m9YmbXKeW4CHCF/eHlUZmBZJVIBlrsCQGRg==@vger.kernel.org
X-Gm-Message-State: AFuF++mIRm8t80TJJx3SiDYRDw9md0lWr1fWKBe8cHGYrCmPNDWEJ+UL
	aubm72iobzAAyPmy7nNoY/pztkQA9gL8f6WWPSN1kESq3XU1BJBmi8keXgl+BOVPKno3zMvnQZM
	ripWC3hU=
X-Gm-Gg: AR+sD11TtzfOK2BHHBBQeCxBx3dp40kOsOfaIOc1L2fd8lRd8cCeIwf4v2TeX/W0HgD
	VV6kvXLbm8Lj9JtFPgS1rzfJgN9jKsClFa6HVR4dDxlIW3BHWiXDnMhlbH3f46y3g+fxH2Eyht6
	nDMcuHnC0fZB51mFqUOfFJtmC6L9VQBk/lwOx0V/1xptnsyISYgNTv8IRLzOcG5cUW+H3IJ9v+G
	QSJYqk2FHoG5HabWhY2c3SisENGEXmbtgIjrl2/JTu97NlCUp94ShGM9OngGmhuWpzcFXMB+Ff5
	jGBf8W4tSdWNHed2FrH3oU8goAob3l7B+Z4zrOB4m4iI7OFuCpziH65lqw8y54NOLJptAn01bbH
	n7TuydlZuZPJXtukmyR9uYI0h/1j3QYPbtkQ6Hg+jRCkXPiTU/l4h6Ll7d/Sn9X/31Y1+cZsgaH
	XktpN4dG7OSKQBIqTtwJYO8rCFRm08kQV36SiMTt7hQqCh/ClV2nADE6sxK32Cy7iWvhDV
X-Received: by 2002:a17:90b:2e83:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3966d160e93mr22267129a91.1.1787783008980;
        Wed, 26 Aug 2026 15:23:28 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-396afff2650sm66414a91.0.2026.08.26.15.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 15:23:28 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 26 Aug 2026 15:23:22 -0700
Subject: [PATCH v5 4/4] pmdomain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-topic-lpm-pmdomain-device-constraints-v5-4-28cbf43f7e38@baylibre.com>
References: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
In-Reply-To: <20260826-topic-lpm-pmdomain-device-constraints-v5-0-28cbf43f7e38@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3785; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=qhCmIzp/0FT1HMjgFAUTckPFBnGHIlkyocQYAr+qsWQ=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqj2dcj8LICYsP6kcZl89EKdspM/Bdva8ywEm3Y
 OnpiUwXjXeJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCao9nXAAKCRBZNxia0/vG
 ZdJdD/9/yRdiPtHBllwGxdBuUwGb/82KJnwYCFbHbnuGPOAIE7XSrnOuNl/Zcnq45oSffcCuwU3
 z8YkqPXWPqOrS9rpuHW1uRt6Z4SayFqUUfO4r7zY/T2BusrhA9nW3So/DbbB+x5rH7eb3BtGKuA
 lg8VyDtVBcbPlSP5xIDCW5cTyzFBMTkVd0Tm+rAtGWJ4KuPj6ZyEoSnc2zni1lwyKhaRcZL5MgM
 opZg0W4pQAfeDN2cdMLHn2L5XQRtHeTv9rct/9nk6tqXzni5mk9rW+TyT5GeOokok+zlPFWp+Qx
 G6tA+QMt735Ntxcys3meMjajhBbC35IwgteyCx68aVozaolnWTi/+5NmyjKcjAWiVzL3e0jFjGs
 zrqbBf6cXvzZcreCBsLa6TNwMUbux70OJm23/Y2yVUTYI6hohUuvtXdfCywLUUD78Npq7bPHBE2
 Ti7iNRuW5fDmrVOzLDrz6yxNxXTutGgnqnJmCjEsT8XE6hVCaddsnWdVGCCfkrgoHHDah8eHHSV
 vflkb0N+FA45K7aWpfAMhl6xM5us4SZOlvTe5XugTBeHxxaBMKErIsKvBqwQolsrjDFKqP0gSTq
 JsBDijLV90hPwTh2hsWchFgKDIGRZcFDcXLvjpvFysH+nVuyaQ5ZvYn704Tr6Yfd6dU8lN2g1h/
 vPHDlDbLHAmK0Cg==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

In addition to checking for CPU latency constraints when checking if
OK to power down a domain, also check for QoS latency constraints in
all devices of a domain and use that in determining the final latency
constraint to use for the domain.

Since cpu_system_power_down_ok() is used for system-wide suspend, the
per-device constratints are only relevant if the LATENCY_SYS QoS flag
is set.

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/governor.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 96737abbb496..1a85fd375db9 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -13,6 +13,8 @@
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
 
+#include "core.h"
+
 static int dev_update_qos_constraint(struct device *dev, void *data)
 {
 	s64 *constraint_ns_p = data;
@@ -425,17 +427,71 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	return true;
 }
 
+/**
+ * check_device_qos_latency - Callback to check device QoS latency constraints
+ * @dev: Device to check
+ * @data: Pointer to s32 variable holding minimum latency found so far
+ *
+ * This callback checks if the device has a system-wide resume latency QoS
+ * constraint and updates the minimum latency if this device has a stricter
+ * constraint.
+ *
+ * This runs in atomic context: for a CPU domain the genpd lock is a raw
+ * spinlock and the s2idle path runs in the syscore suspend window with
+ * interrupts disabled.  The lockless dev_pm_qos_raw_*() accessors must
+ * therefore be used here; the locked dev_pm_qos_read_value() /
+ * dev_pm_qos_flags() would take dev->power.lock, which is a sleeping lock
+ * on PREEMPT_RT and must not be acquired in this context.  The values read
+ * are best-effort, which matches the sibling cpu_power_down_ok() governor.
+ *
+ * The system-wide flag is checked first so that devices that have not opted
+ * in only incur a single lockless read.
+ *
+ * Returns: 0 to continue iteration.
+ */
+static int check_device_qos_latency(struct device *dev, void *data)
+{
+	s32 *min_dev_latency = data;
+	s32 dev_latency;
+
+	if (!(dev_pm_qos_raw_flags(dev) & PM_QOS_FLAG_LATENCY_SYS))
+		return 0;
+
+	dev_latency = dev_pm_qos_raw_resume_latency(dev);
+	if (dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+		dev_dbg(dev,
+			"has QoS system-wide resume latency=%d\n",
+			dev_latency);
+		if (dev_latency < *min_dev_latency)
+			*min_dev_latency = dev_latency;
+	}
+
+	return 0;
+}
+
 static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
 {
 	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	int state_idx = genpd->state_count - 1;
+	s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
+	s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
 
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
 		genpd->state_idx = state_idx;
 		return true;
 	}
 
+	genpd_for_each_child(genpd, check_device_qos_latency,
+			     &min_dev_latency);
+
+	/* If device latency < CPU wakeup latency, use it instead */
+	if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+		min_dev_latency_ns = min_dev_latency * NSEC_PER_USEC;
+		if (min_dev_latency_ns < constraint_ns)
+			constraint_ns = min_dev_latency_ns;
+	}
+
 	/* Find the deepest state for the latency constraint. */
 	while (state_idx >= 0) {
 		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +

-- 
2.47.3

