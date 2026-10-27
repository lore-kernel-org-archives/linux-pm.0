Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107076;
	b=22d/eX06fsa8+dKQ1GNKO1J1+usUvJgeAO1RwkNfzbjFGnzHOBOtF2HArDCMG//sBRR3
	 6+u2QgPX2v4WUUUtZ+kDvzjFvlQYbxZ/GP/xCZESTrm+9qVns1MiSfFByxuM5yAo1a0VR
	 6w0OpaoaB1bJrrYT9Qfa7WcJQyVElPUJo5evqc7XTLeZtI+W/uXvjYB1dX4zTMdKxNkI0
	 ndXE2HDURHIOfICWycLn1fZ0sRukWI4ldvOUOG9VsgZUfmkCYH0GazDEfO7GhkibDYdf2
	 dwDvY1CUL0HzVIy4rg9QbCUdnbciPxjhf+Q3/SEbOAmQJiCD/rLsxla3wUNo0hWERpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107076;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jjDyecQnnlL5whA8K/QC/fRj9uMASe5xPr8cb11QCas=;
	b=e1r8DNpHoGodzeBfS/T50tgwRWHcfACI98SKmSTCkbe54ynhrfwarHQdXgDfYpd6FIfW
	 fdbcDe4Hd8HPkE6dewE3tYAlun18sKoaNL66kmdP0nzaED8g8NP3c7s+4Pjd8RMT0b9ja
	 Qsabl5Z2i2xYHHT7/YAgB1YkJ++AiH0CzIFc2cIh/wX3/f+iufYzyuSfUnWrTRU/6moHb
	 rj3MX2OFqKsi4xS+zhOxRSjs99mXp9jUdyBdgFXCTd0VmT8i71oJEfjrCCkxH2aEtoxlY
	 MuGpJxZVTZtDuwFLphIwrrI/Jp2D5gGNekBfo3giYGGcTo4ec8drGnnLf0X5dLkSuHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S1Ohc7D9;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DD606A321
	for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 13:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 095DD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S1Ohc7D9
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-499f20c7054so2110320fac.0
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2026 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793107075; x=1793711875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjDyecQnnlL5whA8K/QC/fRj9uMASe5xPr8cb11QCas=;
        b=S1Ohc7D9yDYO9kTImSEQV/3gSKyDDFiQkKyMj1zVf/+lf30uKRE9GKjYK4VGZmaV2P
         xrehuLHLkoecRLRMDSCgF9TA6+6uJJE3CbLQ46235dcvvmpeLUeY+V448qODnTcTtmsn
         zTf8h/J75N9dw9ZtIJrZyIGuYWb9t5Fq0kqjjlk8rC6rXw+vqO0+iPEdrvDuM8ufqMY8
         wG3WJdqJCtGLmEeDcWjulxoh/OCQIQFMbm3967pMyzSXikqHaHkE3V5u0WSDN4QiZUUn
         qHSRbPofaTPj98tUiLCrbM3LSvHGfTQ4KP2bAGX7+DRsJCwcqo0arwfDR8e766DKYHDi
         17JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793107075; x=1793711875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jjDyecQnnlL5whA8K/QC/fRj9uMASe5xPr8cb11QCas=;
        b=bRq1RggxBgFA0xDKoxwcjP8rH+xUFRZ+trQtJa5eZaCOUh3d16wLNliVEgWpYORxnn
         6nTF3bJBaFtJnLrBX4vwh9I7FCC+b8xO0b5NcpL+1Fkud07YN4ePjKPJ0CGz8fgDi8SI
         UCW7cUJLYYMnWqYfWKG6KHOkhea4i/kWuZge+7hzKCDXwPR0BiUGzRkL2hWLMjCahQmE
         qkW2vCxI1q+kTnOxzMHydqA0easjW3IKLkICrvCEpbDKLlRO7RJuk5ZlFIFkSEKpVuve
         +LZQowgFrmXAG47WseNhBo1ueyBF97qkXntG6ftJsj3Q3P3UkAMYSu3DxI9k3EYT5JaP
         I4bA==
X-Gm-Message-State: AFq9FYJtZ7xmqbfkXYSR1AF49sQ9PUlQXKGmx6/iM2U6dtYMwHHtU6Yk
	1S4cGI9I0Y8igVh4aT6Cpnb+mhiM/12ERsbwtDOMzLTlaJXcVJHtk2gQMaC7IYD/
