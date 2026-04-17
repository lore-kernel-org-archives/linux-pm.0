Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FE13B8BCD;
	Fri, 17 Apr 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443831; cv=none; b=Re4bx4pK714MVZQ3etRkriTg4aP7bxQ9P7uQ+wiOyxzwm8y7KFg9KIgshg/8Fm8P2lFEicXbak+pAzQpH0iU5vRhWdfAhdKG0aJjKmdSclJQdiGkAytzYSDZQ7fmIwoKe7mUczlLs5ETadRHli6rC3spcq9/D/d92ibBRATck7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443831; c=relaxed/simple;
	bh=tWFcpje6b/UPuUaynpp5o+HzSsytJcZL6uVNyAgG8qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Id0/socXHYSvOgOcL3xcrnH97nfDJ9lFjeE5ZAdiAGwySkva4kL3sEXwQa9r9lQebS7EFabhlzZR/j9GLUvx/eDrn24QJJyh+N3ZU5BnuP3l3oCqFg1pU7A7STdITy4A28eALX15LFq7PZ1W/1VRpzOPy4M5TE8yGwsmz7U6Tm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=UKyaeMjW; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="UKyaeMjW"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776443828;
	bh=tWFcpje6b/UPuUaynpp5o+HzSsytJcZL6uVNyAgG8qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UKyaeMjWUcKnD9zAv8zJPBSrnqk2n1SMU4oVAjw9yGbs0yL6FDVhoo0Ric2waZGe4
	 hU+M+CY4LNI23hIXLtuDmxtraU8btUsAvPfa/ZYQbvn2BYSliD+8DZYPg9+RiUAD6z
	 IbSm8Gw5L8PY1mio8dSEBIoojMvYTcvZ9Xj0kaPw=
Date: Fri, 17 Apr 2026 18:27:24 +0200
Subject: [PATCH v3 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add i2c MCU
 fan node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-add-mcu-fan-khadas-vim4-v3-8-a6a7f570b11b@aliel.fr>
References: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
In-Reply-To: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776443818; l=969;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=tWFcpje6b/UPuUaynpp5o+HzSsytJcZL6uVNyAgG8qQ=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QN/dYkD2B0h67pd/skbXv2YwanXlJWZMFNrSgKAnH7oN6KvpXQkf4z2/bVVV+yiQemeyiyg6rem
 mlbNijAs0cwo=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

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

