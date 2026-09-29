Received: from mail-dy2-f36.google.com (mail-dy2-f36.google.com [74.125.229.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974A559CB1
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707671; cv=none; b=u3SMTTLyVpQMCpkNZGiT8nVYmOAAoE1C8u9wYnK0eAyjvE59DJHwME9PdoRnuzfCSjWKxXO+6HrNYVVNlf95+F2vg0PKj6K9RKOU3UEh3bHrlEpp6DuHzb6+uVsx+paxk2cT/LRD+pZ9TqV0DOFzfBFRmgZFojl5UEiQJSuE7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707671; c=relaxed/simple;
	bh=EfN4DRQ7RGeIckCzz0l9GMwp+1v5qtliTwAQlB4LR8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3SaMAj8p91JxarhneAjg3a33h4VkrJ+TCjeUSmsJ3G56+q4yWe50cKnBTVOE12qN7tybLP67SAPz5xxGf6zeXjrveyfn74Z9u9D/GZr+/dS4KZesWkyTGL+OPzqV3XyR5DulFCEj1w1mvP54debKYgCqKJ8ewIBIL6PDBEH9xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=guhqNydw; arc=none smtp.client-ip=74.125.229.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="guhqNydw"
Received: by mail-dy2-f36.google.com with SMTP id 5a478bee46e88-328664c2da6so3829534eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790707669; x=1791312469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nc0gE7Gombl2PMFQGXcyIkbha/LFCYb67kK5kCWn/0A=;
        b=guhqNydwZBBeh+DNGU+7czrZ1GEdDFWXps+BTuK/k3OOfIk55GJzgw349vYbAZS4/M
         8lgrwKRZhLlJwrvxvnVnlCQMsyQWIqtSUQjDMefEqgr/gY5EwmCQXeVztMC2fEO56vZQ
         kq9gaRNo+1nZGdQ8dD8mkyPgqL7koFN3cFJhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707669; x=1791312469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nc0gE7Gombl2PMFQGXcyIkbha/LFCYb67kK5kCWn/0A=;
        b=ye8Qy6sKkMV6qNf4We3aeXcIi0L/9zUML1Gzdp3X6LJ0lyOsMBzD3Hkhgfwbc7eC0C
         Fe4z4m6bVjlkiuJUhSTT0YuRR91T1lG+B5+cTzUjjNoM0YiF2CcgmhrD6b1dEIk7ahYC
         bZ2+2A2+4VEbCT40KixwLaB/ohtMav1rQtJccx69be1oCU+HHKH9XfFRpLIMNg/esd72
         SWlmPb3IMBG4lBqnD3wkIB6qjpCCdbsITRM171lU4fnIMu5V3OdP8LdMCjrn+nwt0TQs
         XjMu0xxjEQRoCfpcA8ULdOHy4KMWRDi+cwIh9+bbLuwkAMgKfyNMnyT0M3yBApSi7aKi
         rQEw==
X-Forwarded-Encrypted: i=1; AKwUvBxgeOCovRqe//oum8e/qNtVafh2xbVHAsr2yVqehsP4C0VGHvmi9AoyQJB5FHwRR98pEP2HrPZTJw==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9MLpddi6aTc1rIQlz7EVn3NSItm/EJXmE6EyErI8d6YGxencX
	5Yo8dDt0tuw1B5ObGzcU8+CnJ0vukoKsHiX4jvXkUSysZ/D+E/CNwbK0rgv5VqlEdQ==
X-Gm-Gg: AYBFou1Eu1UA+wFHMLoFfNUkOQhGyW6TFw1V0R5a/UD8KryQbavnRLfi3TpjsoE6lCk
	Az87Aki2eEGy928K8GnHVQBXzsa64bHhSQ+bwEO2kyy9mXfTbepb5oBM9DN9wLvsiFmmReCLiwZ
	XStH+Q70be0+zT+PMLV4oomcgC+QeeMem8gQ/KnIMaYEfekw4tGsnbM5jol8Lsc0oZzuVpPqy6z
	5Azp4nmI8hRx7281onZOCnCywa7rh8O4OxuK9mJ4B6dZpQeAOt7x2yZ+prkwYGXFIGaJRH6vMkc
	N0ddh0Zsi4+0l2fKxOWsGbCa7AyaE0qOV0ftfM7YFkyOb7zLe+yI7HJzsrCBgJLm18TOXfJGuNb
	Aie3PTuP7RJFH71LwE27PaWiQamvv/0ZuLmKufXT2+2/0a454y9hQJ9kpYqtff0f24lgcDTzTSy
	farHl7XViLxMpV6EW5DP6N17YjjD2ICFslM+QFMX+an+TXknjLQDld5+APixPohVpK+rs4lSD2Z
	0iYVJpEYg3Hn1dC2M3BKwzyXOgUH31hQfMT1g85/hvLQFQ=
X-Received: by 2002:a05:7301:4882:b0:34b:f279:2c29 with SMTP id 5a478bee46e88-34c65a742damr266421eec.13.1790707668531;
        Tue, 29 Sep 2026 11:47:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34c388c76c1sm1004071eec.19.2026.09.29.11.47.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 11:47:47 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-pm@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/5] PM: runtime: Add test for autosuspend-rearm
Date: Tue, 29 Sep 2026 11:47:13 -0700
Message-ID: <20260929114714.3.I7104ceb30c7a54ada598a7a37806432997216cce@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260929184729.2346769-1-briannorris@chromium.org>
References: <20260929184729.2346769-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If runtime_suspend() fails with a transient error (e.g., -EBUSY) +
pm_runtime_mark_last_busy(), we intend to rearm/retry autosuspend. Add a
test for it.

This is a regression test for the bug fixed in "PM: runtime: Avoid racy
clock checks for autosuspend-retry".

Example invocation:

  $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_PM=y \
      'pm_runtime*'

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 24865ce844fc..3487392e0afd 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -285,6 +285,75 @@ static void pm_runtime_supplier_suspend_test(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(norpm_supplier));
 }
 
