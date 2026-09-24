Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C834CDA0A
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790281818; cv=none; b=e70SDrBO7FfiYmZV3CLbxo3l9xqIjSk4aD/bYVBdCCQ2QjCGSPxP3zd/RFJQ4lJGRm4ZFssCzSAlvou0UtKPY07fbXa7kaJh4Vaw+kfmD2NYj099y2zle3iqrukUWwSZLeLcn69gjHZF54qKilFLKiMbKoLWTITXpeFkaTf4rp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790281818; c=relaxed/simple;
	bh=fxB9/+5eO6XoZVLEUDljaQutKEB1CcmARzOpNjDG6Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LLW/oZ5YOLHJiAPFsXzMDYoXXhko/DJg9YhI8ca/3rD4ypyGWSyQoXWe1Ngp75HWO6Rl4412itzkiBcrNYZVuEXDvZTgngk/F7mArTPiXMV83y51aCPZLuXTTbkrh4MahoK7dvcNQ0t7upgbHNzlLAKUXYIqv9CmCUwBXF1bdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aC3ms5zR; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aC3ms5zR"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea76so125033a91.0
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 13:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790281812; x=1790886612; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VtYe1mtbd6bH9b/KMUQTjop2olezXt+Q+N71ctrgkH4=;
        b=aC3ms5zRHP7B2AUCo1PjLhmb2qBbesZZiH47YFv+ylr/DwbOOYOhQFOIem8SqDajiX
         yEWFfaZZGRfLs/FHJWUm1t5iN80Qy6SVQmcTQyDxcYl6PPoAv/fEGJVQalzZMq/gIAXw
         v5XnQbnQ9YP/6OE495H4Qra0lJbkmzeoTcRgxKEqS2rC/A3mADazzF0OUunyNpSqcAIn
         yb+s/7b0LmjQXYluCeay4I9WxlHZfZZv1mC1nG4B3DuwqRAWf2dzPMUGx4wzsXgS1uqA
         0k+MyMraAd/0f9vU7bwtQD3G2N19bj5xS10QzlnuVMH9FO6MOcXihZWTHbe33VKd/bF0
         P+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790281812; x=1790886612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VtYe1mtbd6bH9b/KMUQTjop2olezXt+Q+N71ctrgkH4=;
        b=YBW6SLReryHvFxViO32OaodQNQAXom1cMhe4xo7fVN1VXz9J2uBawc6534c49oAknW
         L/1PtiCNpkSq25jZJqnUgDEcFl5JAeXga8LJz/eLsWDsKFvxjZe5CB9NEruknio/Na9b
         CDDwyiq8XyUN/8dOS3UDeGB2QeUuXvgux6SDOkfN62qtVUgjn5aeb5u/CQrepyPsnrui
         prwbUiGcJf4A8GXEjah6Ag1Q4XGkIgjBHRP8791h/n8HRzzSTESdwzEMOY0SkraOJHVI
         0oeIpkfEdkW9AUr3KtWO4kiXx+lsXX0wDxqG8qQm/q+vRW7hptskp+MsdnxzYYRmP8KH
         S8Uw==
X-Forwarded-Encrypted: i=1; AKwUvBz700fs7hBDUI3QGx2kSFTPLBUniBYxGtGaMuy0LNHVG+3Vh1WimODigAXuT2AcHBcboi39/A4Fng==@vger.kernel.org
X-Gm-Message-State: AFuF++nccyGjn5PZD/GIt/pnsy2RXJ/UaEfwLGfop1AItsniNfxGoMOc
	06U6XQ173uPYyF3ogg9EK8GshtMWfDCVVm2VU5MpMZgZp6c5fT2IquR/knDeuqaZLiYsxt3/gpI
	SafbJ
