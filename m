Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470770;
	b=gKxYk/oXgZhkJKG3G/st8HGy3WUi6B+TZ56/XWEERvw7HTEoa5j6wVKELrAIeleJ2tfI
	 kmNFPjLSnLmepjKpGdT4hzK4LVEfgs2aOdp9qGRBChGJ3+w3g8Ky//zrp8D2moM/fzWmZ
	 eeosOUjasoTaAoukvKn1mOs5nY3rkiOwHpPRFECqkRBuWP/6MM4uDQiQx2jQIgk5IGRMs
	 JW/C7N5RhirT6Zs3iXJmuHp/lR8gBD8ZQjmYq3c+/2ook2nx5K6ZL7HMxEKd0mkiQQ4Gq
	 AAwCnoz7cNB9ZlB4+e/7Dfa57HE8bFMFwkpH5Vpu+G1PtxWZ+Uz2wln9qKnUG0f0bOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gma6tEKKFClTNwQqyrudA9xAP8hDFuYrKZEMjTt+5oE=;
	b=fZ65oZS8jzZxmzFrTqHB7exvx/gJoZlIVEBBZxYth4sa7Cyoar4B5Ary4RsxheIxnweX
	 e2TIC4PtbZiEG7tjU3c7+IdUVG7DHZO7DpoCnJzwWOHXB/uHQVH5cR2LqeB/IVFxfEt+b
	 mMr0ZVhvDXIfDMens9J76fiv5e0l2iQTGXDsE3OnLoK76Lm6BPh/8jcmHnPRKTZpeJ0aQ
	 82Q44wwD6AMwlPo/iDxAHSOVI5IH/Kns98zfiNq3xhO1Edvk9AtxeDvi9jXapsxeZ0M2C
	 YI3gLfNQLpA/g+W9TWJVeUFNsBBsPEi6xdvPhv/tyQ0SetggXepkdXB4AyY66rtH3XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KVaAVW+Q;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE2606A323
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDEE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KVaAVW+Q
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso2246827a91.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 00:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794470769; x=1795075569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gma6tEKKFClTNwQqyrudA9xAP8hDFuYrKZEMjTt+5oE=;
        b=KVaAVW+QM8Qx3j8rarPWiwsJXaC2P/laffzehB8YUNEvHeldzttyvEEpnwiIasZZij
         d9C9jV/ULN17NwW3Vd7SzB7d85B3JweWpfMqgwkGZLiChDdlg1PZCOE7OwcU4bxkZgSS
         bA7zci8Rp2Uqz9suxo/viyCn+BATWcUxYE/Sv6U0AguJQ31sCKKfx/y6I1onYfjoesvy
         Wk3onyOhVjl7XlciOSFPuas+0kjJYJtip0a8uaTdkGMrcrbXaRAg58tjdyP3LHtrWHNu
         hddH0qGarYPjb/sJno/LE2qcOOkmmWXPr/MCsJQIKh9IT/g9WULFkKLiFPD7zgLx0c3D
         Ip3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470769; x=1795075569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gma6tEKKFClTNwQqyrudA9xAP8hDFuYrKZEMjTt+5oE=;
        b=pM8Crjc4M8WNnunjBBi4toxF2u+IPZM9A8FOV9pcJSYYgVv5KBzjQy7LrdwU56nUkT
         7C/wQVocPLbF6RYAm1MgAlI9G2oQTvbGiDDqU1BHWIhtjpdhnK+PwfEN+bFDu6q/UNXB
         9fZftb5SDbyHHRt5rxX5VQpgQ9OwesCpO44EzvMwT2o3yP+j5yHNsHOKeu2U1b3eTApN
         DFHc22H+NhWFgRrr/mwU6j67GhOzNK7iqaCyQyoBzkytFzUtXIZl8UBThXZQR0vr3Ddv
         ZQyymp8Ty/dCYVQWIjSjNFslxe3O2huzmkFEoCiD9NUlFfKb2WZSGjYYx20MHVpAn1ga
         MT9Q==
X-Forwarded-Encrypted: i=1; AL+hErG6cbP8MKVVXNlgUOYlG8ffXBPxjPgzEQjz5hVIfdNCdvCvCEFd1aaA9eXHAs5z61faskoCy53W2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8BS27gce+dx+qxgaMypJN4Uvjd2zq7m3yyZFq2sTtBC/4Yi3PC
	jU2fq0A6kpSuPeas4GM1JzfJvMPBYOatr5tuuNlsKE5LwIUqdzyEpYAO
