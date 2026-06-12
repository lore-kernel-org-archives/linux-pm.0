Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A53845AE;
	Fri, 12 Jun 2026 21:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301194; cv=none; b=tcNHbiaqofr4uulojgGRBN6mTjsc4F/V3NbwkJ76pky+ZEIg1Owi+eqbx3BbVAPa7OMXzAQ0qWlVJeF/WYCTaG3u9s6xOhOmfxAhNVweu/44YBnCf82ugGd2XjlPhaxU4GZyFRyi1hv87nSsSfyo4tErrH2G/Cr35hWRSI8/cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301194; c=relaxed/simple;
	bh=dCAnpuvyD2IyZrao13e99zC8+VY5IMho1p+xEUxoHvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CW45LaoCbPzm6SZDqKKOCgcQAG42hJquWsjzBMKvf/xsMfDxJ8LG3+q9qW+OTt4xT/rOdw/VYPMOWy1nN7RHlupnP9gz3enRUnw7sUHSHdSnK12vvKntaXQGpGqKqEB6w+H2Qwmdhf1gcW1fVwoN4tcMuc2KWHL+4kHDNK0ZQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGt3qo/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGt3qo/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A417F1F000E9;
	Fri, 12 Jun 2026 21:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301192;
	bh=z2e7a3ryZdKiJp/+tDBJEWLYN2Yda8epBWeDjBRhOC4=;
	h=From:To:Cc:Subject:Date;
	b=PGt3qo/9P3pN32AVJfa4NKgDfcCIuvZ48dRfbt19Nz1EaAwMww7KbJVutxUDvRGYd
	 Hr6gRkN8tn6KyJ1bxbgeqBtfYREQtnd4SkDGHoqLL9lxhVmQBWzX51XIySJxc7Fxrj
	 pms4lkm4FjiJawdAOfBaIgTT8zq4LTpo4YfuxsHIsuhvZ9ecPfveiHhHfKnUoMiPIa
	 iClJcFO1/jurel2pf1Yw98u/kszn+dZqD5EB1wUUBLYgeqfDO21QmjwFfy7HA61cPo
	 NRBatlUfkoR4w0oMnUvZX0Nq5EKvS8g85ut7aUg5jjkyJNT3Cwn3O+BRtRe7E/S+OD
	 zplY7IQNqbgeA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: Match DT value types
Date: Fri, 12 Jun 2026 16:53:07 -0500
Message-ID: <20260612215308.1888834-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The battery drivers read properties whose bindings use signed values
for temperature thresholds and unsigned values for voltage thresholds.
Some helpers used the opposite signedness, which makes property type
checking report real mismatches.

Use signed helpers where the binding and DTS allow negative values, and
use unsigned helpers for voltage properties documented as uint32 cells.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/power/supply/ltc2941-battery-gauge.c | 2 +-
 drivers/power/supply/max17042_battery.c      | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ltc2941-battery-gauge.c b/drivers/power/supply/ltc2941-battery-gauge.c
index a1ddc4b060ce..83cca11e92f6 100644
--- a/drivers/power/supply/ltc2941-battery-gauge.c
+++ b/drivers/power/supply/ltc2941-battery-gauge.c
@@ -463,7 +463,7 @@ static int ltc294x_i2c_probe(struct i2c_client *client)
 
 	/* r_sense can be negative, when sense+ is connected to the battery
 	 * instead of the sense-. This results in reversed measurements. */
-	ret = of_property_read_u32(np, "lltc,resistor-sense", &r_sense);
+	ret = of_property_read_s32(np, "lltc,resistor-sense", &r_sense);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret,
 			"Could not find lltc,resistor-sense in devicetree\n");
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 167fb3fb3732..6609cd74e5d3 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -967,10 +967,14 @@ max17042_get_of_pdata(struct max17042_chip *chip)
 		pdata->temp_min = INT_MIN;
 	if (of_property_read_s32(np, "maxim,over-heat-temp", &pdata->temp_max))
 		pdata->temp_max = INT_MAX;
-	if (of_property_read_s32(np, "maxim,dead-volt", &pdata->vmin))
+	if (of_property_read_u32(np, "maxim,dead-volt", &prop))
 		pdata->vmin = INT_MIN;
-	if (of_property_read_s32(np, "maxim,over-volt", &pdata->vmax))
+	else
+		pdata->vmin = prop;
+	if (of_property_read_u32(np, "maxim,over-volt", &prop))
 		pdata->vmax = INT_MAX;
+	else
+		pdata->vmax = prop;
 
 	return pdata;
 }
-- 
2.53.0

