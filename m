Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07F40A95A
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317478; cv=none; b=WD6njwtcMoQaE1TxuWG6LGPobcyZlYtn7dluQ5mV8rGRVM1hyXaSAWe9p/0AEa2zvibJJOB9AwL5y8uZfQLNKv8lxqaDRs4VyF4yA6Miut3udyhkDaK4X3IyalIwGV1XHKR9aZkSN5v3vhA3L3IYvz9JTF6+5kCNwiDA3snbVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317478; c=relaxed/simple;
	bh=15u40+pLhi5x+nQz+zpktr5A2OAGYH76zS0ua8GK5p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVjodFMC8qboqYsl4rgSK17BfeQ2e7K0V8Cowj4mSCzWEHian0AUItjOzGLv7bdk7lVZKyE2qNOETbePNFyuP+2kSOMB9zBjpgT/p8v+uJUuXrIKf0KzJHNnsgy9ihG0FV9ZxyDJO7RAnl44/g5oRpD89yEzhWXj8pKpAnI0kKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYVv7qnr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYVv7qnr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47de0093c42so577755f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785317475; x=1785922275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NGw4acqsR1sAad4BEmjY+ommPVLQEZy4kdT8lCYhgs4=;
        b=HYVv7qnrLbAWnaSwGHh5Z+EwIz1FgWscKEIyFtDqJZqGApn+a1c2s4Xhjs68trV8eQ
         K362ZO4jtlrDq6CG4tlctabrFVx6V6+ao2chbXbzVo9DU1kUsLETBQrD85344JYKK8bt
         E4rzD8VnnO1YhZNteQAxS/XVyWnQkKpI6l5LZwnYP6CkB4a5BPx5xmj2MYRrBpuxYCy+
         RspaNk53O4XZ/SRgBQPKYzKhCpYM5ec1uq01P4W9v8ADfWBql1iFjATQhOoB4ualTrrv
         ug0U3UrfqQjGtrkm7RWWThtY1/gEmvM1Rt0pCDDaowHG5OM+4zWxb8k+jFSYcqeJ217d
         GMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785317475; x=1785922275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NGw4acqsR1sAad4BEmjY+ommPVLQEZy4kdT8lCYhgs4=;
        b=bPW/8lYIB4a4Q5WNIAJ5pG1v+coqK9Gbn+qfqutrqQ9WLAHRMJCPJarWH7IQpMI5aK
         9K0kpAQMTMtvuV1kEQUkUHwrydUg2ezBekwXNE8ZoFJgM9e/etrtD4EL27T5ngNdKXCo
         p4Sh9FAhHM1D7jnaa7HphByOyPKcnn+z4tFAQUteLKcAf4vliZM4bNymeUUwu1MzF5Kj
         QEPtZWuG2HgXQZM8XzkDZYKxmybA2kWSXZ4K1DAcVKFxmwiDWqT/iOuBrD2mQCUyTSmC
         h03tKoOxBHoDFbDlmVQ6LrDAs+RwcpApiapsPjp3jtevBmI114DsRc79b/Awqz9sKzsJ
         H2lQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBR5hJLE7WUnuhnhQbAjCdS9tZWcyLuJOmay+QsWpCPsXLxZ2a2KwkrQiIYIU+ZB7Nf2kdnF9hdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRfUL0t8891kTr1b/eQM5GNkSG8ixJtTuC7lA9qL+3W8E2RpEb
	owpSCCoSaAn1vp6wxTE2reWfWD77AAoV5dMvfWfNwVi/EryhHZtlbE1v
X-Gm-Gg: AR+sD13cn7QcZjSrp3CgDEiN78fqT5ndLa0cl8mstoU8NFgPYym/nCOS/z4X5NfpWcI
	V4bmdHPrTphZ6o+NDRLSUsmEas/dAG2jLU0q/O+pwSWNH2FN4gXqVAP4f045l8ttDwF8X9xl9n1
	0uCXqVmuySw3GVRL8wg+gny1NgKtxtZEeFImTANoJNfi6yvRWNrena6YL6+6yufcuY8DZEux8yT
	FsaOB7GDIv/y2PRqRDAeczFOPM44fmvaAd/ro/M5LCZFwWj7qYNMevFpysLNniMJew7B/aFIoSv
	BIW8ROmte/UEa6lY2llRMfCZPyzdU/c0XoMOEd9VbAVIGoi4WNk60K/uPXCOR9VNLvuWwUu4HNv
	QpQp8oADAkrkdW849i/RlPGNrM7U916QJXI7VHvK9Wr1VdFKdR+uAruPnzd8v4QjIk/4dwHP/G2
	xAFLE+OLHKN8JvYlBnJYNs+9mpC2DtcZNCUTsWz9Ah+kR1H2q66VRVmcraqtHLjcO1Vopn9F+b7
	sBPBmpcQ7SeVTU=
X-Received: by 2002:a05:6000:2403:b0:47f:9661:6766 with SMTP id ffacd0b85a97d-47fb1ec4d77mr7367485f8f.61.1785317475006;
        Wed, 29 Jul 2026 02:31:15 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6aa3935sm6766388f8f.4.2026.07.29.02.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 02:31:14 -0700 (PDT)
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
Subject: [PATCH v2 0/3] soc: renesas: rz-sysc: Add RZ/G3L PWRRDY power sequencing support
Date: Wed, 29 Jul 2026 10:31:05 +0100
Message-ID: <20260729093112.98324-1-biju.das.jz@bp.renesas.com>
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

This series adds that support:

- Patch 1 adds a pwrrdy_pwrseq flag to struct rz_sysc_soc_id_init_data,
  sets it for RZ/G3L, and has the SYSC driver register a
  "pwrseq-pwrrdy" auxiliary device when the flag is set, so a
  dedicated driver can bind to it and handle the sequencing.

- Patch 2 adds that dedicated driver, pwrseq-renesas-pwrrdy, which
  binds to the auxiliary device exposed by patch 1 and exposes
  usb-pwrrdy, dsi-pwrrdy, and csi-pwrrdy pwrseq targets, toggling the
  appropriate bits in the SYS_PWRRDY_N register via the parent SYSC
  driver's regmap.

- Patch 3 selects POWER_SEQUENCING_RENESAS_PWRRDY from
  SYSC_R9A08G046 so the new driver is built whenever RZ/G3L SYSC
  support is enabled.
  
This series is based on proposal for power sequence driver [1]
for USB PWRRDY signal and DSI PWRRDY signal[2].

I will send USB/DSI/CSI driver patches based on this series soon.

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
 
 [1] https://lore.kernel.org/all/CAPDyKFpLnREr4C=wZ7o8Lb-CZbQa4Nr2VTuYdZHZ26Rcb1Masg@mail.gmail.com/ 
 [2] https://lore.kernel.org/all/20260704093433.273672-1-biju.das.jz@bp.renesas.com/T/#mb6f18d8fa9a194fc0a15db5f4938df420da7b6b5

Biju Das (3):
  soc: renesas: rz-sysc: Register auxiliary device for PWRRDY power
    sequencer
  power: sequencing: Add Renesas RZ/G3L Power Ready driver
  soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY for
    R9A08G046

 drivers/power/sequencing/Kconfig              |   8 +
 drivers/power/sequencing/Makefile             |   1 +
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 139 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  21 +++
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 7 files changed, 173 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

-- 
2.43.0

