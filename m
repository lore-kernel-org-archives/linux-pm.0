Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8950E3B47FC
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868529; cv=none; b=o5Qt0nzTUpWBGlAf4eZ9pXgYsUPbYLIXQ0vAZvTCWsKEVNDFFcXo6tMgX/OD2+zu4ZqIAhAN+tDhsc6aUhmd7JMM7ZrcOw3hieApw+8u84CA991xaOdbMd8NVd6IgRLYwRN48dJyMMTmWIm9CM7xIUBB15QvaqvvqMTbPI1YbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868529; c=relaxed/simple;
	bh=FCuBQdI8M9CLyGRgDYVU09LmhDLGnBteFJRbknT3duo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLwQWZFUbzS/DSsHa6BRqZq5OajC44b3zlTPkV9SqysKduBHtVX1A7NHesKT5EiWe62WbYvNngZT8ZDEh0YZomZXYJcmnbb69a5lhXrq66uyMj8kpIo6B4QJJvY1mzRP0BslAjPqGHZdpdXgPJbifaQilh9X/Pqjfq06zenYPY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpm0DumM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpm0DumM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0ba3bfe16so33624245ad.1
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868518; x=1775473318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzIYPQw/5COzLY48k1UwENwJKiLAR2jrBv0FayowuYM=;
        b=lpm0DumMS3aaSTe8VW5KP92C4XbZRdYFzqRj2HkTMYnFGPe1Y7qA9B59wzyLKqR7+1
         FCsIWO+YigOPHq6mkWxdB/P056cE7wDSZjp/Eb9+d4KqOPt0etkvb3Uzmsn+dAtZuq+5
         wW+Zia9NaLXPzir1+L9lUnsJFACejXbn0M1Ej9AT+zS9m+9TfGE6Mu0sfunSnJ+ghwP3
         NTUGCXrVwNlbKSAhAPAisAp2jh4PVSYnNpK/6wfkAbVwD+9eKp06XkUiI4iyzArpXy59
         3BPHmHoQC/hMrKszhLs8xmLCRhB+2BARXf2e2+ZcHUf77QzFWlkV1TmWtdZqZTZs8lJh
         o5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868518; x=1775473318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uzIYPQw/5COzLY48k1UwENwJKiLAR2jrBv0FayowuYM=;
        b=j/6zpOjbKKk8RDmibqME6DvAbvXqVWsmgvT07mGyhtqoK1wglQRHlgglYG3TH30Nrb
         za+P6z0+gIWYMsFTbOfYv8hV2l6rWaJmIshToeb3Uji0q11vvhQQe8zk9C1SXThGyAcp
         sdm/Wujnt682xkbJJATr7dTZ+mZjOBgA+0jTEam3hwppWNC3ClICw2k9p3CalXig52qs
         1O//d6dkntj+WbKP+d3wsg+C634d01VrJJoyvxt7XJ9vYPrebnEcdFeFqGFiA775NccZ
         n+D2gqszi73BYgvTZRvmZS7DxVwieEeny/bX0s/b6LBKpGsHRUjFyWzL/S7mcX6TQ1j1
         aMvg==
X-Forwarded-Encrypted: i=1; AJvYcCWNW+6FDo6Zx9ocaSrt4KUljGHM8kUZqyWXg0+VMGvEUMBig/WGml35MJhAmL/nH3Dk42CcrF7vvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqKKZszDwWqC2DZAMSrZew6nwoxMYxCzqtw+8KSvWVJP3Xl9GS
	/B43tfRyR40dDHJwOJN4FDMRNzTHAoi40u0Wl+D3qRkrQylNfS2vrgwp
X-Gm-Gg: ATEYQzyNYin0vqEznkmiCGc5KAjPpITvJo9sqJyc0sekTAf8BClKm+ROVz/JZ9J5NZ6
	m7PwdiOcixxuvbxgtiDV0VJ34D52HtfIhDY2N6AYCcGVyxcFNt2LACi7hNb79Dc/3zbqoJO4tS7
	3Xk14wutZKZjckpnBlOaaTlM2dGxKyUgEDxDqqMBGfeI/eoF6rknQ8/4kOdLv1OJdXu3YnH4dNX
	HSbxkl/wpNk/yOel5XhRQ+2av/iqTiVCLVWNSqWvjbMNqyJm3OaPdMuJWx13fPyDUUTXct5MfDe
	AHP++FuzDxKxlbMZkueOj2Z5i818LAe44NedDvh0y+NwSGp2qdRV5DcKJi9hnrS/8eMEzvrxOMz
	HRRs8pVOC8FattuuzCOBdlCDOgnNMSgPFzKKYE/ho/4owgkhVSeJ8B6eP+XYApE/GsSyuH49VCN
	HmkQFGVU+lgCoGfyDV/oMcGrTjX6aMR7Wii2reM+M=
X-Received: by 2002:a17:903:b83:b0:2ae:cd8c:bd04 with SMTP id d9443c01a7336-2b0c485870amr154320775ad.10.1774868518033;
        Mon, 30 Mar 2026 04:01:58 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9a6e:3eae:13fa:fe3c:864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24279113fsm77701375ad.60.2026.03.30.04.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:01:57 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulli.kroll@googlemail.com,
	linusw@kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: power: reset: cortina,gemini-power-controller: convert to DT schema
Date: Mon, 30 Mar 2026 16:31:34 +0530
Message-ID: <20260330110135.10316-2-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330110135.10316-1-khushalchitturi@gmail.com>
References: <20260330110135.10316-1-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Cortina Systems Gemini Poweroff Controller bindings to
DT schema.

Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
---
Changelog:
v2 -> v3:
- Used generic node name "poweroff" instead of "gemini-poweroff".
v1 -> v2:
- Renamed the node from "power-controller" to "gemini-poweroff" to resolve dtschema warnings.

Note:
* This patch series is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../cortina,gemini-power-controller.yaml      | 42 +++++++++++++++++++
 .../bindings/power/reset/gemini-poweroff.txt  | 17 --------
 2 files changed, 42 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt

diff --git a/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml b/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
new file mode 100644
index 000000000000..ef5e04f86be1
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/cortina,gemini-power-controller.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/cortina,gemini-power-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cortina Systems Gemini Poweroff Controller
+
+maintainers:
+  - Linus Walleij <linusw@kernel.org>
+
+description: |
+  The Gemini power controller is a dedicated IP block in the Cortina Gemini SoC that
+  controls system power-down operations.
+
+properties:
+  compatible:
+    const: cortina,gemini-power-controller
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    poweroff@4b000000 {
+      compatible = "cortina,gemini-power-controller";
+      reg = <0x4b000000 0x100>;
+      interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
deleted file mode 100644
index 7fec3e100214..000000000000
--- a/Documentation/devicetree/bindings/power/reset/gemini-poweroff.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-* Device-Tree bindings for Cortina Systems Gemini Poweroff
-
-This is a special IP block in the Cortina Gemini SoC that only
-deals with different ways to power the system down.
-
-Required properties:
-- compatible: should be "cortina,gemini-power-controller"
-- reg: should contain the physical memory base and size
-- interrupts: should contain the power management interrupt
-
-Example:
-
-power-controller@4b000000 {
-	compatible = "cortina,gemini-power-controller";
-	reg = <0x4b000000 0x100>;
-	interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
-};
-- 
2.53.0

