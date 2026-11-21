Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300702;
	b=WEC+xgizDlnlo7Vb+HzGN6L1iudl/qott1fgqgswHDaU7gkLH8xUyzWZvfJgjHovXnf7
	 FCHWClXiOl3afWuwy0I7YIJGbB/da9YAi9BAZ+qYGZVP9WsbivM9RLRQOe7GdnxN6rfEX
	 /Yo+KjpfOKQN4xyyAtWY8xjrJURgxdVds1CKRyu3a3VNHJk0hxOw/HPuqzHDQaAM6o2mQ
	 dI+KtLhTJsyL3NiUR2/VX9QJnX+PgaKKFt7fwyQdjTRXIg0u3vdqJzRObg0p8OcccbSm+
	 3gFZ2QkVI5FiIr2WiGI1Kys0E0DokmsQAUh035Fs3F/ODFwvEEBHYkyPs5G3tevb7MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300702;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2pVvL6liOZozt7ueKQK+LTvQxDDJvrQPgKYSk7ftnEQ=;
	b=Np6WPoqeufoGYCP5YJhBm4WcFAqAetQREATOMXgrbrIVrqdDVgYlBAymvfvDREXH0zy0
	 LWydXLvdIEyUCFMZEzpLd/iM/iqSsjPZCDWk66hcH5o0uRez5wCf/gsj7a3eIShOVIhg/
	 EE2Q9SpVJwac82/zYlweP3CaulZlUfBqWq3x0y+TuDNe2j3pHG4u3vXc9nzjYt51XcXZj
	 lllFP9YX0kKbyTrwlUcUr3ZPdSUox/Zgy7ZFkt4LJBshHXBej30G50RqavYgmG2oAH1c8
	 sxXXTE7jfg8a2Zpjm2Ly4L7VSN6wx5l4UJvmWYhNvOHzjd43X7HRIfb+7TdQCL/VC3Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOcRvZL3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F8606A320;
	Sat, 21 Nov 2026 22:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lOcRvZL3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795300702;
	b=Zl+AFD2UoC3bb7jL7Vbh3csemE0vpGPUdGSjZfDyQgSL+r7KjG9A9vVrz33hRBrrtpHA
	 trlOVjJRKjxsGAnfa+ig9g6cbSkLpdt45Op6jqH3FdVoDh0bBup7S6mknUMsNYWC4ue2a
	 mFBYZNjTd4lTU/GY6KD6MQ0cCIkC5+Pr2Zmgt0kjVYvwegGZPjDWJHIBy9P5NazfWpRd1
	 rE0aDLbjbxp/hcqx+hBC3ygnobS1+U0wzToSB87urNZpLi+Awlsp2WPo4iqiqkbaAhOKN
	 N6ZE67T5OB6AQwLjja2yDTX3yWDzgyyp1+uB8KjyONpd2ahZKoB4ZBSUYbQeWeo4lsw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795300702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2pVvL6liOZozt7ueKQK+LTvQxDDJvrQPgKYSk7ftnEQ=;
	b=nDVH36udObyC1uAZ2gxdf75IK3I5dIXeWlbeGprRSKMYMTz/O2+lPMaN7DqsFuNa9E+4
	 pdRmDXB7PIA7+g/lnNLGGZP/SApJ/Gxw7OoG3S94In9brMY+aPqfeQLYZvCtIBwGzFtg1
	 P4NfcTX+FBlgA/MlHaar0+krjd6dWP72l35g62w15PjmogRQvddEu3Blv8qyAMlbxCcy1
	 AZ/YX5ZxA18/7hCBE2x+edPK/dbTGlTLOQy0OHrk7a4hsMhSgxnSbaAWjtIOjdyQlTWKf
	 srMG6FS5kZzF91dJTOyiZDVRofeJ2vWBuMxZypXmQ2I2vsfHpYsSHmCwhsm0X9FYLOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 56F5D1F000C6;
	Sat, 21 Nov 2026 22:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795300701;
	bh=2pVvL6liOZozt7ueKQK+LTvQxDDJvrQPgKYSk7ftnEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=lOcRvZL3XM1sDcXNa+RiBnRGDgjRO8267WJF0HC9+G9toTTQi8qdqroiQ+jpfQfSo
	 BCBIeBH6NGOH7yVWYm8Jdz/MdtRvr5AA7w02d1D/embM8M9dC6pwTmEuHToOc4yN2r
	 iPdHwv5lcsZdhvlyKoMXn2CjbasOF3Hfi2Rd9QCFXvHQRe1rmho5NpqF+y82DJ+sFm
	 splJbZm8+dTmBrXWmP95y++hRe55j5GPTeH3zHKG7U9d5qnk0f2iduuxyFcy19o/hS
	 i61UIWfrK29msPkeykByqekwiWnLWKZPw6HZaS1ESonYZQ9loNENVzQR6BKSJ+7rWT
	 fILa0E0BTaOxA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C9E364BE22;
	Sat, 21 Nov 2026 22:38:20 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sat, 21 Nov 2026 23:37:55 +0100
