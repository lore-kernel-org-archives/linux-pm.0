Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947513BE16E
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255365; cv=none; b=I9NVHT0sXTZ5+2h8nmNiIuHSXLwREu8441vD0AtkK/p9cguDuEyEnzOerC/wexNgc1Cm+bJ8AolWa/X6uydIiBoMvdDgkdoD802BUmgEbsqkh129oxdX5d+i3CBKEglfZ42o/Bey+7bkn8upWjSAFnvfwf2tIqvTwfdUSrqBDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255365; c=relaxed/simple;
	bh=qEUwuxS2ldHJrvbMxrPEbm+N5g9T6Qqu/k6SeHZj9OE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cmO0lPIej/KFjDaPsxLK6xV3tzcQTcaMioXh8JEgyg0YI35xhT8tda4liyzDm3V2JFmgu96LVNwRZTrW8NitDinEg6ag/ICbhj2HfRQuIo49oEfgoSBFvXCBH3dqwrzlQodk1qX6zONQekZMv/DvQsQ/CO1mwCvsIadJDSUtk0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tp/327LW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tp/327LW"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso602892a91.0
        for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255363; x=1792860163; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hX9ySrij59b5BCGF/OT7UHUToVS6gesb8Ac2hP4ly2M=;
        b=Tp/327LWGCLnick1CmbS9bvWn+5MsjeZL8eGuYHXvysCnnmBDqQ3wEHCWP7Vm1lJp6
         DRZfGIknlkcTqYr/JFw+yu+ByO6QbJEG2GQaPOLdEWOD1dTsPi8tmsTLGz/aMgcXv438
         tLrY2BPbMHf3ZGZDWobPyJBd9OnI2kqpHsZkTKeWxE1gs0dQyhI0aXFSd4P0UQbXC4CT
         90nQoSsXt8uX3J1lDj8SFTqYpiQ0BouZjmM8D8/n7EpoWtmwO2dqpyicx4wWi4qQnngI
         OT7Cwob74187Rj+Lw2El1y8wcC86cYZYaaGiKj5tgu8QxgdVOoSAf2X/g97yCM5LfSqo
         Vftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255363; x=1792860163;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hX9ySrij59b5BCGF/OT7UHUToVS6gesb8Ac2hP4ly2M=;
        b=1j/6EK5Cyt4YdItvt7Dsz6iaNC9YvOPgHEi9ynqK6GcfrKgoztYX71bJfXkVPYYxED
         9lb80CPWHJDtICb4SSOl27feIwbFo1H+aa5u6hXG7h/LzK0qwNirkHeKm+xzYew/JomP
         yCrYdsAnKr4lhtkAmes8Yb6QReMtICY4J6gWiOJAXGn2/YVQhoUXzO/A/8oqey9nMLfa
         YKVVAM69oN5ziHceulPZF9zAcqAeLoMZcR9/5EqdgRcQPwM4zldOMyrHbQd11xRskxZw
         MNXNj/ZOuOMqwcI7ghlU5Bb3LE/vDgCIf/SKrSNlt6l4N2MaXl4VigUGRxKCPVmjPMJL
         SZOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+0C5CLJKDzbbl0ruGxyScEmQgZFGCIooyAZca89156SDJerxQnMmnq0NFbIEIiSUGME0Sb86udw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuWGcshOItPa9aXWlEL03DpqJSLNllklJvI2P4XAkJlfrBkaFI
	8czPWbs2t/8k2QolJqkgkMWw14YVuc51Pg2KLiF62PSYNVJYYNK/0ysJ
X-Gm-Gg: AYBFou3ImVKVGQ0VWq87wdBjGZL4Es4hy52lMRcy3slSBcyG+tJ5OBVCHnPdCmm6c7L
	m77SEXnsNeAGFU/yxIqYnw93mIg1jDJODPToWodstVH5pmuQLGOdNywD/Xs/O1ScT8RhBsaVbWj
	cZA51y6waOjpL43p/Q5tW5HPoTVVVU/NN1C5fmdCHqGF9UNWtwjLZ1Hv9t3CHgLCq1YTrXJS4Ab
	S+iu5u/d6UAjI5mq1eDdPx0HaXUOjLmogXqHj7d80LRuWBuGAyASEyKLHpvTeKY68mYZDwwm+NK
	d6X9QnXd5irq3flKO1Dn58sXT4HlSPHPfw4qEPFUKRJN5ZsHdVg8xMJEzScjjuD7XJ09jSEuuXP
	Pob1rw79qBCir4WgxIWRgynhkYlTlMYux1IbZqVNBp54QS9nux486yrY/MbZOdaFAPqQ8Znw5Ma
	PHJsyR9wB60tTCUK1fYlvR4r+YRHEeAQlf6NLacJWMPFK0PFR+6ylPh5+JLO3T9w==
X-Received: by 2002:a17:90b:280e:b0:3ab:be66:ddbf with SMTP id 98e67ed59e1d1-3acef58d853mr2395968a91.54.1792255362914;
        Sat, 17 Oct 2026 09:42:42 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:7618:4e1c:2cb7:b2e6:ffb7:d23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94798212sm13816164a91.14.2026.10.17.09.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:42:42 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Sat, 17 Oct 2026 23:41:23 +0700
Subject: [PATCH 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-psci-fix-v1-1-dedae27e4a31@gmail.com>
References: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
In-Reply-To: <20261017-psci-fix-v1-0-dedae27e4a31@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>, 
 Reza Kurniawan <imkyufie@gmail.com>
X-Mailer: b4 0.15.2

From: Alejandro Tafalla <atafalla@dnyon.com>

On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
call is rejected with NOT_SUPPORTED.

PSCI provides no call to read back the current suspend mode, so the OS
cannot tell which mode the firmware is operating in or why the switch
is rejected.

Add an optional flag that tells the OS not to issue
PSCI_SET_SUSPEND_MODE on such firmware.

Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
[Reza Kurniawan: split out the patch, rewrote the property description,
 renamed the property]
Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 0d04389c81..7777077dd0 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,19 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  skip-suspend-mode-switch:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Do not issue PSCI_SET_SUSPEND_MODE.
+
+      Some firmware advertises support for OS-initiated mode but rejects
+      every suspend mode switch with NOT_SUPPORTED. Since PSCI cannot report
+      the current mode, the OS cannot verify the state the firmware is in.
+
+      This property is an assertion that the firmware works correctly without
+      a mode switch. This is a workaround for non-compliant firmware, only set
+      it on firmware known to behave this way.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#

-- 
2.55.0

