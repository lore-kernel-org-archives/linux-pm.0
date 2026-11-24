Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795547634;
	b=e5cgi4+Ukx8HZT8Q380us4UoinP+Zg++TwBJIeUQPZoHdToSnxntSjF69djIwttjoKAc
	 jqGEvqr6XF0nAn5wC98h3W5QgD6/nI+MHHHwgdxErIZP7v/5mSH2/2dm9p2G2rl4GAGN8
	 5jJFPhaqPcgTMRtssxdPibEeJME4yiT9kDMm7RJouLAjIMVDaFUCMQ3NXPQsldIIlB2HW
	 +ygB3WqIKaAJtalj2knI5HJmbLd0AwwxiYOG+5T0bwJIa1YwgtXCtpqcwU9h1VYKATotF
	 lbxIvblxBoxMiHgG8TqQStTXCN7SfJGlM2TVvQTf70Bo+YQxBnfD8KJOYFPy3gbF29A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795547634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
	b=DRSm0elBbl9YCjJEP/AXbwec/Qa8NttWCMwnJReQXj0GtpiWZn+juMALyVwyXVmlmjyg
	 zutUdgb/DxmswPpYDomEGdj3bLAD1/pmkCY2QCWheuRLuTBP7b0sXedCKyeOF8kmbkrLj
	 VO9Q0GCf3EiOnYaSnfE/2QI0OP7cTvjVZwZORVPICBoYddP7MjrQxhgMtiQV3+J8et+NH
	 LXfYucTrwfDeFqj2DUVc9TWmeosT6QC4CTxtBv/iRSy19KUm6n6h2miO4Xdf4OPEPNBz6
	 l++7lYsejVP7RU7YNhhsC4Vpm3QVQI99Qh+oTssfVsoCAOKaecw6RQAwIaAZibnmKvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VeMtGqoU;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB739606A334
	for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB739606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VeMtGqoU
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-57297329b3eso2591100b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795547632; x=1796152432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
        b=VeMtGqoUSPC+x/+aHGwCyTPQ5fRdKHU1VUtXjTh/LCy0gAXXMxqcGjxF+NktAw9nCz
         14MsjfU3wtXmRVpqA5lEygFaEHXyZAhi5eeroFwQmTfY4MCDdO4I58SrAU+KD5lmiHjy
         S0LlbsRlq8w1QCRzOfPtOKH7Uh2EXhES22B2RaHvKV77OSmYpmzezHhfPwMe6mrG6h2I
         UydbIO0CN7nAuy6jJloYbHWbj7FRRwat+PyxTMyy72VWvLqz+c6lZ2XRiVeMwLdQD6P7
         rlvet3l+0kqBzVpnzUln4xauZoCPbzmR5o25u3JvC4U59nD/sp8106nNm77Lpc646fmM
         qQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795547632; x=1796152432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8DwRmjGjcZQoXY2ILH3hB5x2vfhtY7WuYsGRx6Zuzow=;
        b=WMz1JnrjX22FZFAXRenO7unUW296ZZV8A9tPQiBsVoXmJ6v7r6XnMhTePS9MomvV3F
         VsdaG50/iTb6YfY+z/D3Yo3LaJBhYQKDWZhvMaip/xLE8XazOIYj5l6PPFOjB7DIwDKF
         jafFrQhMpZ/9pR8eK6AcpQsjB7ogWJyKLneSP+4dlcnT6PgHERICmcYbietoVuKFqgzi
         sohFOjGWnr9WmeMqbe1yLiMuOaNH8Guo3LSRwty4fPNGPOHRWY0j9sp7dbHhyMv/xCiF
         LLpd2R6U82pdB1Ue5FxWZNpCbv3jy3H7De5jxORfELHnd2QIWHQTxF+Yid3h7GnORZ6+
         bUgQ==
X-Forwarded-Encrypted: i=1; AL+hErFhQ+09R0RttnbK9dxT3EP5gUSpaODVKHPNa50e3dGPLOE4VTVu7AwM2ZvRDqwUafqpOi1+2xJjPw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9URY9Ov7AYSlsG0p9JA9QRW+OqRZXaALBChgbBCXiq4IgnkPsX
	YKvdCOaw5tHP1dREOPMqhRP5dBPd50ohsCAl8LFP34hRBCOfesURY8mq
X-Gm-Gg: AZFdTZcPrgXe7rZxAq7/TdQF8pJJQiH95WKiQJhSUiCbvUKX14MHzGbfBO9ECt4V500
	gr6UdpNxJvF9K1O3+pLKaVLrHNT3No9Md//lc6kKoCFOFEGZPOZMYV7tz5dc9PBMJ6rmOvwBBJP
	PdJX3q5u1a/5R9vFwAuA1sJv/o4qzLXchQ9qWXMtnZJgS5sC1cv0parCA3ebYx5riwFeWGpL2fL
	3PZAo6Uc7VzELMymBdS4RqewcPVnySumv9+z47VpRhYdtLio6zsq2gTARVsSfi0qY5X3FZa1G2n
	7IDZGbx1Kb3Nv8LwnNJKIzNkjg5yXZ9Jd7lFPz6OuTO/6Y7+HoXrnS9AVuAofZfJ6dlnXOV/mMB
	xNxM9FtMWprLBADu/5vJq1Ruh5oRL5nPSGc0aqup2VfbxAgs9Ff4RU18ZL9yBVeV6n786Sf+3Ba
	SHt/o+/3Z+KXG8xWYlr3Y7zp11U6Wl4FMm8TjLLJ+ZH5s2jgeCoBYIBDw0MrRd/RjY7b9OfFTWd
	wJmjr+w0IK2+LvvXnhiIa8GscUKMVahwVocpNZgI6VEivC+QAp1sEadskdZ/c/xttSeXSmp43WV
	9a2DSQifS35oKWcJotKf0lNcVl/P93AJyoiNC4nkk5FM3zlCv0k=
X-Received: by 2002:a05:6808:6415:b0:577:28d8:2882 with SMTP id 5614622812f47-57a0bea6553mr15828891b6e.48.1795547631858;
        Tue, 24 Nov 2026 11:13:51 -0800 (PST)
Received: from neuromancer ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-57a362575fbsm12774058b6e.17.2026.11.24.11.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 11:13:51 -0800 (PST)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	shawn.lin@rock-chips.com,
	linux-pm@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	sre@kernel.org,
	t.schramm@manjaro.org,
	xsf@rock-chips.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V4 1/3] dt-bindings: power: cw2015: add cw2215, cw2217, and cw2218
Date: Tue, 24 Nov 2026 13:13:44 -0600
Message-ID: <20261124191346.434143-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124191346.434143-1-macroalpha82@gmail.com>
References: <20261124191346.434143-1-macroalpha82@gmail.com>
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

Move the minItems and maxItems for the battery profile to a conditional
based on the compatible string, as the new monitors require 80 bytes of
firmware instead of 64 bytes.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../bindings/power/supply/cw2015_battery.yaml | 41 ++++++++++++++++---
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml b/Documentation/devicetree/bindings/power/supply/cw2015_battery.yaml
index f7bde324153d..992cd5f6a216 100644
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
@@ -43,12 +42,42 @@ properties:
     minItems: 1
     maxItems: 8 # Should be enough
 
+  shunt-resistor-micro-ohms:
+    description:
+      The value, in micro-ohms, of the shunt resistor used for sampling
+      the battery current.
+    minimum: 1000
+    maximum: 50000
+    default: 1500
+
   monitored-battery: true
 
 required:
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

