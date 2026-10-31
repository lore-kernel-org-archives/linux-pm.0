Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793459123;
	b=dP9SUdUoqdUaWgHGfvSDFUG3JXx8MQVFjYcgCNc0WTEcqQCZbtkM10pVwmU10Wn+ufVk
	 V3BcljRlKZuyccZkx8skI9ewMrwiel1g1HD4UNklFCS4JcPf/2eddYuN43Z6OGJJ5Sixz
	 3ZGk6AgrJjKFpHZlUXwEqRfA9vFdSGbNFA5j/A/GJGcSHkkgyJXHBX7G05xlRznstzuvJ
	 8/Fd7mIrAA5IGPRJ5Dblhm8GUieJDHPvoaRCCj2L34FWmcUAZ8h+ONtSSC0nVaMXMQchN
	 0/ikWFr6XMZFIlpFbE8H6f4H9daihTt3VcOaAY3R2kBNs7wFVCKGYoXLG2ZX+GKFWbQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793459123;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PCD/gBhQWHOD85GSHzF1y0CMZKDBwCfPG8eOkm8c4Go=;
	b=ydR60MkIGytbBTsDBe095Hmc/Bv33PTY76Z6rHOgga78t2kTQCX5ioW4UAVj3ZOg/k/t
	 JBhmkXKYjOkMzH/8GF99z9T4Reho3yvijcWsAzHN0qyuBcfrkBTS+vg0U1mmCrb6jfScE
	 8K6xTRb/GwHYEhBVQyu9TQJ7rTyBzAA/rX6zcTGTZlU8wooEe9ihTPtpEcGmT16L2Fdhi
	 kt6kffWg5SGI3/qjllcZqr0X1h9MdY5d24yIXfSDl1yw5bKp/792x4mGcQ73OQmzGBEv5
	 LINwm2td/990cU30Zyl1BBT4K4aqyhgwBg2lbRT1O0qnappiehyyDei7QIM+8UMWO0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsxV+1Bg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C9606A31A;
	Sat, 31 Oct 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsxV+1Bg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793459122;
	b=qDaSeLWStk7PHnm5utACGkvlwzhBWT15Vg4un9XjJVvz0c18TNANZwpEeJHU5UnldVML
	 /3rvxGFMnVtsJsVG5GRK/lUAP1rvH4Cr6zGGVuNcBgt95nL5pZ6zy8x2NMfmbtFajzWgl
	 mhqV/BoNXwqUDd19BNjo0gs+O1XgksVyr393CjNJZ90d2pjv9lV7KhjwRTUGgnztSWv3+
	 ryYulvM31UmINYtcRX+q58YFflQpLncYLdxgE7Rj6W3o7nGx/cNlrgJ2YZNXS/4e/wMjO
	 8gVgGFQSDGCpT9+K5be7OzYhPGkmeTFGEG4RQ/QysGPzOBHKTmiVGN5NdMv5vc/6AUA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793459122;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PCD/gBhQWHOD85GSHzF1y0CMZKDBwCfPG8eOkm8c4Go=;
	b=eE5LicnadHPN7nr7iXdjiGNINNCW8KGxpmNt1r4ORV0JaiGPN5nOl2HQ2e5JwhmdHBiz
	 gSBhCxVTfTrQUiHZpkgD1pVDNoK1ufQwSkg6eAKfBaDMMv4MTHFPKyEYwrtJOJPZOx9q6
	 g/Ty5gLevDBthdabMG7Nc7cEvKdjCSwJYTF3a1POpqNRv2tQKxzSRNulm5T8EIyYmBUey
	 wcTcmFszRnXJ7T7GA5yhPrrnsOWRTNprxPtAeF4F2By9NHeesJsBwQLMQprVUbBMHbUqY
	 zWunKfPBJl3TqjVC5n+YQ5ZIY+4O4jpntdBEDFsXPV/aMIYjNf17FCSOkcnGcHWvrsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E8EC61F0093A;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793459122;
	bh=PCD/gBhQWHOD85GSHzF1y0CMZKDBwCfPG8eOkm8c4Go=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=YsxV+1BgQaDGfWAUf4Pt7xgOXqzASD1WNojRtnwqPVBaWFxthNyFHmaisd7AY/1Uk
	 3xazw0G0KhJ6ApyoNWpHOL0D16nfBHBOAhl7TtAZ/FsgJTgx2l2j3dB4HsNfZNA7J6
	 aECKscaIPAyewkACXdsFfK00xvCKsOzEp5JbM7T7/OVzqLFG9S+6E6SkfqMnFx7FM9
	 y3s+OFswo+5NksjeIb8mIzJwY36116UPCjxtRC9rRYKsvRxXWYvIQvBXzKI8WsmPoB
	 U0rSyrckTZ6RMT9GhBDEx4aicuW1+3v9PXQ1xW4mwj8W4jiVtX3rTiAMooSfcS1gy3
	 C8Cmb+iPtR3HQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6B60945F0B;
	Sat, 31 Oct 2026 15:05:21 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 31 Oct 2026 16:05:00 +0100
