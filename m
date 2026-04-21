Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04CB3A8732;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772222; cv=none; b=uv2H7cLu5dUy1VDtN5mTMU6+XlpH02Bupi54n6H6E3+fwqcwglInQd8Zoe3GgNOjapTnfnPJwxm7ec8uPQITuYufJ01Vq9VLp4x+F2BpyY6gOYh2YXD2nD7hhdFMI50mnEuiYj1GN0cww8U03YCItXHSnod+oC9Nl0vxtTHD+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772222; c=relaxed/simple;
	bh=XddkVT31/XC/ioaRn+/smsT9FYSpgPK0znWOqQA+3iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pNJmJAwyM49u0zkn0UJW9I8nKJ7R+6G8oPEW/hAnZGma67VtxBFpgixHVkZsetddPNBT1INA5NvCfHTQN2OEPMtWQGGszIDxW38vEfoB/N6hf8dmaJesEstAqOiErs4qUhmfQkGhrIC31EzAX9yhQ0QxBNBGIPSTVQCN43JF+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YouC8vXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YouC8vXn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 871F4C2BCC4;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772222;
	bh=XddkVT31/XC/ioaRn+/smsT9FYSpgPK0znWOqQA+3iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YouC8vXnbDTY+xLHUTOMD8zwUrLiitR7oeYhpXmrbm1HF2qQoy4s9TjbjF3e1RraS
	 sItfNGX4O3QGO4/BG6kVUXF5T/nlNIZvNqlswKkcu/7FH52rA2ehgXuRdDHYbCNDBf
	 VyGGZDVYeAynZvIQvadaAb9Yy0DAP8GgTHijZx1lN3+E2sOPxLTTL/7dIZkpnsD7bP
	 QZC1qyn/DVdAMXed4KUyZXChauY0J6Ywpb3HwxQwztcFxmXZiQimwtc2jQiilpQFZr
	 dgpr4hfWlQ0/2AySIxfCsePMral4ZXGsX74YF+WsbybUf0fetq2kmXXrs93eUEJ5Pd
	 /Yn+9O7Fc+W9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5B2F8FA66;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 21 Apr 2026 13:49:25 +0200
Subject: [PATCH v4 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-add-mcu-fan-khadas-vim4-v4-8-447114a28f2d@aliel.fr>
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=969;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=tWFcpje6b/UPuUaynpp5o+HzSsytJcZL6uVNyAgG8qQ=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+bzlGrOqQsFRScd93G08Hmn2V+TM9X8gF2q1/WNHh/U/
 zhYWO/sKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACbiO43hr0jjMc8dC2ud/ldu
 OMr4Oa160uf0hDs74paIntq3WMKq6yEjwyQNsfC1PP23Fr0RNhNfqLwz57blNbsfzfl9MY/Xycq
 tZgcA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Enable and configure i2c MCU node to get fan working on Khadas VIM4.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 69d6118ba57e7..5d7f5390f3a66 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -157,6 +157,19 @@ wifi32k: wifi32k {
 	};
 };
 
+&i2c_m_ao_a {
+	status = "okay";
+	pinctrl-0 = <&i2c0_ao_d_pins>;
+	pinctrl-names = "default";
+
+	khadas_mcu: system-controller@18 {
+		compatible = "khadas,vim4-mcu";
+		reg = <0x18>;
+		fan-supply = <&vcc5v>;
+		#cooling-cells = <2>;
+	};
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_pins>;

-- 
2.49.0


