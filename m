Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026573;
	b=nqgKdcKcqrWaQOROGuc7CjbPHWWsOtOyYXJ+vKr0uo3ZO0HtI0hXFon5+8UbUEvVvo4s
	 2RWo/TJO18xCrixDtf3Rb5NEQDC/l+01XPXcPMz9ZUKsN0ezAnMBnxLy/tOJGT522Zd2s
	 tr0cY4sZX95XA7111gjFBx3dZyWL7OLurcZltHq3dOEdIjBjIPLte15Hwp7w5gGk0WKvj
	 aCrNZlPTEHt3mXpx4XquwF3Vgn+0qah5BcUCVrbpHGibS0y7vbucA6VYvSjm78u7sD9f9
	 okNCQ5zQcQJZI6FOskuvzGIG3ohotq3hzNuBRyBldZXiZ3BzPh9+80y11CA1pqaqpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026573;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ngZ+YChJ683ub5nqZmPTKf2cgTQixpdwXS2UrmArJoI=;
	b=KVUI8UYzUegZKv68C7UXq4pr2Vs0AZ7idYJ+hreZZn/eR0fPsNCAFBr5SsAN/AUXzvwO
	 cVbab+Tv0iw+UI0GToKPkpQHAony5Zh8sDcKroQbnQKUSi46mTq+hx7V+OfuZXvNVlmbC
	 bBf1NvQ3Lp9Qti17RTViLBx7IXr3cfLbNmEUAi5gWA/hE4xwmRaRLfpa4S47kgarjmJwt
	 DNf5uCi1U2Ar9CGijhZHBEfDZG3BK3V33RvRvXCFq1epc//lJooO6olIXcKLGPzuWP5rL
	 +JmS4hba0NqvYIKoX5f8PEBKfmyz2QOnIzwUVW61Y3mv+kRR0cRmdVYyhEGTVanj7Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9067606A31E;
	Mon, 26 Oct 2026 14:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25931F01825;
	Mon, 26 Oct 2026 14:56:08 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/DNI 09/11] clk: renesas: r8a78000: Add PWM clocks
Date: Mon, 26 Oct 2026 15:55:25 +0100
Message-ID: <4fc4232a28fe500b270d2cc26412a1909c12f5aa.1793026273.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793026273.git.geert+renesas@glider.be>
References: <cover.1793026273.git.geert+renesas@glider.be>
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

Add support for the clocks used by the PWM modules on R-Car X5H.
This includes SCMI remapping tables and fixed-clock fallbacks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH/DNI 4/7] clk: renesas: r8a78000: Add GPIO
clocks"
https://lore.kernel.org/34f97dab00c6d98b7afe8d8df38eeb83abf5c19f.1792776697.git.geert+renesas@glider.be
---
 drivers/clk/renesas/r8a78000-cpg.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 1d66082f6f44b5ba..9b1ff5a8ff1bdc31 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -38,6 +38,7 @@ enum fixed_clk {
 	FIXED_CLK_33M,
 	FIXED_CLK_37M5,
 	FIXED_CLK_66M,
+	FIXED_CLK_100M,
 	FIXED_CLK_133M,
 	FIXED_CLK_266M,
 };
@@ -46,6 +47,7 @@ static const unsigned long fixed_clk_rates[] = {
 	[FIXED_CLK_33M] = 33333000,
 	[FIXED_CLK_37M5] = 37500000,
 	[FIXED_CLK_66M] = 66666000,
+	[FIXED_CLK_100M] = 100000000,
 	[FIXED_CLK_133M] = 133330000,
 	[FIXED_CLK_266M] = 266660000,
 };
@@ -299,6 +301,8 @@ static const struct clk_map_in r8a78000_cpg_default[] = {
 	{ R8A78000_CPG_S0D24_PERE_MAIN,		FIXED_CLK(33M) },
 	{ R8A78000_CPG_SGD32_PERW_BUS,		FIXED_CLK(33M) },
 	{ R8A78000_CPG_S0D24_HSCN_OTHER,	FIXED_CLK(33M) },
+	{ R8A78000_CPG_SGASYNCD16_PERW_MAIN,	FIXED_CLK(66M) },
+	{ R8A78000_CPG_S0ASYNCD8_PERW_MAIN,	FIXED_CLK(100M) },
 	{ -1 }
 };
 
@@ -312,6 +316,8 @@ static const struct clk_map_in r8a78000_cpg_fw[] = {
 	{ R8A78000_CPG_S0D24_PERE_MAIN,		1690 },
 	{ R8A78000_CPG_SGD32_PERW_BUS,		1660 },
 	{ R8A78000_CPG_S0D24_HSCN_OTHER,	1499 },
+	{ R8A78000_CPG_SGASYNCD16_PERW_MAIN,	1651 },
+	{ R8A78000_CPG_S0ASYNCD8_PERW_MAIN,	1653 },
 	{ -1 }
 };
 
-- 
2.43.0

