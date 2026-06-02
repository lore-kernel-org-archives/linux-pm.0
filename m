Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A731960B
	for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431096; cv=none; b=TjPW9RHYmTzKypdFsH+fiVhxGP9vFOOwDHZbQ5lNuAWWPsQueA/vIaiqnpD4KWIUmlRatYx+1iL6zAcAjtiw67T1kAKcUCwHWr9IEdlLSfV5LNcGrXRZKR0iEdkoYDYsjIyh+WAF7AJG/P/VhkPTVkOElT86KnCgJHkk9ceSC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431096; c=relaxed/simple;
	bh=/Ln9LFakNDKoLvwg+rwl9Pq8pfV/yyp8Qn8XzZMduQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTmVmcW3m7wj6f1+fHPBYPUVgBYFYDFasrpWRsWR6ORPO5S08oPs/0NsSFIBAvcdkbmU7bDO7VgrLxo9yx7Fj1NCDDFnA2w8ZCVtV54FEWppc4SHE+3jubPAlt+4WBqjMrbN+qnBGoEL1dacyknB6usI4lYe40MwHfYzMQJVPls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=4T568e+K; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="4T568e+K"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490686877a1so72293375e9.0
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1780431092; x=1781035892; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJ0eMBj31/DmadfkNUO8i3+VOVpXdT7omqYybF6XNp8=;
        b=4T568e+K96uuDJZYo/gDF1kDpZSUm+4cKXGiVJbKlO7RkfuExVxDfrk+Cgso6SCZp3
         qsy+VzoSatwpEYDNTNzsju9nIcGgAZZ5rK8wE102cX8DO2Jf9J4qjvp7ylLjOoByD/w6
         7+HUc9bPz/QuOmGglqxB3560k6vNJVt4KbERD2p7+pbUKEGUT33wG1QEXkW1QQfEJ7BN
         7501btc7VQi68PK3RCgqTS9DT5SA30rE3JZCuJ2Am7xrJwmOBqfkFPihIH3RpXudPFr/
         u0WFlG5xpQ+kbgIlmRTaETV9/x0JwBTXEtqtIseDRa9sBB8MrcRYG1LS9Xnf/RozAdlq
         S93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431092; x=1781035892;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJ0eMBj31/DmadfkNUO8i3+VOVpXdT7omqYybF6XNp8=;
        b=RmngFZXm+DxoyzTaj1QCBfaQgoF1xyvXuxkxd3SwQHkXPK8azVFX2XoC3/8L00/2as
         VcMR5DHYyHaWN+YQ/MXSoxckvNKr8XsHIlfAPiBOqBoPL2RvAUyH2Y9W+9KHHWljojJg
         pqd6fOke12tlhqWCIMn0EHDyndWAzUKjD8dtSfhN7m78kqHtHwwrKk8DEHHMVbA52yn1
         JKlMSB+TrLZura7XUFyuSU8ZSo1h+RAaRHGywWWCi72MXt5T4sZ9LpSRwBy2eCwSACyF
         KIqt4H1Fulm6R6cO6WN6U/Gl5kyAi2jFXZEYXUjmtXJu/tcUHijcaDpjyL+2SCi3leJ9
         KVPA==
X-Forwarded-Encrypted: i=1; AFNElJ9kLHcyI8ZlHzp7Ih2oHkN/RJRr5HHxaRioGNyKvz9c6KVtXOD6Agf2KnlMPK83W8cPdBsydFpjGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNh75n8ZzyI2C3uX7cPvQhXmOTdGWzD3rCEm5grPLdt8S98/8L
	vYXb4znJs06iPhB5IJ3PL5o93XDNtJm9US3vT+1RjFzpc6/375B6SZPEYRb/pL2VW7U=
