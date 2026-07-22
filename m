Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBF83ACEEC
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754082; cv=none; b=LbWMK/H+7p511ySR8Eqndr5VseG9ne0jipt9kymIW97ABjm/Q21N/tmt16qb1FNi6o948kG3qK0qig8ZkHg83M9nk+dDmLms/SoX+tvRpOlZLH9kpLZViOpzTzCvEmS1AJw6YDgYVnNktY1sf9NxDmMlJsDrW0xpqxfVZJ3KyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754082; c=relaxed/simple;
	bh=6esLaWMxVzWgBgD3LBUpQLC+g+cCbkEItwcvYGe7Tc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcabrRW2OAu3PBp3+phWCNs+ppNo9wJL+Q2OGo9V1olUlw22bhqfZ+Ol+5EjPSkJB3+ysbfO/PDRmXTEYsTGKWEnN7wA7Yw2h1aVP5lamFrC4usRf6kt0L+djTQ9ywuoXfWqBDFe/4lASCHl27byWI+TEf/Kk7h9k0oIm/J1RUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8gjKHif; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8gjKHif"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-475417f010dso7484792f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784754078; x=1785358878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WOd+XZss+YRv1olA4v5j/GA2GS28MPr0U93YAb8IAO0=;
        b=R8gjKHiflKoKhfDdkGvyt9M9SfD6jEqxmIiv8g4tECiLkBGxA9z9MbUT2i8OCYOZOE
         V/AhWFyWnpHHbrupmMD76FvO1sXgJ1X5Y3knlZeBL2VYBnd7IAXy798BNjAmlC3HHhel
         /+Qk39EVKnGU+gGkqeXKISaO+CsMYIVJRYLwTk5xYmYsYQYVcsvQmR4FKgy78y4A7RxH
         Sed6e3Hd5p65drijOOinFF6mHoaNca4ffl7zr6eJ1t262weSJG8qbd+d/bgPfOApMEMH
         GJ5GvAAFnydk5aY81heivqiwmh0j4SS1WIgPCCL1dWibalfzl6Uk/9VPSGCBWAqRvQX2
         LPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784754078; x=1785358878;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WOd+XZss+YRv1olA4v5j/GA2GS28MPr0U93YAb8IAO0=;
        b=rfj4AUJND9G81lYXJ8GiaAAOn17V83Wxnn+oB2eDSAAT9fib0EO2Rp3rizUx0UzI4Q
         xO5hhB6BP4+FWtfgdh6ykH7ZL8BtA3iQZaMZg64dltLG35DcX8CKCmJQ20hZJFTMDyQK
         aN7zos4ZfVzJxsDFrFjKKtNaXsARduCwSbRnhfROzCe+I94EkiLteB0iUaxrNvn1cAng
         USGAIDXPaQvl1Ey5nLHVV7KG9/Tt6S8QassaLj2xTmorxtJ7u22EyZO0UBOkIGb51gzr
         FN/IfDO1mVOvR6tT8qcoyvUgFhocJUE4An2589q085crmLo06hAXGyVNJvdaEVRBrxbJ
         VI9w==
X-Gm-Message-State: AOJu0Yy8nZawMyRZFdQNp7+tUqmOuoNz0sl8a/Oohm+HqKigoFvTCskU
	XwuXG9zr70hHek0CEhR6oaUU20Aw6nv898FLdGxA+QY1xbhwlrH0U3A7xoZy9m6g/FioOA==
