Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44216483BF8;
	Thu, 27 Aug 2026 15:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843295; cv=none; b=Hel1qB/TZMfzRAOadjpjbNLX+fxT58acFBv3xG9oSQfHdq37TdYH3pU320kQCchYjggojnP8Icb3wz0vu+r8KNyiJOGt8yzLXm/vUw38YYuXb33s8C0AMv5YHf3T5nEUvH2WQx9UDO+hcddNyue0AmUymIxkFA8JNwzaTA+WdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843295; c=relaxed/simple;
	bh=N9X1o1A15qKmpLvmUi8uvf1u3nvsurMXkO4Su7evOi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKn+8BfXsO0kcPP8udvtFBv/43ERtRyI6qP9Hb7jPI9TL0qKf+l0REXBmfv6/cStjjEpHIP2KPblmJQVHfLc7foa4PCh86FFKjWCGRoT/PbcGjElKwDe40yclcxkQH1pmBaOjKivzMz1R6adkw5eNhUXQpjUkRdn/0QD5ha+W5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2K5cNuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2K5cNuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8101F000E9;
	Thu, 27 Aug 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843293;
	bh=vXVgFCHfAZjBsDcBnc2hGf2ETHKFkRwxNIyEzA/eILM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=l2K5cNufpmuK/+q7JEMYSqUTfPV4hlNcaG27mEMJog5ymD4RDiky913Yep9SNLs+8
	 VewrzRpjnge4OaOTR721YPSfWg6N9At2VULKxi6iLfGynDAYHpxMnJdSDJYa64jgIz
	 12vgAD6GLcTGdcfVgceIIHde1A2U1PTjOaKmHnSKbL/9mZlNA1ZQLOpnzKOjGw8KoU
	 ewa3/DgBzV3XziRTMT5blOpX8eXQRrrSOdolmjKWxAtq+HS9WKD7hp2yxfQHUTLK7U
	 fvwLN7WQuNdBpghPH5sP72OlnbB0T5B0uJyYkPzvv8z1KbnZHJbeFjCKHOGOADgAhC
	 CzDOSG0BGcKeQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 27 Aug 2026 17:07:51 +0200
Subject: [PATCH 2/4] dt-bindings: thermal: Add Tegra264 header
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-tegra264-fan-v1-2-3c55f0c748b1@nvidia.com>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
In-Reply-To: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=treding@nvidia.com;
 h=from:subject:message-id; bh=7+e9ignjrKKJtjq5Bz/A0MmIUQWCvdYLvUdRDu+zfWQ=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqkFLVrGSMq/yUarkQcA5KPLvI+ca6K0zUl4A6q
 go4ulA+NPiJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapBS1QAKCRDdI6zXfz6z
 ofqxD/0Xsjvfoe6LwIZXOz34aAYPtjIGAhJFiVMFl4xiCI/Cd/5j+r+bOo9EO8qjyORkeWQEKa8
 4cskMm+zRS4GDe1dh6z3UzJ/l/H0duKQ4lQ5SHkuzvP2UENnS3291QQs6+Rc4SonEyhdDbn8APT
 8EqhTvEvVbwmWB6tMYXB2zAiup4TKfYsHsN8qyAOE2wX8APvyPTFZq2IvFnJabGSrB7FfqxVrOv
 cAdwj23GuI1c2vNvONTkD6W30gZVsTw6BPTUS3efd7iqg2y4mrve8gTAwQeqz/YJPnn4SXsyn9S
 kJwlRj8D0SyLWyKWAizMi6i87mevegTtNM/wbd/ypqrgX/sR3WfZJNkJWASWqffdqPSoKHWf6Hq
 DNOBsZRTrHLWvJ0mEPBXGkPbB2VLj6uvOgnkr9i457R7Bb2rVJ6ixs8qjYzmSejPwLeaHF0qBlu
 EfDbZvLnlZQLIoa8bk11llNaFDme0JDVh+Gkm8HlmYC37ERQgCtjDgvNfVvPUi9JIiNhwx8jM4t
 CUredvVD1jNxaZxfLAEFZITnR15HYT0iFUkMU2/PFTxLLq/auJS0dHcfC7kbAMkEqT85p5Unxbz
 6jtMwVqXaFfjs7xdmL12RXYqs/r0wh99dMhTAOLhKVIkBKgxS90rs+STRvoQuum4qkta0AL7d4A
 nazWdDadBziuMlQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

This header file defines the set of thermal zones exposed by the BPMP on
Tegra264.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 include/dt-bindings/thermal/nvidia,tegra264-bpmp.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/thermal/nvidia,tegra264-bpmp.h b/include/dt-bindings/thermal/nvidia,tegra264-bpmp.h
new file mode 100644
index 000000000000..b32739691385
--- /dev/null
+++ b/include/dt-bindings/thermal/nvidia,tegra264-bpmp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/* SPDX-FileCopyrightText: Copyright (c) 2023-2025 NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef DT_BINDINGS_THERMAL_NVIDIA_TEGRA264_BPMP_H
+#define DT_BINDINGS_THERMAL_NVIDIA_TEGRA264_BPMP_H
+
+#define TEGRA264_THERMAL_ZONE_TJ_MAX		0
+#define TEGRA264_THERMAL_ZONE_TJ_MIN		1
+#define TEGRA264_THERMAL_ZONE_GPU_AVG		2
+#define TEGRA264_THERMAL_ZONE_CPU_AVG		3
+#define TEGRA264_THERMAL_ZONE_SOC_012_AVG	4
+#define TEGRA264_THERMAL_ZONE_SOC_45_AVG	5
+#define TEGRA264_THERMAL_ZONE_SOC_3_AVG		6
+#define TEGRA264_THERMAL_ZONE_GPU_MAX		7
+#define TEGRA264_THERMAL_ZONE_CPU_MAX		8
+#define TEGRA264_THERMAL_ZONE_SOC_012_MAX	9
+#define TEGRA264_THERMAL_ZONE_SOC_345_MAX	10
+#define TEGRA264_THERMAL_ZONE_TJ_AVG		11
+
+#endif /* DT_BINDINGS_THERMAL_NVIDIA_TEGAR264_BPMP_H */

-- 
2.55.0

