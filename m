Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DC41D620
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 12:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747270; cv=none; b=prMBPCP/hDyNbqlwt3mxL1NoEOH/87DSV34Q9qtrESt08PCa69bJP5AnNDQyX/LOU4ZdNC7mTsVxJINRkvOWYzp5ESYBGJdahffQdTswKoayi6REBQsWK0fF3WKR94soomaf2ZClMDe9xwBAVY9EwcXpja2PGfkjYxNks9i8yYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747270; c=relaxed/simple;
	bh=s65/6m1oKwWVwInxAMcvkJbLYVYyxw0TEs8p76QxN2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klzPEzJA4Pxj0D+sQEcl2mE0QwGJgk9AI0akQ03TD+9tzdmPpRm/c3zWI5xS66wwCK7hwzcsLq0eor3kXGn0PUDCO+7VJqN1xnlK1vevA2GTbydHJgD8qV09STVHF9WJwOnvb1znc1nXz1TmDoDd08TqNdqxIe1U/oaTD7OG6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOqLGPFL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOqLGPFL"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1c26d7e951so128139566b.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 05:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747267; x=1788352067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=me4ajx6kcF2CuOjAxk2YKWSptzCAhb6qkQPk4Sl9OEM=;
        b=eOqLGPFLaayaSqXZgkpDODtCSE4OwGrAy9jRJ5rq+T0WWwr2oB00QWms6Is4yZBxcX
         3JjZLgmdBFJj7hue2SM+kklUT0/JR8XSHqz4+0qQehZopvzQFJRg7B2eeM8aAGjAvybp
         USxfv3EEuFWFv+AKPgPwXMofRbhpVvT4rdXXBP76Q71DVDnWz2QIkHPjjDbH4IOswJve
         tgT0uxQGE7UO70igYbVREKZ83GLXh+eeR19ITGzN5Iic5FsJ3E18LCRr9JItZkwYNwIJ
         9i2aX9urcbDqcd5GtnmiJ278gGRkPAvR63nn8jWoS/o/WMBguoktlqM3YsZK8qiniol1
         WiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747267; x=1788352067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=me4ajx6kcF2CuOjAxk2YKWSptzCAhb6qkQPk4Sl9OEM=;
        b=Wj0Uuy6wBPG0hRvf2F03/fmOKCUN3ABgowcQxSP+k1BHgKrBB3D2avdBSZANUBmwvH
         Mk79l9khcc1cUcTdg6Q3N/LyDE2NH2D1c0G3BwBICbTe4C5k3+GvVxUlTz5ta3vlJfZw
         Lv3UgHgWw8jsYBc5aubv/76PGtN9DeuvFY4RtEo9oPtd+IFggOuMV4hSMIrBnqn5AUBp
         bBI5e6LH9XYs7HiCXvek972cVzFPYAWWBKkrFCFJrAUriE09CexEVyAhLD6wYk40imBw
         fbj6i93SeTdTFunIt/CPOR10TU76dCVP8O7EGp+DuVT0UjmvoItaw2dUIEukTqjfT1o1
         Fikw==
X-Forwarded-Encrypted: i=1; AHgh+RqJb2OKRgL5Sj6ufKFvbhpZN9L6AQhlDqOfSks2TuJ/JMSuuAwp/NZLfwgUKZKsZKUNudOuymJ2hg==@vger.kernel.org
X-Gm-Message-State: AFuF++kHpCvd5segRCigb4O4gtevfzA2fIJxXQZxsDVdPFi1pOhmqjsq
	OIkQk1v+uxG/zdwkYDef6HnFy8OqoEMYFh5vUcsamqQYLf9XjEwu0qON
X-Gm-Gg: AR+sD13MimEpi+IphIXpIAX4IgU8511+x/pQIm9SB5WLDdnIkWNjPIZQWgdJNmNAATS
	3oDf5kC0rglhVtieiFu6Wz674f7KuiU75Y3n3ZJnS9Dh1LckjiA1f4FH2aopIKV+2oCfKET+Btc
	5+/u0IdEJwS8NYQiuMposta855s7Ht6RVWEZkuBzwmK6QbGRlxc2pl43vNcWxKblMHBBJcYep0e
	rCoM1VkfkvsQ5jqO89egb39cOOVmjRsPeLxx/5vtjGk/SMfD+VvBcLE1RZwkX2uDpvc0SI98qID
	NF7q50N5iUmvo6AThds9QC8fD94O1LU89RmLQCC9n8Ntyx2NHbCyjDbU37Y4HQA/RkRctyMfkND
	9LSp33ND0NLqjONu1sUYd3yiR+4oOnr/zWWnY5rkHqbvlTaim6Ty72YolGtdo93Iu1y5vRKvZHx
	rnnoU82CH/B57hHutlipVVb5r+npkPZ2vPlMNyA6f/5QDpnO3+NF4o0ILFVOd9xwGTUIV11NS5h
	7GtR0l3vIvw8A==
