Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5247D95C
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 23:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982449; cv=none; b=sX1dgIaEK4Sbhc49HgSKgbGSTiqCIB0vrKdS6PcOFZWyy6Um4n/qRg8W4NdhZpZG5kBIj8Ibniln2YL1o2V8WMkbsL7eWWVMMN1ZrA6ZFGUd3aB/DtQg0bhcrjlG0wp4wOW4xV8Jaf/OhYYVteRcHNdB+gwM1VmXu40DohCn324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982449; c=relaxed/simple;
	bh=NXfG8BYbOogjZEXW8d5prtXBSKsGjWq60veGgTm2Dvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qa+WsYbPRbhoAqgng8yLZwGK9TnPz/pq0G7WEG5U7OlYsvg+7KnBnUGxNCLdqJWnpwSHzOBbZX7iqElGB4aqWNu4F6tQhNKlSMc5wqpVnr21B3FrhnAREXAX8TCmNLQc4TZpJvN/zthmxc8CTbVMkf1S6UloIz4LZ6CMXExTxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LmACTRqO; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmACTRqO"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3282db206d3so345291eec.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 16:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790982443; x=1791587243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Cj31ExEyFV3PoRNZbMP+vqda3AvxSrb2+xWS+DVF+S4=;
        b=LmACTRqOrDbKZhY2o8Hlq2GzDweKDH5JvnYjuL110WhpHEljglVg8HKdFETGH2AieH
         nqf6UmXnleKUSD9lo8jWyovQ+mRSkeK6zr9PrfFMEOk7A2Xqvm7zHT8jCo/ENPHU3uEO
         fhYunj0xtl/cUyKcqlk62one8V5N0elEy/xfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790982443; x=1791587243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Cj31ExEyFV3PoRNZbMP+vqda3AvxSrb2+xWS+DVF+S4=;
        b=fY/LTIDPMYIJOqKhwIMioHmcbwVdsi/YereRvIF1xSsYtmu6SRqJJkV58QT9b50mN0
         r/xrFZfyTdDMVO8NsCQjCLkawAjkYCUEIfU2XHTXt3yD7Rjjz7ebxDJOff4iyv29e4GI
         6/TabEcvGfIbUIY4L+eAL5+Zo3z7BqHQ5aFXaVtZNhJrGUSILlD6NXr4f6YnRzqDzcyB
         ANTAC1TglaGal9IWQ927vexsc6ju9tnMa+Qz24HSxaY5xtNnbZf15AdLwDQsHXUXr1o6
         liKWa3nsLljWu+QeTD6nYWtOJh3YTIgmXKYRKEzZIblngWoBXbXR/QWVupmk1dPFUF0H
         2X0Q==
X-Gm-Message-State: AFq9FYIL57nuCw5WfP0oDKQ12qvlnF6VFassXWwXuS3BEZ70DBgiSGfP
	f6H5rYetoLuq3WzBUvhAVTKW7njqfyTAXcx4KhDztM4zmhd5vQYr8ug60Z/1S9wGZg==
X-Gm-Gg: AYBFou3ZxN3GbQT6YBBQbu5u0nA4iXuReArPJatFDaL+Oz+F1a8hkFDaW5xxMJtoep/
	hEGZXuFnkeI1y8iXhNQco8Is8RMaoII2A6EARN7WJhmbfs/rQTF4/aHCnnJJYu1NJ469xHsYo7q
	gMpBc7HHI7/Q31+t1iKusarjhrZ+k0FYjjMzTg+dBA5wJZnyxmcah8q7ccePlZnMq69BLngkw8+
	9kAkW8U8e7PKGoLH5RTeNDwasGgxwSOBiHCZIIxAV04lS03tZuYgEaMF4fbpiz4XXnsg8h2gEgL
	pJtyHiuTkFxQCEZ+uWddeYdz2UZMGzN+ebSrn4L7+JKQvy9OLsmq3MiDvJwZfO0Y3rSOnCkM2NP
	KT+y5ZBCA31g0uRgCbgFzw74nXzGTYbAxDKilyWgcfzyVFBPidSbU8S+AgCpWYNL+Kl8Ymu4v68
	J/AXP4Q9B/MjdsZPxtFYppNY2AMVA+02kT+ricN+s+KFn60NSHlbYAZJi4KOtCcj5y7saSKWP8S
	pNPF06CHsFwn/YJVDx/y2ySOrQinVQO3ySEqg==
X-Received: by 2002:a05:693c:41c7:10b0:351:13b4:9c59 with SMTP id 5a478bee46e88-35113b49cb0mr571453eec.2.1790982443465;
        Fri, 02 Oct 2026 16:07:23 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:b0dc:e72e:e96b:3323])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34f0672c2d1sm12058791eec.4.2026.10.02.16.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 16:07:22 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	linux-kernel@vger.kernel.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-arm-kernel@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/5] PM: runtime: Convert last_busy to atomic64_t
Date: Fri,  2 Oct 2026 16:03:06 -0700
Message-ID: <20261002160309.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20261002230714.507921-1-briannorris@chromium.org>
References: <20261002230714.507921-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to use the atomic64 compare/exchange helpers. There are no
similar 32-bit-portable helpers for non-atomic64_t.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This conflicts with some pending work I have here:

  [PATCH 2/5] PM: runtime: Avoid racy clock checks for autosuspend-retry
  https://lore.kernel.org/all/20260929114714.2.Id0a3276d23d30e0b5fd4d6dca730be0f9d8fe018@changeid/

It shouldn't be much trouble for me to rework one of the two, pending
feedback on whether my approaches are acceptable.

 drivers/base/power/runtime.c | 4 +++-
 include/linux/pm.h           | 3 ++-
 include/linux/pm_runtime.h   | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index e70726b499e7..9eed1f79429d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -5,6 +5,8 @@
  * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
  */
+
+#include <linux/atomic.h>
 #include <linux/sched/mm.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
@@ -186,7 +188,7 @@ u64 pm_runtime_autosuspend_expiration(struct device *dev)
 	if (autosuspend_delay < 0)
 		return 0;
 
-	expires  = READ_ONCE(dev->power.last_busy);
+	expires = atomic64_read(&dev->power.last_busy);
 	expires += (u64)autosuspend_delay * NSEC_PER_MSEC;
 	if (expires > ktime_get_mono_fast_ns())
 		return expires;	/* Expires in the future */
diff --git a/include/linux/pm.h b/include/linux/pm.h
index ef3f1310e749..531e46ff878e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_H
 #define _LINUX_PM_H
 
+#include <linux/atomic.h>
 #include <linux/completion.h>
 #include <linux/export.h>
 #include <linux/hrtimer_types.h>
@@ -812,7 +813,7 @@ struct dev_pm_info {
 	enum rpm_status		last_status;
 	int			runtime_error;
 	int			autosuspend_delay;
-	u64			last_busy;
+	atomic64_t		last_busy;
 	u64			active_time;
 	u64			suspended_time;
 	u64			accounting_timestamp;
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 322e3b17f987..289fa72c0af7 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -242,7 +242,7 @@ static inline bool pm_runtime_has_no_callbacks(struct device *dev)
  */
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	atomic64_set(&dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 /**
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

