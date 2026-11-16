Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794832879;
	b=ceY6wx/ViaAcVUB2MrKbDm2Zk26rqcCZjd5AO2LbuDuLMIP+YdOxhKb017U+87fL3MQP
	 5duf4qwe9FlAdlSq1a0/0b9i2E/hVMRCoWb2iS5vwuQB1r8T38Bq8I5FowZDyhuEfFSkr
	 6Kj10Fc/DKKvQR+PDD2woG9mB0iDt7AcuUHNiny2DR8+AiSIRE48FzlP7lmqlhwh7sjsN
	 V1OvM6ES+F927s5XAYmM2lT0e/UOc+ADYALXSsiEjuX+sKcH/PMgDqUoIabEukYn2X5Zq
	 SiTQRv2bmTi89njXbP0COJXbelqMZR4ayhkI2i/5Eyfd8hJJj71AGfjUAFXgu47XXaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794832879;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=B0s2EswTA+rUV5czJyyzCHyu5NeCkNsQpbNM91ynRNc=;
	b=LbtuYwahPS0wSwfmQSKCzUihfC8tbEvjjiDOOlYbYuaobFMwOspMrvy9jaxRrLXQk+6G
	 rVD771puie/AOG4KHmKMJFwNUz9zbOQeeIyQcGA5cItSY19fAw6OmSWHsJsD66/g026d+
	 sODAN06P4rJNUcH7OcAJfrxBqvQD5D3grDdae9DjQltLPk/bxm8ed3ggjG4dzRwC5xeb5
	 eqpVOKNQOpagb44/VGsX4A2iuQZtivamhAZY8AV996OB/Pfwc5ZdFfWkOxHKC3/SI5B/F
	 8MT7GovvwTcneKuIS+jDM1eR7ijJ8zJMN03JmLVvBYfuokUqUHb3fW0AeP8FLpON0lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW1EDcCI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C8D606A31C;
	Mon, 16 Nov 2026 12:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW1EDcCI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8301F000C4;
	Mon, 16 Nov 2026 12:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794832879;
	bh=B0s2EswTA+rUV5czJyyzCHyu5NeCkNsQpbNM91ynRNc=;
	h=From:To:Cc:Subject:Date;
	b=JW1EDcCIu4pSSbHCGghi9ltT95bCuG0dQyeLthSofo2MYQfyP+L30GlA6sZVyW6V6
	 y7kNip8kZIzf6N2PRvcXi6lmUorxb5aEn3cVlv0USpLy4mbSIGsYlJ/1cNgjL4lz6a
	 2VZUMYMI9LmMqHKlYY8mrI2rZg4PnUP0F4ZjG6WKqpkgQWpitcY6xG00e5A9wTB1B9
	 B3SG0vjFag/ZYX6zlL3EdDv1v/s08zf7Y8pGjmumkfD9hQT5Gn1GIKpjpG5FwYOxdX
	 s+uBf8zjfv19ht/0pqqKcT6QRK3+jBRELvbjuG2L+dWNCFf5KVo2CkaCnBorgSZQKS
	 QrkDFt6O5rEgg==
From: Sasha Levin <sashal@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Xu Rao <raoxu@uniontech.com>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-pm@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: gpio-charger: mark gpio_charger_properties as __maybe_unused
Date: Mon, 16 Nov 2026 07:41:17 -0500
Message-ID: <20261116124117.2922333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Commit fad4655224f60 ("power: supply: gpio-charger: Keep properties per
device") keeps gpio_charger_properties[] only to size the per-device array
with ARRAY_SIZE(). clang sees that the array itself is never emitted and
warns, which fails the build with CONFIG_WERROR:

  drivers/power/supply/gpio-charger.c:26:35: error: variable 'gpio_charger_properties' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]

Mark the array __maybe_unused.

Fixes: fad4655224f60 ("power: supply: gpio-charger: Keep properties per device")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
fad4655224f60 is the tip of power-supply's for-next.

 drivers/power/supply/gpio-charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/gpio-charger.c b/drivers/power/supply/gpio-charger.c
index c90c824382c62..647f5bde38c7c 100644
--- a/drivers/power/supply/gpio-charger.c
+++ b/drivers/power/supply/gpio-charger.c
@@ -23,7 +23,7 @@ struct gpio_mapping {
 } __packed;
 
 /* This list ensures, that the array is big enough for all optional features. */
-static enum power_supply_property gpio_charger_properties[] = {
+static enum power_supply_property gpio_charger_properties[] __maybe_unused = {
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,

base-commit: fad4655224f60328cc9bcf4399eda8f6d7a587a6
-- 
2.53.0

