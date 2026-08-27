Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C710448550D;
	Thu, 27 Aug 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843300; cv=none; b=HAeTTvlcrC7DSw59pBoylJZJBXLZf6ckiIGIURVVduu5aT0/p3fUdDzs34k8vT1pZ1cdOu65O2/qtOJkoXuYTlZ+n3MwPFxcttXrHN8jK57o3m4/GWBJ4HpvVIsGpDabZlml7bRzyGz8T2TY31MAlL0IZzqmkBc0oEDnkShreo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843300; c=relaxed/simple;
	bh=O1rzJtMcm6mFTSRKAvHPql4xwRZfD99a2m32PaIgH9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YNAcP0tI6fhh538zRiQ7aJQTqyDHES8FDzntpzY5qF0fr70geSdWKTreexmOxRMim+BYnkQazmtQCWHef+hSrkWG2BASDxh7DjmWOawZIlB9AJUhRpgfvNxxJ55DYhFV+quKjFK2rKR9GwZqw08rmgTjJZsY9RnN6L41nnga364=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoXKxxOy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoXKxxOy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CB91F000E9;
	Thu, 27 Aug 2026 15:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843299;
	bh=a+5yaFkrJOw9/iYBFvWXyxER2EtDDURsdnRYrxTdIcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OoXKxxOy7BYrHgUXWwcWcfb1rDjQfIPPO1pSO+Vw5E12USztLX8Te7L2CRgFm8nB8
	 EeY8/sSdXBuFq1aFmoFi3E2dVlvjpuxI4A1wT0Daks204cbpC9A9kC1mBKEZDhMn+D
	 TvxPMMCLVgScVEvP4sGhK5Llg1+jWiPmxD1VhRgmgBgEjq7hyOtCUBNgtXXzY2SkDT
	 XQ00aJbh9j4uM2LJcxzzXdt7lbxN2+G6kELi7XrGrJuKk4NuDv+Ehhs+x1lJ8GBLz1
	 RPIuk2A9l1IIDcuEdJoswV5vNQ7xSKgJSLIcELTrfyZnjnF42L2lavUJ0vVLyrlYEj
	 N5IV8q68SyBmQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 27 Aug 2026 17:07:53 +0200
Subject: [PATCH 4/4] arm64: tegra: Add cooling device on Jetson AGX Thor
 DevKit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-tegra264-fan-v1-4-3c55f0c748b1@nvidia.com>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
In-Reply-To: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=treding@nvidia.com;
 h=from:subject:message-id; bh=ffBQB+0ihS+VzjDCPSRBlHFSrJqDD1qnX5rd3sZ0miQ=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqkFLVzhXyQ2fkxNWhTmPHQMPaaqsMCkiTBcMgW
 hBjrUAoR8eJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapBS1QAKCRDdI6zXfz6z
 oTLxD/48/kgHW61xy9NZYlsgXDXFV9/gnZC9I19PNy5prxwgkCJrFbiJj4sCXn+hg6vGet070L+
 zdmXym1AJflkY8SJInSpUcSjhqR2kQxooKmRgUz3gdTUFj3f2RqnmtZ3zvS+/fiTsn16sST64DY
 PmH2G1If3Mi7QoRXaKztGTP+ZN0hE3W87hbVB5KAzo4g31XseLmGiPzHKdGN7zawIM8RByMK9Zk
 xSyjaB8VMghiR6JhpUQtv+ObA9ArSq0ykgm2XEY4UCQwz99mQexBuhDXsKcyvrtgCyhjqiQScTj
 MLW33fJ2eabda1es8zeJCl+BpeMu3tpdmceBAYDkmhZvTEFFIEQOFVptWshc0V5o/wOR4aV6y5w
 d2fhLmDQX/dFkr8gHfALItNFHy8wW7VAdNlivswfBYXTeLJ/C5vY3ZrXwxDjzlqaxIz3ZrKLkkd
 ux4tWEm8CkwmyCiVBpi84x4VtkMMR7LA13SraDu2bjsTAuvuSma2vL5I7I+xV4K7EZ6ervV9BMo
 kZMWqWwoXgpJROKgjnPhTu9JdcMLEVy7Z22AQU3QzfBAWVKGr20PHnnKpTIlw0e4jxtaohltT1U
 sb27HZeZMOxr0CbBLkVdGvMrj3W8Al4IxnzBNWOV/bdsfGspwRFFMGXWa1OjwG+ZAqup6s75CzT
 0i4zaaiBUoNufog==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Monitor the TJ thermal zone and use the main PWM fan of the Jetson AGX
Thor Developer Kit to actively cool the device if needed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi     | 32 +++++++++++++
 .../boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi | 52 ++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
index 58cd81bc33d7..d4c9f45e03c1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p3834.dtsi
@@ -39,4 +39,36 @@ cmdqv@6200000 {
 			status = "okay";
 		};
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <40>;
+			polling-delay = <1000>;
+			status = "okay";
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <40>;
+			polling-delay = <1000>;
+			status = "okay";
+		};
+
+		soc012-thermal {
+			polling-delay-passive = <40>;
+			polling-delay = <1000>;
+			status = "okay";
+		};
+
+		soc345-thermal {
+			polling-delay-passive = <40>;
+			polling-delay = <1000>;
+			status = "okay";
+		};
+
+		tj-thermal {
+			polling-delay-passive = <40>;
+			polling-delay = <1000>;
+			status = "okay";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
index 4550e843f513..dd042e57839a 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
@@ -22,4 +22,56 @@ fan: pwm-fan {
 		pwms = <&pwm4 0 40000>;
 		#cooling-cells = <2>;
 	};
+
+	thermal-zones {
+		tj-thermal {
+			trips {
+				tj_trip_active0: active-0 {
+					temperature = <80000>;
+					hysteresis = <0>;
+					type = "active";
+				};
+
+				tj_trip_active1: active-1 {
+					temperature = <86000>;
+					hysteresis = <0>;
+					type = "active";
+				};
+
+				tj_trip_active2: active-2 {
+					temperature = <91000>;
+					hysteresis = <0>;
+					type = "active";
+				};
+
+				tj_trip_active3: active-3 {
+					temperature = <100000>;
+					hysteresis = <0>;
+					type = "active";
+				};
+			};
+
+			cooling-maps {
+				map-active-0 {
+					cooling-device = <&fan 0 1>;
+					trip = <&tj_trip_active0>;
+				};
+
+				map-active-1 {
+					cooling-device = <&fan 1 2>;
+					trip = <&tj_trip_active1>;
+				};
+
+				map-active-2 {
+					cooling-device = <&fan 2 3>;
+					trip = <&tj_trip_active2>;
+				};
+
+				map-active-3 {
+					cooling-device = <&fan 3 4>;
+					trip = <&tj_trip_active3>;
+				};
+			};
+		};
+	};
 };

-- 
2.55.0

