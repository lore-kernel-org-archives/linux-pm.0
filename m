Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0839C631;
	Fri, 18 Sep 2026 02:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789699246; cv=none; b=RFvyGq5izQsgUxwS1z6HwKrTkSNNLYFzJVBsxEfAY3vb+FMcEOJMs18gv4f/BS9DRlteWWRJJ7wZobTHqUZbsyJ18yUB9mtT7jzDlPe0VtOSs2uDjaRU2sWfVBxvf9A7od9A5PtDt1xjq/7potIb4F9fYaLBPzaiOidTENu7V5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789699246; c=relaxed/simple;
	bh=LjFaux2RkoflSgfa+SRMzDruiFnZt3y6YPLO1trSPWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBm6IX34r+AuO8Kb1VwGqJkVLxjq2teMjQPLUAZgPks2kCTl1qBdyKBm7Z+/L/T8+ZALBGVVI6guztwE7/c86s+zmR7sMtyvtEOgOzwb2cG57927o18ot+cQ7ppKZzcMLAMhD19RKoc+wRE10Bwqk/GnGzhx6ULTtrt1pNxN2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyuNQFon; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyuNQFon"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E6A1F00893;
	Fri, 18 Sep 2026 02:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789699234;
	bh=PDbqsyc8sRVugfq1jQAe0RjqzyEbOeblXoaM2oNL4+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hyuNQFoncmrsh0OVEgXaMr7VNUi3hHDsjTpwni03lmR03Ht85l7Mg9Gg99xsK6q5T
	 f938tAJchCSKB+bfduAh7Vj6pLJUz+q1OWHQQLHgUZY+9enkTFOgTp6Typ6ouhxB7I
	 sMHdj8OjiXgsjrUA0PM6WQA8ehsuupqpS9sgqBWLuFGR6lH2hZMXqiSHN5D7W05Kkx
	 klkRU7vGlLJsKlXWIp0tqv/T9cPWlFfwZJTyDKhLUIHP3rwFQ9gpF+sXYhHrJ3Alac
	 B0hjRNeRVglAkea8evREtxMclb1GN1RC/+lzDgikBnazfpse+UGiaaGHd0NqVD2jgX
	 N9NNmR4UM3WRg==
From: Yixun Lan <dlan@kernel.org>
Date: Fri, 18 Sep 2026 02:40:13 +0000
Subject: [PATCH 1/3] dt-bindings: power: spacemit: Add power domain
 controller
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-04-k3-pm-support-v1-1-0acd2b36b96f@kernel.org>
References: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
In-Reply-To: <20260918-04-k3-pm-support-v1-0-0acd2b36b96f@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3268; i=dlan@kernel.org;
 h=from:subject:message-id; bh=LjFaux2RkoflSgfa+SRMzDruiFnZt3y6YPLO1trSPWs=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqrKSSsV4vhz3ANSGQtXvagH3NvV73rB7g4AHhK
 Rs3VXWPYJqJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaqykkhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2xwxAAjNbE3A3tMYAn70EbRs4GLqvjvYjlxxSoVe6JBT8087K/0FiEU2rpM
 SQfWFlbZ7YMqiXp4x8TkBG3LGjp3XO8CltZznTkkmvnljke+QmVxbib1D19n4LNIHUnGAW2/hiH
 QongiyppF3gJwj39ALsKqrtpezxtl52xBBDLDhN1sYBieNlhyafWBFfaF6SvcpNvaCsEAE4aEZk
 Pu3iUI2a0rGHOWaeJm4oMoZneCv8Wwa9Taxot+V27CF8v2p9CtwLUKTk3ZRQQmv02BetlZsMDzC
 doiSeUHtf7hgpxpxqT7VeNKwXL8xDP6fjuTz8v4KGAgt5Ga1JJxQvmcGR7PAg3STe5ZZ7FeVTSg
 fuSufapu8RDHquSP/7eJPpBHviEAPGfGWrse/YL2k43xzff4uf9Cb3aOUS03ciWelgy2ExquYl3
 6eiptqGPgSq9iziwCDc+6KUUY/1IsKTs+AojFAna7VVOrh+7Est3icO9mLq4WCuoPwiNdhmfbHb
 oUAooFM6+JVliRAYfrLxm7fYce57g94c1F8E7DI52p8bQRscgAhRC+8dynPisv+u2u/tSBI3PoD
 XS8mNNlRG7gDzOm51XyS46iRUOheWE6DcQiK+XZFlULQia+JTcfRnrLYKtdJCvyo9UJy1GPByI4
 tKyOn6mRt4nX2j1WKAQvKZWSm47jGQ=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
Domain Controller is SoC internal module which is part of APMU (Advanced
Power Management Unit), it is responsible for managing power across multi
power domains, which includes power on/off, isolation, power-on sequence.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 .../bindings/power/spacemit,power-controller.yaml  | 43 ++++++++++++++++++++++
 include/dt-bindings/power/spacemit,k1-power.h      | 14 +++++++
 include/dt-bindings/power/spacemit,k3-power.h      | 12 ++++++
 3 files changed, 69 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
new file mode 100644
index 000000000000..f869285f84da
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/spacemit,power-controller.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/spacemit,power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT Power Domains Controller
+
+maintainers:
+  - Yixun Lan <dlan@kernel.org>
+
+description: |
+  SpacemiT processors include support for multiple power domains which can be
+  powered on/off by software based on different application scenes to save power.
+
+properties:
+  compatible:
+    enum:
+      - spacemit,k1-power-controller
+      - spacemit,k3-power-controller
+
+  '#power-domain-cells':
+    const: 1
+
+  spacemit,apmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A phandle to APMU syscon to control registers for power domain
+
+required:
+  - compatible
+  - '#power-domain-cells'
+  - spacemit,apmu
+
+additionalProperties: false
+
+examples:
+  - |
+    power-controller {
+            compatible = "spacemit,k1-power-controller";
+            spacemit,apmu = <&syscon_apmu>;
+            #power-domain-cells = <1>;
+    };
diff --git a/include/dt-bindings/power/spacemit,k1-power.h b/include/dt-bindings/power/spacemit,k1-power.h
new file mode 100644
index 000000000000..41ef540b5c44
--- /dev/null
+++ b/include/dt-bindings/power/spacemit,k1-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_SPACEMIT_K1_POWER_H_
+#define _DT_BINDINGS_SPACEMIT_K1_POWER_H_
+
+#define K1_PMDOMAIN_VPU		0
+#define K1_PMDOMAIN_GPU		1
+#define K1_PMDOMAIN_LCD		2
+#define K1_PMDOMAIN_ISP		3
+#define K1_PMDOMAIN_AUDIO	4
+#define K1_PMDOMAIN_GNSS	5
+#define K1_PMDOMAIN_HDMI	6
+
+#endif
diff --git a/include/dt-bindings/power/spacemit,k3-power.h b/include/dt-bindings/power/spacemit,k3-power.h
new file mode 100644
index 000000000000..54b39f2f0936
--- /dev/null
+++ b/include/dt-bindings/power/spacemit,k3-power.h
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#ifndef _DT_BINDINGS_SPACEMIT_K3_POWER_H_
+#define _DT_BINDINGS_SPACEMIT_K3_POWER_H_
+
+#define K3_PMDOMAIN_VPU		0
+#define K3_PMDOMAIN_GPU		1
+#define K3_PMDOMAIN_AUDIO	2
+#define K3_PMDOMAIN_LCD0	3
+#define K3_PMDOMAIN_LCD1	4
+
+#endif

-- 
2.55.0

