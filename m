Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839341DE1B
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 12:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787747274; cv=none; b=br3vz+yeD0Va6tTLKVuAwDS/BRz0c3Ak7ARLSr0u3DDKrsh3YpHpP9iuT5xHjr8U+Bgnfw9FywhnkF6jClCpvM9Y8ahNPAHoA0FD6xqPa0ZZ0nWbVE+CiTUDC2V4hKaL6BOZQZlxEyVVu5+JXA9xOOFqIhutstLqKbcVm8L9jL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787747274; c=relaxed/simple;
	bh=+g3vEkdNg7C0/O7vW53BPoY9M7RNqcD2+kkLYI2zPOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8Dd7xDa6CydIw8XoeRzQLBVnEcMYcjxkMRNcglZQpfqdHj6IbYENnS1P0/Tx6++5bPJbj33NsMqg+sz/PAJ59IqwBoxubgTMzeBCLN4hhE/DGE4mXRUC25V3n4SA2J3m7WrLHkF4ic92GkQ9RW54oKevVEHgmzKHDQBLsYLfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN7RzZZf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN7RzZZf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so1188232a12.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 05:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787747268; x=1788352068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2fRB6g9yGoP8wZu23NCaO6xBgrhz7xylfs1BpMSDQR4=;
        b=dN7RzZZfoVADy4GUHd8VhiCu/ZZJ4tX78JI4BVKXy/r6urN5T5CsgwyzKHx2JsJm8G
         MhhAbj5SfyyKSYHV72OSpJl7fRLAzo1cwjQqg6EFd8I/+Lkf8I0JGzqciTtWpWG153D4
         6XnNlilg/Bavjj6g2qrjbbdwasauDOOcelDOsWjEMJWihS7YRiVT3pK1dcItKIvODmaW
         KAYRftJ/4iUICpObnTara2tl5q830YSlevx4iLF8vqgkNLpY8pviUBzZ9pO05uXQECY2
         7OgloW33PltRsJBxxlxClKen/OnaH1P7ZZOa0c0gWXMRxmnTLZgZaZ2VQfq8h4q7qtIf
         NScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787747268; x=1788352068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2fRB6g9yGoP8wZu23NCaO6xBgrhz7xylfs1BpMSDQR4=;
        b=CQYCLqzr+O7EZFA3tOIj6pfjo+omhJ2W7hMWaL1yRe4gY/Ga/rift+q6kmM0yiJiUU
         gm6/hGnWhd5sZj3J8V/vWFpoVlgpiFvtklyqcmqZexV2OZjy18+qFZVIaWDDrFS6Jfq/
         hFovYifC1xdk4GwGq0y5RSwC03KiN+IFCoCZJzzOStUnYDZXrIFIbG16BBgrXgshMNsv
         OBEmhINSIJNf6cIZ097FcnsljyvJIkBj0hdJ0brYtpix34TFbM+WEqOUbeeKIH0S8FtC
         /qA4Zx1tvgE1Qdl+3xuhp9/gfMOy/LPJsAev6MLDmDLQ/BjQeFk1ZaBijExCkxIOPdp6
         7SIw==
X-Forwarded-Encrypted: i=1; AHgh+Ro7jKl0jOFF2b6qpsLBsGq0j7939YQlurUQotH5RLbedhRtB+6XCx/ECoq+tib9A0pQuYhoCwTZrQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kzrA1sVo6BuGVt/ZF7kqB3JT6vtDjGC4Mx/+QBsIZnxXG3TD9a
	RbwYyc+NOOV1zTORN+Crlqp3a8KPDulFdYvibUWyd+k9tnKZ4Uw8HkHr
X-Gm-Gg: AR+sD13pwMLetwyFJsoVnmWT2ZeKVgFz5AxAphNVrLHeN9Q6BvTR/zh/gD5jHla/g4e
	uK7jZ3XzIPMFsKE7wqkJN5LCcKPZaCggdFmD0WnGKRoGZ/KAn+WSOHsM1fGZIkF5eX5uwkgxlN7
	2SX4CUR2q5jkByH0VRfDxsn8CxV5YqpElixMQza9bZ2GR9+JdX2evGIRQf6YsQiNtthR+emwSWb
	uqmiFNWDi1kztFvvH55c3RIqO+XGGFYsdPoA543lcCGKvbmpY2WK9K7lJEJGG/eEMOBP+5C1+h2
	t56dR/OETGUlD795oJSEbxN1P0ztnE5SFo2urEkUmqiNbzfF2D2WllhZuv/li5GN24KaxAa5Lij
	iuyVDrgXVxygpEJ2TfgrSBirRP1aUXvAzViWvkUyiy3Q/f2WplA/I2XfB1VQWbj/8oNlpYftuY0
	UQUh7C8YycJlf0WwWbzZH/6TTio/B/WOu6evX3Tpa5WioNjCQ/VfhHIm6JtjESLm81p2NZvsMSO
	lpBwHofxa28uQ==
X-Received: by 2002:a17:907:6088:b0:c21:35d0:f435 with SMTP id a640c23a62f3a-c250bc0f8f0mr808974366b.10.1787747268163;
        Wed, 26 Aug 2026 05:27:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b4e9csm504890266b.54.2026.08.26.05.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 05:27:47 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 2/4] power: sequencing: Fix build issue with COMPILE_TEST
Date: Wed, 26 Aug 2026 13:27:24 +0100
Message-ID: <20260826122742.153643-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The POWER_SEQUENCING_TH1520_GPU driver depends on
(ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST. This means when
COMPILE_TEST=y and ARCH_THEAD is not set, the driver can still be
built even though it requires AUXILIARY_BUS, which may not be
selected in that configuration, leading to a build failure.

Fix this by dropping AUXILIARY_BUS from the dependency and instead
selecting it directly, so the dependency is satisfied regardless of
whether COMPILE_TEST or ARCH_THEAD is enabled.

Fixes: 1a7312b93ab0 ("power: sequencing: extend build coverage with COMPILE_TEST=y")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v4:
 * New patch.
---
 drivers/power/sequencing/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index 1c5f5820f5b7..226c62704d9b 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -29,7 +29,8 @@ config POWER_SEQUENCING_QCOM_WCN
 
 config POWER_SEQUENCING_TH1520_GPU
 	tristate "T-HEAD TH1520 GPU power sequencing driver"
-	depends on (ARCH_THEAD && AUXILIARY_BUS) || COMPILE_TEST
+	depends on ARCH_THEAD || COMPILE_TEST
+	select AUXILIARY_BUS
 	help
 	  Say Y here to enable the power sequencing driver for the TH1520 SoC
 	  GPU. This driver handles the complex clock and reset sequence
-- 
2.43.0

