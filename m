Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F23C3449
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159336; cv=none; b=ARRtF+LgxjqyDX8Xoveysxnon8wzqgnI8tA3eLwhoejATXxKPh/Eew8zJ2wEJ+7HhSftN8yz3H9pC7kQ5IDyV4rF+spK99ERvtW/JIRfjI9ruzwEl7Sv/YVYCw81GHMJp1kE6y7TfmdGa2AVhCGWMYFU5M/5TiLRzzSFVJyuiEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159336; c=relaxed/simple;
	bh=hee69kKQIxporq4hpHQJrmvt+8VHKRthHchQouUgNHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jDpke72KALs0Al5DFaE3CAnLMgY6Uh/JaCBYg1suGKKe13ofmeOuM5RZ6f8mBTLcEHWcqfzSk5IwXOxUnhKK5YlAbS0LNtTSR5Cc0RKyPJ8+6bpD8BA1YCa7HIqWXDrdIwa1NT82ZsWHBTJWx6+rrg7zLUADkjXV7daFMvKDa2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=of9wfxPk; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="of9wfxPk"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso973217a12.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787159334; x=1787764134; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y5t8wlz8xh6A0GblrRm2xNMS4IUSixAVnXUOD2UoJaI=;
        b=of9wfxPknzKNEBvMWRLwI4oTgwZOP/E1nhQAQEwP4V8NlLyZBRtmQvqXPVcuHnvvXw
         UVa89/V3/C/y3MkZu2fS7eLyvJ7vOomqlUu/qRTZ5saRkZFkwvie2x1uJ4xOaxRhGwIr
         EuMqWw8/RI8kvV7q/Nq+wII4b8YjMV9LZoGvykhnINeslevd87bKg+aNJxxDXFz1yuiV
         iBN0UyLyyo2pCcl6vcgDCi8inYeLF4FtLJIdzS1R5/EixzsBR6HymSNN2Dgew2UXiSxF
         cqnHgPPFgPC0iaZ5GCdx6CuFsMd8WjDs7n9cZ1D3nTpCHc0F7T1OBsiFCKOQoUXvKHBt
         0zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159334; x=1787764134;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y5t8wlz8xh6A0GblrRm2xNMS4IUSixAVnXUOD2UoJaI=;
        b=WBX16amAoMEceeT4hI2fk0yLEEOVGJ6oiwCSdX6aqF6RhBVcgn3IMczDxwg4TzV5Y8
         1j9GwjJ53MmvV0OVemlybuRX0BU/BhruhYlVjHuc20aEiV1XN0JPBEKJ2XpiaDURFtKz
         lHlVWjbHmlU/8FJHd5NcR2h9111mK48eejgKeTNB886M2sNLvnj8YFncAN6w/EPycSjT
         RlLBEFe9jFxwI/2LRcE8snfyV4jVZIhuH3/Y/WDrLYPxwoiTIN1Z3v0BNnetpzFLgNRJ
         klnMT8e0phmG9a/TuDZXCXBpFNKgQNEp7oAnOOLyB+Mi/tOb4u2WCsqjhYRk6P3n1/yn
         yUtw==
X-Forwarded-Encrypted: i=1; AHgh+RoA68aC6TqtUreCIdlZrEYqTW0KNM82NUg7Kj4T+pBMknnvYGGq75NDlgXyBZAQvHriD84WpaznHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysBGz5KUyTIjiB3QPJJRm+2HLOzp+4qhbDOKQoAhXohzrspU6Z
	zLc7z8iH3DRvg8QIS/tMJsNmpBaUaNYbodHYDq4m9atAXGKAB9I8otCcJjvMXnyMR3FJdJkN5BK
	a4CzPEdw=
X-Gm-Gg: AR+sD1345G9welWUgFmRUUZQE536LKyLWYIGwSFqCnZk5G65pzyFUlO5V5R1MzOwCau
	MIQN2MpRnnz6rPqLRiivURsZxWv/0hH3CveqtFMADQAf5iJcOOPaqOpavTZ5J7KlGf2tJfonSoP
	bi2V4XLKpBbDJv19b2ov4g4nfBdI3KVb/HNX8ZHOnOVeU+Fm+YwFq1aEvFv7s/KuAMs940eyziE
	uwgcdU/2KFzSeEBsCkX+MIzITX/qUF+KhrIyHbJqUsAIC0VgAdF2ARC0u4uMMIqPDQjqDVAgjqE
	dL/t7VXs6F3hsjZeXD8wy7kTGMpF8DFAIMR67t1ccAjZbuLz32tsika/5eqKDmDb1Pgsg+FWQ1i
	yHYM0jiOX1IC6eQU7nX9/TwdpYAr6qPx157Wke3/XXB0dD/AIn53ckrFlg0c5RBHo+GcbT5C/0N
	JHqaffiOhfLjtATy6L2Cxejx1ZcQh4llDFMpL6IuXq7w1AWqEZl7E9ZLLMZQ==
X-Received: by 2002:a05:6a21:3382:b0:3c3:8d86:9856 with SMTP id adf61e73a8af0-3cd0128b46cmr11793410637.14.1787159334361;
        Wed, 19 Aug 2026 10:08:54 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-cc155675287sm862223a12.20.2026.08.19.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:08:53 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 19 Aug 2026 10:08:39 -0700
Subject: [PATCH v4 4/4] pmdomain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-topic-lpm-pmdomain-device-constraints-v4-4-7ceb095f5474@baylibre.com>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3685; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=hee69kKQIxporq4hpHQJrmvt+8VHKRthHchQouUgNHE=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqheMgYgqb9m8k6OMptsXlTicb5pRdRBlUE9gN6
 AjWNLVvyGWJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaoXjIAAKCRBZNxia0/vG
 ZWpkD/46WPRAKnPN8Q1ss8fSksmI6xyk1VjYM5pRj5kbCi0WsMa0T3bZVuaBDqapwAnAXNqpSs5
 AQpNijsW7L00fv/gJwVhhu4wIrddye7HEYJTXVDvJk8WOLMxzqdW/kbfTEqg8s0e52Ol/gS+N7J
 w10Xew1rnFmEDiFw8KyO+L/pOIZ/sSxJcC84x4iZG5iCG4fXQ9rJP6lXcL8svi2CCdGhMdhCk51
 rVhIyHVhrxmQKSij58Un4UrEsaAZiaikJyTb68qifVij3R+cJiwZ5FiBTIwtMv7KBhyn9nZwkD4
 Q0m/38t9nAZ0MZCbcojaQhzRiBIIYRoAYU4hgbRTkWsi4iPB+5zEN/lm1EQfmdfHVOR60MHSvqu
 nKtj3MTy19nCTi1GEbw+ADc4FawO+yIiTel0B5NXuJTPMwQiJOaao8LyTPl1q404SrUHLSjZoAD
 NAeanyngfGqQ/o36s+eQFGnoWNhDlWEm1vveRR8BiN7s1Di831VBY67lGkfVpwR6zVhmccSTOgD
 bq6yrjHZfHVulvggstknLwrnigra08yQ1/Ul/akc0RK5H9bIKOC22paRnNgzJ6G13fDl6AgP7Gt
 /fsPUw37g9W4aM/2SD/pc27Eie7z9EE7ZLWANAsNffltWb1drwLcw7p7et6Ge6fD18AuTE+cp3Z
 ikejdennHoQY1sg==
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

