Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6593B1EFC
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793314; cv=none; b=QA/cJt/jTTugaQF+rcIhRXb2D6FK5DG8uia10yzNKd2xxwrNVLVGgF4v3/uBTk4Ia0NS7AwHGdM0YOjllvgTIoujDLjWlocySfuz0xmitLkECe06n4Jh5RizS29FOo2X4UMhzC0Vryvt5D9XionFyEhHfjitfLls0a1FyXkVAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793314; c=relaxed/simple;
	bh=UagIroYZ2fnu5uOACAlpNWwcWB4DroN03cZGyHaNMug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tqo4yZ7oMvx71qohPERHpwpa2L+oFacHL//nRL3FGKseIskWe++KANS+uSvFxVDJZygD2z1WCppIQAy3IR/G5MRyPFrU+8owGgryj2vc9A71dFJrMPTAKjqg4IDcdKt9amcMymmHWoejQWzbvfDs82/FlhRKWFBCwchUYKa94ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=cOMEC/sP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="cOMEC/sP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so43849655e9.1
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788793311; x=1789398111; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=q7+VM972kenKxQ1sFqEvVvP8RDWSVSkInhi5+r6P5fE=;
        b=cOMEC/sPdYCRQIgP1P/rZTgDENOFTqeRk3m+MRdEDRNfsn2YELSujECIS2OPhaqjrh
         OTjZ500YXuYEgp2OuXQ2lbh9a6BUz33nFkRmRIGylKrOPk7GhogKtRe3FsdJ76YRfZ30
         WvTSwaknL2XPG6OHinv9RiiZ88ruvAAiGno+zJ95XtDKQE/tkghcwZ4MgbUqyLAbqG+k
         30MCpkaY5/PqiJf8JB64MTcSJxGsXA9HJST7mJRTxTofecBLC5E24fY32fWLNKDYUTiv
         VTvH5o6pOJy8PWOMm94/3ILtNkB2SP/DZzysEghvAw1huZKuxI/chWH2FIlfLDhy6BzN
         4S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793311; x=1789398111;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q7+VM972kenKxQ1sFqEvVvP8RDWSVSkInhi5+r6P5fE=;
        b=rg8fZv6iVTpIjaB/J4V9rHQU3Eu6UrdtasF9/JhL+zpEMeoeMluX/2l+XhvGnXeIn5
         0VkwxEi5JlxPNxfSFQ2lPk3dwW2s9Z20dDEn1ss2p68+DBykSxa5No5MB6n6TY7t6OpV
         o4u5su759OvSZYsqC0RCuPFdK/CeruicRPQJkORmuYwsxmehGKJEtVJqTPiHMuH6TTGR
         8/Vl6ol/5iZdVEF/UGPQLGKrVlgPK4sc9ap6J5AEGL90/UYHpUM8G6LWfo3e11Q39Cd1
         fhkidQluO+goAOZpgOmBtxy1fOCuIMIo1csJoTQa6AayYYPK3HBBIKQBw7o3I9unWNdy
         3rwg==
X-Forwarded-Encrypted: i=1; AKwUvBycFkgbIMLRMCfj47PJbXe6YTVMH4XDxTCvj7l0sj2oX0koUvpV6hAhkP3mQBmu/RBtW9iBegV3QQ==@vger.kernel.org
X-Gm-Message-State: AFuF++laUWFNq6uBYkO7WIKwYmN9Kydx08ZBIBZWORtgypjFhKr/bpmf
	1guiAk+nrYbOR/Tqk+MysiQDNqMHMsQWzOYJvBQAkzgrvuwZw2LmQxS52aNKYhHbE1E=
