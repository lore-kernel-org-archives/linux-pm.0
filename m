Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6E483BFC;
	Thu, 27 Aug 2026 15:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843298; cv=none; b=Q6R0OQsuExaMZQLOe9RwApu652CBK+jeZxbe23G79ydEHD4TXGmrHJOE3PCcTtvvCh5jeR4dZLi6B2GIwX7CW99Bmr+uE16yWUFloNypCx1oAkGNe4h/KywAb3afGmePqLEVZmIefmTmLf6dSiqdeyb8or8usV33AYjBxr7SaAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843298; c=relaxed/simple;
	bh=j/ZJUPicfz29D277Mim8zj1iEzQ3/hwesqBtMbJDzog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NHgDysfDvuBXGdaet4796u3mXFeIkpSnIEBzki2fmLTO0HK/M0Tu7Ilgl/1xJogfdpxSIB3CqypDMPQkNOk8GE+7o9hknCOeuXq0YqHIbj7s6Pt0QDPMdcbphooHZvq08zCNEo3P0ywcMJsJ7KG0h93+HiZwqM/WFJKr4nYUrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=girO07J9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="girO07J9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9591F000E9;
	Thu, 27 Aug 2026 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843296;
	bh=n54YcjdvBxFkpn7bi8XHbWvxpTuCfOCiMnGT9/rnvNo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=girO07J9oCjPgF1iTS2zn47YrMSUfYz4UjSVT5ZDAuvQXsTm+mmt8soX6SrIUio+V
	 fHtUO3M0SASxhx1cHxW5Vh0L2pNlj4CXhltuZiXaexJYc6IoVBDeuddg6SRGoOj98/
	 j03NDpHL1SCrzhnSMTNimUk2+GDCsw48qZZ2K7ohiNNWJazOr57HZEBWVaIoTYdS6i
	 6d0snkZFdIg9N+CXIQboxlb/SN6V9g1ij5L8udAMPDPkxgt0qer8iSzy1UnHX610aR
	 Ur49qNf4kP5t49VChsCdrsvvt8EOYNDk4Ewt3FUvh3Ik6HCco9TpUkGxXHjYpWCV/Q
	 El5bqiU9TJ/GA==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 27 Aug 2026 17:07:52 +0200
Subject: [PATCH 3/4] arm64: tegra: Add thermal zones for Tegra264
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-tegra264-fan-v1-3-3c55f0c748b1@nvidia.com>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
In-Reply-To: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=treding@nvidia.com;
 h=from:subject:message-id; bh=x42X/LoitiSAA+x5nw8PyFMoPRI+RXmRFby0FyalBMc=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqkFLVY/QZGYUrqdoqJT9+nWAvUV7l8rJ22CH0r
 c3QHUjuEbiJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapBS1QAKCRDdI6zXfz6z
 oY9ZD/9iUEb/kfa6gUgy7nJm7X7lRBEsOtaw/cytm4lYF42gkYMEDIfPXWLb4O0FXhHgHJBZaTW
 Vp4+p655zXqfmGVKVIQN/CWd7qe/aLi0ItY7qM3N6z87T5vgF+PYe4U9K0bhcKWEScupK+rKADw
 xtpoMMFES5CQfwnECl7/LO6b2uBgvwPyyQTmfk5UctH+OP4h/Fm64+te6regDQrcCaOl1uiivXA
 SuHLbhn0OqVIyCjpglou9672B9uGDRqZRjxJ4CVdvIEZzF3i+sA9n+KKCBMAvJPzmBZlR7Epm4n
 iVHh7jrAdeUqjzZy6Jo0jZlBGgrT9tqdYEt9RMXYz6hVUZeUIij488s0Qjq4MwprkF6G3kcgaVi
 6+OIHnM1HC3GcwkxOa/ah0e85jxenpqJoNU8JKCIVExkXBY8QP3LYDq2++qetXeMomFwF5+NV3f
 0cF21r0FfRnOxokH50kPcRB2/RybYzTXAL1IDeHFFssCYNL9vlrEJZsj1lKMb4w4dSySJzs+N5j
 w/9nKZD3bhlffJb97o16QF1e5cV/qjcTeZDY8v65cBrI4Phn/NRsRvfva+ZGitNKFI1A68O7uAW
 pbS7HERcjE508XaibQvGqA2/Xm1znbp3CXSL2jBv/WHl6A32BTfLXmqclP1q9O/xMDBJASlBiBD
 mx7csDhwLqsAuRA==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Add the thermal zones exposed by the BPMP on Tegra264 so that cooling
devices can be attached to them in board-level DTS files.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 630c20523dcf..5b3082f1ef45 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/memory/nvidia,tegra264.h>
 #include <dt-bindings/power/nvidia,tegra264-bpmp.h>
 #include <dt-bindings/reset/nvidia,tegra264.h>
+#include <dt-bindings/thermal/nvidia,tegra264-bpmp.h>
 
 / {
 	compatible = "nvidia,tegra264";
@@ -4625,6 +4626,33 @@ sound {
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA264_THERMAL_ZONE_CPU_MAX>;
+			status = "disabled";
+		};
+
+		gpu-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA264_THERMAL_ZONE_GPU_MAX>;
+			status = "disabled";
+		};
+
+		soc012-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA264_THERMAL_ZONE_SOC_012_MAX>;
+			status = "disabled";
+		};
+
+		soc345-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA264_THERMAL_ZONE_SOC_345_MAX>;
+			status = "disabled";
+		};
+
+		tj-thermal {
+			thermal-sensors = <&{/bpmp/thermal} TEGRA264_THERMAL_ZONE_TJ_MAX>;
+			status = "disabled";
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,

-- 
2.55.0

