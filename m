Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777970;
	b=3hIip702XJCycsE0xhH/+FbN4jxc/CKXKDwCwQz1JaqdV1MPjjytbhIKOS15Y6rggMhZ
	 FNbLMsDWQvsS+yliyXJexkG4fUC6128l8ufMpM1qvFiuKXED+OhItPgPO+PbdHaebesXz
	 DZdp9KTzXmLWeVEZUxStLbDnjGFwiiTBql0wq946fEs17jyL1YBjf2bgfajbmnE9YQ3C6
	 5lrITu0NfmvHksTF9UzMwXDkmqb3Fkh2Hw0jmVN/xWWKO+Ol50o4d5mvjmBr4vMRho8Hf
	 Qto7cW9Ft8Ll7gbXySoWQRr4qeD5v5a7TuQ9xD7gaf9OxzoIuI8c4tVBUGXZrU1SDFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777970;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=9ebQlmYnQSHGBUB7xnm9z1TcIdbICsKNFrt5czGiFFU=;
	b=02NHh9uEq8V9QkdhD6fyMvumQ99j5IBN84s4D8HP3XWhPiO5yptT0KSoSqxWAPzeF14p
	 1Dp2Xf7aFCwdqfknHSGXobEfkv2mGt8wwWOQeyAQdKwQjXpUgv+IDGfXLJY0owllu/Z24
	 peWaRpEZgG6Y5RJZo0xHwoMWskX9ztSKnakPPbx3+AaY6oLfFqJAbR0n8c9Jws1Tq+rjM
	 UmVGmdOQcZ/VK2vcqZp8wIEhB7nMXuy92Wd1wkqlxgrZucENLkSurG8pAnoDyKwNkL/ZT
	 XC3Jo117Ww5h3E3ify0MfNF0GMCXofXEt1qxkfChhDtiYHdkr55yaGeauIqso9F6QWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2F606A31B;
	Fri, 23 Oct 2026 17:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5412A1F01829;
	Fri, 23 Oct 2026 17:51:47 +0000 (UTC)
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
Subject: [PATCH 1/7] gpio: rcar: Convert to gpiochip_generic_{request,free}()
Date: Fri, 23 Oct 2026 19:50:39 +0200
Message-ID: <528b079a19bd4043754bfb56db8e5950bdda62f6.1792776697.git.geert+renesas@glider.be>
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

When a gpio device node has no gpio-ranges property,
pinctrl_gpio_request() returns -EPROBE_DEFER and its GPIOs are unusable.

Restore the ability to use GPIOs before pin control support is added by
using the gpiolib helpers instead, which cater for this use case.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpio/gpio-rcar.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 54dc47d45de7e861..1192e1f1c6db8433 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -15,7 +15,6 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
@@ -309,7 +308,7 @@ static int gpio_rcar_request(struct gpio_chip *chip, unsigned offset)
 		return error;
 	}
 
-	error = pinctrl_gpio_request(chip, offset);
+	error = gpiochip_generic_request(chip, offset);
 	if (error)
 		pm_runtime_put(p->dev);
 
@@ -320,7 +319,7 @@ static void gpio_rcar_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_rcar_priv *p = gpiochip_get_data(chip);
 
-	pinctrl_gpio_free(chip, offset);
+	gpiochip_generic_free(chip, offset);
 
 	/*
 	 * Set the GPIO as an input to ensure that the next GPIO request won't
-- 
2.43.0

