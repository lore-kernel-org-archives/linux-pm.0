Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1537E30F;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045656; cv=none; b=U3pZjkbf9f2jUfArx1K3SvVM4NU6g3Lii4D/xMNNesv7XEPjHWv4xIOT9mNX1n9Ut2I2WkkOXjgCd+Z0siP2uCb5rl6EC8I5yvL5LnCh5+5jhYb1DdakIYx28L8qsIz5T2XA3mgAw9R7nwKXw03ZvtZeqemFNFPKJ30RrKif+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045656; c=relaxed/simple;
	bh=0OS0O2le0mzHMAbxRNl1A/VObEVx8TTq/lX1ZilvR08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MblASqxQxahthX39bjTSyEerWBTFA37PUG8nTq/aXhX3k9pEV3SB3R9QQyw2kVHC9YX8k4/cKP+jQkuVGED9MDTsfL1r2z6/PVAgv/MrkyzzkkGwFuAsicXed/bvxJk74dolB0HruAB6wwKa/FEqU1gwe1YsQlgQvFNVrY3N9hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCq1KwLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCq1KwLu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5985FC19425;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045656;
	bh=0OS0O2le0mzHMAbxRNl1A/VObEVx8TTq/lX1ZilvR08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OCq1KwLuyiwQgpW1oN5p/FLcYXcVA36EIszpXNd2P1ZyJRR3L748v5W+Kp6ExUzwC
	 aZMuw1X9OIWiADRDQ0X3S7UTzSjsi6xj0k6xxGekKxjD3mqqPykDmaJUos+4ib7mlR
	 uCq6prm/pwqdYauxkxN0fzJhHCcyXnDvPIhfTaFaRt3kAp0UNTmp23ZwWYxph9/+H4
	 pgB6bcfiHACy0FiipRBOxJ0Rb/GPTjvA+2z2sDnt6o8O17Pwi21gQQxpyjO76rhgfI
	 V6ZwpqADaOlQIaXGwXZrp/ayLC0+dk85oGeLiXyF613F6hDJ0kYhTmqb0kOValGviz
	 bVttkJukxvDiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF62FED3EC;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 17:45:16 +0200
Subject: [PATCH v5 8/8] arm64: dts: amlogic: t7: khadas-vim4: Add fan
 cooling to thermal zones
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260424-add-thermal-t7-vim4-v5-8-9040ca36afe2@aliel.fr>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2931;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=QDl6XRK0bbX2myAi5/KhL6pv37d0zhbhr8IIj0YHBpM=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brCZNdzrbuX9w8w1VW1l352MHH9r7zZX7P09w16eVJ6
 8uZa7ZEdZSyMIhxMciKKbL0z7U88e7y0TNf96inwMxhZQIZwsDFKQAT6RZhZJj4cnut1ZvwOcw3
 TkzKu/CAPe+t6+6gNQv6s2yaz+7isBFnZDixIjfzyLeCz73BZ/4d+WN3WGzbNW4tWeOs7MK8e1d
 uVjEBAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add an active trip at 50°C to all six thermal zones and map it to the
khadas_mcu fan controller, using cooling states 30 to 100.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts  | 102 +++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
index 5d7f5390f3a66..ba9219073dd0a 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
+++ b/arch/arm64/boot/dts/amlogic/amlogic-t7-a311d2-khadas-vim4.dts
@@ -157,6 +157,74 @@ wifi32k: wifi32k {
 	};
 };
 
+&a53_thermal {
+	trips {
+		a53_active: a53-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&a53_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&a73_thermal {
+	trips {
+		a73_active: a73-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&a73_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&gpu_thermal {
+	trips {
+		gpu_active: gpu-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&gpu_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
+&hevc_thermal {
+	trips {
+		hevc_active: hevc-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&hevc_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
 &i2c_m_ao_a {
 	status = "okay";
 	pinctrl-0 = <&i2c0_ao_d_pins>;
@@ -170,6 +238,23 @@ khadas_mcu: system-controller@18 {
 	};
 };
 
+&nna_thermal {
+	trips {
+		nna_active: nna-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&nna_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_pins>;
@@ -266,3 +351,20 @@ &uart_a {
 	clocks = <&xtal>, <&xtal>, <&xtal>;
 	clock-names = "xtal", "pclk", "baud";
 };
+
+&vpu_thermal {
+	trips {
+		vpu_active: vpu-active {
+			temperature = <50000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "active";
+		};
+	};
+
+	cooling-maps {
+		map {
+			trip = <&vpu_active>;
+			cooling-device = <&khadas_mcu 30 100>;
+		};
+	};
+};

-- 
2.49.0


