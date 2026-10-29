Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279500;
	b=cIZIjzSkxRownu6jg+kwDyYa+WpV2PG44h6kNLKFRjdUrlZY38QKwiDWJ01FHskSgslR
	 6NS759J2JSO/SwhirswevJfUhyT/SyrU87AvNW2zqPJHDu7m1KEk8h8m3gLTaCfSC0EFG
	 IWeKZRdVWLmnG1yQmtbpzzeQfglUqkn9wpBO/qlq1odHNM+a5dnJtPhjqDGY4HEMf3gqO
	 FokXqpbwShXHvjBC/bJ8R1TSs5hNPbG+KMPebO5FjBzoiMKAL+91J46qeRkKvpsDMECDd
	 JWVM+KIMNa2huAdqL/FgG+vj6I2gBP7544p9QgMcw1IdTMBTU0g5Y69Ts2tqFCOH3dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279500;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=G+5BF49ou0ARRWxKFvfp1ZFgtF67xapc/rlFrqYl8VA=;
	b=bmpHM/TQ4hzgIfc06hV11NbDgdbiOZaDO/kjvH0As8fHjq2u+vkh8xUMD3TTNDF3vbJY
	 EbIm8XP4jQtrLpflNLueoEBh6P3wBNN8GIyIhqz9AND5eWerCARN+3gkBhlKRbxiCTnhI
	 e7eAP0wzi2DG44u/rFmFhqrR022HwswnZ8ZcBnKNVgcmiHXr3UfRY/wrrY/MhL3rfmAlf
	 VKtN4S6g/lpXOdRbFR1OwpwbVkLbdp6pw79naFB+it4+XuVC3IYMmWy6RrcRbtHdzx0om
	 KHslx48ny9BhpcXn4W8SO+f6vOBT/7w68z90dMbQz5VPYEl/GAhR668NzLtAoZZGbzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1A606A323;
	Thu, 29 Oct 2026 13:11:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C631F031E0;
	Thu, 29 Oct 2026 13:11:36 +0000 (UTC)
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
Subject: [PATCH 5/9] dt-bindings: clock: renesas,r8a78000-cpg: Add CAN-FD clock
Date: Thu, 29 Oct 2026 14:11:06 +0100
Message-ID: <843d6df21b3ed139ec71a702e57fd5b516c139a1.1793278754.git.geert+renesas@glider.be>
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

Add a definition for the CANFD_SCP_MAIN clock, as used by the Controller
Area Network Flexible Data Rate (CAN-FD) modules on R-Car X5H.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "[PATCH 07/11] dt-bindings: clock: renesas,r8a78000-cpg:
Add PWM clocks"
https://lore.kernel.org/e723696e02cfb34fb808e2ae3ccb6faf68528c00.1793026273.git.geert+renesas@glider.be
---
 include/dt-bindings/clock/renesas,r8a78000-cpg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/renesas,r8a78000-cpg.h b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
index 8c30476d41448cf5..9d7f3afcb2c52ec4 100644
--- a/include/dt-bindings/clock/renesas,r8a78000-cpg.h
+++ b/include/dt-bindings/clock/renesas,r8a78000-cpg.h
@@ -31,5 +31,6 @@
 #define R8A78000_CPG_SGASYNCD8_PERW_MAIN	21
 #define R8A78000_CPG_SGASYNCD16_PERW_MAIN	22
 #define R8A78000_CPG_S0ASYNCD8_PERW_MAIN	23
+#define R8A78000_CPG_CANFD_SCP_MAIN		24
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R8A78000_CPG_H__ */
-- 
2.43.0