X-Gm-Gg: AR+sD12w6tw12iS0ivh58+UHzt4nXYBNlrtX577Qk7gWiUNxMSkUd4mHd054IPzVi6F
	QnYbqWEKHUwkuau/E0XrQ7tszmO+rcmFOVF23Cgrj5e192mt/cpCA19QutwgiHK1iC7ho3oiZQU
	bBG4FkdwrmX2QunaSmta75tsYO031lklmnUZbXdMV1Z/kbRbUpGJMyWnCcE73mshJumVyD63MrB
	iA1BLbQ/ju6K+t6+7uqAYU/fexgtVYogCMS4KNoa/71tCpiKss5Dv2IYhEW0o+DFL6hYVTvxwo+
	4JDikKwqohatHvIoNhrSl0A69VT31vdEBFr1eMQP6QH2DtS4XDuiHZ+JJdHTLVSyYlIdB2YgObU
	/hoXy53PQg6e0PkY24PV5jKPeZqevDG5ysKaPHnP59fh7sRV+BcepFnmm5A2rt5cG+0JPmn6R6S
	hoc30wSuRmg7V5L+5/oZUx2W0T
X-Received: by 2002:a05:6000:2387:b0:47f:6fbd:89eb with SMTP id ffacd0b85a97d-47f8dc936b1mr487157f8f.57.1784754077794;
        Wed, 22 Jul 2026 14:01:17 -0700 (PDT)
Received: from coolemuke.fritz.box ([2a00:6020:b320:1a00:c256:1463:a40b:d8c6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c63678sm8610812f8f.29.2026.07.22.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:01:17 -0700 (PDT)
From: "=?UTF-8?q?S=C3=B6ren=20Hantel?=" <fugininsane@gmail.com>
X-Google-Original-From: =?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
To: linux-pm@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Rossak <embed3d@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Claude Fable 5 <noreply@anthropic.com>,
	=?UTF-8?q?S=C3=B6ren=20Hantel?= <fugininsane@googlemail.com>
Subject: [PATCH v2 3/3] ARM: dts: sun9i-a80: Add thermal sensor and thermal zones
Date: Wed, 22 Jul 2026 23:00:46 +0200
Message-ID: <20260722210046.2932498-4-fugininsane@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260722210046.2932498-1-fugininsane@googlemail.com>
References: <20260722203341.2917852-1-fugininsane@googlemail.com>
 <20260722210046.2932498-1-fugininsane@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Philipp Rossak <embed3d@gmail.com>

Now that the A80 thermal sensor is supported, add its device node and
the thermal zones to the device tree.

The clocks and the resets are shared between the GPADC and the THS
sensor. Sensor 0 is located beside the big CPU cluster, sensor 1
beside the DRAM controller, sensor 2 beside the GPU and sensor 3
beside the little CPU cluster.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
[soeren: rebased from the 2018 series, fixed the interrupt number
(SPI 115 as in the vendor BSP; verified on hardware - SPI 31 stays
silent), added critical trip points matching the driver's emergency
shutdown threshold]
Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Sören Hantel <fugininsane@googlemail.com>
---
 arch/arm/boot/dts/allwinner/sun9i-a80.dtsi | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi b/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
index a1ae092..8e7f8cd 100644
--- a/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/allwinner/sun9i-a80.dtsi
@@ -941,6 +941,16 @@
 			#reset-cells = <1>;
 		};
 
+		ths: thermal-sensor@6004c00 {
+			compatible = "allwinner,sun9i-a80-ths";
+			reg = <0x06004c00 0x100>;
+			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_GPADC>, <&ccu CLK_GPADC>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_GPADC>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		timer@6000c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x06000c00 0xa0>;
@@ -1250,4 +1260,62 @@
 			#size-cells = <0>;
 		};
 	};
+
+	thermal-zones {
+		cpu0_thermal: cpu0-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 0>;
+
+			trips {
+				cpu0_crit: cpu0-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		dram_thermal: dram-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 1>;
+
+			trips {
+				dram_crit: dram-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu_thermal: gpu-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 2>;
+
+			trips {
+				gpu_crit: gpu-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+
+		cpu2_thermal: cpu2-thermal {
+			polling-delay-passive = <1000>;
+			polling-delay = <5000>;
+			thermal-sensors = <&ths 3>;
+
+			trips {
+				cpu2_crit: cpu2-crit {
+					temperature = <100000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+		};
+	};
 };
-- 
2.43.0

