Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04D13BFAEA
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 17:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787159335; cv=none; b=XVneQ1wZ60bzIjLvVEGWjEs9C6fvm4UU59KgtAjnujifs83apl8nuU11p+EPKqgy3Tu6Yw4iAXZGiRgqU/mx3quhGzgY7+IC8UP/WjiQUUYmvIyF79ZK0PriN9ecdi3yBm0/73Yz2fFQo1mBGD3Xr72UkyzsFGuQXTwbgLmqko4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787159335; c=relaxed/simple;
	bh=5rjDFKrQjDb9eFQM3Ed8es5nA9wG2/nn9jeWV02CJE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCZyA9NbWW8I9R/Vp11waIzrw7aBVwu9I+8C1jyyvqHBDn4WoYgUCNnFT6HHZGzG4dioZMFTZ0bwdBdaD55sZPJR6fDB5FWlgt/Ig6ztKfRmkPIh04G83bwvVqFM4Oh7u0m2pIBbVQvig2QEbgk3f99bwDfVll9C0kejnBcjlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VYvVfKhv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VYvVfKhv"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cbedf318752so807814a12.0
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787159333; x=1787764133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NcXnwaqVZBrDKAIpVWjFshZCqZYemDSzfGz6X+k72g8=;
        b=VYvVfKhv4TKG8Csb2escUi0s4654NyaBff+0H2LzY2eL0x57qtz2OWu+AZu0oHHNDG
         kg1Xqd1DZ2nPCQp76Klvz8EY6DCxYbgpM4SOJAWnBoj8yqPNGOHYrUkbB0gpxC17F/LI
         2gLMl9ZUqpi0FyeouFpFQYI+ANd7p/iQk+ey5mEwmzzFQTLdysOWnWURznuKx+U7owXX
         mLgKEmO66sMKJFO+EwPIqQ6EBV2kfllkTcWRJU0cQbxc7ZQuZd2Ne2yf08e34vzvvWUP
         Afx4gfaJ+rZDxffObnIMsJ0mkf7dWyNeZrCSYcqS2bqAUY76kn/xJzqCEjxGztLz6X0i
         4iwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787159333; x=1787764133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NcXnwaqVZBrDKAIpVWjFshZCqZYemDSzfGz6X+k72g8=;
        b=VElNSS3nAnub0ZnlFAVzzdS5u08ohBuV1JCwHjzq1oZ68NUZRO7OFS+HRe4ua1gEnM
         zBnm/2WgLfzCKOc10+tKP1V3oA3RjvubMcXDiO7X7Egd7x8HEZtWdH9St5saZd5DviuM
         M536ZOQnigCmJfu/HinzWgdyD4F0h+I/J1be4IXKEF50vFZkYNFZZGd5bmM/EzX0+wux
         3OxhKIPF2/2PTB3PGUVLXWEqQn6Qv4mPNi/GvsS7Q23z0JxthPzQVTtDP9z0lDgIoZxX
         RA35DckyZhgZGI4aduCskb9L6+bJRiDrfP4gHfCT1uZiIhknKHRvCEGbwDluerAk0XMY
         tOLg==
X-Forwarded-Encrypted: i=1; AHgh+RrYOn2/EQeGv2lGcnUDNgBS7yZREhw395jksI5xPCSSBFCy30NK55nrwU14vuL4V/QclKHLbQXzpg==@vger.kernel.org
X-Gm-Message-State: AFuF++kvSUo/uxqRZ6Hhki3FaYnWtFNW4IhRVrae4/y2Wn5jAu1puM5T
	R2u3d7KEN+JFjNSmgrTgNxnRGp7nWgBz0FjVPOVInfn/+MLjXmV5ux48L1TeKrCmt8BmyjZH/Qt
	vmAFUkNU=
