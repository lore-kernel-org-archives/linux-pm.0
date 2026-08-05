Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06F33E6392;
	Wed,  5 Aug 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917295; cv=none; b=rGk487BMGF6cSNjwKAr5avn9mIPHgmf5dJcxwGIik/rH6p7m/lqexDDTQ7aIvKBeNXk9Y7Dx+v4OgLeZOJIRE4Ny7cnfJww1/lN/N+tZ5sVjrItGQeSOf8ZHmS9uwfnPqdenVhAcn8TQWZwpMM1jVyQxluDA04c7S0JaecyMwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917295; c=relaxed/simple;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBKH16O4073DhnnhQ09TG4mr82r0R6ze9FxdkZtm90zkWEjFF53T4yQeBM7pSqLixLdv1WHMN8+blkXA0V59Z6eCIeZXFs+86qAN42c0neeyUJpL36Xk5t3qRggRByxSQompXfPFv3uUdW9p1GtaO0F395duf9OYptszn9DiE78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWUfbIex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWUfbIex"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A9C30C4AF0F;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785917294;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tWUfbIexIerufb8STyJWs4Aq2r6Qc4Q5tzhfh56tE34PfHT+3fE0/9saMvQv8LO6l
	 eBW7UdT1NV9tIcbQGIdxinDmIjzcvhxT5OHYTM/ydPJEiMGgJy1LXR+f/ASBRhr4K7
	 D5E6ngA/hH5q5TAoCaM1WNe+u6zYUmXQR4MNhF/i/VqP7vMa8/BxScDTEJzULQfmfG
	 dOhFRXc3uxgfqqQ587yAWF/CJCuNsutC4eNpFOUiY5CXpcxTm6RtM+LeM0t9iLjVBc
	 8NCbyE5zf6A77h8aQHAkGLnJivKtvPVSlNqfmETnh9WKPYZZhJrBu5yVSNccieDEVq
	 h18jhDwIvluww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F1FC56201;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 05 Aug 2026 10:06:03 +0200
Subject: [PATCH v9 2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell
 declarations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-mcu-fan-khadas-vim4-v9-2-75df78710b9e@aliel.fr>
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ1bR+3SpD/YLLt7ud07237FLfMGJDW9iksPyeoyrnbVu3
 tE9/Eevo5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZjICT1GhqafE1RV6qae2btL
 cP7Psga2t1UXr53IU++OWGItMc/Y3YqRYeFrJw7Xj16PnrO2zXrAYnW/w+yxa6pnY1Ha1SuPpe0
 j2AE=
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