X-Received: by 2002:a17:907:930d:b0:c20:ff26:336e with SMTP id a640c23a62f3a-c250c31267fmr762928666b.14.1787747266416;
        Wed, 26 Aug 2026 05:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b4e9csm504890266b.54.2026.08.26.05.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:27:45 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v5 0/4] Add RZ/G3L PWRRDY power sequencing support
Date: Wed, 26 Aug 2026 13:27:22 +0100
Message-ID: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

Some RZ SoCs (e.g. RZ/G3L) have a PWRRDY register that signals power
readiness for various IPs (USB, DSI, CSI, etc.) to their respective
controllers. This register is part of the SYSC IP. Add a dedicated
power sequencing driver to handle these signals.

This series is based on proposal for power sequence driver [1]
for USB PWRRDY signal and DSI PWRRDY signal[2].

v4->v5:
 * Replaced of_device_is_compatible()->of_device_compatible_match() in
   pwrseq_rzg3l_pwrrdy_match().
v3->v4:
 * Dropped rz_sysc_pwrrdy_pwrseq_init()
 * Collected tags.
 * Fix build issue with COMPILE_TEST for POWER_SEQUENCING_TH1520_GPU
 * Replace the large of_device_id structures by C strings, and
   using of_device_is_compatible() will reduce kernel size.
 * Replaced of_device.h -> of.h
 * Dropped local variable pwrseq from pwrseq_rzg3l_pwrrdy_probe().
v2->v3:
 * Updated commit description by dropping devm_add_action_or_reset().
 * Config now selects AUXILIARY_BUS to avoid compilation issues.
 * Dropped the cast in devm_auxiliary_device_create().
 * SYSC_RZ and POWER_SEQUENCING_RENESAS_PWRRDY config selects
   AUXILIARY_BUS to avoid compilation issues.
 * Added match for consumer device and added of_device.h header file.
 * Replaced regmap_update_bits()->regmap_assign_bits() and updated
   the function parameter of pwrseq_rzg3l_set_pwrrdy().
 * Simpilfied probe() return with PTR_ERR_OR_ZERO macro.
 * SYSC_R9A08G046 config selects POWER_SEQUENCING as 
   POWER_SEQUENCING_RENESAS_PWRRDY is defined inside an if
   POWER_SEQUENCING block in drivers/power/sequencing/Kconfig.
v1->v2:
 * Switched to devm_auxiliary_device_create().
 * Added regmap parameter to rz_sysc_pwrrdy_pwrseq_init(),so that regmap
   can be passed as platform data.
 * Added a comment in pwrseq_rzg3l_pwrrdy_match().
 * Dropped dev_get_regmap() from probe as regmap is now part of platform
   data.
 * Added a blank line before devm_pwrseq_device_register() in probe.
 * Dropped the error message devm_pwrseq_device_register() as probe prints
   failure message.
 * Dropped local variables dev and regmap from probe().
 
 [1] https://lore.kernel.org/all/c7fc31f1247332196516394a22f6feef9733a0b4.camel@pengutronix.de/#t
 [2] https://lore.kernel.org/all/20260704093433.273672-1-biju.das.jz@bp.renesas.com/T/#mb6f18d8fa9a194fc0a15db5f4938df420da7b6b5


Biju Das (4):
  soc: renesas: rz-sysc: Register auxiliary device for PWRRDY power
    sequencer
  power: sequencing: Fix build issue with COMPILE_TEST
  power: sequencing: Add Renesas RZ/G3L Power Ready driver
  soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY for
    R9A08G046

 drivers/power/sequencing/Kconfig              |  12 +-
 drivers/power/sequencing/Makefile             |   1 +
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 142 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   3 +
 drivers/soc/renesas/r9a08g046-sysc.c          |   1 +
 drivers/soc/renesas/rz-sysc.c                 |   5 +
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 7 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

-- 
2.43.0

