Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E63644AF
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208000; cv=none; b=GJ6WEsgVPXSsOlQNvfyK3gRkBnXKnCFEPFGj4j6KYgEE6xzTemRQjnHBjf0X86t/RhoicD7+8QKAEGH3CyrOwyJMiXRiY8hD6toJRqbHQEJyNwS8Fqp/UNI0MWAj1llnid36Uuj1clq1tIBH5j+lu1eZNJDo7f5DFBFw7jgG+P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208000; c=relaxed/simple;
	bh=hee69kKQIxporq4hpHQJrmvt+8VHKRthHchQouUgNHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOkYrdw7ZhIIsfrmVX+nMaAKnAVlifjJygSuovjA/2DA4xqPBGalyGkUofMtb67KkQkwHnaQ9PhWV3oomfLm7ANQ8rtpimitkq25r2BjHKundaG+Pcw6eY7kU3l8rvCU2oOFAAkafNqONwJG8mtUdkjVilMxOpM/aHSdv3/HhbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Csugm78h; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Csugm78h"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c0c2a68d01so1916775ad.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781207991; x=1781812791; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5t8wlz8xh6A0GblrRm2xNMS4IUSixAVnXUOD2UoJaI=;
        b=Csugm78hBqe0ytIB/etrliQyBsjClCA7/Rlzzkd8KDY8RXZLKE3aUo4f64l3lRCRAB
         6HkJzsl5GciEfGeghUNvbD9mtncrzNeV6UuHNgrDOH0yZFjauu9X4FuxH/MhdraqkQb3
         hZ5HzHBKM+2wiy/D7AtWhLWC2rDoU8TRbH81u4fHo9m/H33jI2UZu2RcjPqr8prASIBo
         lNhpO6+xI742myHmNB1OWVAH3VyBU7rre2UXCSZbLmrVd70LEZJdu5tTfYpFYWYrCyb2
         JyblmdeLu2zFJFOWzNlQJJ3WWnmwSOVKs1C7xMjKGpZiW9b7sJVG2Df6Kmyg7RTg/kFj
         KaUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207991; x=1781812791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5t8wlz8xh6A0GblrRm2xNMS4IUSixAVnXUOD2UoJaI=;
        b=asGUG+G7Pg97cG8NmPs5KzaWxPzx7oblLaG7NfMw8pfhVfh3LWcQwF1z7SbFEXjNGi
         CVfb6U5nL7ooOVWqyM3B3hQy6j0bBK0Kv0lm3WGhK5Q0ScQ6G+UWOqmpRtD22aSrm4dl
         KQDhC39ju+r/pyK2zKs4mzL/WpahggRCUDpgbugXUWOCAZBH7Mn49dGUBge862E3y5a8
         UuwPB4GQ3DLc5tJMnx8dsn4pfCq7MgcNpDscrOKX+ACvS5ldxjw8XREGdDlAAv9Ov3Og
         d7ypGX4eo2pmliPmxS9mB1BWSyl4tDLJGe3eRROipKlomYcDF9fEGVeE6yz9hbBUGKqN
         EkKQ==
X-Forwarded-Encrypted: i=1; AFNElJ+NIyBV812vTJd2jlPrCYJjhpqBVAgxAjATULeFBLt/mZLmAUAI/z5o0gY8Oq9TNC4do6dXzpHkaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+cpXzoL/w4JsgcGP6IKK8DtnrtZM/vxlueHT04n6iz/AZWaN
	R2KZe4rBo8Wh8scjGnpMmMmuh+bkV6k+QeKlZVUEthFiVWIUh/9d5fyV9NgGkUmiF6c=
X-Gm-Gg: Acq92OFKg5EpsYD4e9GZoN7FhNJA1c8rKUiHJKhOdNU/kbvNT0RYGS9obrhse97Loor
	crbalSXveY0W3Gr0JMAHcsPrmR8Cgy6fMqNwL9qvWpNOheQ+L7mZ+ukxnT713dmA9DXdHisp+xk
	D69gifQk3pO3bcAsGNnX+bGTTYAiuSDHnPSZOMECn7CdVkhiDy42k3Wcz2eP7VlMLlEpL0hyFgC
	iAF61Nn8dfC6JU/PIiNwX2PzulxieEuFDWpLE7rLh8f3CmR7kNxyq7o12BkuA0asknapkANGpY9
	6/8M4QYzHdeFKxwpF0Ju2iE540JgWlAP0tCzwDHJLIG4EvTlbV3eNOVdnWom6FjLYzQuuLqs4D+
	hn/KjvSa95OV/bdBvrsbVAQTTaqNEtj7DtiM8XeWEtip6pK7USpaqXWDH+k/jCXaFfBQu5Eqfff
	dzJ/k9zDpoNixile8vhCpE
X-Received: by 2002:a17:903:b88:b0:2c0:b5c1:8e21 with SMTP id d9443c01a7336-2c2f14f82d8mr50952135ad.16.1781207991376;
        Thu, 11 Jun 2026 12:59:51 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2c164f6d69csm284500295ad.2.2026.06.11.12.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:59:51 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 11 Jun 2026 12:59:40 -0700
Subject: [PATCH v3 4/4] pmdomain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-topic-lpm-pmdomain-device-constraints-v3-4-75d69438518b@baylibre.com>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=hee69kKQIxporq4hpHQJrmvt+8VHKRthHchQouUgNHE=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqKxOxR9r0YOhoMOutBTkhN0W0cUbxrg1gvmT1t
 S+6Tay9pmGJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaisTsQAKCRBZNxia0/vG
 ZY5XD/oDlYMEVDUGeOD5HSPLunU16CbZ1h+S84DD07Hii+FuW0RhH819u7F9fNGIShGg2tecrzI
 zJHKf5v2zeABuQRolxrLtRQxUUGe1617W5Ier5TbXA7LoBYepVjOv1kHj9+WWfv/Q5SxDVb8Pcd
 OVEUT9V3HQMMcLgPWH+fW9SI1TM6fopKcsFy23jUjV2Th/Oo3VHh4+oA7xs4OmfRAjsJSYWT+ch
 y/xydWrIn7OzcMzq4UXI3RbsXNOiuEesjEIMBRS7YcbL50mIUlHg+zj7+FdFvckxPwawAzW5kBo
 3EeYqNjjF+0zlKL+u76zlrVET1dy2PwL/3kdjjYF/yJSrLTC07SXMP9B7aFYxkwk6AQ2bV19hev
 CRY2b+TMwJBxYD50kb2UywIOOrh6XTE7V+SlzA8KdE/IFVcszsjQGddsKLnWIFXp3odCEZMkH/K
 ph7BMsDGrP0WwERjaclFaXXq6e0GYVM/ANjRslEuU3hdtIDuTSzvzRCtbKMgcOk58ucGSGsBash
 sgPp5/1472EOzGHqiKatCMawVq2YhVfj4mR1sKgR4N/Cn5f3yBtoF7m0HTwB4FcViVZ9o8jSCZ0
 hhtMdcnwH+2+PZyJfbvJzf5uKcu1mq1jIyPbEOjPvoeySgRDldjh6MIXLkCoINxwYb/cPga0fGJ
 IQ8PzClEmPSFUog==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

In addition to checking for CPU latency constraints when checking if
OK to power down a domain, also check for QoS latency constraints in
all devices of a domain and use that in determining the final latency
constraint to use for the domain.

Since cpu_system_power_down_ok() is used for system-wide suspend, the
per-device constratints are only relevant if the LATENCY_SYS QoS flag
is set.

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

