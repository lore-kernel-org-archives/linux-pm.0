Received: from mail-dy2-f25.google.com (mail-dy2-f25.google.com [74.125.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610E3560AC8
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707678; cv=none; b=qQc/e6LO62wh0mcDmee07TBCJe3nerxxRplI6sNBKp+otAAXamO6vSbYkNhE34Z/eN1ksHDLkRCT5lqM+VEKVriMD09sCC74jIowDta1mteylVxDRpgpWephmN8EDumNhPKJp8jsNC2896Pf2Ng3lhXciWy38Lxb9gdXdFcW2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707678; c=relaxed/simple;
	bh=B6qbOjmpqkp6AYfuznV5ZV/bRpzVIzhR8xXfGh/yrVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ofPKNtygquniqAXpk89IviLUfj/MWkPZeb/2LuznrfpH2S0ITTOK/oSexQiTd0CFpA0NlJhTkMYyvYNnr6v03aPO/WZlFmjKsuvswJU8wtTqUE6ln1pNm2Q8cIDWAg4fgkg+hD03vZNeDwczOhGpbssxrHndvLmfKhrdXJ/KmpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TgK4zVAZ; arc=none smtp.client-ip=74.125.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TgK4zVAZ"
Received: by mail-dy2-f25.google.com with SMTP id 5a478bee46e88-346c612c7a8so1909328eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790707675; x=1791312475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oMvjcukblw/bh9bT1wLHMpW+zvI8pIG9ZcORGBXggM8=;
        b=TgK4zVAZLm1AQn0qErY9WKihEfCrtbB+1ul2UT3Y2bPB3CP5Fb2TyUJWBO96z62z3z
         g9db2U8YcbmHEfNrtx8uRbMNIJr+yAlcPDeiSZl37e2zi0t9/LBjsDfhXsY5jCLGXEjk
         V9BMsZfKhwPWfWCqF1jocCysyCgzqYowBOuWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707675; x=1791312475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oMvjcukblw/bh9bT1wLHMpW+zvI8pIG9ZcORGBXggM8=;
        b=D1hRkiL1FH8jBjMTIdD015su5LxFV60bq+8Otx+RfwhhEUpke9I/RpUJb9fPsTk1tn
         Vl4M+nhH7kpsjfbFf/s5WRao1Om5znAEz2+VSwMrOW+vZQvsLfWDS8ysT3NiKhxRjolV
         ygJCXjS6lKQqgKd0DdLXeg4diDIZ7VnZ/oLF6HPucR2bq31rJolXsbuLQe8wnIFCUzWr
         rX8gFTvMPa1QPKb+YwIwjwaG8y7ugRM9VDfxhpN4zCXYOkQTTg/VK2H0+Dlzt00rx+o9
         eRj2R+yISqL0hE+hA2yjzacdBgRCe0vCHOlSWirEqaWdyYUUC69HxOcV+w9C+Z4jWHN8
         NmFw==
X-Forwarded-Encrypted: i=1; AKwUvBxRmUtqEMqCUiBdbY4qb3NzJLQMaxTduF2kj2R9cSiD8lxINWaTEeS/+5TE1wSrQ+v9X87Z4ufpHA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJw35TbCkR9nPms3/1CpthHve+nMTpJf6jIXqI3N2MWuqNgXe/Y
	I9Wg+fr2AMLjI/SAJC3f0rZk/8iAc+i5Z0YuCNvaXJCPY887Mf051HrPTYU0yfKW0Q==
X-Gm-Gg: AYBFou0VMzQ5OQqc3mWBn3ZBiQ/UN45BnCYOsFnMI5G0+1hCyVlSSyfOPmejSm7CC0B
	h8t8+nuioaNfOhOCYeN73JbvsyubjITHT9xXHZMGjoP7u0zbCMpWm6UntTFuhficMCs3oQisrZN
	If75bRA/xffyv9ZRkz0ffYXZ0N1atgmREniPnomI8z0VlyN2SfQW2z5z9Hbzy7Ikj1cKCNGYHg4
	41bgD8kROPixoqQxTfKG9roMEFgsG2wPhoMvk1cKzML5tTa7x1c0V5+I4nWbfNZ1rL4RuhRtXC2
	rrU23rQaSLhgIMQWaeNM2L19FONxSBckw6wMZnznw09Q/RtrAbIjG9KtNpOH43Rl69obNPI7i8K
	Az2yk1g4yHgLRPT7XTzMA3gx7LU5vTllUjYyts6VpA9sBFdcGn5yDup1mpCL7gpUCmd9gzQPrFN
	+6OPGRXIa6kPWQOie2lYaHk1hVaJAAimLBjWGRdzpHgpdCpOkIfW5x8YL3eMdBlqo2HFnEudiER
	MPWkN5ipyn3xtYutwn1mQdHTq0Lo+VsJbFI
X-Received: by 2002:a05:7300:ea04:b0:346:d145:d6ba with SMTP id 5a478bee46e88-34c6312e1a5mr249274eec.18.1790707675274;
        Tue, 29 Sep 2026 11:47:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34c391d97a0sm995834eec.29.2026.09.29.11.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 11:47:54 -0700 (PDT)
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
Subject: [PATCH 5/5] PM: runtime: Add test for pending-autosuspend + teardown
Date: Tue, 29 Sep 2026 11:47:15 -0700
Message-ID: <20260929114714.5.Ida7b3291919b265af858b31bd680f5ac9940a0ac@changeid>
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

Add a KUnit regression test for the behavior fixed by the previous patch
("PM: runtime: Synchronous suspend when updating autosuspend"). Note
that the old behavior was racy -- a pending RPM_REQ_AUTOSUSPEND *might*
quiesce, but it wasn't guaranteed. Now the behavior should be non-racy.

Example invocation:

  $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_PM=y \
      'pm_runtime*'

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/base/power/runtime-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/base/power/runtime-test.c b/drivers/base/power/runtime-test.c
index 3487392e0afd..67d637550092 100644
--- a/drivers/base/power/runtime-test.c
+++ b/drivers/base/power/runtime-test.c
@@ -354,6 +354,32 @@ static void pm_runtime_autosuspend_rearm_test(struct kunit *test)
 	dev_set_drvdata(dev, NULL);
 }
 
+static void pm_runtime_pending_teardown_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_get_sync(dev));
+	KUNIT_EXPECT_TRUE(test, pm_runtime_active(dev));
+
+	/* Queue a RPM_REQ_AUTOSUSPEND (immediately, as autosuspend_delay is 0) */
+	KUNIT_EXPECT_EQ(test, 0, pm_runtime_put_autosuspend(dev));
+
+	/*
+	 * This is expected to quiesce a pending auto-suspend. See especially
+	 * devm_pm_runtime_enable() -> pm_runtime_disable_action().
+	 */
+	pm_runtime_dont_use_autosuspend(dev);
+
+	KUNIT_EXPECT_TRUE(test, pm_runtime_suspended(dev));
+}
+
 static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_depth_test),
 	KUNIT_CASE(pm_runtime_already_suspended_test),
@@ -363,6 +389,7 @@ static struct kunit_case pm_runtime_test_cases[] = {
 	KUNIT_CASE(pm_runtime_probe_active_test),
 	KUNIT_CASE(pm_runtime_supplier_suspend_test),
 	KUNIT_CASE(pm_runtime_autosuspend_rearm_test),
+	KUNIT_CASE(pm_runtime_pending_teardown_test),
 	{}
 };
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

