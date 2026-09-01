Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA55B43A808;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276467; cv=none; b=c53RqHyZDW4cP4fgBVfuXRAL1xYlKfVeawjkHVPu5/3x1H5DgPRm/ob/h/d/j8D5ixD6+TrnawYMslQYlFLYgVZb7XdVVn1fXMRcJzLvkiSPMZcmDNYBb1RC64k6Kq60q0SrZGXsWZjOjcNenQvo8mDSvTudk4OxL/RJjbiyk5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276467; c=relaxed/simple;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AzIlAWJwz6ELrXGm2Fi2mALtBE3e/i5QnFlwJyt4o3+NbX20NH8WrXfPtNjILLtRwdTEGeJ9tH9rtuSgwz7NC+qq+42+HerWm2zimSvfyx5b/++hgQQ8DlwvYjfdYxEsU70r56wsvTWl6hnAHHIeuRfw0r/QX7xPRWrhWb9of00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/GI7Gg6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/GI7Gg6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 927F4C2BCFC;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276466;
	bh=NpJ68cAdxRTul9v+KRzPMyOhGoHG7IvwOK7cj3TZ7Fk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=J/GI7Gg6N3UrOXIuonjkoT042Z+OEbLS5iYUsNrW4suZQDlvL4WbUeHlUVrG2PrcO
	 UvqX+47tGZz2WPkZyqXWVkrwgaIIlaRnVEvm1vM+AWcrJmjRwvo0EKB/DoD2bWuRvD
	 Nw6WCyMKZSR192MXFiCzGwWApsJibnHJUu6dfpDzqif9y+FRsnGsARiSMIZn2vWips
	 W8uLzsyU4B+nfXtWbo1ZElBrI9ymvAR0gsUPpXF49T2cronN00L/K6q7pkwYflyDLq
	 YCYXks41M/pnKc6by9LrAVJ12WloVg7PdAJtpG41mJUsvDiYpIgFVqau+RWvuj/Vrp
	 WrE81QUFy8kLg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72347C61DD6;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 01 Sep 2026 17:25:53 +0200
Subject: [PATCH v10 2/6] mfd: khadas-mcu: Use MFD_CELL_* macros for cell
 declarations
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-mcu-fan-khadas-vim4-v10-2-aecdb9955a30@aliel.fr>
References: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
In-Reply-To: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a0d69FKn349lQz/bn81phL9F3j/wlHN1R09ciuz7bOk
 X7mXJXaUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEyEV47hD4+NbNTazXp7lj1b
 IVbpYPlAdYtSrP7THHUzV07j+tPqMxn+WTOr8xt5v/Q6m3rA9ETKExHxrV8SlvO8rCnT0f365kQ
 +LwA=
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


