Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6FD3C9EE5
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049928; cv=none; b=D0XS1+4aKa6pg+SpiGk6Ia3zU8QIcRCnD/zh5QqHm7xEsmNJmuJmo8p7FBpTA7nVpChkn8VDh+XoPSiWLL7qvbMj7QJ5OrqVE0NHzOELmqNAV0f5TuxNKtPDpcJNiNuVT3C1pJM67QaKGvUSLl5ebZVJAEVMnvNRu9iPXVAnKo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049928; c=relaxed/simple;
	bh=j07x97s1Wf+YOc3AIBt+BDtOm6zhVtK4xiYixM5/hT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qu7LOI1TSCL23gqOn8iCXI0KdpRwrF46Om5ey3IXzTHzTf1O4Dp0AHAn4Ou4qazOd+L3G1sjWCz4A3rxJwG2JpEbPgQjuCfQq8baWR4ga1uFEh/RplGf+Uj8d6f3ZNsTfWcQvd+BwwpZe77nDAAfr+kFuAGIZu4tlBIH2dpl+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=e+bfI49V; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="e+bfI49V"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso432408f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780049926; x=1780654726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtVdZNScTofI8P3tHPj6mAWShd/HrYu5mi6gsoESwBk=;
        b=e+bfI49VgsvJxfBEq6H0UUrirhruv6E8TF8GNOD7kMHURArSusMePSmX5tEpVQHhHV
         TFJdmCWJ0MjozzywNFKD/1fy+gcFiK/x/Bu2/bgYRk7qTLfZ3uMDmTFQF4xe8NjKa1a4
         WORc3c8mJHladQhp4wk989K2QIMMfSiRSMwLAEPZ7GY/djYNBs0SX/318wPj/uC2Gqqj
         UC61qjfLkWK5N6HgmrcH2n+g6fnnxGqnB+FszvKgEqcZfjATvNvV11zIF227hHP8u7sC
         m3Mhf+XCGuzkxRyb/125JETq/ViBgPL58VPLO8U33xQ61dBXwvIpyR8BnoNrK8OQTqN7
         dn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049926; x=1780654726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtVdZNScTofI8P3tHPj6mAWShd/HrYu5mi6gsoESwBk=;
        b=UpN4RpaR5IEwdZrypZw3Sw82mJ4OIcZgfpHrCH9ke3rCO5GjRm5Gw93hiu6Tgnws98
         GUHl7fEzhEXmpYyie+E/k4RMd3ZzIK4g2+pfhvUyGUkCjwHgKd7aTF+1j+wMUMDirj4k
         34yDiiUAWldsdyIs2EbIXtp05Co2MAMwdr6QcGw/AeTWTMEQLDq72XluIKKB5y1ALPB7
         jWsOJ1MwWbC9U7dBvs0j9bSXMjS3CHVUIjwdOJzZUpA4sGOeImTuGbUiy5D21e8y9e8X
         sGwIDcYdKycbuTh6dT9Ycab+aFVoxjUSRWavRiRabMV+a8E2xUpmLVFuKkbC2iexI4+g
         mG7g==
X-Forwarded-Encrypted: i=1; AFNElJ+u+lxVGXqsFiiF91FfTty9WazX7ZW5ggp3AMxnoxLNN6VQ7VEkEWtuLjJq87aedsQZh8HJ8Jj/Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/megMO8XyEAr/apHdP4Ll7EpWNfr6ijwNXjLlyD3fBZTVtzj0
	WVUnz1ildee7Ahvk7l564Osr0/iEhqeqfyLCog6ZZR2uJUb3EwUZMIawgeInU1os1Vg=
X-Gm-Gg: Acq92OFUgKZEkeGIQ9iDaHQNvjV6xpSOyzhmJjjxWXgzdScC1yxi8MMis3YgA3rpSaL
	iOqGQ5MsP030Qg9JmbVJ5do0nq2wK0t13FAgWdap0mQrRe6UV1igtj8IbVrGt44zf9DBjZg4VmT
	YSvjl3Ewj61iSIzELd1I6Fi+Qe7Z5bjSWz58pNxlk7sAvI6RtjdLp1KPiL1X4d8j4/lO9sgoTVm
	qEpilsfP+8BOxNHKmhNWFhfC8v2zI2DwvFCzbQNJT+VwF0d8njLEkudJog8q5cuOTYXtlfnc3Ta
	EwmkFvMdbsiTp0iUA56xuGHXI3WkRkxTFqwcpz8eXl6hxLtUmeEyKddjuzlHJALGyVF2cVD56YT
	1H1HqWyHw50oznW4vIGGNutwcGD3XW6a2Gz/BMTwQlsCJwPo/srgJKIvDZ6RqqrZOGCSFql0TZ+
	538i6MJ5C9yIBXeXBQzsmSSBAUtbdyemITI0rCezaiH3V4M77i5ALa1hGLuRX8q3LTlhexwgQ/a
	lentiBJOuAWDUc/xma+5qcGjgvXgwhDC/p0
X-Received: by 2002:a5d:4602:0:b0:43f:e272:edff with SMTP id ffacd0b85a97d-45ef13ed7e4mr2873909f8f.4.1780049925683;
        Fri, 29 May 2026 03:18:45 -0700 (PDT)
Received: from localhost (p200300f65f47db043f932d8b97293bf6.dip0.t-ipconnect.de. [2003:f6:5f47:db04:3f93:2d8b:9729:3bf6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45ef35874b7sm2392386f8f.35.2026.05.29.03.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:18:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v1 5/6] power: supply: mt6360_charger: Use of match table unconditionally
Date: Fri, 29 May 2026 12:18:20 +0200
Message-ID:  <ff94de5fb3ee6aeb1c0256e1a00c1c5ac350b430.1780048925.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=j07x97s1Wf+YOc3AIBt+BDtOm6zhVtK4xiYixM5/hT0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGWf11W6GNZFuwWjHh5SRVpp0Kru/KhvgdEKCj YGOEfu6ShmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahln9QAKCRCPgPtYfRL+ TsQVCACKqsRzsVd97fbfB0uKqFDSIesz/zHQ38cfBH62FRQ/svd1jcnpSkZl4aTnLgP7wiBUZD8 1xG7eoyDmqnsfMqVUwLSuzym3mNgbUzzX5HTrsXhEn8RTQW/8S1RVLXRlAwsgwXn/EvbWtnmDzZ 90atHov9BC9xEpCgBvITrSSuWiG2RTu4Lg24HfdgR9pnPprAz0R2pTH73ClFSOMGhGJobKyDYQR hSnllS526cbx07AycnVtUY2A62G5w8IMbGn0M2YmtZKprJ5RFT/dwhiyRdx3LN1xOqXaj6N6Ygf P8kLbsbwpWiW4P367QSKZT8LykSDYHZSHIRlpa2tvLg6y3bG
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

mt6360_charger_of_id is defined unconditionally, so it doesn't make sense
to not use it for the driver's .of_match_table member.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/power/supply/mt6360_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index 69955f255091..d3b0731f6562 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -849,7 +849,7 @@ MODULE_DEVICE_TABLE(platform, mt6360_charger_id);
 static struct platform_driver mt6360_charger_driver = {
 	.driver = {
 		.name = "mt6360-chg",
-		.of_match_table = of_match_ptr(mt6360_charger_of_id),
+		.of_match_table = mt6360_charger_of_id,
 	},
 	.probe = mt6360_charger_probe,
 	.id_table = mt6360_charger_id,
-- 
2.47.3

