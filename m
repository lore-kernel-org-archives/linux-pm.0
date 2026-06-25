Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE83A7F4B;
	Thu, 25 Jun 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782407272; cv=none; b=XX/zqVH+RQ2H8PZ75+n84QPKmlQzxXDtnqXOEorqBVQ0KZd/3l8yNLCxzVVquf1FCbI68mZuA3q9TiCN1CbuWll93JT12d9UlRmltgRsjkxJjYtsxS5V+JUVUjGFOli+OJcGJ5cFOqiQyvkoLNamxruB/9SlYNJ2w12xuiyhpt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782407272; c=relaxed/simple;
	bh=1Pzzgn4ee5Fq3uqW2V7GD4cVj/zF+fKYAOC8vTJJgv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qGye77bj2wmRRM97qcvzdZJwZgBeqxlYqiTROruiaj3YSlmf3padXjiL+isKBXhCGq/2NHHoMYMk7lef1x7mO9Mrhij03p6MTSQDP7yHKIa5ywVzDkP4TQXUO9XIKDr1YkM1HW40ifrbG93iZgqNwrlnynNQHo1ousO31e94l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc; spf=pass smtp.mailfrom=steffen.cc; dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b=DYGJaixe; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=steffen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=steffen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=steffen.cc header.i=@steffen.cc header.b="DYGJaixe"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gmQGm0FCCz9vCP;
	Thu, 25 Jun 2026 19:07:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=steffen.cc; s=MBO0001;
	t=1782407264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/r6Q5Fzs26vOjloPYfpIEea6sUwQwXI2u+7L2V9FvDc=;
	b=DYGJaixequLTCFpMs6sjybCfXFwh2gJTeBQoGvihIWtmq83wzzeIGg8JppMjJuQI7a0fNf
	HGYvy/GgSwB0gPmpGAHlVS1ox/+oDpOOPsw/eXjEaOSqbe5sza0Dvq/eVTc4RKU+sRR/2L
	Kg6SsP3jeBbZ/h8q8MESmVgJwisraZmztylRe1RLQrkRzgUNjqBeVOPm+yYazZRwj63Q70
	RuYk2XpPGlOeTdEZtn7V1W+gxL+0ZCTnSzwBVCqBrgPmIJVNmd0A8QPTck91+HEYeiIo/q
	JGaF9Fhz6uJcgdED9iSUUfiODyowbXu/bp2Ppm72urfbbEhbKBmuWtQsdJ2hCg==
From: Steffen Dirkwinkel <lists@steffen.cc>
Subject: [PATCH 0/2] power: supply: leds: add triggers for non battery type
Date: Thu, 25 Jun 2026 19:07:33 +0200
Message-Id: <20260625-std-power-supply-triggers-v1-0-d80db570d329@beckhoff.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw6CMBBA0V8hs3aSUh4m/gpxAWVaxxhoZsrDE
 P7dqsuzuPcAJWFSuBUHCK2sPE8Z5aUA9+inQMhjNlhjW9PaBjWNGOeNBHWJ8fXGJBwCiaLxdWN
 q7waqrpD7KOR5/727+9+6DE9y6TuE8/wA7nMPEn0AAAA=
X-Change-ID: 20260625-std-power-supply-triggers-0f4504fcbe37
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782407261; l=1584;
 i=s.dirkwinkel@beckhoff.com; s=20260625; h=from:subject:message-id;
 bh=1Pzzgn4ee5Fq3uqW2V7GD4cVj/zF+fKYAOC8vTJJgv8=;
 b=Qwpm2QtrV9yH5OUxr4r5X7yM2/LC5+p1uwpzg7HmBP/xlGal0fpVOYwRk6eNY/tkLWYzc8tDm
 Jk4FUcFtxC7B3F9unX/OCMnfc3MpKqGGac4oCgQb3Vu2defZwab+YQ8
X-Developer-Key: i=s.dirkwinkel@beckhoff.com; a=ed25519;
 pk=5DcsaSpVtmm7nCi3Bnw5A4vbXI+sg3hBgt8e2A2U/gw=

We want to use the power supply leds to show a different led color based
on ups charging / non-charging state. For this we add support for led
triggers for non "battery" supplies and a "not-charging" trigger.

This is roughly how it would be used with a device tree power ups supply
to have a violet led on power failure and green on power ok:

ups { 
      compatible = "gpio-charger";
      charger-type = "ups"; 
      charge-status-gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
};

leds {
        compatible = "gpio-leds";
        pwr-red {
                gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
                linux,default-trigger = "ups-not-charging";
        };
        
        pwr-green {
                gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
                linux,default-trigger = "ups-charging";
        };

        pwr-blue {
                gpios = <&gpio 34 GPIO_ACTIVE_HIGH>;
                linux,default-trigger = "ups-not-charging";
     };
};

Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
---
Steffen Dirkwinkel (2):
      power: supply: leds: create triggers based on properties, not type
      power: supply: leds: add a not-charging trigger

 drivers/power/supply/power_supply_leds.c | 93 +++++++++++++++++---------------
 include/linux/power_supply.h             |  4 +-
 2 files changed, 52 insertions(+), 45 deletions(-)
---
base-commit: ab9de95c9cf952332ab79453b4b5d1bfca8e514f
change-id: 20260625-std-power-supply-triggers-0f4504fcbe37

Best regards,
--  
Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

