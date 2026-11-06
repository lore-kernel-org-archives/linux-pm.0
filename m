Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980872;
	b=3cHCDdr8Om+W65eNNnj6jSBkG2ZL5wEanO3sCNlWx9ncoFLh9y7En1+UAyKcBV0HCS5B
	 5z9YO+h4A/00G2Ub2Ax6brhuI7KOgceds4sCSg9XgguNL/Xi1sH6jjmFnu8lMIGQOFXJu
	 8REhUvKmvohzQkSdcHXxz1nuPQqcHshjNPyARH3Hj2bhrTR7l5oJfsV7tftYObVMQ4kum
	 36tF/M2d4CAb4p3SX84+/qEuCFnM1YMoIYpZi4Na607bkJEn4Da2FSP91M1iHpmjGBSGG
	 B8yKQ8fH0wNPQWC8BD01AIQ3SMgt3CXpDB8zDnJhjlVeC2UUC42lpJBl+vNBq3il8EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IVRbH9fbQr7HvpMOmMZEA1Ly5MPApVblIj53P80z6C0=;
	b=wEsi94hGFtDH0rmP+TnvGBfJt5tt4VRKY7CEJRImuvXRqmyVmthjhD1zDzliI6FtldVe
	 02M8ASKALSUHxpv1E6UUEL4LeHA0M5DUJbG0M4NdROtEamdH7EdUXW48QdWVR7kA59hVH
	 F6QlT9VNzpd+gdWflb2LZi30ITc5axv+kdmOD53U5Xon9Aq1kgDTadYIqTww0AkN/5iaT
	 Ef5zVcTjG7vdGwO+q61y3Vtf2gkkaddVn564/1cqnaCEXGntLRqBHVA+FQdnnqfrP5kPz
	 bMzyNuoJhZ5f35hf2HelMpdQ+fdWu5JztYg076NYm4IabpDsEt+TMb1zG0AJ6VvQAjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=op1AuvGh;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6170606A326
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 16:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6170606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=op1AuvGh
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so313194a12.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 08:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980871; x=1794585671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IVRbH9fbQr7HvpMOmMZEA1Ly5MPApVblIj53P80z6C0=;
        b=op1AuvGhe04OZzlV2fVeR6NXHYWLZG9w0OjxRgJ/vWTwea/BVRjHYr003McL/IxgQX
         fRDiZCb6FBpSkDqLWgom5iJygwcwE5VhTF2tfsuOycke+9ivgnbGpPjW+lBzeIH59EFg
         v8RXj+PZzUosk4C4tsg/EAUHrgsWpf+BNiObum63DzGVZVfy3Z5w3dm4dIWTkLA8C4RB
         Z14ptT/5tAyEhsyTJCeo/53EwFtasSb9LbDNAbMznvZX4U9JDHYBaB3vjRdTWG5tAbNM
         UvRqEqXLrHtQEIrfNeABAp7ndWpWM/38FmgIjR/1QnpeJXZVwQH0dDRWUZ/t9EcIYAat
         DBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980871; x=1794585671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IVRbH9fbQr7HvpMOmMZEA1Ly5MPApVblIj53P80z6C0=;
        b=GVpn8iRuDJ4io4PSokvB3zPGK45ijacNWJAhSyG1OJJ2/lsmQMtrFeKtRYmdo19dyU
         ct+yIkOx0vvQ/LXYIIDHNtcr2xGmzDX/hDI2fxjN+2DWiHBgZHagXmfLp0eTc8aH1ooc
         7JgIDgYPZH81X1uVTiJ206Jj53MMUcr5AyItabGRMG9yezwSPA1vSlKuWF7AO7iLPkQD
         JS+SO1fLUq5NwObSD01Zizyg/1UNXd13z/gSobjSJiipDmiA65fgAY70u+/gh5VZK6SI
         cYOh4aPUu28PNpMSHBdxLmlNpWt2XkmNDkF0fJi5s23+UgI5WfDvJFoKbU11iIIDb5xC
         eTEA==
