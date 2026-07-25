Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8141F2B88
	for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784982879; cv=none; b=SfpSROFn+owdu5I8UNAmo0xpRDyvTDyY1yXR6l0+kIDqLLnHSRdFPCEJC0a6FqDavL3gD/yr2dQtGQ3jVTH6k+cqnL84b6vX26S5Hu1w1ihXvV5KqPuvirUcvN8b1Crw/0u2nLSjolaqoDW0uujqG/3hAr8q8QlX53CdtSGPcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784982879; c=relaxed/simple;
	bh=yIpki0hQpowpOhTXpYq5RL//PKIQdGZb7mZ4CBOQZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KK81HCiSltlraytROqH0LABmmKR+v+po9kP2Q+aqfMu6IfpjnHinHLbB73ZELTwtE5uefbkRK24vDjhX50GtnWaoYRFQWYnfRI4QrpCBLlVWLXXmQlpikYslNOE8adAmgEyuM2kRS8NZs3u3HgzJkmWILBEcPHbhAHIIJb729Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYtVJAWt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYtVJAWt"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495590ba856so11499325e9.2
        for <linux-pm@vger.kernel.org>; Sat, 25 Jul 2026 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784982876; x=1785587676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9yh7k6NAJzwLtBw+kNy6gQ7yMKMbL+s8UKzMqMWiOlQ=;
        b=rYtVJAWtBeFZYXOybzbs+f3C0jFRsnxZy6HRNGy8+rVLQv6aRAl7mggZIu6RHhxKCx
         a0cDAA4A/GIOC4UOFFqs1TGTBIb8rqjyWl6MR3F9uiMDnghTtP+VgofR4IdZ7fXLuym7
         +51yYCnAUDWrJ+Ccx6vcWnMods2qjvI0eXQjkeGW1FAX7l2SwITgfpml6w+sPV8Q25bQ
         i7TjOWDPskCmCSpHDgBN90BHRIdLBDPp6Xw5K4EJNPfAFs9Nln2NuaGPHcIJZ2MtbN3K
         9KFczspzzDxbmUPBv4B2nQ/EXgBzzVg2dJ2wn+B8W8SF4WeVCSJFtEYvv328x0cJWrq4
         +/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784982876; x=1785587676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9yh7k6NAJzwLtBw+kNy6gQ7yMKMbL+s8UKzMqMWiOlQ=;
        b=EsGS+b/wO84dDycsz5NEAF48T4/mVQCqjvrH7cX6Mr0WKhFIcUJfUF3y+1E7o/iEGy
         qp3eqLYMRZ4/r/T6RTrrzaaFkKl1PdLS9VcJ600eYCgFDbzEaDr5gpybh09QOAMofIJu
         aUWswBXdIBHgAGN2AYnzmPOYXe9DTcmyXVFDlA0jKwWTL5q3cYs0Mu931crwMYb8bYBw
         CikRiun0NKPOaTXjXJqOv92DqrupbHUEx/Qtgko2JA47KqJJsXPvbJZouq8xsGd9mAmG
         7P9msTxtR3oWXaN/KCigYnEWCda02gxDxmAiiqqz3zCVEoMALJoLa73L9Z7lovdt6i4s
         Oiow==
X-Forwarded-Encrypted: i=1; AHgh+RpXEKW4A3Tzpsw+ibaOvFiKTUsEA3A8ce/IBb8Fn5E0oCE/MSDL4MmyDZ8JXsZnUktcJe5yg875aw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/VFYRkDGvvBNrRt8sfXHDJvySAh+C5N0ZO3N3XrhhPJXh9/Xv
	fVnRrVAtN2O6jpeBsLUhInYOzv+W1s04lgtanQOOgQfCoWd9KjhKfIHG
X-Gm-Gg: AR+sD12+PzsnR+ZtEg4RBZt7yQh26PHvAj88fz+SU92ufexpbUKD2NPheaKgk7gL/7A
	YlgfmaRN45BwHR0UvOXJ+z2ESJC3L6lobP5wIhhLv22NJQQLVa2Ji8pySunLpV5vtWqTEHn+DrE
	8A3W6nd8V6NN/Zwk8ltqpOM/8XU8Xci0k0qtP5hKoTpCHJTIL9aRryAQ2P6NuDCgzYKPwP7xs9B
	zDY3AIeuAoJxomiKpn/0qlxWBhVzzJON0yK0Y9g31FQ+XDoY3SIzuHPcAkNstfif8oJje8U8Zyd
	l0kT/l2drKDsWDvBR7g0Nk8DMSk4CclcOAUlG3hQvoMwktj+PfzUucn81bHy8kXVxDnMsd4KLYB
	TSimzmO+S6kaxJtDmXu2OvegBxgM2uLVndgrr9RCq5bHeKsPEGff4vgcRHwhmUyBoobgzwa4tf5
	OC2bSaH3lmKFovqHTnrQm6lyFPoGU=
X-Received: by 2002:a05:600c:4683:b0:495:6274:56c2 with SMTP id 5b1f17b1804b1-496b56bbc9dmr26029325e9.2.1784982875693;
        Sat, 25 Jul 2026 05:34:35 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:222f:1bcc:b186:8220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4858e86sm44563295e9.1.2026.07.25.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 05:34:35 -0700 (PDT)
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
Subject: [PATCH 0/3] soc: renesas: rz-sysc: Add RZ/G3L PWRRDY power sequencing support
Date: Sat, 25 Jul 2026 13:34:27 +0100
Message-ID: <20260725123433.162348-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi all,

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
 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 141 ++++++++++++++++++
 drivers/soc/renesas/Kconfig                   |   1 +
 drivers/soc/renesas/r9a08g046-sysc.c          |   1 +
 drivers/soc/renesas/rz-sysc.c                 |  40 +++++
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 7 files changed, 194 insertions(+)
 create mode 100644 drivers/power/sequencing/pwrseq-renesas-pwrrdy.c

-- 
2.43.0

