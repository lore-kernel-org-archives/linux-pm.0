Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022746;
	b=OO266iAjABiCGq9tMwl3RtRDkTzkKM+yfg8JthR/8UqjyDS1R6yb/ysZD41lyRtIR4ql
	 CZxXbT2TeVdZ51SiiVVSDL7bjbyxr2DW3U6kDbjz/2z59ZbnpKS83Cpskfe5n1okSn6ja
	 588F215KwNF3wy72emsmq6UBjsiHB5HNXopVu4emEHQSuagcJyW/JY9Lr6JEflnw8Ta/O
	 84ex282qmUBP7u6SumE5XchIrRTfNpD+1iAFfDZ9EhTVoC4USf+CxY6uRKoF8gaI2AGic
	 /9N/DOjDw8LzoADgjvsJNWaAqXm1bfxMRh5O6HbU5jDcRddC2anZcK62jzTCCnfCL2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022746;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aeD5uCDGesSovlbMQ/jFI6qOUKSvFgQeSaLSjqHk7Xw=;
	b=Dm18W8OcbjpraKdcDD9lJLDjLhfsICRjeGBdL3Bl3YMCIVLIH6Pp/t5Led3UUacOSY1x
	 lVS73nQlRiDq6fCHtMH4zfqcEMfbRJL9XW30jx7hFfRYf9+VA+j2hbGN0hSNzoWnX8uH4
	 ZoH6T0CsPaFU2Jiax2XJwjOH2gYpDHOMYNKY4Sl7Qva2tyhCWD4UQwPtW7UzDTaGLUE+B
	 xLPUmyfin2NzVftq7fD40EdaE8Gu/YIc72U1CrRRS+IvUpAqm6NsnV2gOEkJDFdk27sG8
	 R5E5E8+24K+aO0HWN9f/SFsfzGp2IywnVr/dS5Ce9wO7UiUCIOXzGuZIKOch3UXcoJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faUcQm8+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE55860A2616;
	Wed, 18 Nov 2026 17:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=faUcQm8+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795022746;
	b=LaQk/Ii6LopjwdAqmePPWBHjlN+XPyWZMa6Sj6/UzQRcdTK99ryeZpTugMGTvD+NbpNN
	 IZRev0bnI1s3GSjVbtBhh7XL0lZnmIZ/qoDoYrGgET4tJ7t2zt+zrLNE0iI2feNCb0rra
	 Us073UCEwUz9kfA5OstMRYmqt07eEfAq3MfGOcf6AXYXOIwnBEMP2LpW8Rm3E6IDjO4Rc
	 SJJbVApfdGEAlLAnTfb2c6iTC5/0nOnZWafWcL+0AEuo5XOzFz7Bmn78blu+z1uZyBo8n
	 3tN4FPf6g2UQfDmowcArciyTXpJZvb5nvQZfmt2hXFjOrRAM/oXCG+iArDXCokojzUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795022746;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aeD5uCDGesSovlbMQ/jFI6qOUKSvFgQeSaLSjqHk7Xw=;
	b=OVmMhajHiYPLZgdgNxsvE9RsTVEUQG2PeDW2E+WaEjctWqULAxr2IQwmF3qnSwGHugSl
	 hItTyFN3AEpda3zLyHo3OJOcJ5RUYa6eetR9WMO200JCCp5UyPHoUqR1kJMmJLikt31j1
	 kTd+0btmYlfJlvlsOup0Ua4AHo92K2NLiNaSmg/j/KqP0q4NYt9gnOEL0N0v4LDYXtrjg
	 yyZ+qAzEOl0sOhf+X3L6Psj45VZGnPbgyYcPi746ls1JnVoAzzKRAgXL9gtzzldQSgPHQ
	 LG9QGfC+qjoL5IE1Q34oukznqY6FGuLpjsmI3D5TXBheLt8Yv9+YxZPSHTKkXmFAXhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AD0811F000CE;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022746;
	bh=aeD5uCDGesSovlbMQ/jFI6qOUKSvFgQeSaLSjqHk7Xw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=faUcQm8+kQi6Fg0JtJC8e3PzxMrNvBees4MpOGJkBt+T3RQ2+CSTWCVRp5WBDieiU
	 YlI6jEVpcvtjMGeJSnEqoiPy2knA3inU8xx6Tin41ywESZL0USbTsUWBh2nI8C+PyT
	 a1CNsb8n8udvqzxZEpj0+87YF+/jbquCwLynmUDakKfQN2PL5syZ14grqVCrzUrnNZ
	 Muwl2yeAftB0qrnRHZb81zYA7Pyw9JboearWzUBlvlvj/jWRfUpPRwTq9Zz3XiW775
	 17a/jNAH6dWKgzyeXDRqb+TRfpcKpRwmO7MuXUllSARIci44F7oJD9AZ0vgQ99LxQo
	 zOXvjzLQEwKhQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35AAB4AEE6;
	Wed, 18 Nov 2026 17:25:45 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 18 Nov 2026 18:25:37 +0100
