Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026560;
	b=MtApuWDFRPCvbVTlxmeoULYJMUOi9z3ghCnO/ZrZXG/563dl4O4Twuuy8tRZRh4I5nE0
	 RxVBtBEAzOJpKJwcvsrcxfUcMHpJ4GbOeOG9D/DrvHWlEqvvZAtH+V/zzcytv0r2FVkQa
	 erBhTcUevCzeijZKWmRvoYrkWfYDddkb34aMtVNHpvNpjhbazJeEQszCCpUJYLAwTOOBZ
	 igCbNWEa+iJTd8O/U8l381K9F5B7pXxE4tARhiv4heCAZVripdIDCnmAs9vCoxanErIAZ
	 I5vM27JKI+bJ1JC5wGuryfBCmL2u555QdmkgVfHlytEgNajnuXB70bOw9SvjgH8lvPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026560;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=44CTiA7A49EJN2VY0UCM0Rmoy6mh9PnJJvTxNQQxTx8=;
	b=SUKn6jAZg/ncYFYW7nm6A/BBA2KCLNzdOHdq9w0yney0ozJKo7yHesbf0SLmrSaaHlKN
	 bMbDVI5Flnrjhx3AW8Pmba4jwq7N/jnTrkkhfgYYRlCDRLDLKujxY2SM/G2k8iXkP0JBB
	 1QVh78enycSn5Oc1Fex11HJynVoxq+29gzCvOZn66zAa36U8sZgW9MKMfGRFpcMYKCzgS
	 UFxbrO0vIvjtj704Cy7Y/aqaXAFI7+LdReAoQeMTwNlqjxuI8rI3MM99ieA8c3Fls0daJ
	 O4mGvjqICWkBT0MNv8RLimc8TmkavlcdIiOkFfMjXw6RRMgjiIAMRhQYIDLfj7/rbGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AF606A31D;
	Mon, 26 Oct 2026 14:55:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6B11F01829;
	Mon, 26 Oct 2026 14:55:55 +0000 (UTC)
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
Subject: [PATCH 06/11] pwm: rcar: Add support for R-Car Gen5
Date: Mon, 26 Oct 2026 15:55:22 +0100
Message-ID: <f09a095ee5128c94c5dd1dadb71e655ec9dac658.1793026273.git.geert+renesas@glider.be>
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

R-Car Gen5 enlarged the PWM output cycle and high-level period fields
from 10 to 24 bits.  The high parts of each field are stored in a new
register.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 3813094c601efc8c..5e91509de7a7c162 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -31,7 +31,8 @@
 #define  RCAR_PWMCR_SS0		BIT(4)
 #define  RCAR_PWMCR_EN0		BIT(0)
 
-#define RCAR_PWMCNT		0x04
+#define RCAR_PWMCNTA		0x04		/* Low part */
+#define RCAR_PWMCNTB		0x08		/* High part (R-Car Gen5) */
 #define  RCAR_PWMCNT_CYC0_MASK	GENMASK(31, 16)
 #define  RCAR_PWMCNT_PH0_MASK	GENMASK(15, 0)
 
@@ -124,9 +125,15 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, u64 duty_ns,
 		return -EINVAL;
 
 	rcar_pwm_write(rp,
-		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, cyc) |
-		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, ph),
-		       RCAR_PWMCNT);
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, lower_16_bits(cyc)) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, lower_16_bits(ph)),
+		       RCAR_PWMCNTA);
+
+	if (rp->cycle_bits >= 16)
+		rcar_pwm_write(rp,
+		       FIELD_PREP(RCAR_PWMCNT_CYC0_MASK, upper_16_bits(cyc)) |
+		       FIELD_PREP(RCAR_PWMCNT_PH0_MASK, upper_16_bits(ph)),
+		       RCAR_PWMCNTB);
 
 	return 0;
 }
@@ -146,9 +153,14 @@ static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
 	u32 value, cyc, ph;
 
 	/* Don't enable the PWM device if CYC0 or PH0 is 0 */
-	value = rcar_pwm_read(rp, RCAR_PWMCNT);
+	value = rcar_pwm_read(rp, RCAR_PWMCNTA);
 	cyc = FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value);
 	ph = FIELD_GET(RCAR_PWMCNT_PH0_MASK, value);
+	if (rp->cycle_bits >= 16) {
+		value = rcar_pwm_read(rp, RCAR_PWMCNTB);
+		cyc |= FIELD_GET(RCAR_PWMCNT_CYC0_MASK, value) << 16;
+		ph |= FIELD_GET(RCAR_PWMCNT_PH0_MASK, value) << 16;
+	}
 
 	if ((cyc & RCAR_PWM_MAX_CYCLE(rp)) == 0 ||
 	    (ph & RCAR_PWM_MAX_CYCLE(rp)) == 0)
@@ -262,8 +274,13 @@ static const struct rcar_pwm_info rcar_pwm_info = {
 	.cycle_bits = 10,
 };
 
+static const struct rcar_pwm_info rcar_gen5_pwm_info = {
+	.cycle_bits = 24,
+};
+
 static const struct of_device_id rcar_pwm_of_table[] = {
 	{ .compatible = "renesas,pwm-rcar", .data = &rcar_pwm_info },
+	{ .compatible = "renesas,rcar-gen5-pwm", .data = &rcar_gen5_pwm_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
-- 
2.43.0

