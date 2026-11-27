Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795806595;
	b=5JTXnDvA4VOteOFNjphA2Zg1Qs2q52xkFgd3Xa/vQvRHFF0zaI4PebIGg3YpajnOeuCV
	 wtUBSkSTOCdmU1y4ztpulvWSZ4tn8HjBopm7aAxgqLBK2/r4331VsPAKCMFt9K3ZM2K+z
	 7vunUrtQX8inFtsZycb3Q3hUy2laEbp8/D8xGBTCHfm5XC7bdJt/GxSYX3ZcP4ijHEldn
	 3GPhnuHgodSY3vum89LyH4G65dactfpS8WPzhGvpjEbpidfTwaohI+kYyicLMvVf2ZiGL
	 JQoSlNokazepZCT4cUjcg8mrVOuc0acm3+3Tb+TrijBUemVXxyYQKm1TTo/O3QulHOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795806595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
	b=1ZvMX/XH5IfHbhwthTDhWh9NugqNz1ayto7+MOBnTWRNHjZRfZNdeupgQ6cV0cUf1jIt
	 BQkSPXjjq85ovqdcOIMP1I1gA2vUp8ZqFqIuJFKD1V5vT3eyMngtOWqIj+CE+1ZTswoPg
	 lGpq/o6XIBPy6HpEBrUlYTSHPc02pRmFvwKy1HM14r5oLmFYgXKR8+ZB0ehYrEOgnmlMy
	 7Ori/JK5pEw7eroYNgJ42O/N4jJAQMaEmWA/7u9Z495t+QvsMLhclVs3dHZ+C9zpQetrS
	 WobT71AwM2J+BNkQsxcN22C38mBgAsBetf4BhYtgFnrAuTh6K6FeeF1GFxj8QraMyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="V+Y3/Wxv";
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E6D606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65E6D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=V+Y3/Wxv
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8a2518f7cso9914861a12.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795806594; x=1796411394; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
        b=V+Y3/Wxv3EQIonXFUaq/JKFEBf3WK2UbJPcbI2b0SojJ2IyT7ZRCcxvgc9C47fHL69
         jPMIwElCu+zJDWyWYtYBqGdAsKsbw6zu9uKZ4ErBd1Z2aMCfu7Ntl7qGJKmEZzhS5zU4
         ti/HB8wdq/cRr0V0RiONp35u2XoVNIniGbgdyKLmJdfDKU1J3ItwhWBldl9lleseKGuP
         ILWPDk2tHHcDw0cckNX/7WYRVfrgNA/YFvB2Rz2F4A2u4kHvj0pYW3cWSKvcMd5bTEMj
         QMbNUhOnC4vvcLsNJFHUmrxCpTCXeEyJu5bQe41325rgrnCUVlRLmafhrQVR/zXEhjpO
         gTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795806594; x=1796411394;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pPqjsPGv3eilo8FZQHSgEFw+4wPb6iLEdkbWG7h8j1k=;
        b=IUEdscbvV40oNA1n8Z5KthKSrcr/Cqw7P+Smua8J+MlLuvYBtmxrvK+dX4W2qjFqu+
         WsDEjD5QAp0geGZdYnacbqa+GY8w4iowimuxceyuQPu6Qi261ffob6u5qzbeywFaaVA6
         2CTFa7cD/BJ03FWKtukBqs43RvWyHFtXBbbNYVUHxJIsp1vxWtEEcaYyA8rli61JyKJi
         mQh/itLSC3nazSlqpCNRWa8Uqd/YDIrqx3hTj7sCmm85Q4YjTGTuDmeCw8w/ADGyzB+o
         xixMLBWHojMdgvh9NgjtxFYObmQIWusJkIRuEQwAzVNz+8yjT3VxPrbZqHE6lZgtJw5T
         64uQ==
X-Forwarded-Encrypted: i=1; AL+hErEeOfTPEOEa+INM7hDMESY7RruMJE5kb1hPyhP46GEXHn0t28JWm0WGuMcqwQsOigaGT/ScR2OY0w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OBf1LSdzMStSzmUQBPTkyjDLFzR4rDlqYXLKrgAPV8CLf56FV
	V8NS91yLBE8LJBV1LyIcbl+rZg6CA7JXD3Blu6BmQjcNn1SOQtK5T1qI2FhcSFuH7tE=
