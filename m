Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794999148;
	b=aCcA49h93GaDBcH2o0aH23H98fetX2NWGktBDyhwKztxCKzaThiibAcoO5UhFMOOikI1
	 V4haPbMDYmhKh6WagSYpwIMaJ37cdF7D11S/aY16uozaruaU9hKf3GmP7Dstw5uO/n04q
	 qVf1fwrV4xFojo7BTKvMq7tjiO0YXJF31wAEGE4DOXktYt7KjWB+Pwr7MjvAe7NhqcXmp
	 eUZGwGxTPU3VU4w6qGlfrz8xgAqZj9oyx7wh2AHay7IZwE/sBDIhO8ZRwRoIqpVIi7npI
	 L912QYP+fJewNe2yF7zGlp9erXwFjmYOX9uywMix01QsVfgpIbvChanQ1m/XJXPkzQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999148;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2By4B2DmE6jOQ+T2SsshaYG24+i1LcC/o8XIi2KFjfQ=;
	b=JLdMco084qp86Zg9ud7PSmZcA0e0uhgPQS4xir4OIMAN3b5FJyGfVWktD+Yoq1b5HnC2
	 pjs+X76rXf4S6QgAanOC2W05uMB1+I6u9YeBwB8d5Ed9+uuIP8srPnhdLuMNfAu4RYZN9
	 ytUQuLCTnvj3laZnj3TUdvaMa4PjuZhca7GCllLWt51W7ogLAVJJGEvqw5bsJrU9MLCNg
	 YCSEnLCj7BKTBAlhBcNrc6gwg3i8XXYDQfTfzPKDbIXcSM6Q6xIEo1FVCCs5/yNHzPPVs
	 v6mRuKAIx6F5dBdzUxLk17rXHxADiwwND9GLsYvUYwcnbnraaG8JbsotK9TaxmjMI/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+qRzA9A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B4A60A2613;
	Wed, 18 Nov 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a+qRzA9A
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794999148;
	b=UV4d4i3hc8uJKj89x1fS/OabbwHwW9pgpqtKosQgEHG0bwrNrvTciyddWCPPQHmVNf8k
	 pJefJGpSnHUoddWcwvPkCPkiNjCEDc1g++HW4JdgMOxFPl16XzhdX3ohAC+xlfAAt9e8N
	 D3BjGUA6JKgoOziEjTwDE83JIK97bPHDAr3kzQ4faLfrUbVP4XuyKT5+SrI7I6hjwix64
	 1EPH+itMxWgH50iBVueqx2fvJGaSAPm3EMuh2Xriis2roSfCG45PX2M6T0EqVNDRWWuKP
	 IhGN6r4e+yUfQoKbTTa+bnjsB1DAX+0Zx/4qjzDoy8tr4gIP+hE2pbm4Qby2bd6aihg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794999148;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2By4B2DmE6jOQ+T2SsshaYG24+i1LcC/o8XIi2KFjfQ=;
	b=JX+NIHr45DW3P8igOXGLVwG75m9zPmQcsSSo8t2JXO7EWhKux5XqqOSNOIT+GzO1YlLD
	 rQmPyd821AJDVTqBMOZeiF6znkgnC54PBuoF2d8NV80F+5LvZZsqsi88SkR46JgtmroPm
	 HHMUoiI5FCXeJz+YYO0CSYMcydgaL8qniAb1E/apzFoQUJd/brpgyKrLFY2UB+R8CsEVR
	 2Gkbsq/GLRkwf1JevasC5IplF1yIhzoTyIOOZ6aHdv4MAFIiYba18rfVfs839XFoW+x+x
	 Vm3DjTxDS5weHxWgzO9WzLt9+XlCkZRtvMbG32jXxzM0VaefKt1n9vgBWtLkomVo8HA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 428DE1F000D0;
	Wed, 18 Nov 2026 10:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999148;
	bh=2By4B2DmE6jOQ+T2SsshaYG24+i1LcC/o8XIi2KFjfQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=a+qRzA9A9YDM+wVMDvTkzUD2OyvwOr/Sj3B0nOfhHr7Ai/qyqNBTg8XmqLpB5gxnn
	 Cl5gxxcRJ4YGi5+QW233inzZGvgY4fV/d33ehBhvYv3Xt4hSfPs3G1vTf9W1Vaopvr
	 j50WErYjLJuJ+Qyign3v3twPmZnMem/lhQJZajrAuv8R0TwSglIk9t/tvUxC1gwpn1
	 2AWefvqYnDTVrol1vwy/zKzp9soTmLZE++2ixNhmuU5YV/6uqhhqi6ur9Pr04ImrHr
	 c43dRJGnZUQ3zAme6OTheS0Sfaj6lQ7qMdUf89dCo0vdEDI+5SMNMj2f53hZnymFXG
	 eZ1yI8BYSc7UA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D4B664AD24;
	Wed, 18 Nov 2026 10:52:25 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 04:52:29 -0600
