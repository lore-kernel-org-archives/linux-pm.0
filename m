Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB304A1399
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985746; cv=none; b=NCe8eg2Ceus6+Mrc6UYwV96pavmvQhJUvMvtRr67zV6zPQELdiPDwwYj5/0OqacCd/iMKaGW9ByQD/IHZw8mRgdgQyouE28b23VpoL+UEL/a5gDVNpukk9Dn8erlj+NYgAp2FnKooPip0Md2ArIdDMyVbiRJ6ejN1SRQwo1z+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985746; c=relaxed/simple;
	bh=lB0Bes671BROEQ9VD1Y2AMxRwGu77UsD5N3peyamiys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqT/jXzRn6EZBX4POYKBoP4Q6NpyuI4yXa5WRGV09HkGer2L7jZLMcL4+kdggOXwqY/XmBXRWPofcVoOvfEEJJZ4Ma/+PgiQCjO+6TlDOsnmGACWoMjFZwZkjcqKFhgV2AwLIXPNrUpxoO2h0x8gl0rTGCU4iv//KAyYSvE0SSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qTU/v9Nv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTU/v9Nv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-473dc4cf238so1007589f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782985742; x=1783590542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8iw1Xl6qbcQCxs4NT4Uomd3ECGsKeoj91RdXKkbkmc=;
        b=qTU/v9NvN88MScLJGmsxnArAgxBxIzQhAarCb5OSadG6RCuLDM109DC9GI8TncCnjO
         PLRAGdD14apXC4RXc0VFG59moW0OhSWpXairVSuvNJ7w5e5LIQBhQYgPu6jVpgZyDGPw
         Us10n3ElBsff0hnU6fm+IWBHkMZUT+V9ozllB0milw4uUJA1e2H8NPdZgtJrAWGm0Mbw
         gdKHUfxs2hMTzjFb/d+VuSSpTPCSONpUOLidg3/SprwiEE6hZxCY5kc5anoCvX4OJpN8
         j6Jwtz1IN5aQSno5zO6G/DtFrdxlFcAR+VDiB0kjBeBDLRsqNXczh9IVbTmRZDIxZkhc
         4Iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985742; x=1783590542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N8iw1Xl6qbcQCxs4NT4Uomd3ECGsKeoj91RdXKkbkmc=;
        b=q6QhYcL3kvMqokIGtza1MJZOtqedlGlsBuPANUAmtCpfR1xwcKXPxtgbMWhAOKxjd4
         58W2hOwBWklDlg5QclyNYMJmITVFzWGiXdUP3vDmH6GIYkJYo/o868XtinzStNim67Kg
         X0cWwutK3c3qdf0kJXCG7FGdnOmUmDIAoM5dfvx7NFD4prhEfKVg9pmY+JVIpBpPTcnO
         0vF4JIg/Qw65O7+K4YpWzKTaO9CWv36GnaISrNwQHm8jm7h7jGBsbZ2+yYKBG5Zx6ExG
         glxZ4BYW9Ufmz8SZAa6/TpU9a6tbWRDAh4CFVnrB7JYl4DSNxu92hUUMtTvo55adO0VG
         79oQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp6RjHgGO1vEnCubG21AjBL+aCbGvbwW3N/vLjMaRMaBN9SN+sguMi8ntm6b5qLxBhunHRgl+OcTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQNoelXCEaKDbW2/KYXSFrDXRCBWjElW+bL+SRsyvEjC7ocul
	tmbqO2MVJl9+NusptFTy46u3Wc5Jp+hqPgwTOTMxjZahV5G10aqsh073
X-Gm-Gg: AfdE7clTzesDR+YYafNuP5TiSVitqaFAZJ0FpNycEYPA+EvQb0jqf+9/keQwfzMUQCq
	VivQcJvX37nzQrmteNlZlKZFr1q2/yVEMzinvbcLiL3dDpqvKYl7iQp6eliZ3QB89d8tqk7TofA
	tPjKB7LnwQiwexM8DhnJ+vhzWEmHa4P5eO7bpkRiVd+o52p/GYMq7UVsbAWY05ttcZ7cUAQ936A
	otom80HY2bAkQ/dFoLleM1yvVWgo/e33z0ycreRzQtF3F6gxGmz6vTefn4d4WfXIoFXvqOKvQs3
	9hKhlTELgJTi98Y7mjHhYB9N+2rh1t7YSOLzkQFd9nhTgDsSl8Qdokn3HU2EoIBuC7ZIdQcwlNx
	a2hk4dRGQhkTbYF5I69Os3DK/QbooLLyC2XnIBa8mAg3GftVtOqxnFfIhAwkv3FUxu1MCpzp1wk
	w06k2Xx944BpJLbh5piG9DAVazJcjZZtrqXTrVjiVIJL/dWeKMOQEonY3f43nL1wt2ePsaiNoCM
	ILVtw==
X-Received: by 2002:adf:e00c:0:20b0:46e:27ed:6d0d with SMTP id ffacd0b85a97d-47757f4cfcbmr5464018f8f.8.1782985742306;
        Thu, 02 Jul 2026 02:49:02 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-52-250-217.retail.telecomitalia.it. [79.52.250.217])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-477dbe617b1sm7381364f8f.16.2026.07.02.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:49:01 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 6/7] dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
Date: Thu,  2 Jul 2026 11:48:34 +0200
Message-ID: <20260702094846.17325-7-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702094846.17325-1-ansuelsmth@gmail.com>
References: <20260702094846.17325-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN7583 chip-scu node.

This is similar to Airoha EN7581 with the addition of the presence of
thermal sensor in addition to controlling HW PIN and other miscellaneous
pheriperals.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/arm/airoha,en7581-chip-scu.yaml       | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index 67c449d804c2..cc564dc7b414 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -19,15 +19,29 @@ properties:
     items:
       - enum:
           - airoha,en7581-chip-scu
+          - airoha,an7583-chip-scu
       - const: syscon
 
   reg:
     maxItems: 1
 
+  '#thermal-sensor-cells':
+    const: 0
+
 required:
   - compatible
   - reg
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: airoha,en7581-chip-scu
+
+then:
+  properties:
+    '#thermal-sensor-cells': false
+
 additionalProperties: false
 
 examples:
-- 
2.53.0