X-Gm-Gg: AYBFou1UfkVGso6t2rffAX6FRYS3RydetiTE42o6NUM0oKzmACkt/bmrE/eMZjSE88W
	7Cfi9fHnjowy4T+iM3IFrnNVcwoAyXiSuK9bBhfI3vZw9zKhlX6amFD2lMicdKixCciF4M7dPTB
	+E+8LltjC0EJzzX1uyzBgMhIVyAnalqUKnemS6/V8PG94f6SJQ1sjJ0MWQmexyKMWQtvt68kItk
	10gzUjVBPP0ZTFoNJurIYpcfgmpxlz4ut9YhsIERJ3b6YNUcytxSO5wHJut8BqZshHWq9Lc/Tc0
	T++eWYxxnKFUB7XM0zAM3Fp0DFC/FWxv+9fmEtPubUSwPNGoSDxQxSIKiakomVtgOinWZO6isnC
	TbCKzDhVJqYr6ioWN6lfj29p/e2HbxCRz3ufYIs+j7pA5SVImntAfeRXku72H0CxrKrBZBrX3fe
	MHCIpFYmyAIbbz26OBUbML+bSU1r3tcMbG9ymeNqUrerwqRfgBx1tcor0//FMmXLJzDz8PCa98q
	b02EXhQveYScHVGzq6koNfwmMW1J+gQEN00TxCSOK+gC1genkdkirrKmpgVGKfYUk9nsXU/RxI0
	UPiBCJLi6kefMCO7yY7n0glhkBdJ6dYwLlgTR1sV5bRDulptahAi4uURxyRq
X-Received: by 2002:a17:90a:e7cd:b0:3ad:6090:a189 with SMTP id 98e67ed59e1d1-3b182f93b3cmr4879918a91.45.1794470768965;
        Thu, 12 Nov 2026 00:06:08 -0800 (PST)
Received: from shaunak ([43.242.208.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197ce49d6sm3474383a91.4.2026.11.12.00.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 00:06:08 -0800 (PST)
From: Shaunak Datar <shaunakkdatar@gmail.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shaunak Datar <shaunakkdatar@gmail.com>
Subject: [PATCH v2] dt-bindings: thermal: marvell,kirkwood-thermal: Convert to DT Schema
Date: Thu, 12 Nov 2026 13:35:32 +0530
Message-ID: <20261112080532.30774-1-shaunakkdatar@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Convert the Kirkwood thermal binding from the legacy text format to YAML
schema to enable validation with dtbs_check.

Signed-off-by: Shaunak Datar <shaunakkdatar@gmail.com>
---
Changes in v2:
- Fix the maintainer property to use YAML array.
- Add the missing newline at the end of the file.
- Rename the schema to marvell,kirkwood-thermal.yaml to follow the vendor,device.yaml format.

 .../bindings/thermal/kirkwood-thermal.txt     | 15 ---------
 .../thermal/marvell,kirkwood-thermal.yaml     | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/marvell,kirkwood-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt b/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
deleted file mode 100644
index 8c0f5eb86da7..000000000000
--- a/Documentation/devicetree/bindings/thermal/kirkwood-thermal.txt
+++ /dev/null
@@ -1,15 +0,0 @@
-* Kirkwood Thermal
-
-This version is for Kirkwood 88F8262 & 88F6283 SoCs. Other kirkwoods
-don't contain a thermal sensor.
-
-Required properties:
-- compatible : "marvell,kirkwood-thermal"
-- reg : Address range of the thermal registers
-
-Example:
-
-	thermal@10078 {
-		compatible = "marvell,kirkwood-thermal";
-		reg = <0x10078 0x4>;
-	};
diff --git a/Documentation/devicetree/bindings/thermal/marvell,kirkwood-thermal.yaml b/Documentation/devicetree/bindings/thermal/marvell,kirkwood-thermal.yaml
new file mode 100644
index 000000000000..00edb4c8f8f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/marvell,kirkwood-thermal.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/marvell,kirkwood-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kirkwood Thermal
+
+maintainers:
+  - Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
+
+description:
+  Thermal sensor present in the Marvell Kirkwood 88F8262 and 88F6283 SoCs.
+
+properties:
+  compatible:
+    const: marvell,kirkwood-thermal
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    thermal@10078 {
+        compatible = "marvell,kirkwood-thermal";
+        reg = <0x10078 0x4>;
+    };
-- 
2.53.0