X-Gm-Gg: Acq92OFSawjrzPXIG5jGbqiL7kBcr9khGSDTfmbc2IMemS6ew55C0xM/PjbM70L/j4Q
	B/qzE20IL+QOv48mfEJ6Ds4FKO7vSLqyjJNO9DU1kAlWWYUkItqZAG2wM+JMYvo0PixXiy2dmoX
	6/yQII59qAVglXSnJ3wpK3XAZc45ClGte7QleBhek6qQCJWnEid/mfwjrZjpHN/v98lSemN56VM
	yjhMc/+bGGs4PgBn9108PPnQoxm0+Z9Q8SpkEhza7Xm2T+NQBhVyTfHlvZkentI6X4G0KOTHlFa
	VasjXmwHtjBno9QxpxD0GD6YQj7i2oVMg5FYUOTw3mV7tviEpT79rEuVIGchH3+NgXKcOSkPZiq
	fObJCa+xFvThkSWJiS+236MlE4UWf4nTSCrP9UAT/sFZjzydGqrwn+COFieRtV+HIcxtNYxw0NO
	jUMGzYfLMI7knscsQZSKLTh6ECiBjGpscgNQ8s2dcw8PUYJw9FKtU=
X-Received: by 2002:a05:600c:8b0f:b0:48f:e230:29f5 with SMTP id 5b1f17b1804b1-490b6163925mr2735985e9.16.1780431092442;
        Tue, 02 Jun 2026 13:11:32 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b63e6720sm2588515e9.13.2026.06.02.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:11:32 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 03 Jun 2026 00:10:51 +0400
Subject: [PATCH v7 3/7] power: supply: bq257xx: Make the default current
 limit a per-chip attribute
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-bq25792-v7-3-d487bed276d0@flipper.net>
References: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
In-Reply-To: <20260603-bq25792-v7-0-d487bed276d0@flipper.net>
To: Chris Morgan <macromorgan@hotmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=alchark@flipper.net;
 h=from:subject:message-id; bh=/Ln9LFakNDKoLvwg+rwl9Pq8pfV/yyp8Qn8XzZMduQI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTJWzxr/mIv+ztuUe+nqm27fK7/nXTn17OfTyta1lw6e
 Sljj6mwT8dEFgYxLgZLMUWWud+W2E414pu1y8PjK8wcViaQIdIiDQxAwMLAl5uYV2qkY6Rnqm2o
 Z2ikY6xjxMDFKQBT3cXA8IfzheD9WT/nub18/aPcXXvngzUuj66UnWR+VqoUtFVc93YOw//az54
 boj86fd4yu85w/ofv1bZSMdImR05+OMQVY7ulbj4vAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

Add a field for the default current limit to the bq257xx_info structure and
use it instead of the hardcoded value in the probe function.

This prepares the driver for allowing different electrical constraints for
different chip variants.

Tested-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/power/supply/bq257xx_charger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq257xx_charger.c b/drivers/power/supply/bq257xx_charger.c
index 7ca4ae610902..39718223c3f9 100644
--- a/drivers/power/supply/bq257xx_charger.c
+++ b/drivers/power/supply/bq257xx_charger.c
@@ -18,6 +18,7 @@ struct bq257xx_chg;
 
 /**
  * struct bq257xx_chip_info - chip specific routines
+ * @default_iindpm_uA: default input current limit in microamps
  * @bq257xx_hw_init: init function for hw
  * @bq257xx_hw_shutdown: shutdown function for hw
  * @bq257xx_get_state: get and update state of hardware
@@ -26,6 +27,7 @@ struct bq257xx_chg;
  * @bq257xx_set_iindpm: set maximum input current (in uA)
  */
 struct bq257xx_chip_info {
+	int default_iindpm_uA;
 	int (*bq257xx_hw_init)(struct bq257xx_chg *pdata);
 	void (*bq257xx_hw_shutdown)(struct bq257xx_chg *pdata);
 	int (*bq257xx_get_state)(struct bq257xx_chg *pdata);
@@ -627,6 +629,7 @@ static const struct power_supply_desc bq257xx_power_supply_desc = {
 };
 
 static const struct bq257xx_chip_info bq25703_chip_info = {
+		.default_iindpm_uA = BQ25703_IINDPM_DEFAULT_UA,
 		.bq257xx_hw_init = &bq25703_hw_init,
 		.bq257xx_hw_shutdown = &bq25703_hw_shutdown,
 		.bq257xx_get_state = &bq25703_get_state,
@@ -675,7 +678,7 @@ static int bq257xx_parse_dt(struct bq257xx_chg *pdata,
 				       "input-current-limit-microamp",
 				       &pdata->iindpm_max);
 	if (ret)
-		pdata->iindpm_max = BQ25703_IINDPM_DEFAULT_UA;
+		pdata->iindpm_max = pdata->chip->default_iindpm_uA;
 
 	return 0;
 }

-- 
2.53.0

