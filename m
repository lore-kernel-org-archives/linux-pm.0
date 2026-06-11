Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDCA3624C2
	for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781207992; cv=none; b=BwcIDUXKWuFC9vf4/oyooM0IU3y9+5J/XNzNheCL9ECGjRv5D8Fv65jbNCK8hQ7XlXf5pVK5m95MK8+oP8O2BsCiuHup3zhG79chB35CyReU4kydpJRggo2VXPw9/9iGxae0kNlLh7WNCp/+R/WKz1ItvJ+/Zx9s8i3AVVFD7jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781207992; c=relaxed/simple;
	bh=lSghmLcBqOaXz+e5q1UZsb2LiJb8cgQOzwadP+r59NI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EwdeuIHxrH6sjyu5BByLnxQ66C4CtbZOHO3byCE1mmnjF7WrqhZSlXMf+lz0iiZu9wuOfbbjTdzCXluebcjjwaDf3amkf3GSvHy3Zgf7dtwHmz1sgvisXwOUJBfKk9MXQw/7zfYsOvhV3rtSpOPiwjw5qljaYjf1u1y4fvzuKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=RTvrFZif; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="RTvrFZif"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c858961a8efso93062a12.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 12:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781207990; x=1781812790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSIBejhwHlB5hEk0OQhpOZoYtknjNxZToohEVhY+Ui0=;
        b=RTvrFZifTiFApCPUq1yM+TSewlLPdDvOXmHW0FYFhoQ8YF6fTtGuJD9jyQALI9OzUx
         kXXJqays5ntRl//k2RofAtye8X4SVfjg8oAEqhgQmileaGjyvppYsA0O15g5GwiZwxFK
         WwV2i2UiSPSMhy1ci2gltALc7CMsYlaTpkIKg3uiDGT4UmqqUbsfafJzGys1Ym7++STm
         Aq5CO+Vc+6CvEWo5kBxBq9TM9sTaJ3iShNcdn1wUnQsxH5Yd8ogAbRpI7bsML2SPsAd8
         Rr/0vZzuqVsX8wbShTrL+3cHfCViq1MNPbiIOEwT4lKMrKcf05RxALSEi7eUo3xyZMJA
         vKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781207990; x=1781812790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rSIBejhwHlB5hEk0OQhpOZoYtknjNxZToohEVhY+Ui0=;
        b=slH/EkBk4EuS9TGGRxCYWMBkxEAJ2fG6+7lBOxTiBtWISrEN32CefY/CMaB6PwCQej
         61dnhxQsCYNU6PmgX7d1UaDJOmCPTpmlmU0UfAm810ZF1lzoXD/FSP+037xlO4f07WLx
         pqBjRrSkvRN40QH1Ehjdl4OlpdTLRH/uzjCfpXD0pCAYg2w6rOoIb4FxJEBHV9TVal/0
         5xANiwbjnXOM2eqhqJ5qCthoQJ0LbEjZO8HOLnDc7H/MIQDTvX3nLxHZWqudAPV7r9hm
         x4jU9aA5MN+05UsYCfN2EEmRve2uTC1WiTx8sYNhESHEqJjw6oUWZfkEHYUSY0dPDrGn
         vTFw==
X-Forwarded-Encrypted: i=1; AFNElJ/BnmvQ2BD/8pF8WbsCCNKa6PwGNHCLOEqYz7K8BeldDRj1HECIwBdhZj4ndkOTQUaSKkKSuMTiXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9MjXeqrFsJ9VNDYtnGsa4Ys45GWOLntyW0xtuKL+9u3efrRl
	skvL6KN4nLbipW8H+0HAIw1z2jvDbxTyH4JqlUuFoti+7Xj/nkYKoxh/SP0IGVcpFnA=
X-Gm-Gg: Acq92OHpNjoh8pjr+x9Y7v+cReB17EQcQeE0OUk5AkzmKOZNj+r8k7p4g2zW+mjrMDE
	z8s/TNw9vHuDLGYDBXlNzO3PHrDjTe3yh+I2nXAeepAqukX84VbAAIjQOBK9VwA3jG4veBGODi4
	sHjhwcaPhYsWXKzOaxCeZ+F1KHYMp4JfsDovGY0T+JSXtg8qnrE3h6Wa1ut8cNhNXwkHoizPR1H
	3nHAVLPfxerKRkvIda+uJixcI72DCPRlJKWNDxtxaitQNdyckEKiuXURxYFugVAfS6qWLpBsDAC
	JBJkR592y8jIfUETB7+jRaEA/X/KsSdnSqcyC8JQrqtOF+H+3k9lGwD3K0iNumHbC/fAxYfacHy
	ts6mqyL7YREr07/vB8XwfkEwfjj6YI4uAwQDxVEf1FbfyjjHpqPIbG2/lotKSgP0cPvYiNxF4sS
	ZZw38Wh9k+WkOUcu4fc6r+
X-Received: by 2002:a05:6a20:c5aa:b0:3b4:85db:1bea with SMTP id adf61e73a8af0-3b5e312f496mr4348060637.5.1781207990522;
        Thu, 11 Jun 2026 12:59:50 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-c8661a67603sm108363a12.0.2026.06.11.12.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 12:59:50 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Thu, 11 Jun 2026 12:59:39 -0700
