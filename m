Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FE34FF5D
	for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309908; cv=none; b=KW/i2823OAoOHiC9UJ5zo1UAEIOJ9RuRQrhNCaahFRlHBAOfGromAElV+Zm8EzhXgO7S9t2iNN8C762FfEtsarlCZhJ+2IoDYiu+2GsHBAoSpPc7VsKHfKxn0D8pvyjdOqz4BA1cp0/7vexjniFfrENr1NlKwE9W9RKLcD35qMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309908; c=relaxed/simple;
	bh=SDZR0f4mn+dW4ydcs/xXwRJsr5lrh50NfNsz2U4AOGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0IJ2iTNzkDcwMibyscMwdaR/i03KoRJE1OscSnW6IhH4K1bkJ7OecK+mCd8JQVxVV/4McTxIOgmQyVLYychY1+A/PHCL9rOPG4exRgUmhsh31fLbLHv2JGbYIR2ab9mq/1T3h7BDeTDqleiZYJerK2P6pIg/sS0HzwocsQUt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHN2a/eV; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHN2a/eV"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-68244d317e5so6171783eaf.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Apr 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309905; x=1777914705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qm0WgPLRhpaE+/n98mlMN9+6F5W+8cs8HRYLALKl0Vo=;
        b=QHN2a/eVmSWT4u2f/rvlVdtMTbkO/9gWssafsvO/qmS//TG1d2lx6/rg2Q564xeCbI
         PZCSQtg4sLoNqKXTN/lNs826ME2Vp3M8uNxziQ61isrTnah+6cJk2viFiDnbmjjXP6A+
         MwjoOOw6n98IQenO3dkLo5EFsgGj+rlRttrFeBc9gSp/feZWedk15Ddm3k+A8wekeP30
         DdCdYdFWcY1PpAH5baxF7IaQ42rjWjlri96bm8cSXFN1leyQI52kdfhh7LFVu2Iljy+i
         mLI/ci5MU7gWAIoO3l9nbHYwY9VopSR1BBZMnO6kCx5hF3X6CLlxrdTrWJGUD9ZPODAf
         p4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309905; x=1777914705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qm0WgPLRhpaE+/n98mlMN9+6F5W+8cs8HRYLALKl0Vo=;
        b=BWKug4uDFwa9b+9SRAASRVr0s6+GvfZk0ubhS4Z4kuZ2sDS+bFIV+SdypNeV9gfcQT
         S6y9sVaQ0LCVO3izlkQdfFk4t7Rs1wU8u5B1ZffXb9r5IG2nROUs1xtYOKRM+V14XAEQ
         RJ1QTu7SXIAqHGxmtY81qII0jsT3aXD8t6mBYogYicDv1oILt+EHB5psSz+khdaZgbr2
         ekVuRTe9DVkEj0lAepVqeVc58HygSvXf3qHCQk7EkOqtZQcAv+yHuzS9MB1WicDVPVjh
         SREYCE3RCkGF1yV3rDfoEcGCh9NHR1jf2j9JcFBHBVvldX4lPyhBHAcoj6cUScxjJr8D
         5mgw==
X-Gm-Message-State: AOJu0YyqLtTOAbuJSbjt++wnBXsA9B7ZOfCwcDskFTaGlNE66MP8x7dx
	6GzTZOvN4M1oekNVWxB40C4v2t4fuewKVHHrhAkAjjRB5WVlN4XK9RJs
X-Gm-Gg: AeBDievIU58/gT6GLF24fmyPIPcjeTRJFYtF15y//a3GxlaCdQgOkWp6nxuDixcSIvj
	BJw5adNZS4S8sozNwApXeiXdSN1+9SjF+qEjddBSWlWgZkQiDXY0UL4MYhM7mCy5tmE7r/1Iyou
	U+X9H32gCktF2RX+dPs3qSDeQWmhXYHDN0/SZrbDzEzIniGQNs+xEDpqr2h2+h60PmEgQQN67td
	etxa4h3VmW5MzwNQY4BUTdwsfj+evwhyKRpToAQLE1LOKNGI6n4YsUT1QAZY5BSNyFnjS/RUwpE
	2oCRoqOIw5MbC3Jw3+Rpfizb3kfTH7SmIvMVh1+UDv9iJB2sdujsT9Dnuh13wxrHY0as3Ldajrf
	8SpiHQdeSpBT2vO5uCRpxi6Zx9/hDYjV3IsNWv4WFWnDUKLBmctI0/zYD/gR3lDxilndUGJxnoi
	SEOsTTyF52misjXfC3Zw1s8GjA/JgCT7I=
X-Received: by 2002:a05:6820:1996:b0:696:1dbd:9827 with SMTP id 006d021491bc7-6961dbda16cmr10887373eaf.12.1777309905398;
        Mon, 27 Apr 2026 10:11:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:11:44 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	xsf@rock-chips.com,
	sre@kernel.org,
	simona@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	jesszhan0024@gmail.com,
	neil.armstrong@linaro.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 3/6] dt-bindings: display: panel: document Anbernic TD4310 panel
Date: Mon, 27 Apr 2026 12:09:11 -0500
Message-ID: <20260427170914.5062-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

The panel used by Anbernic in the RG Vita-Pro is a DSI panel based
on the TD4310 controller IC. It measures approximately 5.5 inches
diagonally and is 1080x1920 in resolution.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../display/panel/anbernic,td4310.yaml        | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
new file mode 100644
index 000000000000..2da957cd5d49
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anbernic,td4310.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anbernic,td4310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anbernic TD4310 Based Panels
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+
+description:
+  Bindings for Anbernic TD4310 Based Panels, such as the RG-Vita-Pro
+  panel (a 1080x1920 5.5 inch panel).
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: anbernic,panel-vita-pro
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description: Panel power supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "anbernic,panel-vita-pro";
+            reg = <0>;
+            backlight = <&backlight>;
+            enable-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+            rotation = <270>;
+            vdd-supply = <&vdd_lcd>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.43.0

