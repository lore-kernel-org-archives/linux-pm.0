Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381C855C301
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707674; cv=none; b=nTojuzrAdyEXlfS8FhGWFfWsOwERJHzxrNNJYB6UfU57kZIKKt6Xj8WOVSoZoo7PdU3ZgF3913LbO5JCH3I+qfOVBxmALyjDWHBaNCo6ee2juuVpTCmd30R3SIiorHBtSFDcQIEnA+1aPZnx1QF8LPSaevgMxgxi/Kvfy0nvb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707674; c=relaxed/simple;
	bh=01L+QQECHra3xXDUIkDulIcHYQjusCnd2MqkIHFu46o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7RLviJPEsYW0ZMHA19XK9bXWWMbXil6+bv6fYPCmnTxFFypaw9vJy+mA1mskFrpBlMQGWGK4Ib4Llv1GC4M8xhxZXNJEcR1E0CuI4D9cZ/Wnh0KJnQBgN2bjOPlyUYU5A8U/siqF06+ojIWceleIfLxXXJqt+JkxPvsOWOrr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l4J1Oh1x; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l4J1Oh1x"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3410209aa6aso375605eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790707672; x=1791312472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iw97L1f7Zvhgrq8Jgnb3mPTr/+Xzqez0KSXoOwEr4YU=;
        b=l4J1Oh1xwO0SH5PP/SemGW/zVO1nJYGkcYUQu7lXx2knuuQop385nn5xVAdK4qckvR
         2bkb3pJhmvlWU8OWyrRP6vYGqtHutxsefEB4oLOkacjRkJPeIla0k9s4VRGuuKXRfY5x
         YzR3G7p6CXNJ6SHmjpC/63qB4+qF7iFZmvH0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707672; x=1791312472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iw97L1f7Zvhgrq8Jgnb3mPTr/+Xzqez0KSXoOwEr4YU=;
        b=DER9Z/kv6bkNRKLPnEVifrDczTjIKeTwWRY1WdHjweBUczVou+Mjn7MCF3jgFomtTt
         ID5cuigqhEC8+4LAvZWrJ39lYznpcZZ+anWxrnBiMIqKwuCw5sKFdOAb6e3CCHdiSpXG
         gcjWhjwdCQDtMWF/rdOiJBrmWHeWdDhHeIFiomMhjAAuNoWVbQLEYdiOK9RiHF4+LjYp
         cHqvPFArxExlVLeycXiSu0xopZqX4QRo6ObUsmJwuMbC0MBKW60ItBi5zmWQ+MPTBTn5
         yyrv7H06w6/0Xh+PQRDZzfkZ2CtZUqrNXZXdileqwLS2usuJbTNZ3SIhtPPHwHGx4D39
         hCbQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlzDxuE5KVbqwJo6xJ8oDZmOnFl36Oxn1RUCWOWSDGTjuVqDKnN7EuD554C4UolwS5LCdBhC1x0Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYLpNGGL4NWoc29uZfDFVPYvOm82goMKAQn7ZFm/lfhxs+lCY49B
	+R81fpNpKac+fuKncDI9t5fvl0TWUfpfGwA5mll97QG9fliKKWy1ch0C9EuqZfeKdg==
X-Gm-Gg: AYBFou2c8X/0gtZBXkAmdZtiKkEQm2YLvIvGZDBrs+CgaCOoO27z8nxXmVnWr74zHWF
	kpx32fKhWFT0Tvf1y+jQ62VemJtpwslqje73oud0igNScuGPIiQtJT1Rs4Jl/IKbCkWTBlPvDLP
	qFZzPoyt2S59Nl33mh3Iw19lV6tu5RLla3sSrXOzJYxWrm5HWTNPx6BPt8xUREEeXYFqHiBRA5U
	4hj3Va+VN4J8z3sOlNQpIErkH3jsqLmObpFVnAryuqgeramAUwGy6JeKUm44wczjOmK4WZdxS2P
	mSbTi7hjVn2+gO7Jn4ZpoXukJg/8AqPcrB4xEOLWGahwsW+KBNzJyESPM1TQMyJKh3SRbGCeGon
	1YGW7x1Swp7E7lphNtnj1RMmNwvBSZydfLGpaCmWoi6F4L7x2c6UUfwxL12DhlNMqvsN81895Rn
	VlwyLWGAwudHKRMPdUC06cbQmlc7wznDm9z22pkLBieFcgHI/pZ3R4rbIEIhiW20SdJHLKK98Y1
	HzZMsGZWI+AaVD4CjkzZlSd7pNxwYwWxsxX
