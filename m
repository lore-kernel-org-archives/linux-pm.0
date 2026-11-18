Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031137;
	b=XayrtZOT2ca6EDt9q/LEkEw5Aa/SoGpdjESs5LgskfJFOEzWflbKYdBmcOruWxgHzGnW
	 clSPlgabfXKHdeExM7KO2IIa0Ud/G+GUpSTgC8lffhxT+rHS5UJUDKPYB/ApEDf1L1f5S
	 wZQuvyQzgQJ6B4lyjBVXekWh2nxMP0lEFPwTVIU/dqwhQPgs5Dp8Eu55YP2jSXQiSPEEc
	 hFOvDU07a/jsposv9CK+8scupWndB96XVPUyojQatbL8xFQ0NIt71379kpBU7frBe2c5Q
	 hZHXiEKeD0P5yQ81csZ7Y33YSgY4X3kc3t5bZnKkTf5Kdn6aY4iCQUEydbTmJIp6NVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031137;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=nqLdUz2tK7kVryVTffOxPF1P1cPo4qfTixVBvclS3Ls=;
	b=dQ1r/9qb914gpfubhxrp8qx4vto7CEIAw9cnsRG+R7cbLVqHaO70iYNzH+Ejaa2TATy8
	 KE7yXJAbOPw6l56j1ulJoUd5XvNa7u6EU8UDP+NIld68LQrOqgydilFvcpk48vN85GT1L
	 ti0I6GOQDAw406Q9o2IWUuWnGHzvzgJePtogvAziuRoH4JO9WsflrRzcn3pTdes/2pUN8
	 zhBCyhG83M+SBSb/N7HQgAAT/HEJ3xhSr3oFpu9NxOgVWWOh4tEPwcNrWM0eUC4aYlEY8
	 AkL5slC1skSDsiuvl0XF11yEnlF2MaI1hl7YujDho5TX/hrYZFI6GqB24S25Q84UU1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF8606A31C;
	Wed, 18 Nov 2026 19:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FD81F000C5;
	Wed, 18 Nov 2026 19:45:31 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Vinod Koul <vkoul@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Paul Elder <paul.elder+renesas@ideasonboard.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clegoffic@baylibre.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v5 03/15] clk: renesas: r8a78000: Shrink IDs to 16 bits
Date: Wed, 18 Nov 2026 20:44:51 +0100
Message-ID: <066c0c074865c2a8684f541c3513b8851f3b09a9.1795029012.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795029012.git.geert+renesas@glider.be>
References: <cover.1795029012.git.geert+renesas@glider.be>
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

Reduce table size by shrinking DT and fixed-rate clock IDs from 32 to 16
bits, which is still plenty.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/clk/renesas/r8a78000-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/r8a78000-cpg.c b/drivers/clk/renesas/r8a78000-cpg.c
index 03fcd128d4293cfc..236c638834703f95 100644
--- a/drivers/clk/renesas/r8a78000-cpg.c
+++ b/drivers/clk/renesas/r8a78000-cpg.c
@@ -17,8 +17,8 @@
 #include <dt-bindings/clock/renesas,r8a78000-cpg.h>
 
 struct clk_id_map_entry {
-	u32 dt_id;		/* DT binding clock ID */
-	u32 fw_id;		/* FIXED_CLK() ID */
+	u16 dt_id;		/* DT binding clock ID */
+	u16 fw_id;		/* FIXED_CLK() ID */
 };
 
 struct clk_id_map {
-- 
2.43.0