X-Gm-Gg: AYBFou2UmLx/SprCyXBzmCwCqEFT2ZQ0Ec1c97wWLVCosJTcmJTgIdIAMnaMUho0PyH
	0mzSboiXvcxccRhbSO1A6zEWjfri6l4hCTTW3uQ6oEv5wYo55v31TVYUobbbzjyku1RdLHP7jX9
	pUoNnND5U/UpvS6Hnw6lWAoK9U4/cTPixgV+JtCVWjmMCsh9ECbnvXVnldKE5c5K5CMxrVOlW4B
	09qJzGRkLU+U5Q0JF/h5DhI6FLPbDjPjUYEWYPMFU1ZZ9+dh/y2JMYmZocJzsEIGzVSIml97tUL
	S6vhaiEHDYCYGRKYldKvtiFOE8wz6o1w1Kjc+1uQ3+eOXfhoKDIfn21ACFCm3ReXYoFE7ZhutRH
	Bxz74CKvqmZ2cXDeVNqcvYER2+apUylYk/VeAlC/mAponLMhny5V7H+3Z3R9zzGlqILTiPgXRHT
	MvrOTD6EPTjqWSUC3Dx2Z3Qvd9GoL9gvPA5GwKoDMAEiqaXQnOb98Kf3ERGVjYLxrYxmvKYsf+L
	m3+Lw==
X-Received: by 2002:a17:90b:2e03:b0:39d:e1da:81e5 with SMTP id 98e67ed59e1d1-3a09864ac91mr2524573a91.11.1790281811835;
        Thu, 24 Sep 2026 13:30:11 -0700 (PDT)
Received: from localhost ([71.212.197.238])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a0b99e5220sm314936a91.16.2026.09.24.13.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:30:11 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 24 Sep 2026 13:29:59 -0700
Subject: [PATCH v6 4/4] pmdomain: add support system-wide resume latency
 constraints
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-topic-lpm-pmdomain-device-constraints-v6-4-a69a4856252b@baylibre.com>
References: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
In-Reply-To: <20260924-topic-lpm-pmdomain-device-constraints-v6-0-a69a4856252b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3127; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=fxB9/+5eO6XoZVLEUDljaQutKEB1CcmARzOpNjDG6Ew=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqtYhO/pBs+HJDx0CB6GxV7vuaRHLxW8Ie1Uk00
 mUuwyb/tf2JAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCarWITgAKCRBZNxia0/vG
 ZXXqD/4yQNgnHK20pgLFU9A+2dkachcRKhy7BmE6C0dKG/2Ga8ieae1CF8vwiSc6iRznzP69n/w
 du5dDMcMZqlFpJPLZJTBcrvrb4bl1PHhCIfTU1Bze7ksdUf9ah4wJgwSuURcJI/G6YP77AXdPdo
 BjjJsZTNiS0Zq/k8DIWuSDfZMwDb4Mz3j6sUTbeUtd4LkSPd8QJy3rANQLKLadsIZvExvtlUhMn
 pnILxbXPmhDZOGV23PGbtRETXlnBFYvSK0khqodnYQj2gs89CK+H8B7R6y5jIfkAdb54ZGRvExY
 YwRlZPVSN8KAKSG1y1u/RGP8g9be6nKVexPa+b1Iq55oN3ak1zKftF1q8u9YWgvSaxAdf7LIY7S
 iFCbq7LLedAaTJPmCSmQGN+4XlsejTBR5RstVwq42xlaAt74Bfkre8VIipO3hLe2x7uDtaKALIX
 +6OEjhl657e80fKJB3EwEVKW931qh5cY7KuDgwvUBk682PNggIOLRUICA4tZgVG6/FtjF0ebvZO
 n5mSz0zKEeiOqoykoTZSzuEGFuebgY2go8xfIT30V3lrfbdXZp4e+rY5/rfk3aZfkzVrS+Big55
 TdvElL0pfrVzBt9hKBSCOK7SCQxIr3MOcpJfGiSOUx+gWb2YPoO97VaCywQ14wZxCUb5QxZ9urF
 svtb5dOTJBfDCfg==
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
 drivers/pmdomain/governor.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 96737abbb496..38bba24ec26e 100644
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
@@ -425,17 +427,60 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
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
+	s64 min_dev_latency_ns;
 
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
 		genpd->state_idx = state_idx;
 		return true;
 	}
 
+	genpd_for_each_child(genpd, check_device_qos_latency,
+			     &min_dev_latency);
+
+	/* If device latency < CPU wakeup latency, use it instead */
+	if (min_dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) {
+		min_dev_latency_ns = (s64)min_dev_latency * NSEC_PER_USEC;
+		if (min_dev_latency_ns < constraint_ns)
+			constraint_ns = min_dev_latency_ns;
+	}
+
 	/* Find the deepest state for the latency constraint. */
 	while (state_idx >= 0) {
 		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +

-- 
2.47.3