Subject: [PATCH v2 04/12] dt-bindings: regulator: qcom,usb-vbus-regulator:
 Add pmi8998 and pm660
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-pmi8998-vbus-v2-4-3c77a72b280a@ixit.cz>
References: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
In-Reply-To: <20261118-pmi8998-vbus-v2-0-3c77a72b280a@ixit.cz>
To: Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Robin Snyders <robin@snyders.xyz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: Richard Acayan <mailingradian@gmail.com>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, phone-devel@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1376; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=iOvaxT1G2XggGbeguNuBhCumUCCnVFoo/EJHZMzemjU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq/d+XFuPrWspHz0miqC/yWOVsqMFXFIgZPsEzr
 ljLnGzKRAeJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCav3flwAKCRBgAj/E00kg
 coz0EACAFvKPWMjZK+r8pF7ySaq6i5bl+/hHZqLw2+kVCr/AEwVpylT8fEjDTOy/OHRd4NHOUJ7
 hWaboAHTpc+okUIpvDJ78EdCXinzoasks3mKnUMicEdVjDD3JV2tmb4Wxgi7X6e+1bNONR4tkZk
 /dYUrC/1NwP2Go9bE9VeAbtuWOngNMIw+SrgJmjztAhW01saymfaWcrUjeV/C0XCeRMpGnL+S5/
 yQweeho95OuyO8isF7R13wENLfQ/79Jf45dzN/x87i7/g46DXLtUBD6EFfk4DVvdsuHlQIMD1/o
 /gqFXcD2fiZMXPReThwSQAdkP7IUwjNHu+S5tLXNn2DSqIFPpzb6K2/CiXSxF00wU7/Gg1XIL+c
 0IAv34gION47c3ka75ph+pKOnaoZPsgvZjqgB/7nTF7ATG/1ENLkPUhyzazowN3h37y+jdnpYmI
 EjDv06WI1w5Mlsg6jKZahoQN5bi9RrDgveaC1xDLJYJzsfBe1ZKDlrEBce9JSjp/foLEheniWO8
 BLh+1K8yKi9/jV9RmQiq+3a5ttHiv9pDfxCtrSSRvjenf2SX6zgK0uXx0x5nCIYf3HHPbtCRZ81
 cbMGev6iXiGRKfi1JpK5WWfjSQmhssmbjTvGnHhMJVyabbZxeHBrhJJCHezfYKWszOCndEUZ4RH
 9ABGTObMyUKmtcw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The VBUS register block on the PMI8998 and PM660 PMIC shares the design.
Define corresponding compatible string, having the
qcom,pmi8998-vbus-reg as a fallback.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 024b34d0eb1a6..96f984060ce4d 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -22,22 +22,27 @@ description: |
   and 5.0 V.
 
 properties:
   compatible:
     oneOf:
       - enum:
           - qcom,pm8150b-vbus-reg
           - qcom,pm4125-vbus-reg
+          - qcom,pmi8998-vbus-reg
       - items:
           - enum:
               - qcom,pm6150-vbus-reg
               - qcom,pm7250b-vbus-reg
               - qcom,pmi632-vbus-reg
           - const: qcom,pm8150b-vbus-reg
+      - items:
+          - enum:
+              - qcom,pm660-vbus-reg
+          - const: qcom,pm8998-vbus-reg
 
   reg:
     maxItems: 1
     description: VBUS output base address
 
 allOf:
   - $ref: regulator.yaml#
   - if:

-- 
2.55.0


