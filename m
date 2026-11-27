Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807415;
	b=YRNCLXr0n55k1jDT4bvcI4vy4EndNeuOi80+ekYzBU/HQk8aOhuCVi9vF2ziLKVxT7l2
	 evcTicA49ga+LH8YFc78LYFeVQ9eRxu2UZGocMPXkRfWXNm2wRwzhGOYZm+Tu18KUbDZk
	 F+76xI0LTjhXMEZLpgxMrPX64FTlAi25DFQnvJE6WFJOz12vi0IYaDiI3d7bVI8IFUBLA
	 0w6KKvd63caU4Fkv3tND6y5agerm7UFmv5XzuLM0SmGcu2TJ6cZuvwrFgFPSi9wVKNIz8
	 nasSO+zLDflPsQ01LVvVnovQ4U5daUVD65X0jpRSi66LINGrgAwP2MQWbbrsxNfauYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YdE4huuvwKUfz6uZKmm4M7NAmc0tPYzip99VdkJjyKo=;
	b=arBlSUYHlm1435CzNuDyKt3heffTY1kBW98IVx2AzAVqRflNEReSp9RLnXVcxUSrCwNt
	 81W6sMew1NR+eF07RdDbsnGWU8jt2siCyBw+YA7R0UhuRGdMqBs3fdo4yaNe4nMLR8Piv
	 CSVUcuZ3ZVIyLgJdH6xTJE9qYunkUAG6PYZdI94I7K+kNxkOyR7GhciOuYHbjY/iDC92U
	 EdSq3OXflNJOp8GN9VO3GA6eGZFIdOdT55GEQajdG5hPoIVe1v2NxhDLLr3wplKanjiUc
	 sUhiEQQ6L4/bFrQ8+X4vliIiTuleGvuotjqgXFbvGSuq+5uqTt1thmjB/NCoE63SLuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7l61vSI;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9E606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 19:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B7l61vSI
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6b8e2d8df4fso4894661eaf.1
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795807414; x=1796412214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YdE4huuvwKUfz6uZKmm4M7NAmc0tPYzip99VdkJjyKo=;
        b=B7l61vSIhdkOyAt3LUmrrzOhiZd1ahrzKQKN7sK4HQ9v4caE1EJkDi4v/eHzCS+4+1
         BSq2wbPDO6qWQqxOxSoZ7ldKfGivXziy2aAdrj6VhTl1D4mjvZcQdRY+lxGIQ3AnuuDN
         fbHIIadFA7GiMm5sBIENBAsC7EzAb9/zWXRtly9GomZKtMcntUuiP5TngKIXNShFmOFK
         QloMb+EBKwOfCHjmtc/j8KtmrNTNJWMjUUgSORUp1SxtMW+zCl0LM39DeerkcX4AmEqa
         N4JADi4m9QjXp94HkH8H33VhJmVD5HIZ6i0ZPFeGxkW5sWCqCVhBLUaBaJsauJ2XsLcd
         LG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795807414; x=1796412214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdE4huuvwKUfz6uZKmm4M7NAmc0tPYzip99VdkJjyKo=;
        b=ZlgyUOcaiOkHnRZBH1BY6/jWtyOCfa2WUk9K4rmoxmsLCRZIw8hqzxBIvcmRnMepOx
         Tz0IEij6hxh5K6GXXvzCZ6HnNil1OZI2fHGoatjs12pdv4FkHAHLzZgrOlw4vp1cC/tg
         tLIpuziLXxXtJ2S0C8wP9Br+ypBZh8ZUj3FOdzoYx6g0rsfF7FaWcSqfMzf7uwRFqK8H
         fbf2l4NfE428lyDES7Qm/uffzakzHgoEeg3cWExzdSxzV6vSTUMStE/BYl6XnuHQ0xNA
         Dc/44HwZA+A5HS1GjX6p7a8U2NOyyuldL8coenrySwDx51oorsICghojfbp4UK2fXu50
         N06g==
X-Forwarded-Encrypted: i=1; AL+hErGSRR0Brd6v5OAv9HrZXPfevcbmFQSpDLmKURTmnatwNurs8xo35GRytPnyKua8KDF6pOmN7raiQA==@vger.kernel.org
X-Gm-Message-State: APuU4Z99V0I6hANPfOS0aWNfTo0V6RsikS7r3L7e/ZYueyqPzt79NvFc
	lZeDvnqtu+VfxM0G37chiksz1dbiaMnc0kOe6oWDug/iLgQVANa5a98S
