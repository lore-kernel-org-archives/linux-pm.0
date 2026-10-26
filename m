Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026577;
	b=qkuiKA6C2TQAt7rZx4txbdqEsfzEp52yFqCc7E7wGcMsBwgoqx8vSCywNcxiVX6Ly0i8
	 9v/DVypACgocbDDpPMxMlgpnSARP1U291FWH+T+bf5f6lfoafkd4pwLfupdNI7Dt96QAp
	 xdmxLn+qp9GOsIu15D+o4Rmj9LKJIF+xzxxiY47fg+1QXyAV6YqIayQxADdM6OsfiYngV
	 dsSuJLL0NTKrAnKolJPDgn5fdJvI825B5kV5VtE3ArPmP6gf33Xb39EI0n1eYR0vMMi0q
	 P1SLoHpagPN9ShdHeucxTDnqAU8v+eZyXRxQwXCsOPgh/UlXmf89wjpqSOSqevetfhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026577;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=+BXLUS8lDAmpc0E9HAwHG4tK1aoD2k15ADbFhH36gJs=;
	b=oCyVoeRlyPYXjkVFnFmBFmatkaGpFHDc85x8aBXiTjijaBhCz1ZiYWa4lZLAY3JPEuMP
	 vTzbLKdhjAD7D2F58CmQOpL5snd9AXDmBB/Ml74dNngodz9EMAYq8Wlluy8IAlPm9KvjQ
	 oP5+tk+VdY8PfpGmQhOgCaoaJF2VhwG9Ijfpwe5sgS6+Iosoinkz2na+lL6yg8bKot3t4
	 B+9SShmqoSssh+coV9naVV3d2mwDEkrTqNoEsV6pv2HqX9wqBhGdZunVLNiVcPf1rAjqz
	 uw/7nY3+JRAATEP29/NT86qMdpWW6jtnLxuDb6a+bNrpNVQK43vbXcRemmSUV6pDc5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C55606A322;
	Mon, 26 Oct 2026 14:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A3F1F01829;
	Mon, 26 Oct 2026 14:56:12 +0000 (UTC)
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
Subject: [PATCH/DNI 10/11] pmdomain: renesas: r8a78000: Add PWM support
Date: Mon, 26 Oct 2026 15:55:26 +0100
Message-ID: <a04faf03f3854d3eef291dd6e5dd886a54bfb0f9.1793026273.git.geert+renesas@glider.be>
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

Add support for the Pulse Width Modulation (PWM) modules and the 16-Bit
Timer Pulse Unit (TPU) on R-Car X5H.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v4 7/8] pmdomain: renesas: r8a78000: Add SCMI
remapping support"
https://lore.kernel.org/2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be/
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 838566ed821e29e0..62156bfb8080e6e4 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -681,6 +681,8 @@ static const struct mod_map_in r8a78000_mdlc_perw_mod_fw[] = {
 	{ 0x55, 225, -1 },	/* HSCIF1 */
 	{ 0x56, 226, -1 },	/* HSCIF2 */
 	{ 0x57, 227, -1 },	/* HSCIF3 */
+	{ 0x70, 244, -1 },	/* PWM0 */
+	{ 0x76, 249, -1 },	/* TPU0 */
 	{ -1 }
 };
 
-- 
2.43.0

