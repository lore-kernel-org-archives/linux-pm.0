Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5E37F733
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367993; cv=none; b=brmODaHglDkOA9O1k1v6Hxsx3Rd37QXVrXX/oBR2yDKkAhdLnHJG5xkPhQiVacSBu0w0P2EuMruSL5cPUpuwUKEnES/ZougTnW7uCI73oW2IwOGOc5grVTTgBoxPaPgjCsruhhuhwQKtHKQr/FT8oN4X262Z5wGz9RbU4rJGp5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367993; c=relaxed/simple;
	bh=8KPPZhUzqh96jYNd2rJBExLV22pVBjiyuGvVLIon7zA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYkfh8An8GtEz6Qnu0ZtMt1PQGEv+PbvFv7Vqbew9LUPqBrzGpcJRsrf6+X0vmn18GXhvarPro5snr896Hh3b+EQPcfMZy4yv7uOwK/GfI4J9D/hvvwJZpfSB2VpN4gJnL/3uNzqZDNDq9OsA6r3evKi7Z04fv+jIT0CROEu/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/FASzF5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/FASzF5"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c742d7c8acfso674016a12.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774367991; x=1774972791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yc7wk42EADhvDIltPVK1lZfj6uphT+tiZ2F0l3KerEk=;
        b=G/FASzF5mGztd422oGgvKGuUqXAJ7XA6Bp+wowAWUGrhDMChyMt4St638oxyzQ1L2j
         DyMBk+OWGdV3tQ8VKFK+sAQOufQMA3ncCSzqrnIaPsK7AU8SD9LQYyxtsrHh+di4TU7k
         TovUXi3eI3oXYMG9rlnoDe1VlU4N+t7fnWjKtg0uxpqcz72PB8g1/n3yEtciiVdNdFOi
         dm/2Sc0yDo2Zmc1lhYTCtVeE9d/1rR/7xf8tATNOmhOyTdFgQhR/GNhdO8h9NQwrG4Og
         dgEQpXsiPu9yNcTuBnBgwdc0nFl2Nqq+2WBx4IPPQ7S/huYfByz3cvtM/DEa5M/cpAEs
         JoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367991; x=1774972791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yc7wk42EADhvDIltPVK1lZfj6uphT+tiZ2F0l3KerEk=;
        b=Lm0jwSrwz0pX3MzmzO6/b8Eli8ILb04QOSehZYwtfYTrJU/UXeV2yv6kf8mWetmzTr
         XBzrV5t9nogbHnlqn5FxoX8qqcRhkhRRxBPiS7yTojCXjwFoKV5P+1sW496Vtv1oqYhW
         gTmeGpusmOZc9RshQIDiWWlFrsUKW9mTDZPFB0cHs6uDZkRbit8ff8lxe6BpAM8ALeoE
         3b/2IaZfD68icAeQIQ8w8K4gkEpMMqSAABrgYzEeSujRRNttjLqmAr/EPqFx3Ai2njuS
         dj3C9EBz4KsOM+F+q1DeNTeCdRCQ00yK+BEZUdBc0KITgxZVf5RkNiksEK/Ggt3jaI/U
         9f1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUsIXGsxdRC4itZTlr7YKoNZyDyz8RkqqsJSpJkrHU9M3RvrthsDPMlJ7ia6NpoJuV+BeyGWUZcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzD0/FJAXmoffbKri2eDxJ7cFnb+OYeQI6DVc6ykIV3zrN4qPxz
	Y0Z8jtmvwwpjGB7tLwcHFMUkthno9soypC/Y+U39XgnL9swtPN/KAnmIYDWaHqcsDAk=
X-Gm-Gg: ATEYQzwNKoilPk1W/L8Yqko1BcLiJ0vHTVkve/nj17mQg2+Otmg23WD6Kv42Rfm/0tB
	zOkZ1EdXm3V4bEgF8/w/fMbA7qFioxc0VayT95wvmMp6dDKb++mqGVy5Lcjl/L2EfaxsNMoJkGE
	DFRM+horuAWD8ggmW6a/AF6APwd7QSQE338SxiBhTzjmorfEaMHdjRumKpQueR5yJqTdaKq6D0D
	k03PhUplemzoqc1NK7nRFFgsxbR/WDNxzDAkQodFUsuVtgI3BqHkHvDKIDnezE+ZaaL6t1eNXPv
	3AUit596sx1RUdKVhAaOQyLtg2jAaogOOButdT8iTTysU/kPUMDYDiMquTL/jh8L0hGEQfzZyDv
	GsYJx318Gyjbjat7qpO7AZmkicjrj9AzVY+RTcArSlP0HNNl4qjxZDQEq6bn8TC3xuvu0W5vu4T
	0QbsIgtfygQmODZn3Sk7naPL4On3U2pmIrnQjbMfNdpIWMj7uzxx+PSChw6aaLl2suvxmBt4GoB
	0k=
X-Received: by 2002:a05:6a21:6d82:b0:39c:cdb:5d82 with SMTP id adf61e73a8af0-39c4ad6540bmr304311637.38.1774367991049;
        Tue, 24 Mar 2026 08:59:51 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3easm12352116b3a.41.2026.03.24.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 08:59:50 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lee@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: reset: st: convert to dtschema
Date: Tue, 24 Mar 2026 21:29:30 +0530
Message-ID: <20260324155935.183952-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the STiH4xx reset controller bindings to DT schema.

Suggested-by: Daniel Baluta <daniel.baluta@nxp.com>
Suggested-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
---
Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

 .../power/reset/st,stih407-restart.yaml       | 31 +++++++++++++++++++
 .../bindings/power/reset/st-reset.txt         | 11 -------
 2 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt

diff --git a/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
new file mode 100644
index 000000000000..d7adbc00f5c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/st,stih407-restart.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ST SW reset controller
+
+maintainers:
+  - Lee Jones <lee@kernel.org>
+
+properties:
+  compatible:
+    const: st,stih407-restart
+
+  st,syscfg:
+    description: phandle of the syscfg node
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+required:
+  - compatible
+  - st,syscfg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reset {
+      compatible = "st,stih407-restart";
+      st,syscfg = <&syscfg_sbc_reg>;
+    };
diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
deleted file mode 100644
index b63948737d80..000000000000
--- a/Documentation/devicetree/bindings/power/reset/st-reset.txt
+++ /dev/null
@@ -1,11 +0,0 @@
-*Device-Tree bindings for ST SW reset functionality
-
-Required properties:
-- compatible: should be "stih407-restart".
-- st,syscfg: should be a phandle of the syscfg node.
-
-Example node:
-	restart {
-		compatible = "st,stih407-restart";
-		st,syscfg = <&syscfg_sbc_reg>;
-	};
-- 
2.52.0

