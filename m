Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DD4968F6;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353537; cv=none; b=cAaIArs7owr9PRr9jzLgyx5c4gd+TTetlawmhHSL78sBJM75mF5AP54qyNlEfAaTG++3KUoSuO0mo4e526iFQXDb45EaTL1FBZJCLU+oe4Xc5kUEWxSdzAV7F+8mJjksuRZ281sNW+EED+9UT6MVwnNQivQ+BSQSDX9hUvN8cYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353537; c=relaxed/simple;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=suEhrQfnIvxOCewDTLVeHWlhaCngFHZsc1Nxag9W4b8eYij+Zg1LI7qYsHu2TMrKnl2QoupXWiX0G96i0gFQ8uF5mLRGCtMq2Oq3JiusefxZ8pKKjNKdSJkZs13tlCWfvOXCTw+p/9qAbZ7bOMTyStyU1Rew84MMVKC9BZQ9se8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlMEPtYb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlMEPtYb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21602C2BD01;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788353537;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZlMEPtYb8sDEZ0lQL5z/OEYH3pSB5l7nbCuiXsKG8SPqRvvO5ClN+z5/SNch0oLZ/
	 v7WFc41oZTAUBcRTkYOwDVL/t6PfXUhqjd76Xpsuv5Hw66qu9gsdBTO5boHTykntop
	 3iWSoBQ1/cis4nOw9d8BuHo/eF4jpMUbDVC0THKo8gaaKjpC+XVUDxJRIncdR6Zitd
	 lAN6Y7VgBslaZNVUt4EXb0x3CpPmolWppZ0JBP7i3oJUkXZyopi2GAWrMWkKZgSlck
	 0RbL/4e7LfDWHNvGirlfZBiYE39epGlE3YNRuO/6ZtJ7mkYOFhlAhDs0tJm2e4TlIV
	 wd5mJOs9eq4sQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F7C624D0;
	Wed,  2 Sep 2026 12:52:17 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 02 Sep 2026 14:51:06 +0200
Subject: [PATCH v11 2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell
 declarations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-add-mcu-fan-khadas-vim4-v11-2-5f1610d83bf0@aliel.fr>
References: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
In-Reply-To: <20260902-add-mcu-fan-khadas-vim4-v11-0-5f1610d83bf0@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9YM6dc6bS1vZX3qQ9qDK78sPlr6zubF64d6wdvYll6Un
 6utsG5hRykLgxgXg6yYIkv/XMsT7y4fPfN1j3oKzBxWJpAhDFycAjCRi62MDD0TX+8LUWzmzfRJ
 +XC3O7U98KaJwkXnXyZa21oSpz0578jwT9vP0PPDHN+5E1e//PsxU+65S1MA78ob7uuWPLGNWGe
 ixAsA
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


