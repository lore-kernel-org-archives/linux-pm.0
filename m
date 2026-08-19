Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC466415B6C
	for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166817; cv=none; b=ETqe5AsL/8ABasX/OH1gIuLm9ovmNh9p1Z3MmsG5I825d5cOQ+p03RCYMEEHQDZu4b8TrJoJn2O9DGsaHshEGS125i4OPbr3JU1WAtWuGZdXyf5YHmWPPML2ItXw51ysUPaD4HDp+xTT5tZriZysNlJac/YvKFM8krMxm+56ryY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166817; c=relaxed/simple;
	bh=wYad11hA3mnk2VgyJfhQxyQ2a9j5WMlBNGeJ1xdfi/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcvHDMphRH3t7JEDLLzkgsW704cvQKVsLi5/lLUS4ChC3ZWHrJXycJhrJYDnkXJPkcZ+gbsuqXBuCYhsf/xE9rvH1wFDi3Z9FYqEOlcmSWXmfMszFQTF4p/glFTybnbipljcAHkl04eS2TCvm++w4gYBHUb/75P6ETNjQBmnmHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V418U5fO; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V418U5fO"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47fe2d179e2so863130f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2026 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787166810; x=1787771610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1VtCkrUfMEjJubGDHG6KI/oRc3p1JRjRbau9vzxQEAA=;
        b=V418U5fOqa7uQtYMs++KzdUXclo9l71l/HuQGFumH/z9mecLgTqor24y9AHyRwlsdX
         EnRFZZbpgVph9JgzEckHZ4+r/G8RriF2CPzV1TryD7WNsTVDDeAzW2DbbCq/t5TQwTCE
         zd8fiDeI15pD+knzAWc/5goR2MvXXtpddUSrCQJcXHgO1BC7Hhf5vYEDgvEqiOjoCz2q
         dOx5Rtlc1U1f+cWE/LOp9D2B0gIaGOdmLGfqAF6rtRGK0PAx0h6lSUYTpM0/3qq716Vm
         JDxYVYuTrIjtLnLNQ6cY8AMHPP8fCnKmI3vw2jSaz+fBbik6EdmXS6q6ruxgNu01KoCe
         jDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166810; x=1787771610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1VtCkrUfMEjJubGDHG6KI/oRc3p1JRjRbau9vzxQEAA=;
        b=GPHWlgA4Q+Y06ZxCTlU9+0NPFhH5BcZJX9efoJZAwta/VhYq5cDgXg5SyEyFLH+ZAq
         YcWgulutZ0mxfjEPb/CKLWGvzlb4jB7PGQMI5phQdqLj+jLu1XnZAUUotn+xd8NeEaTo
         2fqywWq/leDi9sxoGd3vIo/JOHgu5rB9/0NkDLbBj+PZeGLNnnC0W2TCMlIf38H9TATX
         PMEdGkv+7UxiHVjNCBD05SDCWMQqZC4hcFdG1sAadS89nYM/jt/AaM9NfmQY073cMe4f
         33ai5OjbAEWkMvvTx6pq471IxgJFd6+seuYlqrDKWmmVevgH4/+mwQYDZkKtoR52IiGN
         navw==
X-Forwarded-Encrypted: i=1; AHgh+RpOlceaL3pmG57VbPOy4LiZJZ/6JHklwy09qZxYztCuzr4i7WS8gnporo2GOBzJkbgk8jh/rLl12w==@vger.kernel.org
X-Gm-Message-State: AFuF++lIQcCMw07snIIYpyHnxOiKdl6SvqWJRzioGqJgHd3aXIKmmppf
	ogKQajSVFKwjPVRKJ9eHkon2UkGnC29MYrAFJW0YK89JuO985QxfeNPG
X-Gm-Gg: AR+sD13Z2Ag3UhzIoBX6HuZzoxsy1xN+GdnoBNwM3glI8uxCWVTNHK1GBFFiXwkx2q0
	5N4SU8n2NJwBtsTwIvjnEhzAFC+s/cev8Dg0W2EUm29Uhcfq3GgrI5lMr+k/4PQNWqjkaKOdMiY
	/iSk2q5TgzcOowGYcAr+EEYneV+jaEs+gfu3NYqTVKnJfMQ7I5qZSRc1eBpAMbFszW21NgAFqSI
	yYSK1pqIZCg3b7w2itzo4KHpm/2prL4Uxrm3WkkoJiH3TrF8v0S+XJ46nv527nJ9tCIUuaWNG9x
	zN9uDJ1bZgYXyfGAEDJENuUbcTpFyeNvRXUNke3qSVZzJCsElkpM4urMvMKvaNBtG/8rzG3rFPo
	GH+v867q0rAavXbWi+eGzLPnbJAJpvqjx9yMpcBxkDoPDxTwnvbBaF060/uwJbcJ8VsaxHDdbxL
	nPRfBRnpbdPSV0yhXLKffw6q+x7ouGIyJbQ14qSrIGSIDxA/CrAF5IszKJ5BBg9In8EEH7
X-Received: by 2002:a05:6000:4283:b0:482:a909:53d3 with SMTP id ffacd0b85a97d-482b1e877a0mr11578952f8f.2.1787166809988;
        Wed, 19 Aug 2026 12:13:29 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:c7e0:8c9b:65f0:4aef])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c338dsm6153398f8f.25.2026.08.19.12.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 12:13:29 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 2/4] power: sequencing: Fix build issue with COMPILE_TEST
Date: Wed, 19 Aug 2026 20:13:19 +0100
Message-ID: <20260819191325.217809-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819191325.217809-1-biju.das.jz@bp.renesas.com>
References: <20260819191325.217809-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The POWER_SEQUENCING_TH1520_GPU driver depends on
(ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST. This means when
COMPILE_TEST=y and ARCH_THEAD is not set, the driver can still be
built even though it requires AUXILIARY_BUS, which may not be
selected in that configuration, leading to a build failure.

Fix this by dropping AUXILIARY_BUS from the dependency and instead
selecting it directly, so the dependency is satisfied regardless of
whether COMPILE_TEST or ARCH_THEAD is enabled.

Fixes: 1a7312b93ab0 ("power: sequencing: extend build coverage with COMPILE_TEST=y")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4:
 * New patch.
---
 drivers/power/sequencing/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b7..226c62704d9b 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -29,7 +29,8 @@ config POWER_SEQUENCING_QCOM_WCN
 
 config POWER_SEQUENCING_TH1520_GPU
 	tristate "T-HEAD TH1520 GPU power sequencing driver"
-	depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
+	depends on ARCH_THEAD || COMPILE_TEST
+	select AUXILIARY_BUS
 	help
 	  Say Y here to enable the power sequencing driver for the TH1520 SoC
 	  GPU. This driver handles the complex clock and reset sequence
-- 
2.43.0

