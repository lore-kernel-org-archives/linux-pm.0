Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778058;
	b=ofd1HfwSGgtt4vJY6JnVGpz0f9O76KWWnL4c/ErvmPhef/nrJ4vLAvGqHDOfng9vtmkZ
	 KruiZbsreaKPUwwIQjGtmR4elhaoRdLjCnnNnPMxvjYjVz/nGbn+MGJa3SBJ4l5Xxg0pH
	 TL8/+lxjJrNs7CASj6GZg9InSMzu8nyZutOTIWB/Nu8KGeB8hHb/M0SEkVV+PdOV+IDYC
	 QXRruhu3MkLjSOeoeGJ6/gtI9FssLKcuBSPAwB2vF1dSaCjmhh0hqFyEbqXImiNHEq1Q+
	 gTBUGDfdkJaZfFNan1cX0wLhjofEnvM9Z0o46mZ+hXjvh8AHQP8W4uEIN2BEfqC8ReA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778058;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ft7W8Aot7m3+1YC13GQrmthgZInPfqoU0+jIRIlM4ck=;
	b=ck2QtOlPCKLQMuUaZcO6U06hyZe3kGykLppx7wnrsL6vY1gG9aSJLMIf0yyv06FQoxoY
	 dgUVpgklG8ahP4dO7Q1PBVTR3IV7PmdXTFWcoHYKzzS+PlAmEyg1/1V4ycy/Zu3ugvm6l
	 diIB5o7TRDNiFmf4Qup4bd22nOiewrLzmYc45zfyTFJVKDgHFrMr3xWve4PUZ7FoYeWaU
	 x3ROtdWa4AFjQts7hV3RPh4M9X0g2kqXfgJF49nbWNvwIygB9+hL3zDTosRQiW2bfwpF9
	 /6i//oLHbng5AgAYThrK7te0yGXqVVDiGaEE7vySK9JnYoZpwPJBz+h4TBrOfNdoedA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9B606A31A;
	Fri, 23 Oct 2026 17:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03E81F01825;
	Fri, 23 Oct 2026 17:53:48 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Magnus Damm <magnus.damm@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/DNI 4/7] clk: renesas: r8a78000: Add GPIO clocks
Date: Fri, 23 Oct 2026 19:50:42 +0200
Message-ID: <34f97dab00c6d98b7afe8d8df38eeb83abf5c19f.1792776697.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792776697.git.geert+renesas@glider.be>
References: <cover.1792776697.git.geert+renesas@glider.be>
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

Add support for the clocks used by the GPIO modules on R-Car X5H.
This includes SCMI remapping tables and fixed-clock fallbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v4 2/8] clk: renesas: r8a78000: Add SCMI
remapping support"
https://lore.kernel.org/c38d744c09dffff550a9b882051c211b572b8daf.1792163045.git.geert+renesas@glider.be/
---
 drivers/clk/renesas/r8a78000-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 758cfe78ae58e0fb..1d66082f6f44b5ba 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -35,12 +35,16 @@ struct cpg_data {
 };
 
 enum fixed_clk {
+	FIXED_CLK_33M,
+	FIXED_CLK_37M5,
 	FIXED_CLK_66M,
 	FIXED_CLK_133M,
 	FIXED_CLK_266M,
 };
 
 static const unsigned long fixed_clk_rates[] = {
+	[FIXED_CLK_33M] = 33333000,
+	[FIXED_CLK_37M5] = 37500000,
 	[FIXED_CLK_66M] = 66666000,
 	[FIXED_CLK_133M] = 133330000,
 	[FIXED_CLK_266M] = 266660000,
@@ -291,6 +295,10 @@ static const struct clk_map_in r8a78000_cpg_default[] = {
 	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	FIXED_CLK(266M) },
 	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	FIXED_CLK(133M) },
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
+	{ R8A78000_CPG_SCPBUSD16_SCP_MAIN,	FIXED_CLK(37M5) },
+	{ R8A78000_CPG_S0D24_PERE_MAIN,		FIXED_CLK(33M) },
+	{ R8A78000_CPG_SGD32_PERW_BUS,		FIXED_CLK(33M) },
+	{ R8A78000_CPG_S0D24_HSCN_OTHER,	FIXED_CLK(33M) },
 	{ -1 }
 };
 
@@ -300,6 +308,10 @@ static const struct clk_map_in r8a78000_cpg_fw[] = {
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	1663 },
 	{ R8A78000_CPG_MSO_SCP_MAIN,		1459 },
 	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
+	{ R8A78000_CPG_SCPBUSD16_SCP_MAIN,	1454 },
+	{ R8A78000_CPG_S0D24_PERE_MAIN,		1690 },
+	{ R8A78000_CPG_SGD32_PERW_BUS,		1660 },
+	{ R8A78000_CPG_S0D24_HSCN_OTHER,	1499 },
 	{ -1 }
 };
 
-- 
2.43.0

