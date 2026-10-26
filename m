Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026548;
	b=FRucNsDWjFMDnvuin7g20ZdVRQ+aE6UrbbefeN27WIVnEj+NaZ1aUx7n8aNbzL3fylim
	 +hMZiCk5KnSxVvP9bX3YwdFIrxP+reux3dRUpG2D7K8l+9KQ1NSDtDdktMN99VgKXh8tE
	 JzsirvpKaoKRVlbccLIaeKOGeIeNFLRAw4l0FHNPe5Ry93SHyQc740A0fMamk7K8AZNZb
	 lj+X1A5gEJECsYGGmVMuYgJ/7py/Ad9Xiytat6nSOUpdEIbqx+Ml50L61KyOf3jCbuSXJ
	 IYPAUr7d/Ht6CE+IQ2bNNmUFutHh9/dnZ9q76XxOs8cbf5nDf2WMsG7Iz5Pupvi7Oew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026548;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=qTszvocLaYOpsjYueDSx5WsodbShfzlk4+GQlonfBSM=;
	b=UC0lf3cZetydwlDsn50tGJDdy+0XzvnJJ6R/Us9vPbzAV9dWmvtyPSz3sQZKRoMuOvFG
	 CEoN37TNd8arEGzZHoJElNl2fYFhOxpIjVwl6t8GluKluNRV6oCXOi7J3DpEOg9bYnbAG
	 4oE2MwumeQE/imtaKbC9/hSu21j88R4ncpYCtFooxCYlBPzEjGugFgKlQETre3ts03J/n
	 K4edbtdTcstXQzJddjE0Lv2w7Uo0tYz+hE6QzcUnzjE6JGk2UWaXObvlm/v1f6xzu4Sv2
	 49f45sH0Zq5YDQucWjvfaRyn5RUMnMDxago6O7+hklgmQeijNm+RrSfhhIwY7v9kbsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E4606A31A;
	Mon, 26 Oct 2026 14:55:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F891F031E4;
	Mon, 26 Oct 2026 14:55:43 +0000 (UTC)
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
Subject: [PATCH 03/11] pwm: rcar: Use FIELD_PREP() for PWMCR_CC0 access
Date: Mon, 26 Oct 2026 15:55:19 +0100
Message-ID: <3bc3726cfb6e59c378500a63fd5e52a6f0f8cf5c.1793026273.git.geert+renesas@glider.be>
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

Use the FIELD_PREP() helper instead of open-coding the same operation.
Drop the now unused RCAR_PWMCR_CC0_SHIFT definition, and redefine
RCAR_PWMCR_CC0_SHIFT using GENMASK() while at it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1733cd700693713e..4641f258df531baf 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -25,8 +25,7 @@
 #define RCAR_PWM_MAX_CYCLE	1023
 
 #define RCAR_PWMCR		0x00
-#define  RCAR_PWMCR_CC0_MASK	0x000f0000
-#define  RCAR_PWMCR_CC0_SHIFT	16
+#define  RCAR_PWMCR_CC0_MASK	GENMASK(19, 16)
 #define  RCAR_PWMCR_CCMD	BIT(15)
 #define  RCAR_PWMCR_SYNC	BIT(11)
 #define  RCAR_PWMCR_SS0		BIT(4)
@@ -99,7 +98,7 @@ static void rcar_pwm_set_clock_control(struct rcar_pwm_chip *rp,
 
 	div >>= 1;
 
-	value |= div << RCAR_PWMCR_CC0_SHIFT;
+	value |= FIELD_PREP(RCAR_PWMCR_CC0_MASK, div);
 	rcar_pwm_write(rp, value, RCAR_PWMCR);
 }
 
-- 
2.43.0

