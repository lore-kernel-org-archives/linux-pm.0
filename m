Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793853664;
	b=iL2+WlPAvyGoiRXWXXrrgn+4gPBxo7J20wsTdUs0YJ0HCZkFLV45GiQb8ADz4P8q7waZ
	 ZU26vPdxPBPg/mS8r9RlKda3hiTuDlm/43uFizmysdD9B8ToIVyR1I7vAHsmBaBAUGObi
	 kT2w5gJgA7rdnzhBRSrEcH0gOWnQEU4G+3UzIGNIdyefb6NPU+WhZ3DG1biWG4i7NwqM1
	 AwBxFyR5CdZqWtTWRXry+t8bMR3r99NA0FlaWXsGVMjv/adFl1EJpFH/snE+n4CjEbCug
	 nnbB1kUR0/EFtVazUly/dLOrIMkr9DYkWH2f5lJnyuh00Zy9a+yVev+k5QhHPudpfSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793853664;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rH9b+qonWYU0U9xuZioxm6lWLILfzoQKLx37tFS+/zY=;
	b=qsEHi6ddm2lf7tH7Jm54p68UdYNdTngoyzpzsSpIVx1uT3SYkqHkxX+RHq4C/gagG5XF
	 Cl3juwmA1roLf0vRNhbMRYMsoUbW7hm1bKXdqBGkWPO/vWMH4clICX8Ct/SoAI8nleuSP
	 hmtUqDiX8HTd0RUlDjyLGGd7sRLElOLaVWUJ3ZVwixArt/bcKd5Q7cjDTMSm4VgroZyOC
	 LrkGByQhT9qXZeOSU5pdeud2kAo7LxfG7lDtyVtUY5cVlE/ErZzgta8nIXpxlMHvx5S7e
	 i/EYhYUaHk8XKvtfCF/xn8UIxUrcwNzUwk0yXyChmSYFRLWNXdO76AfpyZIL5VoHATA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecmzfAII;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D30606D830;
	Thu,  5 Nov 2026 04:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ecmzfAII
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793853663;
	b=O7FLfZ46QptknCKIlDfjWo+AghJsHUTi+1Jn5mBpr3ogZiBOAmSjhFk0Ofst0OjbPPrl
	 5E5jm/ScULxnyeB6oDwlb2YcryNe+/tvgY+jv8W7NeilBbJW1CcEUi6c+J0yMuL97Oxk2
	 gXYeZwnFI1YAByGapjMuVC9ktf7JfHIkMVhf2Z1ig3+5lTUdyKBcE+pyXrcQrTJjZzu/a
	 NdHaNrRwiBvsFKuxfSCdBIWclbowk8NXz8KVh73e9vI40rw691A4kr2VNgwrfHl3phwIg
	 cvK/H9H2d9m06GV01sCmovab6RSwFeBCJGtSvZHctF6jlJcUNW4qqPzUT49letsugHA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793853663;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rH9b+qonWYU0U9xuZioxm6lWLILfzoQKLx37tFS+/zY=;
	b=DxqcyKbn9dKhnbMD7EyTdGQXfk6vfgZ3TEpZh6uUxoXh+U2CmM99mwCLjS3pSJP2E+8Y
	 BQsyJt+lP+efuWK0Ve5KSM/pD6Z29YLPF2IDL51p8XywTmijU3mV4mXPx5vn/ksd7tbhA
	 QauyiTtZi20XR/QRSSUvMKpnkKWXF2dvdaEBClg6ex6lbRWn3MQVyoGqw+L59LIBPPa1X
	 X5DfAdHkkxQd5cmvOUDbc/9m95APi2kAGXK+Ixibu2fSBXzPDG4JvrrTqKSlC+nrf15v3
	 nEbzy9sxe2WyEzT8YwkWMoKGyT3cUdYTa1ne33U+PG6c7AGn/yUb6LJMd8B+Ma0/nOw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0550C1F00A29;
	Thu,  5 Nov 2026 04:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793853663;
	bh=rH9b+qonWYU0U9xuZioxm6lWLILfzoQKLx37tFS+/zY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ecmzfAIIHeVK1xB9coAJNocts1Mk41gB9gnOIJs4mCI6Q4ojE8RtIEc2W1o8Xf04S
	 U1H99VSmr8WeMpAhw6p7prmD0wjNEJsWRgf4l3ATpmFxVhKN0PTvtuZu/32JN2wjiZ
	 Q6tWuSAi8ke4zUi7tvjUEq1ILA4yfADvsPBInj2c6M5Th4JNGENBYX5IUvgUeiufXb
	 BjX7pIvKKMuiPdOQA7NpYNqSyqPpWBFJ/8v/wXNqPZ1rdbbaVFhuDUY/HHHRpse3s7
	 dng/KXBnr7IVwaMNmQ8PQuc6ng74Ja6yarH4YJuZScfbz8HbHWN2V/BtgziHj2Xtcc
	 keJEKTGIZWIww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 23DC7470AB;
	Thu,  5 Nov 2026 04:40:58 +0000 (UTC)
From: Rajan Yadav via B4 Relay <devnull+rajanyadav0307.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 22:41:01 -0600
Subject: [PATCH 6/6] arm64: dts: allwinner: a133: Use the A133 CPU OPP
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
Message-Id: <20261104-a133-series-v1-6-58217cb33a87@gmail.com>
References: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
In-Reply-To: <20261104-a133-series-v1-0-58217cb33a87@gmail.com>
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
 linux-kernel@vger.kernel.org, Cody Eksal <masterr3c0rd@epochal.quest>, 
 Alexander Sverdlin <alex@sverdlin.org>, 
 Rajan Yadav <rajanyadav0307@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793853656; l=3324;
 i=rajanyadav0307@gmail.com; s=20261103; h=from:subject:message-id;
 bh=x5FE0Mhj6qYPFUq6zvVIYk5BeSBjVopTztLIpG1kUCM=;
 b=piOPG5YLJZp9HRQREOhbgGNTbR72tV2osHC80xB2c/s04EqF2pecIuVVvVFrmA7bNITkzMaP1
 rEp1ItCY4kyCpCPkzegLvgQs+BLD8k0cHTkALKaQm76R1ezINQbZfyN
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
  of 1464 MHz.
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
Signed-off-by: Rajan Yadav <rajanyadav0307@gmail.com>
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