X-Received: by 2002:a05:7301:db18:b0:33e:61ab:8309 with SMTP id 5a478bee46e88-34af9606139mr3743921eec.23.1790707672135;
        Tue, 29 Sep 2026 11:47:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34c391e25e1sm904778eec.30.2026.09.29.11.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 11:47:50 -0700 (PDT)
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
Subject: [PATCH 4/5] PM: runtime: Synchronous suspend when updating autosuspend
Date: Tue, 29 Sep 2026 11:47:14 -0700
Message-ID: <20260929114714.4.I1efb3320288521918bec038f24a69f1712af75dc@changeid>
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

When updating autosuspend settings, we request synchronous autosuspend.
This is sometimes a best-effort action, because we don't know if there
are open reference counts for the device. In other cases, we expect this
to be reliable -- specifically, on the teardown side of
devm_pm_runtime_enable(), which calls pm_runtime_dont_use_autosuspend()
to (among other reasons) ensure the device will immediately suspend if
possible. (See commit b4060db9251f ("PM: runtime: Have
devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()").)

However, synchronous rpm_idle() does not flush pending suspend requests
-- it simply returns -EAGAIN. This is noticeable as a small race
condition in the following sort of scenario:

	/* Last user drops its references, and queues RPM_REQ_AUTOSUSPEND */
	pm_runtime_put_autosuspend(dev);

	/*
	 * Next, driver is unbound:
	 * --> driver remove()
	 *  --> devres teardown
	 *   --> pm_runtime_disable_action()
	 */
	 pm_runtime_dont_use_autosuspend(dev);
	/*
	 * --> rpm_idle(RPM_AUTO) may return -EAGAIN, and the SUSPEND
	 * request may still be pending...
	 */

	// Indeterminate device status: may be left SUSPENDED or ACTIVE,
	// depending on a race condition.
	pm_runtime_disable(dev);

If we use synchronous rpm_suspend() instead, we will properly wait for
an outstanding RPM_REQ_AUTOSUSPEND to quiesce (or else, perform our
own).

This is a safe change, because:

 * drivers that use autosuspend shouldn't care about .runtime_idle()
   (the difference between rpm_idle() and rpm_suspend()) [1]

 * drivers that don't use autosuspend will not reach this code, except
   on the teardown path of devm_pm_runtime_enable()

[1] This isn't actually mentioned in any documentation, but I infer this
    because its dedicated helpers (e.g., pm_runtime_put_autosuspend())
    skip any idle checks. And surveying existing drivers shows that
    those that implement .runtime_idle() behave similarly in their
    .runtime_suspend().

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
See also a regression test in the next patch.

This resolves one racy pitfall when using devm_pm_runtime_enable(), but
it doesn't resolve another pitfall: what if user space forbade runtime
PM (`echo on > /sys/devices/.../power/control`)? In that case, the
device will still remain RPM_ACTIVE on teardown.

Surveying many devm_pm_runtime_enable() users, it's common to fall into
these pitfalls. Commit 2d90ecdfa326 ("ASoC: rockchip: i2s: Use managed
hclk and runtime PM cleanup") shows a rare example that got all the
details right.

I may propose other changes to devm_pm_runtime_enable() later to try to
help those, but I expect them to be a bit more controversial.

 drivers/base/power/runtime.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2a99b7509744..b0262f187041 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1788,7 +1788,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_irq_safe);
  * @old_use: The former use_autosuspend value.
  *
  * Prevent runtime suspend if the new delay is negative and use_autosuspend is
- * set; otherwise allow it.  Send an idle notification if suspends are allowed.
+ * set; otherwise allow it.  Attempt to suspend the device if suspends are
+ * allowed.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -1816,7 +1817,7 @@ static void update_autosuspend(struct device *dev, int old_delay, int old_use)
 			atomic_dec(&dev->power.usage_count);
 
 		/* Maybe we can autosuspend now. */
-		rpm_idle(dev, RPM_AUTO);
+		rpm_suspend(dev, RPM_AUTO);
 	}
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

