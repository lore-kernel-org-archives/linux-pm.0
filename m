Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E5494A0E;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986243; cv=none; b=mde0xeDDlgZgj8hgQ2qI/KGF20h3EkrCR0p/hVA3tO4xCdf7CE4c0UiJUsu7C3LuLOHofvZOn6UHLAXld+IR8IuZBoDdtqaSGBC0kXgDvRCnQ6ktoql3TDWx+jYYsoNUTmUC56dB7+jatgRD+5W/6s8xlHYPiawbWwhVFERaKI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986243; c=relaxed/simple;
	bh=mdko54FYHW1Y4Fx45AjmFQXhB8/L+lPNnWi64EUhCbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dhNOPqusFyFWUEsrSr9JaQlexb3+pwpPcbpUAueVDVchesl6tT34Df6v6sp7kzM9OS6yOVAimxaS/lY315ntMir9yhwH9MBuyuKsVOXjvuEON4b/b4asEFQ7Oswon8lSgFw9lR8ADBjx61OFMemhQg7tgFsok3Re7RyCFFuHDvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSxLkMwA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSxLkMwA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6F62C2BCF4;
	Thu,  2 Jul 2026 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782986243;
	bh=mdko54FYHW1Y4Fx45AjmFQXhB8/L+lPNnWi64EUhCbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cSxLkMwA+1v8J6sbKgIuDA+k7WXE3nBxR00coS1kORu4MLERM+qO0NHOZi8czD/r9
	 xMP30klkiTpSJd2vxayYHO3dRMGqbq7TRpcPgBiCb7cjInGqQ3dySrcSahWO/HbTW2
	 +C6E8dJJBYuhDf72xknq5sXaOAKURmLwBQiGZmzclcjuCw1ms5oWszGEQBxam1tRSB
	 CD6NmSCWY8qaEpB0BqA+QSIIeDMyH+DcVB3nGc1eKG3PBjyY8KKyvA8NLQ6KRG3YY6
	 K1agjs6l7v0hSxCNJQIPCRvkwuzXjMHD2z7TVXmCI+4OuUBinAsc+s8DiLCc3/pr5p
	 Q9lq0ma1/3XOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95E1C44500;
	Thu,  2 Jul 2026 09:57:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 02 Jul 2026 11:55:55 +0200
Subject: [PATCH v8 2/8] dt-bindings: i2c: amlogic: Add compatible for T7
 SOC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-add-mcu-fan-khadas-vim4-v8-2-244feee91a36@aliel.fr>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
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
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1314;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=UhqbrsqWdh/iR+BhkbanI5uJd+ofvIkQdzdIbbn4Ngk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ab6Y9Xykrm1T41a5nvHOs4Eh2d5Lbxpkt+oMb7NeXTO
 FrjT/N1lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABPh5GH4nxDqkpAx7/Lp7QKz
 m/k+nEx4cMUjVaXmw6K5Gmo9ujvmZzD8T3o7X3HN8g9fnse9fX59S8PXlxMSn8XO28myZyGT05b
 eCTwA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add the T7 SOC compatible which fallback to AXG compatible.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../devicetree/bindings/i2c/amlogic,meson6-i2c.yaml         | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
index c4cc8af182807..7b59b60b62e5b 100644
--- a/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/amlogic,meson6-i2c.yaml
@@ -16,10 +16,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - amlogic,meson6-i2c # Meson6, Meson8 and compatible SoCs
-      - amlogic,meson-gxbb-i2c # GXBB and compatible SoCs
-      - amlogic,meson-axg-i2c # AXG and compatible SoCs
+    oneOf:
+      - items:
+          - enum:
+              - amlogic,t7-i2c
+          - const: amlogic,meson-axg-i2c
+      - enum:
+          - amlogic,meson6-i2c # Meson6, Meson8 and compatible SoCs
+          - amlogic,meson-gxbb-i2c # GXBB and compatible SoCs
+          - amlogic,meson-axg-i2c # AXG and compatible SoCs
 
   reg:
     maxItems: 1

-- 
2.49.0


