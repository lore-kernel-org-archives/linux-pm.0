Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778101;
	b=qsStIN1xKyyt1k+exBgwiYoS+bFa6cz4D1lb9+a/YCHl0o+s06R39+yYqEu0/5lYuGRm
	 cLst/AliaGBeaJT0BZxtIjas1uuBYiQxzWJD9I9EP02s0v09FJyugdadfYPxQUjlX+6b6
	 H2KIgM6PcRolJnQZwGTijiSgAF/yd1wgiMddfEAyqH0QZWj3C4FS7vi1nhctq6QpFoybX
	 Xck3zCoozMcMONU1WXXop0G6punwdgy5bSacW1/fYir8WFG+qxnYB7ors2GSInRfSIdGY
	 z/8gWwCUp1EJ8P08GZlGvTrAXxUsXDBKLI6X+wgPGXVC28pBO4PqUPxb+kviRj06fLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778101;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=pao9WubCAod8keYe+2yXT+0/fwRHZA3RvWmCb5PUwHo=;
	b=AmEcfuBlZ59Cbwh7cO+sEOB4gkD/PKn/4JW6jQE162M39xltC4RAzhUCasqRjaAls1al
	 Lto8isL0HG1ikgdtqFZTcY0k/Qi+BoDfcv41d0xH/OGI+lXoPksaO2ptfQLJ+9kkRLn+4
	 j1Kpmh+ne2z7CAWjbmfNmgCnY/XJf8OsSNhmymVqOesP8n91Rl/LJMPzgL4bFQaCrbKrl
	 wQcODv9WWBw55DA9r8+z3aX+Y5zN55kpKZhU5+IyrQeMQzBwOCcaY8HiBUzirQ/rwk6px
	 mXHzJi6dSXGZkeWDi1abHj2+aH0QQdIdSGYIjUgLrJjRSRKMX51ddDGD3WqY1frrCPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D5606A31A;
	Fri, 23 Oct 2026 17:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC851F01825;
	Fri, 23 Oct 2026 17:54:41 +0000 (UTC)
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
Subject: [PATCH/DNI 6/7] pmdomain: renesas: r8a78000: Add SCMI GPIO support
Date: Fri, 23 Oct 2026 19:50:44 +0200
Message-ID: <54e186a3436605f5755dd16eb90b3b7a06e97254.1792776697.git.geert+renesas@glider.be>
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

Add support for the GPIO modules on R-Car X5H when using SCMI.
These are handled by the AON, HSCN, PERE, and PERW Module Controller
blocks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH v4 7/8] pmdomain: renesas: r8a78000: Add SCMI
remapping support"
https://lore.kernel.org/2895c8f3cbe718dc597ad25e16c2461f0d681ab6.1792163045.git.geert+renesas@glider.be/
---
 drivers/pmdomain/renesas/r8a78000-mdlc.c | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pmdomain/renesas/r8a78000-mdlc.c b/drivers/pmdomain/renesas/r8a78000-mdlc.c
index 10089d938f71b27e..838566ed821e29e0 100644
--- a/drivers/pmdomain/renesas/r8a78000-mdlc.c
+++ b/drivers/pmdomain/renesas/r8a78000-mdlc.c
@@ -644,7 +644,23 @@ static const struct mdlc_info r8a78000_mdlc_default[] = {
 	{ /* sentinel */ }
 };
 
+static const struct mod_map_in r8a78000_mdlc_aon_mod_fw[] = {
+	{ 0x20, 811, -1 },	/* GPIODM0 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_hscn_mod_fw[] = {
+	{ 0x50, 332, -1 },	/* PFC_HSCN_GPIODM0 */
+	{ -1 }
+};
+
+static const struct mod_map_in r8a78000_mdlc_pere_mod_fw[] = {
+	{ 0x30, 193, -1 },	/* PFC_PERE_GPIODM0 */
+	{ -1 }
+};
+
 static const struct mod_map_in r8a78000_mdlc_perw_mod_fw[] = {
+	{ 0x30, 201, -1 },	/* PFC_PERW_GPIODM0 */
 	{ 0x40, 205, -1 },	/* SCIF0 */
 	{ 0x41, 206, -1 },	/* SCIF1 */
 	{ 0x42, 207, -1 },	/* SCIF3 */
@@ -678,6 +694,15 @@ static const struct mod_map_in r8a78000_mdlc_scp_mod_fw[] = {
 
 static const struct mdlc_info r8a78000_mdlc_fw[] = {
 	{
+		.base = 0xc1338000 /* mdlc_aon */,
+		.mod_map = r8a78000_mdlc_aon_mod_fw,
+	}, {
+		.base = 0xc9c90000 /* mdlc_hscn */,
+		.mod_map = r8a78000_mdlc_hscn_mod_fw,
+	}, {
+		.base = 0xc08f0000 /* mdlc_pere */,
+		.mod_map = r8a78000_mdlc_pere_mod_fw,
+	}, {
 		.base = 0xc05d0000 /* mdlc_perw */,
 		.mod_map = r8a78000_mdlc_perw_mod_fw,
 	}, {
-- 
2.43.0