X-Forwarded-Encrypted: i=1; AL+hErFJZmjeeyR00h43nUhbzKFejzQCPKilve+kPvzgJVu6tje+PvJCpdXkFzhGw42aqhvPGOmMN188DA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8BJsozxq1hhVWF1n1RKXeldiOYqFEtgZWEO8jDHXVXuTx9ph47
	ZXELVFats/F6R0cnlB5i3h05GUcBbq5PQOi0scmYUkKDRFGqlows/lak
X-Gm-Gg: AYBFou011X0mtkUboLGlZ+PId9n6d3YQs/VtrKnse77WL5F68oZ6UyiAtY6Dal09qUo
	Ck1TQINsBIz6yEIwfVgVkKSbiRGbTy697IiRuwgiwtkwSgTVNYwyBGuONYC1hlIUPzMs4AoK6j9
	dzKwmm16e6lVNtoVOhA5Cdx/qMgFAY+6EdneYBrl0ewf+3z8awPyLROBEptGDy2Vhu3NhYJ+opX
	Id/FOukylIoWyNTvusUROpyWng6Im1BBtuOOPoI2ykwaidsLnxPz42Um3t/LyDOJcvgtkK+YIpq
	ey+TQAsNpuW8xE3tqrrjS4zOF7KAGqQco1rvgXfVid1MyURDkOOVh4/Co1NdQp8et7A7GcnBHDp
	rI5hI4CXP8axU5JKBE0NvfjB0S6kmoU++NP8YzEskPtJOzZdXwcAmcpJIf6NPDtVvAhuBw4Zq8I
	yrSm62jx1pgHb7FXMdSXjbp7PhDQ6y7LPwjm4opKSKCD52JYw1fBcJL2S46RnJn0FtWyQ0GrOOe
	z3N/HrIGd3xRLYrFHIBkmLM
X-Received: by 2002:a17:90b:5905:b0:3ac:9c37:942e with SMTP id 98e67ed59e1d1-3b0db70add1mr2802118a91.49.1793980871142;
        Fri, 06 Nov 2026 08:01:11 -0800 (PST)
Received: from hj.. ([163.239.22.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb70a7fbcbsm727930a12.25.2026.11.06.08.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:01:09 -0800 (PST)
From: hyunjungg <hj351016@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>
Subject: [PATCH 0/3] power: supply: fix work-vs-devres teardown use-after-free
Date: Sat,  7 Nov 2026 01:00:54 +0900
Message-ID: <20261106160057.2754689-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

Three power-supply drivers register a poll/detect/charger-detect work for
device-managed cancellation (devm_[delayed_]work_autocancel()) in their probe
*before* they register the power_supply via devm_power_supply_register(). devres
unwinds in reverse order, so on unbind the power_supply device is released first
and the work is cancelled last. The work handlers call power_supply_changed()
and dereference the power_supply, so a work instance still pending/running in
that window touches the already-freed power_supply device -> use-after-free.

Each patch moves the devm work-cancel registration to *after*
devm_power_supply_register() (and before the IRQ/poll that arms the work), so
teardown drains the work before the power_supply is freed. No functional change
otherwise. The relocated devm_[delayed_]work_autocancel() still runs its INIT
before the work's first queue site, so no queue-before-INIT window is added.

This is the same class as the recently-applied cimax2/extcon work-vs-devres
fixes. Found by static analysis / code review; none is reproduced on hardware
(each needs its charger/PMIC/gauge chip and is not QEMU-reproducible) -- treat
accordingly.


Hyunjung Ko (3):
  power: supply: ltc2941: drain poll work before the power supply is
    unregistered
  power: supply: axp20x_usb_power: drain vbus_detect work before
    unregistering the supply
  power: supply: mt6360_charger: drain chrdet_work before the power
    supply is freed

 drivers/power/supply/axp20x_usb_power.c      | 16 +++++++++++-----
 drivers/power/supply/ltc2941-battery-gauge.c | 10 +++++-----
 drivers/power/supply/mt6360_charger.c        | 13 ++++++++++---
 3 files changed, 26 insertions(+), 13 deletions(-)

-- 
2.43.0

