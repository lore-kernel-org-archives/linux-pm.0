Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B79B3DEAC8;
	Thu, 17 Sep 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632045; cv=none; b=I2htX4SvXCJY4jZ4c94b9aLkHY5R8XWdkNC9xdzfYcPO1+DynX9PiqGJM7kpAR5EcU03KkE9NkSv80HPjFF+Uyc8diKnkc2MxnJe9+UdQzlWF1rjY/DWGi9AoGG0DcMcBsp4lsH6K2JMfTyNQcB3k2Nw8AMBi4tiwWYpZvuiz+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632045; c=relaxed/simple;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9UDwLv70/cg8gqUqjEJwIaN7ANEtcKS9J3lvI7mQ38rbLZ+k7sm31kUwiES54jhvTjvdJf6Q0o+sb+VfS+48QixN5jqhD4Kl7aEvGAkRalBMTxX7fUnSjP6yib69/9kl8AS5Ptt0mcd7eRX05IAMzbhtHRIWf+eNkO5ZeC+TkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6sv3G/5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6sv3G/5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C1AC2BCB9;
	Thu, 17 Sep 2026 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789632045;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=c6sv3G/5Ulsd5ezzpAqkpKyZbOU0Tjjv07ers42WVgx4fku5nqvj6f8qasXSoj+Da
	 Thxu9oEds22asrE96G30xf8Cjn6bNLekuKxJ3TCAG0Pv050OYCPeUdDDYFmLPZSB+l
	 S/V5+/wJqLaFJ+wPZf8hsQWbKEmzwa0RcCt5BLUzzuMjLLvvod4+n7ZP/FzD1h7sBl
	 7EuljgCTarrfxh52Wzexwbc7cWJZ3SOPV8p8Cgz508n2DolzTwoNPmlo/BMXMiIT+s
	 puuRTket0eO5Nk6emSnmbG2n/uuhGJTlWb2iBNbDS3kS6QYVjKaCWx7VdMDkx9Jd7B
	 Lftz1nEmLei4g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3023C982D0;
	Thu, 17 Sep 2026 08:00:44 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 17 Sep 2026 09:59:01 +0200
Subject: [PATCH v12 2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell
 declarations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-add-mcu-fan-khadas-vim4-v12-2-497cd543a148@aliel.fr>
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 mfd@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1351;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=EC3QR4h1VRMR/TQsGWmFoDDKLNA1VXSGTQljiGJtTRI=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9bqedK7/+k1Vv8LyomYtW1HyrO7knvrqs7YHZo4tb3zb
 AmPyYsdHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEpNIY/qelh5nP+h7dVsS0
 zZ770fmImcvbXqg1ls7deiiu1Tk8ZDHD/4rnXz1O/nigqGPX5vpG9BLvzpnHnCt8hef9fBKiwb7
 vHw8A
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Convert khadas_mcu_fan_cells[] and khadas_mcu_cells[] to use the
MFD_CELL_NAME() helper macro instead of open-coding the struct
mfd_cell initialisers. While at it, make both arrays const since
they are never modified after initialisation.

This is a pure cleanup with no functional change, done in
preparation for a subsequent patch which will need to attach
platform_data to the fan cell.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/mfd/khadas-mcu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/khadas-mcu.c b/drivers/mfd/khadas-mcu.c
index ba981a7886921..0e74efe14f367 100644
--- a/drivers/mfd/khadas-mcu.c
+++ b/drivers/mfd/khadas-mcu.c
@@ -75,13 +75,13 @@ static const struct regmap_config khadas_mcu_regmap_config = {
 	.cache_type	= REGCACHE_MAPLE,
 };
 
-static struct mfd_cell khadas_mcu_fan_cells[] = {
+static const struct mfd_cell khadas_mcu_fan_cells[] = {
 	/* VIM1/2 Rev13+ and VIM3 only */
-	{ .name = "khadas-mcu-fan-ctrl", },
+	MFD_CELL_NAME("khadas-mcu-fan-ctrl"),
 };
 
-static struct mfd_cell khadas_mcu_cells[] = {
-	{ .name = "khadas-mcu-user-mem", },
+static const struct mfd_cell khadas_mcu_cells[] = {
+	MFD_CELL_NAME("khadas-mcu-user-mem"),
 };
 
 static int khadas_mcu_probe(struct i2c_client *client)

-- 
2.49.0