X-Gm-Gg: AYBFou1PuH4XY1+kOvJxnURCez1yvA0T/tCofDMtpi2l7vmHGmucuyBKAFZYg9C2cKW
	m2jLV4Yx2RNrIUnQJZPxZzh8o9X9CUo2dahZ6S7YjBhBdXY4QVCufVhetAglFFoUV3M0qBNjtY7
	RVqVGEVBjkEcCc2RAepPo8JzucbhEc7Y1xT2akLyC1CiqcPxETKgkXpwQWu7VIMxXWV2hTRu3NT
	xBW5+ICdwz9BrJ0TVd8ij8lu/NjrJlHCWvun7GrqMf2wXSCrMc3UjMjm+P+dD0D1MfVni5eWidD
	hPjgeSIrj7O7AmL7a7drmhU48oHLrNspofCypA8loptWCaZJWHRgo350Nd2FI7J9kKvE93M6y6I
	i0NkFZZUQdGSjzH9vzVLpfX1cr8eIOFhl5hMnWz3DyE4dZ9+l7MCEVd7E4Q0eULxZ6cwg+ssjSs
	psU63YjxSUSaphuKHkpIQ7TAit3y3JSo7POatMjR70hWMUa0aduUDALBvKL64PUGay0P5GxEnEu
	AWPWbGe557t0S9O9Gff4alQxi2oPi6BfpURlyYk
X-Received: by 2002:a05:600c:548c:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cf8267dd3mr244520955e9.12.1788793311081;
        Mon, 07 Sep 2026 08:01:51 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-2-51-220-108.alshamil.net.ae. [2.51.220.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm262992705e9.14.2026.09.07.08.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:01:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH 0/5] power: supply: Fix probe time race against driver
 teardown and battery parsing
Date: Mon, 07 Sep 2026 19:01:40 +0400
Message-Id: <20260907-bq257xx-init-v1-0-1a08b29e1a68@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSwNz3aRCI1PzigrdzLzMEt20NAPjpNQkA/NkYzMloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAhGDgz3AAAAA=
X-Change-ID: 20260907-bq257xx-init-ff03beb07c36
To: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>, 
 Chris Morgan <macromorgan@hotmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1846; i=alchark@flipper.net;
 h=from:subject:message-id; bh=UagIroYZ2fnu5uOACAlpNWwcWB4DroN03cZGyHaNMug=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWTNu3jn5W3RBVEi/2PNE27PtjyQniV9wUByBpvba/3wW
 7ceJHY875jIwiDGxWAppsgy99sS26lGfLN2eXh8hZnDygQyRFqkgQEIWBj4chPzSo10jPRMtQ31
 DI10jHWMGLg4BWCql2oz/A+VTdvlnPK38dd8rpf2Kvn1Ccd5fvS8vXuuw3NuQfmP37cYGfYq7dg
 6YWulw8ssycXpjySjH0VPrNNxqH1z3mfyK2NBBS4A
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

If a bus holding the battery-equipped power supply goes down right after
it registered, it leads to massive fireworks as the driver starts to tear
down its resources while callers from other contexts are already eager to
process events using this driver's callbacks (and their private data).

In current power supply core it's further aggravated by the fact that the
battery parsing code expects a psy struct from the caller, which is only
available once the device has been registered, so the device gets
registered with its hardware constraints (e.g. charging current) not yet
fully filled in.

Fix the former by preventing the unregistration of the psy device before
its callbacks complete, and the latter by providing a battery parsing
helper which doesn't require a psy struct from the caller (as it doesn't
strictly need one).

While here, fix up these and other adjacent issues in bq257xx where all of
it was discovered.

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Alexey Charkov (5):
      power: supply: core: prevent unregistering a power supply while a callback runs
      power: supply: core: Allow getting battery info before psy is registered
      power: supply: bq257xx: Don't ignore errors from bq257xx_get_state()
      power: supply: bq257xx: Use psy directly instead of driver data
      power: supply: bq257xx: Parse battery info before registering power supply

 drivers/power/supply/bq257xx_charger.c   |  56 ++++++++------
 drivers/power/supply/power_supply_core.c | 128 +++++++++++++++++++++++--------
 include/linux/power_supply.h             |  13 ++++
 3 files changed, 143 insertions(+), 54 deletions(-)
---
base-commit: af5f12805e5cefa4fe68d6127c7e1fb78cd5535c
change-id: 20260907-bq257xx-init-ff03beb07c36

Best regards,
--  
Alexey Charkov <alchark@flipper.net>