+struct pm_runtime_test_data {
+	int pm_counter;
+};
+
+static int pm_runtime_rearm_test_suspend(struct device *dev)
+{
+	struct pm_runtime_test_data *data = dev_get_drvdata(dev);
+
+	/* Say we're busy the first time. */
+	if (data->pm_counter) {
+		data->pm_counter--;
+		pm_runtime_mark_last_busy(dev);
+
+		/*
+		 * We could also purposely slow this down, to potentially lose
+		 * more races:
+		 *   msleep(1000);
+		 */
+
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int pm_runtime_rearm_test_resume(struct device *dev)
+{
+	struct pm_runtime_test_data *data = dev_get_drvdata(dev);
+
+	data->pm_counter++;
+	return 0;
+}
+
+static const struct dev_pm_ops pm_runtime_rearm_test_ops = {
+	RUNTIME_PM_OPS(pm_runtime_rearm_test_suspend, pm_runtime_rearm_test_resume, NULL)
+};
+
+static void pm_runtime_autosuspend_rearm_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+	struct pm_runtime_test_data data = {
+		.pm_counter = 1,
+	};
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	dev_set_drvdata(dev, &data);
+	dev->driver->pm = &pm_runtime_rearm_test_ops;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+
+	/*
+	 * .runtime_suspend() should return -EBUSY once, but retry due to
+	 * pm_runtime_mark_last_busy().
+	 */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_autosuspend(dev));
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+	KUNIT_EXPECT_EQ(test, 0, data.pm_counter);
+
+	/* Don't let on-stack drvdata escape this context. */
+	dev->driver->pm = NULL;
+	dev_set_drvdata(dev, NULL);
+}
+
 static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_depth_test),
 	KUNIT_CASE(pm_runtime_already_suspended_test),
@@ -293,6 +362,7 @@ static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_error_test),
 	KUNIT_CASE(pm_runtime_probe_active_test),
 	KUNIT_CASE(pm_runtime_supplier_suspend_test),
+	KUNIT_CASE(pm_runtime_autosuspend_rearm_test),
 	{}
 };
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

