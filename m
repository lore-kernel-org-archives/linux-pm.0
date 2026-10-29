Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279492;
	b=IiM8DVdinm2OT/FPFwVRvR29PzDSDwtlVXhvMNH3oHeJszN8hjFjB4p79PsQGRYjwrUT
	 IP191fzMtR8NtDY8Rab7kDM4XOYq9xmzQJdf11RE7Qevx/q0w6zuWyyWtJnC7Ma8NXo4f
	 1+ADHinz4nWmAjqL88qrdRftSx54z/kv+uKSwFGAuGBK39C6R/jwt11VsJR43V7CiZXr4
	 pFq3vTN3UYgFPz2JXhHGOQPxo6x1jnz69esdsYEIj9LnZ3SzyPRBtvIO6Iu1HiHCZBHVH
	 xQ0GRtgbmNZsGqIFFmx+CbbPbA1h5OKBG9ihppiYWTPZlwBwWB/oFxMKdLfrvfssCHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279492;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=TacSadf5vVdafv1GWEGVsOyle84bCFtG5lLBQAWeJf0=;
	b=x0dw+2JgOYy1O76WjhYQ22Fy5E40O6w13GNsCBsUWl9CRLPHBII3h4fV/tlLzYTQH+x3
	 KKf3cpPeFqKRunj39+Kz9kajg7AgWsie89IdqMB5WdTR/MbE10BGSBcj4ttS3y/WzS9bx
	 ZJwmBimeY1mS9GeiHJ7DdO7dY/2bDvsgNrJSF1wjSZJDDTz/YoP85CJ7EoybSmjWHQZlA
	 hTnhYQ/QEuMH11rbgfwpMZr5W83r5ApYrA6DD74l0Oc+N84d/cUJhGFcxGFNPqGirEdJv
	 v0n0EoTCtRY4VbpZDiS57lIj2OUek5YeUIUZl+vcxsCdOJISGVVbmUpe6uxIHgVPwfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF33606A321;
	Thu, 29 Oct 2026 13:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EAD51F031E2;
	Thu, 29 Oct 2026 13:11:28 +0000 (UTC)
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
Subject: [PATCH 3/9] can: rcar_canfd: Make clkp local
Date: Thu, 29 Oct 2026 14:11:04 +0100
Message-ID: <415c8b26718e2e5d53f74e65daedf9986c76dcfe.1793278754.git.geert+renesas@glider.be>
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

The peripheral clock is only used in rcar_canfd_probe(), so convert clkp
to a local variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 74d9ffd2790587b9..9dbe44710dcced80 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -467,7 +467,6 @@ struct rcar_canfd_global {
 	void __iomem *base;		/* Register base address */
 	struct rcar_canfd_f_c __iomem *fcbase;
 	struct platform_device *pdev;	/* Respective platform device */
-	struct clk *clkp;		/* Peripheral clock */
 	struct clk *can_clk;		/* fCAN clock */
 	struct clk *clk_ram;		/* Clock RAM */
 	unsigned long channels_mask;	/* Enabled channels mask */
@@ -2111,6 +2110,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 	bool fdmode = true;			/* CAN FD only mode - default */
 	char name[9] = "channelX";
 	u32 ch, fcan_freq;
+	struct clk *clkp;
 	int i;
 
 	info = of_device_get_match_data(dev);
@@ -2181,9 +2181,9 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 				     "failed to get rstc_n\n");
 
 	/* Peripheral clock */
-	gpriv->clkp = devm_clk_get(dev, "fck");
-	if (IS_ERR(gpriv->clkp))
-		return dev_err_probe(dev, PTR_ERR(gpriv->clkp),
+	clkp = devm_clk_get(dev, "fck");
+	if (IS_ERR(clkp))
+		return dev_err_probe(dev, PTR_ERR(clkp),
 				     "cannot get peripheral clock\n");
 
 	/* fCAN clock: Pick External clock. If not available fallback to
-- 
2.43.0