Subject: [PATCH 03/11] dt-bindings: regulator: qcom,usb-vbus-regulator: Add
 pmi8998 and pm660
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
Message-Id: <20261031-pmi8998-vbus-v1-3-4d805e5a0f27@ixit.cz>
References: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
In-Reply-To: <20261031-pmi8998-vbus-v1-0-4d805e5a0f27@ixit.cz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1294; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=8b76kVmv0SWaU2OFA005s+KLQA5vUoRMBd25Pd9muoU=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBq5gOvbY+oPG3hlXZA9XqKAk3Vrm8L+RMaCUlD3
 mLWP36ir4eJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCauYDrwAKCRBgAj/E00kg
 cq9cD/49B8I13OS7eo7LRQmzgDIyJRzRCkX+iJZxX+yUi87mXltY84FGkEMBuSSy7LOEhOezFhb
 MXLl8g4tUGflPLcBWoV2IdaVxV/ieR6x2kh1PYDrSoNqN28Q3qQRagDJx6Gt0ijfgBaEcAU0OmS
 EfAA6FU73aIassgW7RVWsjpWdNWcH7zkmIrpPCSWc+r8rSYzXxAo6Gtse1yPK+CWQTT/cQmDpHi
 V7I8X2EtDWoyOhbtRun8S8b7HlJcdi5sYBd7x2mXDoAIPekI0X1iCIloXk1AUqdd4j87O7nuLVX
 ewFcyKJkzz4dkc9ehH0HcicJh+JDICKR7/dyF66inlJUSrGMXKVYRrBFuVc7uDpRoB+0ec688a1
 6BQ782d6oS3611pQTC8bSC0WBot34NnaHW4u6H6nLDnbH2mEFYMa2PjjjzaLIlPFzwMIXhumAKG
 dmdX0+eGXHEseXY2CTABkYOK6t9fwOvF4R9ewLlSeTlsv9sZN9Rgj60BHrI2TYwgUApSYJC6uVI
 sAIRJgMH0Z5WF96R8MAIbfPxP2xrpZjegfJxEJT3c2DzHW1ZDjdQNCIx4g4Ncz345+38VaeddwK
 pNyqz+isUt5wvmaXZTOTyVYROs5tSyNbEZJqv06Z+2jwRTCA1eEj9gao5c9anvpSfPdShtXZW8e
 LWGJmBuf2z3yv0g==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz
Content-Transfer-Encoding: 7bit

From: David Heidelberg <david@ixit.cz>

The VBUS register block on the PMI8998 and PM660 PMIC shares the design
with the PM8150B one. Define corresponding compatible string, having the
qcom,pm8150b-vbus-reg as a fallback.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 024b34d0eb1a6..3cdfb556662cb 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -24,19 +24,21 @@ description: |
 properties:
   compatible:
     oneOf:
       - enum:
           - qcom,pm8150b-vbus-reg
           - qcom,pm4125-vbus-reg
       - items:
           - enum:
+              - qcom,pm660-vbus-reg
               - qcom,pm6150-vbus-reg
               - qcom,pm7250b-vbus-reg
               - qcom,pmi632-vbus-reg
+              - qcom,pmi8998-vbus-reg
           - const: qcom,pm8150b-vbus-reg
 
   reg:
     maxItems: 1
     description: VBUS output base address
 
 allOf:
   - $ref: regulator.yaml#

-- 
2.55.0


