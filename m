Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026556;
	b=yW8kkh1EJCy5UqkzCLdTbPy2ND8xxvIYW5TfQ0NJy71H1XZUc5+ql1YVhM/nFtIORM0S
	 7o9tkttJd5j9gYzu5eh6mQsvccqbgi6NdecNc6keuH8Gk/SdTvyG2r0RCzYDFuqn55qwK
	 SOqS44c1jNX24Qje9Rx6J3XZMylXAKPPQPV9nz3l99CslqKn+AK+I2iToGclu14iOhRwC
	 V3txMvo191qJytxOyocj2wygezDuZQtgWuO889p59R6+JE+3BXGpFeebV7PxFltLUAt+k
	 Oskv+2B1lHGhxYDnKE31DxCewPNaooTLvoBUA85x0xyeAS5fdFv7Ai9HpIM8Y0gD4XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026556;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Fj8cRFNdTuS88avz+KuVmikpDiQtONWEEH1nURlLM7Q=;
	b=3Dbw9fb6VxqZ01PvJC4JkFND30jEvBLRVULMgYAEZoyuXdfzIlkyt7b992Q57sZdKzpK
	 x46Ygyry6AJObx04Z46wLu9zVoJJnlq6oLwr2KpSm4DZoblddbzMO32FapBO8lNvcvbMy
	 kbOl/gAiGL2tnfGgBHDdlc8/GcMIglJDh4RlXr/K+b0KATQQobLZ5Jj1QVd8G/PFCHwFG
	 DKxXJ+794h0qAfEy8GKIJm4vh/WNB9xPD/+O5GIDvwYVmZ++Ja66INbvbLbtm53d+2uZY
	 Sxind97iAgZnc0LMxNruza/yXt6iVJsutZgQ1fcoFtTPN/TjimmNt4smEu64qQNGDHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1872606A31E;
	Mon, 26 Oct 2026 14:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32871F01828;
	Mon, 26 Oct 2026 14:55:51 +0000 (UTC)
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
Subject: [PATCH 05/11] pwm: rcar: Parametrize cycle counter field size
Date: Mon, 26 Oct 2026 15:55:21 +0100
Message-ID: <a11daddd0c005d9bdf2b36e3b8b93720f1da4f55.1793026273.git.geert+renesas@glider.be>
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

Prepare for the advent of PWM blocks with output cycle and high-level
period fields larger than 10 bits by parametrizing the field size.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 51 +++++++++++++++++++++++++++---------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index f1f68bfe016f729f..3813094c601efc8c 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 
 #define RCAR_PWM_MAX_DIVISION	24
-#define RCAR_PWM_MAX_CYCLE	1023
+#define RCAR_PWM_MAX_CYCLE(rp)	GENMASK(rp->cycle_bits - 1, 0)
 
 #define RCAR_PWMCR		0x00
 #define  RCAR_PWMCR_CC0_MASK	GENMASK(19, 16)
@@ -32,14 +32,17 @@
 #define  RCAR_PWMCR_EN0		BIT(0)
 
 #define RCAR_PWMCNT		0x04
-#define  RCAR_PWMCNT_CYC0_MASK	0x03ff0000
-#define  RCAR_PWMCNT_CYC0_SHIFT	16
-#define  RCAR_PWMCNT_PH0_MASK	0x000003ff
-#define  RCAR_PWMCNT_PH0_SHIFT	0
+#define  RCAR_PWMCNT_CYC0_MASK	GENMASK(31, 16)
+#define  RCAR_PWMCNT_PH0_MASK	GENMASK(15, 0)
 
 struct rcar_pwm_chip {
 	void __iomem *base;
 	struct clk *clk;
+	unsigned int cycle_bits;
+};
+
+struct rcar_pwm_info {
+	unsigned int cycle_bits;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
@@ -77,7 +80,7 @@ static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
 	if (clk_rate == 0)
 		return -EINVAL;
 
-	div = (u64)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE;
+	div = mul_u32_u32(NSEC_PER_SEC, RCAR_PWM_MAX_CYCLE(rp));
 	tmp = (u64)period_ns * clk_rate + div - 1;
 	tmp = div64_u64(tmp, div);
 	div = ilog2(tmp - 1) + 1;
@@ -111,21 +114,19 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
 
 	/* div <= 24 == RCAR_PWM_MAX_DIVISION, so the shift doesn't overflow. */
 	tmp = mul_u64_u64_div_u64(period_ns, clk_rate, (u64)NSEC_PER_SEC << div);
-	if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
-		tmp = FIELD_MAX(RCAR_PWMCNT_CYC0_MASK);
-
-	cyc = FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, tmp);
+	cyc = min(tmp, RCAR_PWM_MAX_CYCLE(rp));
 
 	tmp = mul_u64_u64_div_u64(duty_ns, clk_rate, (u64)NSEC_PER_SEC << div);
-	if (tmp > FIELD_MAX(RCAR_PWMCNT_PH0_MASK))
-		tmp = FIELD_MAX(RCAR_PWMCNT_PH0_MASK);
-	ph = FIELD_PREP(RCAR_PWMCNT_PH0_MASK, tmp);
+	ph = min(tmp, RCAR_PWM_MAX_CYCLE(rp));
 
 	/* Avoid prohibited setting */
 	if (cyc == 0 || ph == 0)
 		return -EINVAL;
 
-	rcar_pwm_write(rp, cyc | ph, RCAR_PWMCNT);
+	rcar_pwm_write(rp,
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, cyc) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, ph),
+		       RCAR_PWMCNT);
 
 	return 0;
 }
@@ -142,12 +143,15 @@ static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
 {
-	u32 value;
+	u32 value, cyc, ph;
 
 	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
 	value = rcar_pwm_read(rp, RCAR_PWMCNT);
-	if ((value & RCAR_PWMCNT_CYC0_MASK) == 0 ||
-	    (value & RCAR_PWMCNT_PH0_MASK) == 0)
+	cyc = FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value);
+	ph = FIELD_GET(RCAR_PWMCNT_PH0_MASK, value);
+
+	if ((cyc & RCAR_PWM_MAX_CYCLE(rp)) == 0 ||
+	    (ph & RCAR_PWM_MAX_CYCLE(rp)) == 0)
 		return -EINVAL;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_EN0, RCAR_PWMCR_EN0, RCAR_PWMCR);
@@ -202,11 +206,16 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	const struct rcar_pwm_info *info;
 	struct device *dev = &pdev->dev;
 	struct rcar_pwm_chip *rcar_pwm;
 	struct pwm_chip *chip;
 	int ret;
 
+	info = of_device_get_match_data(dev);
+	if (!info)
+		return -ENODEV;
+
 	chip = devm_pwmchip_alloc(dev, 1, sizeof(*rcar_pwm));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
@@ -222,6 +231,8 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
+	rcar_pwm->cycle_bits = info->cycle_bits;
+
 	chip->ops = &rcar_pwm_ops;
 
 	platform_set_drvdata(pdev, chip);
@@ -247,8 +258,12 @@ static void rcar_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
+static const struct rcar_pwm_info rcar_pwm_info = {
+	.cycle_bits = 10,
+};
+
 static const struct of_device_id rcar_pwm_of_table[] = {
-	{ .compatible = "renesas,pwm-rcar" },
+	{ .compatible = "renesas,pwm-rcar", .data = &rcar_pwm_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
-- 
2.43.0