X-Gm-Gg: AZFdTZftBhQcK7oMWAYzb9JvG+0X7Vxu82ovcajdDpd5QyNECTy9KXzMma0l/W+sDzI
	nMxtXMThQncGojslnFzxGtf4Lgd25mx3L8A4JemVPnRu7+dXgwvUhhrSqk9xW+WVSAEYxK59n2Z
	j8LHjhOxGQuTQjPGwHQw5S2dyuNpaPEjW+gAYn/2jLridM2TtfV23qqNYLW8oMYLne+U1Q7KuyB
	T6XMp39iSuPPsqZ69eXWUOjerWLwW6KjnM2Sn/c4Udh/krZcFhxMvOObPudnne0MSt0AKLYtto8
	6dD/eJZKAVM8RsFfpLwSSiyWXlhtXNUnkNoeGig3cItR8psfQZMmClpSl1+ylhEJ+XdUgBZ/clZ
	YQ1Inkddd0VfMdfQIebW5lk0m80pjJffGDbmwRH6jG1tXwU2QFbw1snFhfMH1sNZQrblYrVr2k0
	bV8VgRP7bvgsaNDth8wMWtftUzPZKS5BPvyGsGSG4pEERairPeCvdwJG0uEJ2IHccxFo4MiSV4E
	3AseJPCkdJKNhoj334zhVmSeh84WHlxNjuZAqkx3YVax9uoMExd0b4TMpvMi+84Zv+5LL0CLqxL
	Kjdeln+1piIb/aDo8QDIu53p6xJ4zQ==
X-Received: by 2002:a05:6820:3510:20b0:71a:efbe:ef21 with SMTP id 006d021491bc7-71b3920c4e2mr14032041eaf.5.1795807413607;
        Fri, 27 Nov 2026 11:23:33 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60891cf6sm24044850fac.13.2026.11.27.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 11:23:32 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V5 0/3] Add Cellwise CW2217
Date: Fri, 27 Nov 2026 13:23:27 -0600
Message-ID: <20261127192330.610452-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: Chris Morgan <macromorgan@hotmail.com>

Add the Cellwise CW2217 battery gauge driver. This driver is based on
the sources used for Rockchip's Board Support package [1] but has
been updated to use the regmap API and devm helpers.

[1] https://github.com/rockchip-linux/kernel/blob/develop-6.12/drivers/power/supply/cw221x_battery.c

Changes Since V4:
 - Updated bindings to set 64 as the minItems and 80 as the maxItems
   for all battery profiles. 64 remains the min and max for the cw2015
   series and 80 remains the min and max for the others.
 - Renived the status okay line from the vita-pro device tree for the
   battery monitor since it is implied.

Changes Since V3:
 - Two more small fixes requested by Sashiko, one trivial fix for the
   to not always write CW2217_CONFIG_RESTART for the cw2217_active
   method and a small fix for the regmap writeable/volatile ranges.

Changes Since V2:
 - Fixed more bugs pointed out by Sashiko.
 - Corrected an integer overflow condition when measuring current.
 - Corrected logic for when we don't have a user specified battery
   profile.
 - Added power supply changed logic in the worker.
 - Updated the Kconfig text to note support for the cw2215 and cw2218.
 - Added a check to ensure polling interval cannot be below 250ms.

Changes Since V1:
 - Added a default value for the shunt resistor in the binding
   documentation, and updated the commit description to note that the
   min and max for the battery profile is now per-compatible string.
 - Fixed bugs pointed out by Sashiko bot, and corrected units for
   temp and shunt resistor values.
 - Corrected include pointed out by kernel test robot.
 - Noted in the commit message the patch is based on original work by
   Xu Shengfei at Rockchip. I did not list him as co-developed or
   signed-off since I did not have his permission (yet) to do so,
   but I have his authorship included in the file itself.

Chris Morgan (3):
  dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
  power: supply: cw2217: Add support for Cellwise cw2217
  arm64: dts: rockchip: Add Battery Gauge to Anbernic Vita-Pro

 .../bindings/power/supply/cw2015_battery.yaml |  41 +-
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  |  20 +-
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/cw2217_battery.c         | 878 ++++++++++++++++++
 5 files changed, 945 insertions(+), 6 deletions(-)
 create mode 100644 drivers/power/supply/cw2217_battery.c

-- 
2.53.0

