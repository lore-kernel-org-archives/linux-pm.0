Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF9330D25
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 01:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788226474; cv=none; b=qwnZ4Y3Y0eJsSj7ViMg+sEC+f62qQxhAi002LrvLA1JV9XglMdO9rGcDGwWznROHpQHJDK/A+Q2kKQ8hB5K+JbL+VnpRre0VvgDxiFunAzOG9VRklP9nB68Nalj4SxWj3xqLGiV3z6BPHas6CRrZdNQMR2YZa0M8pNLbsLHY8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788226474; c=relaxed/simple;
	bh=MF0hTNvzTdpGvqo8emDiLI7Op/glV1Xy1dpT2XxnEE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhW5OTajOMj7TY4O7WN2LkIW8tluwqD8QdspOuwEXAlT6YrJ5JU+x4DglxqhH/2gIED96oRZYiAemNIpVbijC0k8YfDBVEPeMn3pko/Q3hCoBdoMjYlOv/JUkdF/6L1WPh6vnGNEiYvBoGPpInEIcs7/9rqNjEUZ7GISLD8bvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MPxdh1MB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MPxdh1MB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-395cf2535acso594702a91.1
        for <linux-pm@vger.kernel.org>; Mon, 31 Aug 2026 18:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1788226472; x=1788831272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y9fRfnXzddhjDeOspwFwhS9N/kT3C//SscgMJBIw6do=;
        b=MPxdh1MBb6aapgqA/tluAGHgUjeTGpdee8rkVU6DwhT/p/hg30EL3V8JaOnlCW8mGR
         LV0eozwftPCgzwn7SruhNRaMd2HRPOZJRVq9OG0MmPoIr0IWQMoEh92+S2DqwXYcOsnw
         46KG84lNBwwIUAto6tBmMDaqy1Nzsnw6Pwgkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788226472; x=1788831272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y9fRfnXzddhjDeOspwFwhS9N/kT3C//SscgMJBIw6do=;
        b=PtLgV/XEfANnGgIBcI5OcXla/fF7eQ0QZon8uWFtuI7yV6jHsiijNz7e2uQ7EIZTO1
         ZkiBsqKgy7oZupMDd5AvORbtSo6kaTUVtyWmVijrsnm9sMumei/KRr9ruPYKdyy0TOrC
         c+5e39YMpky4pIWR4H+2i24tI4P8X5TA2C6LfXOSBY7idXUv/3fWKn9AO0aXpknLfX8a
         hBohz+rh1A/yyCDpOPx++WoBLMlls8bYmpI4G//CecLoB7PWcGdfMmOuSHCjIPRnXqXb
         YpS04YYz1UzD8ZC4Xx3N0jJCBg02q8KxOsdWQku0kio/AItnf/VAD5bhUBTHO+aImzYT
         sGQg==
X-Forwarded-Encrypted: i=1; AKwUvBwQ9POj6lzEgV6byqjEqD1YhiVr4Gj0fBHh2i4ZH+v/pV3PXmii+E4KkdzbM2XVKZiFaPl6Q9yyOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nzTVN4v2J34Er+pZAtE6Dkr/eOHrGB4th03vidiB+nreMLIfTu
	SgxDOmD2ZQvEpJHmFEcIa8Olow4hxqpQfeeKakIJVfHsNRrH9uFtSOfkEipJbvE/1g==
X-Gm-Gg: AYBFou0ZhXp7pJpqn+m2M+1PB7OTKe2561Bp6LH5PqzPzfWjVJOq2MOv3/8YM1Kd95j
	RrS9jrnqUSuEbqJXDS4TTss2dK66u9WJnKfnc9Lm71UtKb0OCavRO9dR1Bjnyp+68w85GoDK/rR
	VXplkaHn6FAb9auMBRT4ps+xRGMwbnal9YCdyr4lgJVdeobrdryV5G4bmuogWhx8Sn4Ltb5Z6TN
	Ptdby/7nr/xjVQHa9owrC5NLdV9RshSrVjzBfl2oI65QiTbOvPIgLg5S2Th7TniDZIqxOtDR/xZ
	OmDoALlJEi09strT/Qfh9JRBMnBeDUuJrC8BoOZdDOG28aJYI3Th8qNCBi4cp4C8rGHrmIJOcZD
	e/RTI35yRAK2vwzlbQRxZBJONEMS8SmdeTpwJscleVCit5uEToupvS03ZVCHphYA7ODS4k1QkIY
	WPePZ8i9ijnaYOkxo9vU8NLL5a0mKbXDF6HU1V6BHIRejI7jAGZbOFZbw0/lveftsOOTFzA9CSN
	k8z/TjVAHfbuXsKICBCl94d0GpUNtCFDlaxjw==
X-Received: by 2002:a17:90b:1f92:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-3990f78b130mr2150062a91.14.1788226471666;
        Mon, 31 Aug 2026 18:34:31 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:ab65:e5d8:860b:c20f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3286f8094dasm35514254eec.13.2026.08.31.18.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 18:34:30 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/2] PM: runtime: Only queue an idle check for RPM-linked suppliers
Date: Mon, 31 Aug 2026 18:23:22 -0700
Message-ID: <20260901013341.1417232-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a device RPM-suspends, it queues up an idle check for all of its
suppliers, in case that device was the last consumer, and those
suppliers are now able to suspend. Today, we do this for all suppliers,
and not only for those suppliers that are marked for use by runtime PM.
This isn't directly harmful, but it is a bit wasteful, and also may
induce unexpected suspend attempts (e.g., if a device was purposely last
touched with pm_runtime_put_noidle()).

To avoid excess idle checks, only call pm_request_idle() on linked
suppliers that opted into runtime PM.

Noticed by inspection of trace logs.

This is not expected to have a functional impact on systems that are
using device links properly, and should only be considered an
optimization.

Fixes: 5244f5e2d801 ("PM: runtime: Defer suspending suppliers")
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index fab38bc98113..4d84d97f09c4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -361,7 +361,8 @@ static void rpm_suspend_suppliers(struct device *dev)
 
 	list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
 				device_links_read_lock_held())
-		pm_request_idle(link->supplier);
+		if (device_link_test(link, DL_FLAG_PM_RUNTIME))
+			pm_request_idle(link->supplier);
 
 	device_links_read_unlock(idx);
 }
-- 
2.55.0.970.g62bdec98f9-goog