X-Gm-Gg: AYBFou3zSAxi8fNFk6rjK+Xosa8HNP3tlQGYRFFnPPOHVCaX8OEZ/dnhVPuJB2gdzbe
	UDUqGCiibxSxgtIfkzUbGe4xiX9DyjvjExbSh+YIIX/Jpz98BShM217AseO7FLY/i9nRJb9rpOE
	nApLMTgQ+wnGAV8qibJoZlEMRkgPsCQt9hKuCGbaQckfnaFPGvsvq6ccX0XADdZR4tUqUQricq/
	uJfZqDe1O5Wfcu3iThhrN6GxdDmZ3I4hb088fjYy2nDKqkNdU+turUXxhUPASf5tbNaMPmqHfvg
	X5xG50hhxKVAWZ3s0KtiDtynQo860BYGDowPcwcFiCyHnuZpNtOSCP0ucDnq+xV0BhpLV8RfI8X
	pgyuzkZM7YvF7XOxPfMA80PUj8qiYyvwBvWMAWjkbv0nNVT8NZdEhtuYf7MVat/lLn+5xJPHGRX
	xm2D/fvO1L0Pq2BF2cJLNz0RYQEZ/OMjjtSy0cPPyRkUdrUdKHAfGAY/KBaq+ARR//4yTzV9qB0
	aeE3O1XTv1mpL/RZtK+qx1cR51QAn6st7kF8E8Wkd/Qr1B2HTmVnKGYoUvb9zEbBfUb0lFNMlpL
	M8ePyAkc3FW8po7Mawi3EegkyZcqhg==
X-Received: by 2002:a05:6871:739f:b0:48f:e107:3183 with SMTP id 586e51a60fabf-4a83f60f86dmr6853825fac.54.1793107074863;
        Tue, 27 Oct 2026 06:17:54 -0700 (PDT)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b74c0a7fsm23412fac.2.2026.10.27.06.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:17:54 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
Date: Tue, 27 Oct 2026 08:17:49 -0500
Message-ID: <20261027131751.1724448-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027131751.1724448-1-macroalpha82@gmail.com>
References: <20261027131751.1724448-1-macroalpha82@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add bindings for the Cellwise cw2215/cw2217/cw2218 i2C interface
battery gauge. It is similar in function to the existing cw2015 but
with a different register layout. Each of the cw2215, cw2217 and cw2218
only really differ in the minor specs and the hardware ID they display
when queried. shunt-resistor-micro-ohms is a property in use for
multiple devices so not appending a vendor prefix to it.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/cw2015_battery.yaml | 42 +++++++++++++++----
 1 file changed, 35 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index f7bde324153d..12d2d9a9cf6f 100644
--- a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
+++ b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
@@ -14,12 +14,13 @@ description: |
   phandle in monitored-battery. If specified the driver uses the
   charge-full-design-microamp-hours property of the battery.
 
-allOf:
-  - $ref: power-supply.yaml#
-
 properties:
   compatible:
-    const: cellwise,cw2015
+    enum:
+      - cellwise,cw2015
+      - cellwise,cw2215
+      - cellwise,cw2217
+      - cellwise,cw2218
 
   reg:
     maxItems: 1
@@ -31,8 +32,6 @@ properties:
       it is to mail two batteries to a test facility of CellWise and receive
       back a test report with the binary blob.
     $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 64
-    maxItems: 64
 
   cellwise,monitor-interval-ms:
     description:
@@ -41,7 +40,14 @@ properties:
 
   power-supplies:
     minItems: 1
-    maxItems: 8 # Should be enough
+    maxItems: 8  # Should be enough
+
+  shunt-resistor-micro-ohms:
+    description: |
+      The value, in micro-ohms, of the shunt resistor used for sampling
+      the battery current.
+    minimum: 1000000
+    maximum: 50000000
 
   monitored-battery: true
 
@@ -49,6 +55,28 @@ required:
   - compatible
   - reg
 
+allOf:
+  - $ref: power-supply.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - cellwise,cw2015
+    then:
+      properties:
+        shunt-resistor-micro-ohms: false
+
+        cellwise,battery-profile:
+          minItems: 64
+          maxItems: 64
+
+    else:
+      properties:
+        cellwise,battery-profile:
+          minItems: 80
+          maxItems: 80
+
 additionalProperties: false
 
 examples:
-- 
2.53.0