X-Gm-Gg: AR+sD11a0dZm4hLhB02tLJBRXCuFsTsn2deUttD+6ILDF4mukn1/beoWFLX3XEzkUeH
	YqdcLEf6tA22qiDOfRct9jQfu/Y0/5eOxAwLZ5li+v/uusM90X76aWwhxwUZLZotz9CoLFQrTSP
	VnatIqgwR01RH9gxxrhf0K+jHyfF3UUcUfoZtI67ENZSjGqUKFH6P6Sj/qTVzEUhkY98yd1fhme
	0Fpp4F2mX+ctWzuV3I2UJRowGV3bcAPsnY8phEmw35mP35t8h0HD0cfZ5qs4+1SD9kiL6LfHcB3
	dF+vicnpUfdXJBcGh6mQIUDrFVoY0zUwM1lzsTCCOfJclnpxu9eiBRXkyL63vVZDeDMHuh7PF1S
	QNgztA1MFR5eyXMBsAYJyF/kTGylLxqLOG/2uGzZpJzs9WWkD/90MZCXZXMz1f7h1C6Qs2OZ9Qu
	1QGI0yQeiuNNC7cynzgGkRXXFyHjyKHNXwGyHETUlLYs2sZcKkhIzP1MZDCw==
X-Received: by 2002:a17:90b:4a4b:b0:38f:240d:b857 with SMTP id 98e67ed59e1d1-39580a4d03cmr11013093a91.2.1787159333155;
        Wed, 19 Aug 2026 10:08:53 -0700 (PDT)
Received: from localhost ([71.212.202.210])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3957f6b9cfbsm1203547a91.1.2026.08.19.10.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:08:52 -0700 (PDT)
From: "Kevin Hilman (TI)" <khilman@baylibre.com>
Date: Wed, 19 Aug 2026 10:08:38 -0700
Subject: [PATCH v4 3/4] pmdomain: core: add genpd_for_each_child() helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-topic-lpm-pmdomain-device-constraints-v4-3-7ceb095f5474@baylibre.com>
References: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
In-Reply-To: <20260819-topic-lpm-pmdomain-device-constraints-v4-0-7ceb095f5474@baylibre.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Ulf Hansson <ulfh@kernel.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=khilman@baylibre.com;
 h=from:subject:message-id; bh=5rjDFKrQjDb9eFQM3Ed8es5nA9wG2/nn9jeWV02CJE0=;
 b=owEBbQKS/ZANAwAIAVk3GJrT+8ZlAcsmYgBqheMgnhYNOkWBn64xmzenyc+flwmGG+entv65A
 1xolLCMmFeJAjMEAAEIAB0WIQR7h0YOFpJ/qfW/8QxZNxia0/vGZQUCaoXjIAAKCRBZNxia0/vG
 ZfhLEACBgHuXVvgh9ibODD7ANTt6um+n8FeNZOZZqdBa+tT1TNtA0uzYMfaCnnGJUuIvjo7Eaf5
 +uVPVq3r8OV1cn0KAlAsbd2KHM+o0VeCJqNPthTSoEstWqXv1QCEGBd3ddXA4ATiyjpUdFbmnfC
 15SWwiMWQxo+tIqYGKDdbzKR2NSRkx6RyqycCeulmiTqFLUQompJ2NN/b2cHDM5sddxX+hswt6t
 KvayuSorDMHVXy9rv0R22XU75uWc9JI+bzSc9gGHRQCbvNcZUV07Gs9iGwUZ1pWEHtgv7Sd0fv9
 kmHHEt3aon6RJrAqNIh0OjGCWjZGSQn5H9ZrEtmlA2/e3zz3bVZ6SRGPoSTNBpw808fIOPtseWS
 6e4aUMj8w/fIEh5W034v7pa2ggf8aHTwTZw2jkelW0wE6KfQwIr58504wiUSuRNJPJj4KzpJxZ2
 Y7NiZXDED2LSpztyDh3pkaNci3LBb9SaCUpbcv+0sTn3QOBv22+sMaXrc4sMiYCPUJgeYfau4Gg
 ZrIxoL/i0FHx+RTel2JCT3ZHCZqISSO8GQWJGgFTBuQ93/x3satY/6br8ClMylALSbxQJj4crzR
 mUanugX++EF4x/CfKsUaK7X0nSzI56FLYCgsFM9A1TexGB7lMtMHTLa40VNH/6dJgBdROTBMSXK
 TwBk6uKDpCwh5oQ==
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
index 842c4169e290..ff27369d9a97 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -24,6 +24,8 @@
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
 
+#include "core.h"
+
 /* Provides a unique ID for each genpd device */
 static DEFINE_IDA(genpd_ida);
 
@@ -276,6 +278,49 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
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

