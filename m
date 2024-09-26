Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527E18870F;
	Thu, 26 Sep 2024 21:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387020; cv=none; b=OQrecE5MEwFoMhMzYJNPNb8WiPJZz82XtVDmuRYuLD2ynykczAkp+qI7b/9lMYkdQfaGrDGVTFHuU+j5EC67aXTqE4rLyNyWijUssbl1FAXJO8W9sTZtmakILSLNoWy6NeyJAQcQ7VkgPMdsEqv1MVCN3kOGYzJYi06zHT+SzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387020; c=relaxed/simple;
	bh=mK3EP9N38PN6Fd6hVdbTpmZtsfhGzxlZo54RVJ6YRQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LhxFe6t0TRewRZS4nFggPkBFHzyeoE84G/5O1+ZIkWhxzuFH+f5rwDbsMAMXPEyqseSj1nb2+8v+7xrvp6fqTBxDeCJ6cxzyHNEi2DDQortP7sKDy0TUt+nUeDAGh3bCmpc/tQTkW3v1HXSlnZKY/WhjPLc/HT3LawZOzuUaW94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8EslHzm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8EslHzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F92C4CEC5;
	Thu, 26 Sep 2024 21:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727387019;
	bh=mK3EP9N38PN6Fd6hVdbTpmZtsfhGzxlZo54RVJ6YRQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=s8EslHzmEoyy0fU6rtDJsExMtEvceolnCJpY2hCVhsepR/y++YGyw0u373kSK6OdX
	 P9EqaQuJMS1E3iSixQsHWK3EktD4nsHwPkiMTbVGlztVYmMKZYVk9IcRk+t5OLO64q
	 xxZzt58zN8DHiTVNchFDcBL3Vn57Ga49OW3HrM12Mc60hnqE9zg4Z7K4LqI92Dx2P9
	 80Fh0B7nrO1VZr2PevyppZUGrrpaTLRohDBuxqcunb7+t/ncfovDNNYo/wpJCBkFaJ
	 kOExlUDYqddpMB/IMYZZAFAWr3IvkluFOyj31iy3a2ks8jRKV2YrG24OFFZmd0yjIQ
	 IGcZehIv9+dUA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Caleb Connolly <caleb.connolly@linaro.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: power/supply: qcom,pmi8998-charger: Drop incorrect "#interrupt-cells" from example
Date: Thu, 26 Sep 2024 16:37:26 -0500
Message-ID: <20240926213727.3064977-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling dtc interrupt_provider check reveals the example is missing
the "interrupt-controller" property as it is a dependency of
"#interrupt-cells". However, the PMIC parent node is not an interrupt
controller at all, so the "#interrupt-cells" is erroneous.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
v2:
 - Drop "#interrupt-cells" rather than add "interrupt-controller"
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml   | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 277c47e048b6..a0f9d49ff8fb 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -60,7 +60,6 @@ examples:
     pmic {
       #address-cells = <1>;
       #size-cells = <0>;
-      #interrupt-cells = <4>;
 
       charger@1000 {
         compatible = "qcom,pmi8998-charger";
-- 
2.45.2

