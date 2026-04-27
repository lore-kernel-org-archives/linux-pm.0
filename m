Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B80C2BCF46
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309904; cv=none; b=tkkoyXSbakpm6kE+zjZKr2mhlBnO2GsEeUOgwI2861AmhfiUism8TEUysz1lqXtSNMu+p+0mP5Jg89Tanbycddzqboxccba6ZwgmcR06Wv896mk3ggMWvT+ylb0nDeM0GstTwJFGkoyYbZzOwcyc/JBbcihsbE9isokxhqHXshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309904; c=relaxed/simple;
	bh=PSBsdqT+sBcPCV2VzBDoN0aTW8ELufQDnrojHfAS3LY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7PfvKaxp/gorrIWP2mi4dSxe+9ZmswUMcD2Usnjwq/e3mrvmfRQGEdnGKQJUfFWk7+RhaB33RPKkHwFyqEFtz6R7Y3cjhT0Z2EOY4Xu30NjME+JvD/4IRONdIzUpstOzbJ04CVlLsK5ih7xV1zA7iIDBPW+A0yyG2HM83bDeq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5YZNmIr; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5YZNmIr"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f053b7b90so5934045b6e.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309902; x=1777914702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWxnwwnK1m7QIiM+kHUhFi9CGYBGNw3PT7/C0xFv7DM=;
        b=D5YZNmIrKfS7YPF7uuwMVfsyddBqyFQxRD2t45plJ+wUlCZRBK85Lj2uO7paDZs4NG
         6s1is37fihNgV47FMkUWGgKyGZpUHo2H8msrCwGlztHkaMkt93CKuHIX440FNwp7++li
         YF/5Dgl4hAgRVyNBJqv/75ous+XqjIkKEgjbI1AdF7W6qZcy2gT5wBiyDkGkaISbtdXn
         MJTLfzWipmcEG+QpvRG2RNBrFvSTYaRHC6liVv09JSKHQl8EBqAnORiwaYJR0GTjEpSN
         NqqxZzrNdMbxIxGYDQB0UBf5nxIGFOs5bPYI8cnyaWc3vxiEtNFcG5Ou0cws2WwJQfNE
         unsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309902; x=1777914702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWxnwwnK1m7QIiM+kHUhFi9CGYBGNw3PT7/C0xFv7DM=;
        b=MQ79Qr8zHTjtUvlSC1D/NFBHI/aJ2VfySPVbl6zIB7HHO0gjBN/Yrks3gHUjxe0uZJ
         JpzwMVCUtx88BQHJFPXAnXljDlGVOmxaobQn6Zgb5Dgo+Y1Qri/RiVYw2iqsXLgV0MBe
         4pDF3VNCkjU0jrvyYSJC0hvgP4wHx47bY15nTL745PYIs1t6bdzuVJ9s13/q2iOVaxck
         irIIlbu6rM5+mv7CCjVg6/NSpXKT8hJ87PQJOwQ2PLH5GAjGSPBmpf9foP0ElL7U+AVP
         Z0/8c1DZVnjPim6qrsertIPq6bVVO4kdX+fLM1jW1cCUpTabSGtT0+mV+gKcxj2V+gq7
         5N0g==
X-Gm-Message-State: AOJu0Yz6KJduVQkh7cr5/fQ0WNRudB5TmPvP96woohxFOZzwiYWoSwIF
	MA72DQKylQEymhZOkF2mfstLin1PmwPzISwMJ46lj0HAREbRetK17dOG
X-Gm-Gg: AeBDiesMC6HCbitzoli1aF7bRO7kvZA+PCb5KN+c67OLQBF+WGUsPXwO4Aigg9RaC+p
	ou18+c4h+m0oaVEw28SEkNNwv79hZ5DEku3jdkvLGfR/73Jj5h3ds935rq/HdTVNKfGoiFGouB6
	cP3TwLsKjJnbe4eIBjjds7bwdov31TFBygoTzoyB3GzmidtWUyZUCe0CXY7ZrEbRoYNqTGC87PF
	/rRcXfG5NLN9jqN0AXzbJpirpEab5wfw/ZQHT4w7jqMnEvuKJ8G9F6E5I/P5Q620fxAhC+Hf/eu
	7wZU3a7Bj7YFkDIWZYyNeW/JhHx3wbhnOXfD6tnQv/Kp0JK0L/pwQhBymsccH+3Nbp027W4wJJ4
	EIx8zKCTnvfxQ3x3T8Rb2/DfdxKWtQj5h69IB7WoTqIpBro7BZ0aalYh+chkMya99aGk52o+G/r
	NY72KXRE6I338tNTzauOVFGYh8YMC4tig=
X-Received: by 2002:a05:6820:150b:b0:67e:160c:36c3 with SMTP id 006d021491bc7-69462ef3455mr23999976eaf.48.1777309902045;
        Mon, 27 Apr 2026 10:11:42 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:11:41 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	xsf@rock-chips.com,
	sre@kernel.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	jesszhan0024@gmail.com,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 0/6] Add Anbernic RG Vita-Pro
Date: Mon, 27 Apr 2026 12:09:08 -0500
Message-ID: <20260427170914.5062-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the Anbernic RG Vita-Pro, based on the Rockchip RK3576 SoC.

Chris Morgan (6):
  dt-bindings: power: supply: sgm41542: document sgm41542
  power: supply: sgm41542: Add SG Micro sgm41542 charger
  dt-bindings: display: panel: document Anbernic TD4310 panel
  drm/panel: anbernic-td4310: Add RG Vita Pro panel
  dt-bindings: arm: rockchip: Add Anbernic RG Vita-Pro
  arm64: dts: rockchip: Add Anbernic RG Vita-Pro

 .../devicetree/bindings/arm/rockchip.yaml     |    6 +
 .../display/panel/anbernic,td4310.yaml        |   63 +
 .../supply/sgmicro,sgm41542-charger.yaml      |   99 ++
 arch/arm64/boot/dts/rockchip/Makefile         |    3 +
 .../rockchip/rk3576-anbernic-rg-vita-pro.dts  | 1317 +++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                 |   10 +
 drivers/gpu/drm/panel/Makefile                |    1 +
 drivers/gpu/drm/panel/panel-anbernic-td4310.c |  291 ++++
 drivers/power/supply/Kconfig                  |    8 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/sgm41542_charger.c       | 1045 +++++++++++++
 11 files changed, 2844 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
 create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3576-anbernic-rg-vita-pro.dts
 create mode 100644 drivers/gpu/drm/panel/panel-anbernic-td4310.c
 create mode 100644 drivers/power/supply/sgm41542_charger.c

-- 
2.43.0

