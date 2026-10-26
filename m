Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026552;
	b=Hnvnw0f4fG/gcv5W6O+P0vzjIXj+JyfHAigv4DMotid/BMAmgJdbgMmxynKnvZBcKuKC
	 14+hryy9nZ6ZOQyrL8u1G0dGneteBZJpvUIIRzDHI9RY7AreSlYwBI8aqLL5k1IXDQYyC
	 nWguJt62hKKXuW7tNFONgPImE6NaqqiTt/W/ZvdH9+dW3o8A8/xoPkWgsZGOkFqKzxZ5H
	 RnRX9amJqSZ3gJOgC/u7Y/SCZ4D31MnFd9bvGFpqb9LfH+7/Wu279yKg3MzS+dbTOtHLz
	 4ZGs5FzDSA4s0Qlu8G85iL0MDCz2UbLpgJcEb0Lha85sAFHVi+KPPRXR9+EeKQH8wxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026552;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=Dnm/tcUJmHvrsoD+AO8fIj+Ywcx6TXnaqfDc8lUuFK0=;
	b=mhy5owxq7G0pGg1MJj1FzhCHmdjmkmKgEiDTvQcbWLTkSaOcm//OsgsN/gWVP4IvYgd7
	 ihU2E2ptXfKyR31AoLI9xDIFYbjEHo3Ey3y8QAR3X1TH3fUu3Zjqpzw+BJh5M/YjehY74
	 nHV4RWmPfGmTaa/bD3jltRnhjkYOXn/q/8y8ZVzBfw8zUxcMtGODfossA97JNxLcvCpmf
	 8mFF9N1NJxgv/2NWSQQqRnNIANishM3w+nx2KMyQUYx3GzfPBmmrAhEZPTM5HEsU6Xe6G
	 6gJZ91MVa6qH/whbow1w/B5tZjVnRxlxso09280D8cRXzI9trcmxRZy7FXYurmi8tPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19A606A31B;
	Mon, 26 Oct 2026 14:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91871F01825;
	Mon, 26 Oct 2026 14:55:47 +0000 (UTC)
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
Subject: [PATCH 04/11] pwm: rcar: Add helper variable dev to rcar_pwm_probe()
Date: Mon, 26 Oct 2026 15:55:20 +0100
Message-ID: <05d7b0c93b90f1d9d7dd3a54eb4c299b9b40442e.1793026273.git.geert+renesas@glider.be>
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

rcar_pwm_probe() has many users of "&pdev->dev".
Introduce a shorthand to simplify the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4641f258df531baf..f1f68bfe016f729f 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -202,11 +202,12 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
-	struct pwm_chip *chip;
+	struct device *dev = &pdev->dev;
 	struct rcar_pwm_chip *rcar_pwm;
+	struct pwm_chip *chip;
 	int ret;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*rcar_pwm));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	rcar_pwm = to_rcar_pwm_chip(chip);
@@ -215,9 +216,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(rcar_pwm->base))
 		return PTR_ERR(rcar_pwm->base);
 
-	rcar_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	rcar_pwm->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(rcar_pwm->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
+		dev_err(dev, "cannot get clock\n");
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
@@ -225,12 +226,12 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
-		pm_runtime_disable(&pdev->dev);
+		dev_err(dev, "failed to register PWM chip: %d\n", ret);
+		pm_runtime_disable(dev);
 		return ret;
 	}
 
-- 
2.43.0

