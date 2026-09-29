Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A195221CB
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684673; cv=none; b=V00YhxlMHvo7p36DPZBU0S+ItNWEIlCJEcvcADgjEfytC7jh95UEtVqJV/PghfZvtZX4E0qRxQ9k7DhdHNEI0RNqXORn9h9DIiYmkaAro67M5HaO06wjVykGrWsqaD73r2WVVIY84agwHGh0WvvBXYS9/HQeUUwf/8vtdBIsMwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684673; c=relaxed/simple;
	bh=CPEi90r2204QF8UFqqmcvO4LpsvgMZ4QxnHpaWfz53M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox200LuhwzZ/iBgQYMsW/Ut9lslJNIk9KhuhtZCVkaMJcle4f4VnnuTlcCQI8bLAc7IsVEb2kzqXBQA0xRk33ZfieYs776E/EduKQ4FOADuNm8YbKQyqWdrZU2G9YO7bhGktkyayyNReL3KYUSzUY2GD3ow8tMODA5mm+FtBtmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+I6aKj/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+I6aKj/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so25558405e9.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684662; x=1791289462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=boEWQcjTdM8NwmxpZiqZk6dpdmmjLo9Kr/Z9eFTkwPQ=;
        b=H+I6aKj/29h2MiSmHjYgjzTrCmW/x6GQaliYZ/UPHR/Bxrftljh8bYWng0wGWtXco+
         djNFiQ0xWXs+IIr6QPvoBCevf6GGlYpm3ZtNZNiLvntAFKIVFiUg/fKqDCQQCgIrmR7t
         BDME8DdB6yXTwTK0Kwo0y7vDmniR4nH2khPdBWnY4xF+ar/jbyxg1fiXWi5L/ZrbLBPn
         lDpYo72UtG0Bm13SyhPpOx4mSM063pojADCpxa1Zl7i5MBtqMqOc7LTM0LYRIW+vD+de
         aSoY4JdXmTVuFstQYIujl7frmxLaNjLCDZu6+yR9fm37BL0nU9nqK1G7ErfJ2YV4mbVw
         prfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684662; x=1791289462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=boEWQcjTdM8NwmxpZiqZk6dpdmmjLo9Kr/Z9eFTkwPQ=;
        b=x8MMHw5ER6hutm9u9a4oc4j4h/gggQzunjnWISfG5TC0syOalA6LdoKFXfSNKPeuYT
         lTZkrWYqE62exfXx0z2DlfuoOeWf8QFOFIT6AiNx0QIb0ytJobfKuIvOVotojy7PWNfN
         9OXqvLzjjHMVYLyvf8Zz4rfCZvO34EEuhw1VPfr8+GySpE09+TofGRotIKs9enDQqTf7
         Ogxa5LM+8HoYXFzwipqAYer/KbMXee6DBjryxxvq4DsksKRFZ+Zz8Tj5KZWwGSIYMGED
         eFcuHERSeW4oJ2x9io2S0XbE1NZlmKVCxZTqXXqsiOomuwXpSerNvus6GZeI+I4C5K9Y
         sg7g==
X-Gm-Message-State: AFuF++m5J6BWx15TH+K9c1LupDHT4rzMj+I8DOeyGFeWsrix+v3ovke4
	xj8eFAhTJJjpJUCB1JW6smyR0YhosHqn+4dw5+Q9ZQ1Durg59Nm0DK/c
X-Gm-Gg: AYBFou1qPAA/b2jmXNASbHFKutUyYeSETruDW8nggzcm8fdMrYRpiwDaft940LJJqqL
	bhzz3ZDEEMTg2A6g+4QMrFyjTnVnoCxTnaWfjR/I5y8qKUzJ+bx0Jo5/8/Kr9O9jlNQVeKwFjtX
	Y6zEh5NxbI8QfeMRX3WH07pfOIch2fmtxPVF05pXw+vMq+QdKELh1SPkObcgR7++rKlrkC7YAlx
	4rsxAKqil1RSMXwgfGy0cL0JioLMJWCe35X+uSzEqlE791JEJmHPa3Yw3WBw0+e5FqvAXvOCCei
	0nunAvjQ8atEsh7jrFojZ0fv2VD8iegPn/5bNmVLww3D3v/WnwsskikDTvMk8Bb7P9be58867La
	MIHVgCDpJGKvycSW2KC57cqNPFeK96EsOBqWlx5nM08sy93vuEMTRwAQtdvSoe4QlDcNfMPmW8e
	Os2QmYw4euS7ZKrcZyRtgByo0lZm1xe9v8Rc5nxg4S85tA1TiQE4sHx0ZFXgIlFgyLk6QOrfL75
	xXTlMEYHnTNe6N8/eBZ0Saty9ZTS1jEPckHP3tQbyTDdyrb/7v/5s8cjwWby7bxhLs8kxmBsIUS
	8HZX6BE0JpdxbaDBzg==
X-Received: by 2002:a05:600c:a09:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-4a0099c361cmr62461925e9.24.1790684661815;
        Tue, 29 Sep 2026 05:24:21 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfafa23sm70994965e9.14.2026.09.29.05.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:24:21 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/5] soc: renesas: r9a09g05[67]-sys: Instantiate power sequencer auxiliary device
Date: Tue, 29 Sep 2026 13:24:04 +0100
Message-ID: <20260929122407.219448-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On RZ/V2H(P) and RZ/V2N, the SYS_ADC_CFG.SY_MSTP_ADA bit controls the
power state of the A/D converter. RZ/V2H(P) has a single A/D converter
unit, while RZ/V2N has three units sharing the same bit.

Instantiate the power sequencer auxiliary device for both SoCs and
provide SoC-specific auxiliary device names so the power sequencer
driver can manage the shared power state across the ADC instances.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/r9a09g056-sys.c | 2 ++
 drivers/soc/renesas/r9a09g057-sys.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/r9a09g056-sys.c b/drivers/soc/renesas/r9a09g056-sys.c
index e6a66688423f..3895583fde07 100644
--- a/drivers/soc/renesas/r9a09g056-sys.c
+++ b/drivers/soc/renesas/r9a09g056-sys.c
@@ -86,6 +86,8 @@ static const struct rz_sysc_soc_id_init_data rzv2n_sys_soc_id_init_data __initco
 	.revision_mask = GENMASK(31, 28),
 	.specific_id_mask = GENMASK(27, 0),
 	.print_id = rzv2n_sys_print_id,
+	.pwrrdy_pwrseq = true,
+	.pwrseq_aux_devname = "r9a09g056-pwrseq",
 };
 
 static bool rzv2n_regmap_readable_writeable_reg(unsigned int reg)
diff --git a/drivers/soc/renesas/r9a09g057-sys.c b/drivers/soc/renesas/r9a09g057-sys.c
index 308492c31acb..b9def8dc73ae 100644
--- a/drivers/soc/renesas/r9a09g057-sys.c
+++ b/drivers/soc/renesas/r9a09g057-sys.c
@@ -89,6 +89,8 @@ static const struct rz_sysc_soc_id_init_data rzv2h_sys_soc_id_init_data __initco
 	.revision_mask = GENMASK(31, 28),
 	.specific_id_mask = GENMASK(27, 0),
 	.print_id = rzv2h_sys_print_id,
+	.pwrrdy_pwrseq = true,
+	.pwrseq_aux_devname = "r9a09g057-pwrseq",
 };
 
 static bool rzv2h_regmap_readable_writeable_reg(unsigned int reg)
-- 
2.55.0