Subject: [PATCH v2 6/6] arm64: dts: allwinner: a133: Use the A133 CPU OPP
 table
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
Message-Id: <20261118-a133-series-v2-6-8bcec9c9aadf@gmail.com>
References: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
In-Reply-To: <20261118-a133-series-v2-0-8bcec9c9aadf@gmail.com>
To: Yangtao Li <tiny.windzz@gmail.com>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Alexander Sverdlin <alex@sverdlin.org>, 
 Cody Eksal <masterr3c0rd@epochal.quest>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794999144; l=3568;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=9RwtNBE54nzjhJKSSd9WvjqDW6S0SKtsSGS0h60Ibhk=;
 b=RYaCsVy1CxE3WsdfOmFeUTfltmC5+noQeaqGmatT6wD6gN9vhvPy7TVRCmJgDFipyIzA7JAyj
 JmqGaudtNgCCC9jenEkNs1zsg71Gdo3pElxwH8rN/tuM6AMILFtMQNl
X-Developer-Key: i=rajanyadav0307@gmail.com; a=ed25519;
 pk=4ZPeiP5qrv2b44q/Obxi2koUS70Q6npbttJnpUoTlgg=
X-Endpoint-Received: by B4 Relay for rajanyadav0307@gmail.com/20261103 with
 auth_id=1391
X-Original-From: Rajan Yadav <rajanyadav0307@gmail.com>
Reply-To: rajanyadav0307@gmail.com
Content-Transfer-Encoding: 7bit

From: Rajan Yadav <rajanyadav0307@gmail.com>

Switch the three A133 boards in mainline (Baijie Helperboard A133,
Liontron H-A133L and Teclast P80) from the A100 OPP table to the A133
one, so the speed grade is selected as the vendor does it.

What changes depends on the chip:
- revision A-E parts with a normal marking ID get a0-a2 from the bin
  field, as they get speed0-2 today, with the same voltages; only
  1080 MHz becomes 1008 MHz. The exception is a part whose ICPU and
  PCPU values are in the range for which the BSP forces a0.
- revision F and later parts with a normal marking ID get the a3-a6
  voltages: higher at 408 and 600 MHz, equal or lower from 1008 MHz,
  and 1008 instead of 1080 MHz.
- "high speed" parts get the b grades, with 1416 and 1512 MHz instead
  of 1464 MHz; revision A-E ones (b0 and b1) also get 1608 MHz.
- if the firmware does not provide SMCCC SOC_ID, the driver keeps the
  A100 selection, adds the BSP's a0 rule for normal parts and warns at
  boot.

All three boards supply the CPUs from AXP803 DCDC2 with a 0.81-1.2 V
range, which covers every new voltage. Without the A133 support in
sun50i-cpufreq-nvmem the A100 fallback applies. The Teclast P80 also
needs "cpufreq: sun50i: Handle boards with the allwinner,sun50i-a133
compatible" to get cpufreq at all.

Claude Code (Anthropic) drafted this change and its message; I
reviewed it. I tested the A133 table on a KickPi K5C; I cannot test
these three boards.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alexander Sverdlin <alex@sverdlin.org>
Tested-by: Alexander Sverdlin <alex@sverdlin.org>
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>

---
Changes in v2:
- Commit message: revision A-E high speed parts also get 1608 MHz.
---
 arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts  | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
index 545972d2324..3a89d3f74b3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-helperboard-core.dtsi
@@ -7,7 +7,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
-#include "sun50i-a100-cpu-opp.dtsi"
+#include "sun50i-a133-cpu-opp.dtsi"
 
 /{
 	model = "Baijie A133 HelperBoard Core";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts b/arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts
index 90a50910f07..1b9cbcbe5f3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-liontron-h-a133l.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
-#include "sun50i-a100-cpu-opp.dtsi"
+#include "sun50i-a133-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/leds/common.h>
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts b/arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts
index 47b5f2ac824..7d4c346276e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a133-teclast-p80.dts
@@ -6,7 +6,7 @@
 /dts-v1/;
 
 #include "sun50i-a100.dtsi"
-#include "sun50i-a100-cpu-opp.dtsi"
+#include "sun50i-a133-cpu-opp.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 

-- 
2.34.1