Subject: [PATCH v3 3/4] pmdomain: core: add genpd_for_each_child() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-topic-lpm-pmdomain-device-constraints-v3-3-75d69438518b@baylibre.com>
References: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
In-Reply-To: <20260611-topic-lpm-pmdomain-device-constraints-v3-0-75d69438518b@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=lSghmLcBqOaXz+e5q1UZsb2LiJb8cgQOzwadP+r59NI=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqKxOxPetHP8BcNIvaCryjnp9l8y1hEXu3m26eL
 Km/RwGYX5uJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaisTsQAKCRBZNxia0/vG
 ZewhEACBlTA0kXOXG2xitas1A4XbnlYIFN9Udx60Tu1BdRAwDZw9FwAsP3cO8zGhsnp157iwRRc
 3Zv4YZEDfVGybCM/3Uac4ysg9iM93r/NwibDnJ8WoMX39sY+5bpOuzbDOipaT/NytfFH/9id2zY
 yVaT1ctwrrBooVk3CzIkD7sbxhrT0TFSlqZuZfhwp0Tjaniy1koJGILaxbJA0shlSxg3xf7BhNA
 HnYdz7FPpX6adu/S+KmdIfOwurAtQm9VVyppY0hsjaDCPBpxc9EX4WHuOBgb7Ux+V+z63JZyEZw
 121x4IhgEilMNtJNWqxSnawM/s2aMLP1B4H6D16WE5FcQGrRHMUr/EbVIC/QJpbvh5zkWC3K1S4
 LMDgmFUbztRQZsbnBZiV+NoMo+z0/wZQz7o50PQC8ok3WSFvv1U78cJp90Tni32Jk5t+LF+tzKX
 ofEAq70UeTPZrok6fzxey0DrVlcqd1ajQObYhGLBtzvj+rrFi1+A8idBlK8SoeQ4fQKM0WocpLm
 3yYNDcsg5x3LEun0YZfIxvRrV9MN51+R2Jrrhw+ar3qfAqiHLMuhloCap0R/7miwRfPdK/fAjTs
 KZsX9yDpJHKIhEA8ex6fhqQHZQAIqccaW4Uc4H7/lLL0lLt9RleXMv6uLyy+0LXs7mvzd05GW36
 CjtHzFc8mSNs3LQ==
X-Developer-Key: i=khilman@baylibre.com; a=openpgp;
 fpr=7B87460E16927FA9F5BFF10C5937189AD3FBC665

Add a new internal helper function genpd_for_each_child() that recursively
iterates over all devices in a PM domain and its child domains (subdomains).
This helper is useful for governors and other core PM domain code that needs
to examine or apply operations to all devices within a domain hierarchy.

The function takes a callback that is invoked for each device, and supports
early termination if the callback returns a non-zero value.

The helper is defined in a new internal header drivers/pmdomain/core.h and
implemented in drivers/pmdomain/core.c, making it available to other PM
domain subsystem components.

The first user of this helper is the cpu_system_power_down_ok() governor
function, which uses it to check device QoS latency constraints across the
entire domain hierarchy.

Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
---
 drivers/pmdomain/core.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/pmdomain/core.h | 17 +++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 52ea84e548ff..347bfb7db75a 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -24,6 +24,8 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+#include "core.h"
+
 /* Provides a unique ID for each genpd device */
 static DEFINE_IDA(genpd_ida);
 
@@ -281,6 +283,49 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
 	smp_mb__after_atomic();
 }
 
+/**
+ * genpd_for_each_child - Recursively iterate over all devices
+ *                        in a PM domain and its subdomains.
+ * @genpd: PM domain to iterate over.
+ * @fn: Callback function to invoke for each device.
+ * @data: Data to pass to the callback function.
+ *
+ * This function recursively walks through all devices in the given PM domain
+ * and all devices in its child PM domains (subdomains). For each device found,
+ * the callback function @fn is invoked with the device and @data as arguments.
+ *
+ * Note: this function is inteded for use by the core and governors,
+ * not for pmdomain providers.
+ *
+ * Returns: 0 on success, or the first non-zero value returned by @fn.
+ */
+int genpd_for_each_child(struct generic_pm_domain *genpd,
+			 int (*fn)(struct device *dev, void *data),
+			 void *data)
+{
+	struct pm_domain_data *pdd;
+	struct gpd_link *link;
+	int ret;
+
+	/* First, iterate over all devices in this domain */
+	list_for_each_entry(pdd, &genpd->dev_list, list_node) {
+		ret = fn(pdd->dev, data);
+		if (ret)
+			return ret;
+	}
+
+	/* Then, recursively iterate over all child domains (subdomains) */
+	list_for_each_entry(link, &genpd->parent_links, parent_node) {
+		struct generic_pm_domain *child_pd = link->child;
+
+		ret = genpd_for_each_child(child_pd, fn, data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 static struct dentry *genpd_debugfs_dir;
 
diff --git a/drivers/pmdomain/core.h b/drivers/pmdomain/core.h
new file mode 100644
index 000000000000..7061891d31fb
--- /dev/null
+++ b/drivers/pmdomain/core.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Internal header for PM domain core
+ *
+ * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
+ */
+
+#ifndef __PM_DOMAIN_CORE_H__
+#define __PM_DOMAIN_CORE_H__
+
+#include <linux/pm_domain.h>
+
+int genpd_for_each_child(struct generic_pm_domain *genpd,
+			 int (*fn)(struct device *dev, void *data),
+			 void *data);
+
+#endif /* __PM_DOMAIN_CORE_H__ */

-- 
2.47.3

