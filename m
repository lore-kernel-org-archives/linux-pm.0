Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792662104;
	b=GwDts3hNyn1cWCRj1AmsZCW+4S6p4bp2fh2DQd5MOeVXKCEmKBrnvHXJVSA8D6TEJHqb
	 SjxDnWZMgTxxl+EL7fuH83OMWddu3Xm41LZajVL8LC6gxVOeWx6psp1fwWENbsJFrQkeH
	 uLn2qkrORsyfDgrxaf6LWDtBB89/9T7E7TGC7bAjyCUl2+reYDp7cJteH17zft291JMmT
	 oUbGygNkKsxGZXnX1ponGnoKH9IQq0Piy1SvwB61rd/HLRuNcv2LN0YB1ZExhjqHkmYay
	 tiv/fg53oPV+pebFY31dTRKMKW7F8hydg1la0GIn8MzcEe+3iTDI/6SSaYgZ+gz/dbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792662104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=OYDgm4R1tjaY+JvgEyu2MMXdyhh68gFfDYeaLIp9hAE=;
	b=gQneyw7vJMP16YYDrneqw49eQzYiMhjQtlNUsifk6ArsId9QUTqHn8jRirndz1HCrkZy
	 9BmOBtFDVLIfQKrijKQnYNRnM173jH5E5EplIxaEku030oxIGaU98c4vA2C2KeOFwpU4D
	 /c/ZKpZLNeSKvi1RbSs0CH/2Vi1jcy5y0guXGuSRUCTvntgTGmdfraQJCEYa1LZ3isK6R
	 0ipSjj7A2LoQwjTRN50vIpwEmkm14sic5BDA3yhJ2w6Lm1lRPWG2KAa/K8rsEZzTq0bro
	 Ub3rhQTbccySURV4BBgpCJw3WMo5+afWk+lVE4HKAMrcOiClyOHSY9J1ha2jEjR4ZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft85iyEp;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CCF606A324
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44CCF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft85iyEp
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9d7791b00so7405195ad.0
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792662102; x=1793266902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OYDgm4R1tjaY+JvgEyu2MMXdyhh68gFfDYeaLIp9hAE=;
        b=Ft85iyEp/12SfLEwAij9mE92Qr0ZiQXzSmTKtFfmLaSrmJxg1uOe4AbPE77e1Efbza
         WlbgZCwprEcvIugCo3kFPmDksaKpGt05pcesVs+k5n2Qarm/yYZkLa+R1KhJXOlFsQMW
         2pZYasxHMnAIPQsFFEQ7SxM5pU39s8R8rEw3PAPDt80ATC+3qvJHWeov/M0NBoGUAgMn
         9OjDc8Dbd5x1jP3dkG61kmki85Vrn3IfBSKbHNghQVJD6ZM7tOISdEKQcgI3UyC09lLP
         X36CYvLY2uTLdDnutUqm7V9mvt+FSIWsf2nVyk8i5Lh/sxNiPn81hIdU5SuAmalUX/cY
         S2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792662102; x=1793266902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OYDgm4R1tjaY+JvgEyu2MMXdyhh68gFfDYeaLIp9hAE=;
        b=xqLvYLYd/jjf8Zshrg+QPbsaL/HflPUt5QAXJa7+PWYYVp/uqUW3/Uc/cgdbtQWwke
         a0BU5NluO+LQ2Vrpbtt3s/ZCFJbZ0T+K9XbT8uz5yF/kD6p1a7GJPRT9nu8X4J0oYoU6
         8PWCeGbHjPOazrzRu8ucGzuS9mEFT9S5wzCZBjUbDctXUPV8GuIODVrhrej/2YnI/s3F
         P+MPlV7cOz2JrFwal1Dk78wkXkKFgPjEPRYf2GwWX6UXrSyL+tXev6JWYd4V0xCuoBCS
         SzIuK8CIiSN6onHRGMktfaYeN97w6HrTvjROXQYNOuG12sbOME3tl8MUGLdZhXjM677p
         dYkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBZOVyST1TxTDg3TTPIEYSMZn5T44vUnhUpcyV68WNj9Vui1kcaZlkVRAd5UWe3ciS/xRUibyr4A==@vger.kernel.org
X-Gm-Message-State: AFq9FYJvBs0iECTti3ZcocYwlK6oShr2vMJQCrh8hvWbrWCld+BsBU43
	IcW/0Q/IL943VSUaM/oId5X2ueGgHtUOvwkzSpgJe+h7wLX2iuGTbbSx
X-Gm-Gg: AYBFou20U9+DMfsr8NH978Muv1TUXLz4F7YsAt9RpeeFmswjcgvTOIPIOSzDHwkAGRT
	98zA2xyTa4o64bMytWuTpO0zYPY2BpCPjcKgf0pQokJOX8wtflSnwYuvs8oD6YrOlLhqB1dzahC
	Gi9fHWqJYMHHaW7ZvSIqVD8uR/9+8ULDD9FgJbYE+7KWfWequkd+ZLZTSVMC0cQAPIxfCh3cBDe
	US8dZie1DBUtla2md92hrByKSqSSaWZAoJ9CQDF8FPRifaKoTw3UvkXtkL1fy2/Rty7t0per202
	Vhrq4c6pewSDb/IYr+sKbNfAGMbxwZFzmwA6Ollyq/8aU9o3gI3gd2QCVtqGNgI46Mr7YEzmsF6
	OkI5SQySEXJH0ZHGgV7r3CmeN30jeX3mSpT/44rt6hiPzAmIQDSry86zSsA6NPdpF8Da9Mj/OzQ
	fjhJxDmlylJxuJ4SimJ40Z+yDoAdAe7G8xLs+jZi2E49rhG3d7GNyTX/lbbn21zo+T5ed8AxyBk
	GUwmybjwx9Ngxu0bpvvc8VfJnwQOR0uhwy12jcsxl5PIB/J
X-Received: by 2002:a17:902:da8a:b0:2e9:660b:35a with SMTP id d9443c01a7336-2ea437b199fmr37175735ad.3.1792662102554;
        Thu, 22 Oct 2026 02:41:42 -0700 (PDT)
Received: from [127.0.0.2] ([2404:c0:701f:d27a:ab05:82e0:7670:1951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4356c1sm21483075ad.38.2026.10.22.02.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 02:41:42 -0700 (PDT)
From: Reza Kurniawan <imkyufie@gmail.com>
Date: Thu, 22 Oct 2026 09:41:10 +0000
Subject: [PATCH v3 1/4] dt-bindings: arm: psci: Add
 skip-suspend-mode-switch property
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com>
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
In-Reply-To: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Val Packett <val@packett.cool>
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
index 0d04389c81..2eee38d155 100644
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
+      it for devices that ship with firmware known to behave this way.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#

-- 
2.56.0

