Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744588;
	b=HI7H63U811+n+eueY7csr43CP5Q27EAV6EOYDlSCbo+VWAh73axcIX6mtl0dC0eWs3i/
	 GU4D5qXUNfhkIBDAg9zy1Ye6CAnUQQXgmFKx2Dq0HGhd77VHoW0NIFEj8OvvjORMOe9j1
	 RrcMayuZ3GunEtgAf9oQ9pJSZH6lY7wHedSdSmX8qWTzu1qaIRQ7bFyw+FOTrhO954D42
	 JBVBh1TmjENbq0tdzu3qp+wlW0fKiSBjKuk0T2iiaSonlDQCZI6xXuMJiWklEtILWTxtB
	 gtYz3jyHvB+zKrMILj3j7rv7xBDppHDTAlBO+j0FfYa2fj6Mt30QLU8CG05Q2Upx93g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
	b=as8mdmCFcisQ8FSVTEkpIFmuoWUIs6sf5PX/wUYHbfUYiOZ6Fb+xhUW3bMuMdPXjSNPB
	 ORL+6lhhRuns0roP5v5nBdg1yd3yLnWvuYPyfx7zHlhTLL+SFF3fwFUQGN5ZyYzs19Cv6
	 pNLlBrUnO4CAeX5/abgldoZ/PGxdIZ6ZtzlY7zOMs4XaCzJYPZk8tjckJZy6H4EcdVCLI
	 M1RouvNrqRYJFp0sx1vl0WGvV6ZybKmWuAGeb2OrdOCcrtCiwx7GnhYCdWtutqMaLmxlU
	 /fyL6HG43oWhKy+kKCAfNL6BmKQL0K7stywftYbbP0pud8atbcwPyMScXY3+JFhkjtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WZ159z0d;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A904606A32D
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 22:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A904606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WZ159z0d
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-14394530ec6so176616c88.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 14:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744587; x=1794349387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
        b=WZ159z0d3cdyU5ZVhyL5x/B4/1Ju2qWuATdw6DxScbh0z6/a1Qj4iPmHsaGHAmRD20
         XBK/glreKqfgoKH2lJatjUxFnN942Ieb84oy4GbFNnqldIrenK8Yo0S5eBsKLefsKiO3
         qSK33XMlfPyP5N7vavJ78UHFBeM4n3HQ6+7qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744587; x=1794349387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/GjwPB9R1GefsC7sb/ZiS61uSaQkMOnfI2lEQvw+YY=;
        b=ig3iz49gwrc8l1qVZRQ8Hu0oJ541m+rzJTfzEhMm4eJ7vXL2bRPUKDAO34tIJwbl32
         BfKiSaiZiZqzyWxl1Q3afDNxxWFpAd97TWwCDnsxoSdy3vStZx9hnELffzGIr48t9Wq+
         3+adBDoyaF79SSG1h3FGbmCIV+HiP4ihzqMMT4b73MfWVxrDcedbxqzfTt7ubxWtMM3+
         daqcH7GDTFdoN1tPw9FwZIrTaMKRH4CV+/OukIBjJbyi67YUc2SVEVMzgGbEijZs1Y4k
         MNFJXlIVNmKs0YsqvjZc3wVrjLRX0ynJtisZFU+48kxHKVFH589iM769bz6/tDb1LO1y
         0S/w==
X-Forwarded-Encrypted: i=1; AKwUvByNkNPDsqv/Okc8vc2t5qv+aZ8EnUP7H2QZu3p/knljNHoaeJQoQAxNNJsQPMKSJVC7FTfUYmA+Xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8n/2Iyu6P8Y+4QIR3MlPFi7LBdWhmFQgZQmLICKeDeSLxMykm9
	MuhiX+j2rBQ2CzqOENqxqZw7pp39JtGY5qF6/SVftZ6MZJn2F4kDCiNzUu4SSnxppg==
X-Gm-Gg: AYBFou242R8IFGhsbJUDk0byfLNCavn5+SLxLMB3C2DtGXmBZy553Y+/Idl/hrurqKb
	xL2/xq57pN5u8Og/JF8opYKPuZ+aC7AsXQEfXuYPImc5/fEikQbFjJckfjbfPsFfimXLlLozNKp
	plGpvBu51/xYVW1+Ngy8n/adUgJUN/r9oSHnfn+F1gigJHVjFmfcu4UFcuCiIX/PWPcUj765Rw/
	6jqO8T6HaZx4n6hi84pgj6wpl6z0nXp1i9Iray/UEMhgFCrIeafDkeHClU1HKB2zggRLezeNs3E
	u7wowu3OrO3b6Mj0diQj5uSqf2pYV8fHkSIBjdr24hyjtKNw3kdkTdH95O9ksf3IKtzCl6Pjawf
	xRe7lXzTfdRBU2lbwy/svQp/DZ8cUVAiZFSceuoJOFPMWqVC2ScdQTs2PQbloeLAAEuoyGBya5Y
	90Sp+765w15qhFLj+LbJIRQArTcBGRj0OxAP06WW3wHzSWNgawVg2NlXvlISQL8PjPM7GLl2ZhU
	JQGDLCw6AOJd7b3NBAz9xr0XDe2qdqiL8TRaQgmgz6qjuyXKDkGbkOHN+F2k5zVRac+U3JI66t7
	2cHLcav+VO7MvD4+8GDdTNMIppy/xPlrrqaMg/fv/IDN4KqXTn2Djw9RMdCGXa2X7NXC
X-Received: by 2002:a05:7022:7f17:b0:168:3243:c937 with SMTP id a92af1059eb24-1ac5cb1c8b3mr24793689c88.16.1793744586621;
        Tue, 03 Nov 2026 14:23:06 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36ca390df28sm1162364eec.18.2026.11.03.14.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:05 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/5] PM: runtime: Convert last_busy to atomic64_t
Date: Tue,  3 Nov 2026 14:14:40 -0800
Message-ID: <20261103141442.v2.2.I998d26c0d635b80496ad12daa33b8de602030eb6@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I want to use the atomic64 compare/exchange helpers. There are no
similar 32-bit-portable helpers for non-atomic64_t.

As a side effect, this also should avoid some minor load/store tearing
corner cases on 32-bit architectures.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Add <linux/atomic.h> to pm_runtime.h too

 drivers/base/power/runtime.c | 4 +++-
 include/linux/pm.h           | 3 ++-
 include/linux/pm_runtime.h   | 3 ++-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 9d3508d9b4a2..2a117d6a776f 100644
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
index ae68a9dc7fc5..da537be94732 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_PM_RUNTIME_H
 #define _LINUX_PM_RUNTIME_H
 
+#include <linux/atomic.h>
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/pm.h>
@@ -242,7 +243,7 @@ static inline bool pm_runtime_has_no_callbacks(struct device *dev)
  */
 static inline void pm_runtime_mark_last_busy(struct device *dev)
 {
-	WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
+	atomic64_set(&dev->power.last_busy, ktime_get_mono_fast_ns());
 }
 
 /**
-- 
2.56.0.398.g882cbad275-goog

