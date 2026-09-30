Received: from mail-dl2-f40.google.com (mail-dl2-f40.google.com [74.125.229.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677A2373BF6
	for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2026 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736670; cv=none; b=Kv5sv6bQ7d2TV9nmrtEeuDKS2OEDLha0d+dR1fPh0d2qey5z2qIHmGaysmtfvQ77zPeCU/78NRs2IEHXkuuDY/d/L2qxf1FxtxLLUebJqMPWlvaES5PVeDlregSFTAbfQpS3saBWlxe/7Kz2ir0F3EGyNtcHPizmzuSetxMIEtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736670; c=relaxed/simple;
	bh=WQs5In3pWprR3zrRnTgoo/qUfCjyLE6wU00tTJoQt20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt5fjCun0ctr9cOg6SYZt26QhBucnmbmlFSuCdFGcVNACN2lAg3iRgze0ZAEvOqGWon1Fs6KOwxpqG2Vh3RwqgpODkjKxX3lf+6s4uZSrxtr8GwY3FnB2kYhlTgkmOyUXkNg7T0fWWmBZH8cbWvJHEyAhfMeELZ7GzquB3froGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kXokne2Z; arc=none smtp.client-ip=74.125.229.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kXokne2Z"
Received: by mail-dl2-f40.google.com with SMTP id a92af1059eb24-14beee9ff79so467520c88.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 19:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790736666; x=1791341466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z9PQZ/RdlGnjkaRoa0q1K5xoYon3f3vH5dZxAKS9M00=;
        b=kXokne2Zgt4gTNadDfRkTKi4dBhJCeZFUPGewtkm5xHDQOgw8qKQNXtCw7zZY0nFA8
         WbnIHhMP+pYUoLzTPqbUxBzHvW/UaOlv/Upg9o0Glky/qqze0+BRm9S3p4pFTx0ryghP
         bMWoJmckzIFbXMZ/zsa3Ynv3HmlZjUtlIw/vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790736666; x=1791341466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z9PQZ/RdlGnjkaRoa0q1K5xoYon3f3vH5dZxAKS9M00=;
        b=BS010TrmRpSjg5jUyj3poidJ7OiLruEgbVKqQf1hyrJ45arlGinMzc7TWkqadFhmCN
         g+b6KhBBy4919B9mzl6nZ2xlF+UchPzRYG6vzOhVhXf3svHYRONNqEkIGKtyE9+ea5lw
         W/jOcsLZLMzgKhJnhGyL92X2ZJGI/RrKUXSMjYbtKpCMu9Eb8zd/Zlj0mAHlJslJIJWR
         x0LFdr5B7xznyS15ifmKyanzum7d3B4FTDD24hhWLED9gReS4CTyNnh0lYLIMz7+axTl
         EbL4pEy1hgVPiI35gzITuSBGOyz5tmtj8wT8c5n33pZbAe9bovMofxwdAFoi8gkSBQFb
         R6iw==
X-Forwarded-Encrypted: i=1; AKwUvBwL7DaNFSoMbHp2j3mcFjK6vjxdvh2ZajIhbj30ahzgapUu8TXRnFaLj0HO149eEgDIXWPUiQFksw==@vger.kernel.org
X-Gm-Message-State: AFuF++kEsi2bRG3qA4OwYL8r9a+GOwm9PhqffJq5q43YNYV3NuUutmWX
	RZAX4buoGozbSsxRk4Kd24Si2n75f4ils0f8pkWa1f/kvEcDaWGXM2ZFP2P6fKnzvA==
X-Gm-Gg: AYBFou14z8riwZDbABu9plV1FoFFYF1QCkPdLeEQMEEWWm776/0s8+gfRljbt3D4p4x
	JNByRXQBYE+t1oGooHB0Z6koJpJAc/POhKUD3pVsBUNX1UcTqfPQiLfN4QUr7A8N+DwOmSoY0xi
	ZTd5Qb9H0kQORUCOu980lh0B4Q2JOzJqomCHEjUrkgbMRM7o867qCDDXkFtSQyZW54GNNz0Ln68
	F46R/BvJsluBhL9v1QecGNVXBGUjZd5c7Tme9EB+kuG7dlWiVjMJ7t38H9mDtVKnmK8zKI4Gq9L
	ILiX2y2OeSGyn1HVugPTs8z+5u+2x2iqyE7mHHqP6lGQ+MCPu+DT6cTR5buYdoE+21JpCvPFzY7
	nbD6YI1TnofpeyczmM+4xoICWl9d1/m66qQoz5LmYGku6JIzZLVir05h2HAoIthHBZDD8z+XTBK
	SZGGUmSO0nwDzis5cLE3+9iXaZFC+7xuPd8tc9Zo9/ezGvqRwFiHAtIT0+v87wRd4+As+jo0UKj
	aKaGqs3sKtJuwviPe1EE7QT3BmsuXcyqTES
X-Received: by 2002:a05:7022:3f07:b0:143:26ea:371c with SMTP id a92af1059eb24-14c9f218abfmr1529002c88.28.1790736665960;
        Tue, 29 Sep 2026 19:51:05 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:5f5a:aa9:d06d:b4a7])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-34c38bea1bbsm2713158eec.23.2026.09.29.19.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 19:51:05 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Doug Anderson <dianders@chromium.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v3 2/8] PM: runtime: More kerneldoc formatting
Date: Tue, 29 Sep 2026 19:49:50 -0700
Message-ID: <20260929194956.v3.2.Ia1cae8a40a24662df11553c225f4438eab65b7db@changeid>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260930025044.104824-1-briannorris@chromium.org>
References: <20260930025044.104824-1-briannorris@chromium.org>
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

Changes in v3:
 * Wrap/shorten differently
 * Resolve a few other inconsistencies with a similar pattern

Changes in v2:
 * New in v2

 drivers/base/power/runtime.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7e75f6d5df07..00d1981763b6 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1254,12 +1254,11 @@ static int pm_runtime_get_conditional(struct device *dev, bool ign_usage_count)
 }
 
 /**
- * pm_runtime_get_if_active - Bump up runtime PM usage counter if the device is
- *			      in active state
+ * pm_runtime_get_if_active - Conditionally bump up runtime PM usage counter.
  * @dev: Target device.
  *
  * Increment the runtime PM usage counter of @dev if its runtime PM status is
- * already %RPM_ACTIVE
+ * already %RPM_ACTIVE.
  *
  * Return:
  * * %-EINVAL: Runtime PM is disabled for @dev. The usage counter is not incremented.
@@ -1607,7 +1606,6 @@ static void pm_runtime_set_suspended_action(void *data)
 
 /**
  * devm_pm_runtime_set_active_enabled - set_active version of devm_pm_runtime_enable.
- *
  * @dev: Device to handle.
  */
 int devm_pm_runtime_set_active_enabled(struct device *dev)
@@ -1634,11 +1632,10 @@ static void pm_runtime_disable_action(void *data)
 
 /**
  * devm_pm_runtime_enable - devres-enabled version of pm_runtime_enable.
+ * @dev: Device to handle.
  *
  * NOTE: this will also handle calling pm_runtime_dont_use_autosuspend() for
  * you at driver exit time if needed.
- *
- * @dev: Device to handle.
  */
 int devm_pm_runtime_enable(struct device *dev)
 {
@@ -1655,7 +1652,6 @@ static void pm_runtime_put_noidle_action(void *data)
 
 /**
  * devm_pm_runtime_get_noresume - devres-enabled version of pm_runtime_get_noresume.
- *
  * @dev: Device to handle.
  */
 int devm_pm_runtime_get_noresume(struct device *dev)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