Subject: [PATCH v3 01/12] regulator: dt-bindings: qcom,usb-vbus-regulator:
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
Message-Id: <20261121-pmi8998-vbus-v3-1-91ba2e61a877@ixit.cz>
References: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
In-Reply-To: <20261121-pmi8998-vbus-v3-0-91ba2e61a877@ixit.cz>
To: Abel Vesa <abelvesa@kernel.org>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Markus Rathgeb <maggu2810@mailbox.org>, Rob Herring <robh@kernel.org>, 
 Robin Snyders <robin@snyders.xyz>, Sebastian Reichel <sre@kernel.org>, 
 Wesley Cheng <quic_wcheng@quicinc.com>
Cc: Richard Acayan <mailingradian@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3908; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=uY38OOoOv7AGRyzhEMqIBpg8bK80KZsXFqsa90ruurA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBrAh1aZ71OU7nXEzGksm9JPBqUjPCMKJQIwl0AR
 /GgYR1ikoGJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCawIdWgAKCRBgAj/E00kg
 crzrEACvV8hZp+8Nvex937epX+wbnJpLE+R4rEnKDaBYvYJasLsS4i7V176Fpr1lzgZVqn2X2be
 A24nn3e9hYzSDgRsGY1EahzxU7y1xxVS3uWfENPH6N2uv9/pOBPyFacjzD4Gb4AWW8Puh2ykUUO
 n4uCZuUH5CEOMMXdEWGqznkA4C7/xVj/CmdxhPlZCDFR7/q9yZCM0qBsGY7yBrgvBtmTwfPLCqI
 TIfLJhSqgYLFwbb77X6SUNuCYxJHOgH3+NDmfwENUA6f2qAjN4flYy0zsv5B3g+IketMeOBa1Wo
 RuEvnRzsFV+WCrmNCdQXRPeFIWF/OkYce1VravKDOXYC8W/JibanTSZpalLa92uZQCtkiHjXyf2
 DG/CLoB0+o7FxKF+ZRVY5Dgen78IevGVAvaErCy3WGB81nX8vTWFcKFs5uz1gL3s/BLl8tl+SLn
 mvab9y/NQ46sotGVTyN5rjcJuF8XHDzwk9vfnkqEPEEILiAs95eFK9/uCNvgGwzrY4eBrsDK31J
 kHWKa5HvJL08xthSrVv4NQxbHo3/RiVeTaZ6+G0BaHXCR+EU04LTmDTURyekkpf8rHG7EQJQD8m
 SIm66DualkV8214cYVk/uZahvSA8HrDq8kjVkS42C/UbAAIGma9yK8ITT/x0IUW/p5Pa3+NzdAk
 BTnzG7xO4yUobIg==
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

As a part of the definition properly define existing chips using
min/max/multipleOf properties.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../regulator/qcom,usb-vbus-regulator.yaml         | 56 ++++++++++++++++++++--
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
index 024b34d0eb1a6..7e984ab9a1474 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,usb-vbus-regulator.yaml
@@ -9,35 +9,38 @@ title: The Qualcomm PMIC VBUS output regulator driver
 maintainers:
   - Wesley Cheng <quic_wcheng@quicinc.com>
 
 description: |
   This regulator driver controls the VBUS output by the Qualcomm PMIC.  This
   regulator will be enabled in situations where the device is required to
   provide power to the connected peripheral.
 
-  The pm8150b variant uses an OTG current-limit selector, supporting limits
-  of 500 mA, 1000 mA, 1500 mA, 2000 mA, 2500 mA and 3000 mA.
+  The pm8150b and pmi8998 variant uses an OTG current-limit selector.
 
   The pm4125 variant uses a different register layout with a 2-bit VBOOST
-  voltage selector supporting output voltages of 4.25 V, 4.5 V, 4.75 V
-  and 5.0 V.
+  voltage selector.
 
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
+          - const: qcom,pmi8998-vbus-reg
 
   reg:
     maxItems: 1
     description: VBUS output base address
 
 allOf:
   - $ref: regulator.yaml#
   - if:
@@ -45,26 +48,71 @@ allOf:
         compatible:
           contains:
             enum:
               - qcom,pm8150b-vbus-reg
               - qcom,pm6150-vbus-reg
               - qcom,pm7250b-vbus-reg
               - qcom,pmi632-vbus-reg
     then:
+      properties:
+        regulator-min-microamp:
+          multipleOf: 500000
+          minimum: 500000
+          maximum: 3000000
+
+        regulator-max-microamp:
+          multipleOf: 500000
+          minimum: 500000
+          maximum: 3000000
+
+      required:
+        - regulator-min-microamp
+        - regulator-max-microamp
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pm660-vbus-reg
+              - qcom,pmi8998-vbus-reg
+    then:
+      properties:
+        regulator-min-microamp:
+          multipleOf: 250000
+          minimum: 250000
+          maximum: 2000000
+
+        regulator-max-microamp:
+          multipleOf: 250000
+          minimum: 250000
+          maximum: 2000000
+
       required:
         - regulator-min-microamp
         - regulator-max-microamp
 
   - if:
       properties:
         compatible:
           contains:
             const: qcom,pm4125-vbus-reg
     then:
+      properties:
+        regulator-min-microvolt:
+          multipleOf: 250000
+          minimum: 4250000
+          maximum: 5000000
+
+        regulator-max-microvolt:
+          multipleOf: 250000
+          minimum: 4250000
+          maximum: 5000000
+
       required:
         - regulator-min-microvolt
         - regulator-max-microvolt
 
 required:
   - compatible
   - reg
 

-- 
2.55.0


