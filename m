Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279496;
	b=yCDYo8PMmM/plaD1tFhBaD2rFepYyLhsHT8+657ay4bwx9N1lFr4gz+G2zoyUclvq/R9
	 A78ABWmtNBsxQY1T8/ogZ9KcYr4xsvsmRSJpuV9j93gBvRRuT338Hd/GLUxbr6NdIB9tH
	 1GRwgjuIvJL1msCeQQP0RTTfmtF9eoB0t2MM5nxqPiJEV0TvP+UKlCMq8gfR3ftrmDDP0
	 175yhEocFkw86IC0R2X8DHFsfYQ+N72NL4UeGdW9wsngB+gk7j+AAplOaGUmiDQ5T+iIm
	 rXzNEXG2uyxK5jXAEZlWpJnnYb3IHI7TY2sFY40kCi2q75vfF81SHBDqMIFxo4/aHfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279496;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=UUqeGT/89ZU6Y+fkarnYEZGHmF+apa7zJQAL+t56Yiw=;
	b=XFWdw8BRM8SOc73EtG+cUWWmKKkxsauM7vieClQSSNocBZXYJh/kQ8CqY0M8IzaOwl0s
	 CCx8QrdweiCvwMHumbQC5B6oM273O/nbnbqlLRx2ckEmmU2rRNf4FCZq8c3QHFNtsrZ8D
	 xC14Cw08VA1FXN8CknjZUUa92Phz59RrDxFXnNbO2R2joYd3XzdiDiC/sKYW1rHRAk0Xu
	 XkVifh8/73bl+F+p4QDhQizWm4VXWEavZueT7d9GgI5g1nMDOp0hVmhYMxpfhSkWHU8Qn
	 p2llIzf4TRtCNbd6+/4uPCTKqikZ3rg1DYvo+VmDZ47Z1EtO1RLQFRenumh4qc8U2ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60E606A31D;
	Thu, 29 Oct 2026 13:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 886D91F031E3;
	Thu, 29 Oct 2026 13:11:32 +0000 (UTC)
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
Subject: [PATCH 4/9] can: rcar_canfd: Add support for R-Car Gen5
Date: Thu, 29 Oct 2026 14:11:05 +0100
Message-ID: <2f986484ade3f3ab7785a088b476b4bc6f53c157.1793278754.git.geert+renesas@glider.be>
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

The CAN-FD block on R-Car Gen5 is similar to the variant on R-Car Gen4,
but uses split global and per-channel interrupts, like on RZ/G2L.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/can/rcar/rcar_canfd.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 9dbe44710dcced80..702a3aa1949ab9da 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -636,6 +636,23 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.external_clk = 1,
 };
 
+static const struct rcar_canfd_hw_info rcar_gen5_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 127,
+	.max_cftml = 31,
+	.max_channels = 8,
+	.postdiv = 2,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+};
+
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen3_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen3_data_bittiming_const,
@@ -2370,6 +2387,7 @@ static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
 	{ .compatible = "renesas,rcar-gen4-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,rcar-gen5-canfd", .data = &rcar_gen5_hw_info },
 	{ .compatible = "renesas,rzg2l-canfd", .data = &rzg2l_hw_info },
 	{ }
 };
-- 
2.43.0

