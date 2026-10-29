Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279508;
	b=49F2majlQ/RRX/MUkcpswtanjjVlfgVc3GZGy+E0aytpJ4438DjZ4hBeNIuVOTqiXgWt
	 eOB+Wb8cdh3qDZa0GXCWmssTCGICsIGO8m0xI+doEnXUCeYY+JQf3CMY3XKwuaL2TgI8v
	 3QQEXwUQxmgexkq/eoa87edIE6EkXJKO0YAaEgj4oLep2Xi982OWleCDEHnvTBOIz+aS0
	 jeMR2jpAjIhZTprgHqB6/lcp4pE+L7P1+LQ5PqYMRvr0VxT45VLObIHj7HCaDFXjL0jdV
	 bDd3F3m0xadFOx5/GX/7vis+5GDm/JUu1GnrZCjdg3Fc/87ZJoinFcgCU2GLgSJrYCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279508;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Edmcko11Xp6DEFFN8DrNllqPF61F7sdGOgmwg2xTmCQ=;
	b=dIgcqD39+VImuyjvwTNch/C1mQIAd58r9R8v4J9pS+UW8HCMMeUV+VkU7V+EBpFlFpdQ
	 zEVJe6wkJUep2Cu1K8YlosyqGmsGjE30aoxGBIyy/3Ss2ktbChn7m647KYVRbpBpqaF27
	 GAYyLDjssnpHs++BPkFIMyjvJbbOYP363yXDOMkRz6sLkAlOdN4RDJJpFRj3Aj6/Ke6S4
	 XkptT0zxiVANT+m8Dq7Xa+XT3HaKROR1Q7ol47CDBAsYdhbTq2nFIEY+f7kc2tD2+p2O5
	 ozalYEYHpKNEHRMP517Up0L4J8BGbsDtZzIXESDMHqPk+X3mAEFmFFYUJPJLKH0CddQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921B606A31C;
	Thu, 29 Oct 2026 13:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14331F031E9;
	Thu, 29 Oct 2026 13:11:44 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Biju Das <biju.das.au@gmail.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/DNI 7/9] clk: renesas: r8a78000: Add CAN-FD clocks
Date: Thu, 29 Oct 2026 14:11:08 +0100
Message-ID: <5e76e7bc1d45939387746d84e4d8628f4fbd4f9b.1793278754.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793278754.git.geert+renesas@glider.be>
References: <cover.1793278754.git.geert+renesas@glider.be>
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

Add support for the clocks used by the Controller Area Network Flexible
Data Rate (CAN-FD) modules on R-Car X5H.
This includes SCMI remapping table entries and a fixed-clock fallback.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH/DNI 09/11] clk: renesas: r8a78000: Add PWM
clocks"
https://lore.kernel.org/4fc4232a28fe500b270d2cc26412a1909c12f5aa.1793026273.git.geert+renesas@glider.be
---
 drivers/clk/renesas/r8a78000-cpg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 9b1ff5a8ff1bdc31..4e986b6cb79e4631 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -40,6 +40,7 @@ enum fixed_clk {
 	FIXED_CLK_66M,
 	FIXED_CLK_100M,
 	FIXED_CLK_133M,
+	FIXED_CLK_150M,
 	FIXED_CLK_266M,
 };
 
@@ -49,6 +50,7 @@ static const unsigned long fixed_clk_rates[] = {
 	[FIXED_CLK_66M] = 66666000,
 	[FIXED_CLK_100M] = 100000000,
 	[FIXED_CLK_133M] = 133330000,
+	[FIXED_CLK_150M] = 150000000,
 	[FIXED_CLK_266M] = 266660000,
 };
 
@@ -297,6 +299,7 @@ static const struct clk_map_in r8a78000_cpg_default[] = {
 	{ R8A78000_CPG_SGASYNCD4_PERW_BUS,	FIXED_CLK(266M) },
 	{ R8A78000_CPG_SGASYNCD8_PERW_BUS,	FIXED_CLK(133M) },
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	FIXED_CLK(66M) },
+	{ R8A78000_CPG_SCPBUSD4_SCP_MAIN,	FIXED_CLK(150M) },
 	{ R8A78000_CPG_SCPBUSD16_SCP_MAIN,	FIXED_CLK(37M5) },
 	{ R8A78000_CPG_S0D24_PERE_MAIN,		FIXED_CLK(33M) },
 	{ R8A78000_CPG_SGD32_PERW_BUS,		FIXED_CLK(33M) },
@@ -312,12 +315,14 @@ static const struct clk_map_in r8a78000_cpg_fw[] = {
 	{ R8A78000_CPG_SGASYNCD16_PERW_BUS,	1663 },
 	{ R8A78000_CPG_MSO_SCP_MAIN,		1459 },
 	{ R8A78000_CPG_MSOCK_PERW_BUS,		1667 },
+	{ R8A78000_CPG_SCPBUSD4_SCP_MAIN,	1451 },
 	{ R8A78000_CPG_SCPBUSD16_SCP_MAIN,	1454 },
 	{ R8A78000_CPG_S0D24_PERE_MAIN,		1690 },
 	{ R8A78000_CPG_SGD32_PERW_BUS,		1660 },
 	{ R8A78000_CPG_S0D24_HSCN_OTHER,	1499 },
 	{ R8A78000_CPG_SGASYNCD16_PERW_MAIN,	1651 },
 	{ R8A78000_CPG_S0ASYNCD8_PERW_MAIN,	1653 },
+	{ R8A78000_CPG_CANFD_SCP_MAIN,		1456 },
 	{ -1 }
 };
 
-- 
2.43.0