X-Gm-Gg: AZFdTZfOn9olya6JUElnwYVcslxSw95J7TjhM0Ku4teRIODMegLFcNzTygYQ+m1vCyM
	VSGwmLm0ZdjszN5q2K2GqyfGnl/ZMsO6hWkLClTOUw8tUhHIkNGgtCdggLQFTGLYVBX1YY661vQ
	7GISmdp/RiCfequ3t9RsDkLGFpUNcQ664l8TXvGN1CcRlUPDP5sh5tUAvCmFkUfXmCY2zU9vewG
	auKdQOknCWJ/b3qp7jun4h7BXbSysXx6VWDaQ+kYSiSIe0e/QkPE6OQtYCjh4VbpEwCi6RsiIrn
	OxMGgEBOfOOe+ZXp8MSga7xhicSEENpmFmP/eFfY9U6dA2aLkHlvbdP1NviweB9w5S+5CilPEKd
	Rf6BRT6oodEw8JqRNzsSTlSv83QIm/jUmFLd5w9sdw6Auc+m/fJR7M97cINLHhZVn6/AsgwmXfZ
	jXQpCfzSrPRtxp4wwZK9ttWm3Y4AQ+CLy7/qUe3v/cSg7I4/OwDBfJQvJdMjmXujuNt910Bu4S8
	aFOd/AF9lWfyP9GWQhUTKjMmN8cfmUoHExendhlgqN8O0ma91uu137ZjE4FYP91+RCImmNln13x
	ghMy1RedTKSHT50cZkb+CotmxLZBrR+XBQvNRy1R/QMkdRbdKhztIdXHFfPKxUfjqNVImuOFHKO
	drdFMR+BoCA5MjXq/Og==
X-Received: by 2002:a17:906:c10e:b0:c41:5e31:5184 with SMTP id a640c23a62f3a-c513a99abe6mr2111709066b.13.1795806593819;
        Fri, 27 Nov 2026 11:09:53 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afe85fdsm909175266b.69.2026.11.27.11.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:09:53 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/6] power: supply: max77759: UAF, charger ABI, input
 limit, and supplier fixes
Date: Fri, 27 Nov 2026 19:09:51 +0000
Message-Id: <20261127-max77759-charger-fixes-v1-0-b364a0862d72@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH/VCWsC/x3LSwqAMAwA0atI1gZspQa9irioGjULP6QgQvHuB
 pfDYzIkVuEEXZFB+ZYk52HhygKmLR4ro8zW4CvfOOcD7vEhotCisa6suMjDCaObxkD1HKpIYPO
 l/IO9/fC+HzyzkaNoAAAA
X-Change-ID: 20261125-max77759-charger-fixes-a1cb573d50a7
To: Amit Sunil Dhamne <amitsd@google.com>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org, stable+noautosel@kernel.org
X-Mailer: b4 0.14.3

Hi,

Patches 1-5 are self-contained fixes for stable backporting with no
external dependencies. Patch 6 fixes supplier tracking to follow the
DT power-supplies relation instead of matching any "tcpm-source*"
supply by name; it carries Cc: stable+noautosel@kernel.org because it
requires v7.3+ power_supply_desc.init, the v7.4+ in-tree DTS
power-supplies property, and the core fixes listed below.

Summary:
- Fix a use-after-free of chg->tcpm_psy when the TCPM supplier unbinds.
- Report and program constant charge voltage in microvolts instead of
  millivolts.
- Disable AUTOIBUS alongside CHGIN_ILIM instead of relying on firmware
  state.
- Notify userspace and downstream consumers when supplier updates change
  the charger mode or input current limit.
- Sync existing supplier state at the end of probe so events emitted
  before probe or charger module reload are not missed.
- Follow the DT power-supplies relation via .external_power_changed
  instead of matching "tcpm-source" via the global notifier.

Prerequisites:
- power: supply: core: give each supply's epc_sem its own lockdep class
  https://lore.kernel.org/r/20261125-power-supply-epc-lockdep-key-v1-1-c8a41b8a4470@gmail.com
  Required for patch 6, which calls
  power_supply_get_property_from_supplier() from
  .external_power_changed and would otherwise trigger a PROVE_LOCKING
  false-positive recursive-lock warning on the first supplier event.
- power: supply: core: fix use-after-free of supplier names
  https://lore.kernel.org/r/20261126-psy-core-supplier-fixes-v1-1-33de6aa53cd8@linaro.org
  Fixes a pre-existing power_supply core UAF on supplier unbind/reload
  whenever DT power-supplies is populated (since the base driver already
  passes psy_cfg.fwnode), which is hit during supplier reload testing
  and by patch 6's supplier lookups.

Tested on Pixel 6 (Oriole) with USB-C charging, tcpci_maxim and
max77759_charger unload/reload cycles, and lockdep enabled.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (6):
      power: supply: max77759: fix use-after-free of tcpm_psy
      power: supply: max77759: report charge voltage in uV
      power: supply: max77759: disable AUTOIBUS for CHGIN_ILIM
      power: supply: max77759: notify on mode or input limit change
      power: supply: max77759: sync supplier state at probe
      power: supply: max77759: follow the supplier from DT

 drivers/power/supply/max77759_charger.c | 244 +++++++++++++-------------------
 include/linux/mfd/max77759.h            |   1 +
 2 files changed, 100 insertions(+), 145 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-max77759-charger-fixes-a1cb573d50a7

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

