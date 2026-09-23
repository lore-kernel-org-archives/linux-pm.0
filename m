Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D3420468
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185658; cv=none; b=HdFsqByPCgp/kp4JMpzxT7nZ6RLWEehbfmvBvqJSVynRUZpxocfd854pt4UqwjyYvet5RraYtK6e7KbZy/x6fPA1rRNYhVwkeRD81P0EmVQEKMCbUGvoVVAW66yKWQXp+fpijek7MtiQ93x+taFhrv0OM4/O8/ptmPk58JI1y6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185658; c=relaxed/simple;
	bh=0YvB+gKeMCEr52FU8yTn+OnBKkONI3/GywzbBevpz1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvrbDt/ZWiEbszTMBF5K4p/HsN0iyd+dzHTvRRLRsl37mxg82pHPlqauVyihlPq7AhnzhPqs+jqeoZTRMWeJYlm70vUiJKRRF38wfQFOWoWmyDNVHLmVHGU/eYtsY9sPTSWLnNAnT94LQZwf2TzIa5NOzUrBRIN+OKaF2bHFYUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PfSyPLXS; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PfSyPLXS"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so924434a91.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790185655; x=1790790455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6EyUYM067KGG+izocu2dLZC94FMAj+PnJ7z88RiTQs0=;
        b=PfSyPLXS0Z+lI2CM4fLhhiYK2nTqq1nLGWAipuVBh8oDa78h4+qkf4i2SfYnTxiIwK
         yFjyf6eETab1wVYQm5QtpUZRzK9DHG90NVjmct45J82t4alePvssUZ4JleXYtcTMyHsp
         qC09HR1Fz9oVVhXnUmFU5KIZ5ooom08IPRcZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185655; x=1790790455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6EyUYM067KGG+izocu2dLZC94FMAj+PnJ7z88RiTQs0=;
        b=kWE9PgzanFdvIQkfq3Hdz7MkREsQjUYPgmjrS+BVxn8mtc4ky6YXkezhdtVqrPiWqr
         Atd0n74DUoHmf7MdDZpXSOW3ApQikMRJW0bEGZwbWzx8BHUJOKe81Oc4SW25r/IC3xlH
         1nBxzeW6evXgW1aaZHr3GKyCvEatOVjAzrOcy2o4mVjPDKZOS+8HkoJTMNbnnt+KEuh2
         KfoUYxzTBFXiZxMQXhVL6sI3zgbOtQ1mLbiOXEHi9KAuDo2XjtqGSi1uyTFvTleZ7hhq
         C/4j5+zBMzJwc1/SVonQAFRnKKSr8u7abW/jOnI3gfws5xuiW35HhgO9AxrRxiFwA3ON
         5/Lg==
X-Forwarded-Encrypted: i=1; AKwUvByootOPzeZmjePV6vycQ+LASiM9t+Bk/7XlR+dsqPxQfmiO2JPHN/TmIdbQJk5DLAbHqxFuOh2QuQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kh1T7SB0eWGXF/wt56CpMJjO54WrKSithIc3Wpl7d7DcwlSc+3
	zN8Qq/XYVndJzFDQ5nXAV2SRsW6CDwmzf5zPJYlWN6Msv7lO2z6N/ewaWZm2I66mOw==
X-Gm-Gg: AYBFou0HQN2iXVyTJs8pfOkXzUxG1EIx6lMTHo4HixSoywqn/i//zeYJrc7tuyhsX49
	3Kqm9m+TvmsdiD6ACFgYKhMQs9nyfBuENL7OILDH103Sr2QclLah5AcqRfBrX3xbv0v8Gh+ykjN
	eG7fFpccQwFVKJ1phgl+w6mqioIhzjglOiJAOE1AN0QxqfqlYb44hrkhwigZ4zgdx6Cll/bgovu
	pYrm0Xhkhz6wT5xeulhSGZRpO9Xp4U9uaiqJzqA9sUv/1kDWeYUINlOkaUetl4b7cJRr6bkaBjB
	jNpmOoutC69h752w5P0f7Vbh8qFRbjA8smqUHrDZQivXmcK3oGSapTv0Rc48H2MVOuG4ZaS8GPZ
	KBeAZwSiAPypB7Pq3CQHLuOnFaCkANgScynkBRLkdhr5JJ1JzdcrP/CrawwcSHxfq55rrtqZe5q
	bwpg/Sx7TZTwwHA0a1KmxiYmZNTGSpMACXuPje7vfC8CmioLNRBp09cc51vrFcTWlQBCzC3yKE9
	a6v/W8M0rjg4EHmhxwvSQ21U+7pNPb6+PCgow==
X-Received: by 2002:a17:90b:258b:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-3a07e54e52fmr3089413a91.13.1790185655638;
        Wed, 23 Sep 2026 10:47:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:642b:a4c2:7ea5:5668])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3a09773d402sm137703a91.16.2026.09.23.10.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 10:47:35 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/8] PM: runtime: More kerneldoc formatting
Date: Wed, 23 Sep 2026 10:40:26 -0700
Message-ID: <20260923104031.v2.2.Ia1cae8a40a24662df11553c225f4438eab65b7db@changeid>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
In-Reply-To: <20260923174711.1283986-1-briannorris@chromium.org>
References: <20260923174711.1283986-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In taking another pass at these docs, I found some more inconsistencies.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * New in v2

 drivers/base/power/runtime.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7e75f6d5df07..dce7b6ff7e9d 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1255,7 +1255,7 @@ static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 
 /**
  * pm_runtime_get_if_active - Bump up runtime PM usage counter if the device is
- *			      in active state
+ * in active state.
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
@@ -1635,10 +1635,10 @@ static void pm_runtime_disable_action(void *data)
 /**
  * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
  *
+ * @dev: Device to handle.
+ *
  * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
  * you at driver exit time if needed.
- *
- * @dev: Device to handle.
  */
 int devm_pm_runtime_enable(struct device *dev)
 {
-- 
2.56.0.rc1.310.g51773c2048-goog

