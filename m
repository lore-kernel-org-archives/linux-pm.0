Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D003E959A;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=U6Xm9VqPCfKiVdbMZYCOjA6P4mqIjznZQmixPyZvgWCxeA751jdCqSkYfyMUn/YbGbLdei9/2XHB9vp4nI9MKd6uONAjnHlmag229IDmadgDS+z2OnqeX0BW5HZIhYj3HL5rGxnJx3zaorNg4uZDYZwSwt8Lpz4v9xTZZ5LOu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=0fwwYNeYc3kr+antF5NrKzPSvQ6OoHbAnhgXEJEye30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9I3swSO2ZNiGyo3XevgoQGZlEgfVBoLqILo5mFaqHPFX4H0M+KkicVFNV+N/sVIBecyde5v5FKkDTPPTL+JcCcB7u7BmUmu0WK0xblM4sQwQRXAuYRmxMNqdE1PEvcFO9xZPCVHcXbLljZXQEG3B39fyH1JRqWdqovwVa36Fzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkRYfLSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkRYfLSp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3241EC2BCFA;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=0fwwYNeYc3kr+antF5NrKzPSvQ6OoHbAnhgXEJEye30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QkRYfLSpf98W7hQ4ObbEW1P7mNvxg0uTiNgwI3is1u4TqGRHjMiiCysDYbGlpvVH4
	 sE3NHndNy09z1N+ONPBEnxhlSFDQHCx2hVCFgyGf018Rv3mV8H6QAoqRQIsEr+Ta1b
	 AiiSRl/+pU5ZcNP+mKWCz/TvUA85+fPnxqtnJ92I1xXYIpA/3laMq9HZ/FmtcoCsIv
	 8mo3+fmi2Naih0QAYTtXf4jCm1UbLooH6ylk3Dr35BH3Ro648LhDMyinsW5/4kfVyw
	 GXckxmtOTkT+vdctqOR2lgqI7EMUB9zDpFB+vFEWuJDZN18q0LQ8UQHRzRuiakku5g
	 a2V3dsFurWRsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286F0CD3436;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:25:02 +0300
Subject: [PATCH 10/13] ARM: dts: mediatek: mt6323: add support for AUXADC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-10-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=814;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=La2MB3KRVqMYMwKFh7B+QquLap8lejJsUVONHZ0oCfM=;
 b=If4UY3kmkGiEJJtVFcFrKYvQsaQvfITJvuCaHU1csy8WFVf6gx+wsgv7vYyM5HTJ73TbQgOTx
 WkNqaEcst4fCb1ix8Y3iJ4sOMMXOH9KGgZQl8YBm0mb/AlQVmgIlyRm
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add the devicetree node for the mt6323 AUXADC.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 arch/arm/boot/dts/mediatek/mt6323.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/mediatek/mt6323.dtsi b/arch/arm/boot/dts/mediatek/mt6323.dtsi
index c230c865116d..c070f4b0936c 100644
--- a/arch/arm/boot/dts/mediatek/mt6323.dtsi
+++ b/arch/arm/boot/dts/mediatek/mt6323.dtsi
@@ -14,6 +14,11 @@ pmic: mt6323 {
 		interrupt-controller;
 		#interrupt-cells = <2>;
 
+		mt6323_adc: adc {
+			compatible = "mediatek,mt6323-auxadc";
+			#io-channel-cells = <1>;
+		};
+
 		mt6323_leds: leds {
 			compatible = "mediatek,mt6323-led";
 			#address-cells = <1>;

-- 
2.53.0


