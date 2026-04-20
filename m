Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF9382F0A
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776720995; cv=none; b=qM++HkRgbMO+5eVU1qHOYWMAu/Robi1BThPMuWF4zldwtB9L7oOunEaiZyjg+eNsrbuHy6IopHWctU6zD5mGnzCX44HSC2Wlz+IxpmDF6qwIuKHZGz1RvIedwLh17Z0KzjuSJD3cB/WKyo8CzvPdedyVKMbC3mi49k14px99VmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776720995; c=relaxed/simple;
	bh=EKvdaIKyTKvcKJGyia+SK7d+HUNcnLjmavHs+qnlEDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MF/ZOfap0tx+J6s9t0K7UohlVeOMtn7tfC+tJY5fNJCRdXmlt3YAbNjfWAhtlSHl0b6B3wAjieBGtawv/aEv3VwAk+8VZKatUYqfs6TSbZKfuvRYKH/xm2QjtxLZfCYk+ejdLpTkjhAYIV1sqSxEWZbOG/yYohnWG+ez0FDgx5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxyA3F3r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxyA3F3r"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so31265055e9.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 14:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776720992; x=1777325792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeDXgOZ2fJAOAlM2C3zm9hiJl6sDVNOXzlY1iVGrLts=;
        b=JxyA3F3ra4LE3ND+V8+JSqnBRDB2tlPE2Flnz/ivNKfjbfH9/rrwBEFRuMQwKzWW5A
         EGOmQJB6MEyMHgfMLGMqddDFkjBjciugY5BFnL9JdcMomFOnGZdgwWYpps5Ybmm2MUrN
         Ad2J1qddjha+2HOC9hf6T3IOity3ZRYCi+uX1P4h6Uw3TJlp17n+RGVIG8miACN9JDJ7
         kmUEEXtwRTUy3VqWRqMLXvnh+E60xXOvtGAUhCwr95rxAAkU12E9DZ6dMmciORPXXlbJ
         RRziC8tuXHv9YnEuTUU1guytduNpPRQgTMJAWwiT8FUdl5/kde5Q0fyxP1RC/PO4e9AC
         BMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776720992; x=1777325792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PeDXgOZ2fJAOAlM2C3zm9hiJl6sDVNOXzlY1iVGrLts=;
        b=S3xmrKtflXZ28tjhm/kjWmhjp0kQsuY3Y7JTDM2grhXXoDvpfA9njHa/nrVLyWk87X
         gDUqomIPk1wqs6YlHakCPO8T1bqxpLbLRC04Qu40xMjRn3Z3EVCQ1/Mrgv3SPhSR+/NT
         vJBFAcR0GEWyBeEOlzBthk2OTvh/0UmNe+mPhAVGFI0CwtgH7DZjPU/fbabQzTm8Hkr4
         pY98pdHHGIsUgn9XJjr8qpnTSMJfQgrK3z0mA5FByWsSZSlb2d+qowG4ldwwI8Ti2fXe
         TzMyfVmyh8SWqVBwVQs8tra84Bw/bl3H4VeaeNEzfA+DxTZX4koTlF7SNIcXwB/vNfEr
         1dqA==
X-Forwarded-Encrypted: i=1; AFNElJ9MHV86pMuc7ao+vzTx+rA+dXqhbaV1n45lylBNnCaKpk/t8u1sGjIPXr6EMZIzPf/jrqX5jhSK8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz6j30rql1H/2beoebUKr+tgW5gyW4jJOwZRAMkQLUyCsUvzgD
	wR01voI0BTAvTCHDrzWYvtA9ezTM03CRGIL6SFCe/POiS6J87hqPFYeO
X-Gm-Gg: AeBDieuQNDO/pU8aoF0A8Qr3XUdyJKNzZzmSGuaCT2k/Qt8cjZ7+tzl1CfTfhp7NH2a
	CMXxPjohII5nZFL/pCrTCsAoL9J8BSRfZHKKaIaNtQioxnRBXCNNgYRVw5Qwu6LrEFHOxqvnaor
	IlPxnM18FVlMZZdFhdXQ8Cfa/Uo7aRVX435bKX1CeuWr2HgGzDHrcunHJjxIp8AmiOkBUzZtEnn
	WcamyvdT8rEoMM31KJJidCmWJiirrLhFKFTS2BQ4CV7LT0mhb2+y09B19MjJzOlolnj6QsYChYw
	J4ncKI4AL50hWkaVKvEj2hh9EJlpJIKlAxVysyMBtS4tP46cx60PqwL8DKY2fC23G3ZvwOmpsNE
	+gHYcEgZbwykdHtG+9wIrk7gXqs6zNyZC66xdW+LdXA331ks7NCWwQMNXX1Damw5/3ql0IjlX4W
	e3ApH/4Kn389ugv0wZ3w0t+eM2L9jkXg==
X-Received: by 2002:a05:600c:1907:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-489201cdf13mr58952175e9.12.1776720992169;
        Mon, 20 Apr 2026 14:36:32 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:36:31 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Mon, 20 Apr 2026 22:30:00 +0100
Message-ID: <20260420213529.1645560-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the currently supported bindings for the MT6392 PMIC. Its MFD driver
does not use the compatible property to bind the regulator driver, so
don't mark it as required.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../bindings/mfd/mediatek,mt6397.yaml         | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 05c121b0cb3d..2866e95e338b 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -68,6 +72,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6366-rtc
@@ -99,9 +107,6 @@ properties:
                   - mediatek,mt6366-regulator
               - const: mediatek,mt6358-regulator
 
-    required:
-      - compatible
-
   adc:
     type: object
     $ref: /schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
@@ -231,6 +236,22 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt6392
+    then:
+      properties:
+        regulators:
+          $ref: /schemas/regulator/mediatek,mt6392-regulator.yaml
+    else:
+      properties:
+        regulators:
+          required:
+            - compatible
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-- 
2.43.0

