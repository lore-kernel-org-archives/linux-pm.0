Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895566;
	b=hD/7tCurAO9Gjh3JESORjTguu3M7LSA2yJ/r3RX8Srr3l282SMJh8yhX+kWkZNYa9/iB
	 nrs0Z+PpLz3YHvRWo2UqfPV8pMoDtOvMORZ73QswIe6o7DKMVLln/Va4GqH8pHNu0lKQs
	 PLjHaLV/N+GuF+oO4yRyP+tTJzMU5PfD8NL8iQgIsPpvbYsTSBnjBP5LJH+YJpIjG1Tba
	 Lkfm2SgMipfOZfGEO83fBn9l7MPt3uuHPFMimB7puMLRhuJ7TnYd3sXWb9cgfLHouyk3m
	 Dbprh1/7OPKbv41BPdufBQwjgih0fMj/wqsC1RCJw6u3aP7MTDU6+1jjEj+8Wi4B42w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Fn/7Nz6sEtWAi655Kzihh8bKMNCzwwsZZnavj9Q/a3U=;
	b=GWwHTt1iR4DMn/yjfntMLlktAjhgffz7G/vz/5Cnn+k0JYnQ9Bv2DYaJYgS+5JO0S27h
	 ZEGfYqzN4InTmujyc5RdLucB4F0X/yciLwWxurqUveJcsZ4oVTcZ/FFQKm0RWYadgVivo
	 kyBlx8fy870q9SLPWB3uqLbzp60f8rx2GaDq0Kjtck8iN+KDqd2pzTECMUCuz0lv51I8p
	 HiFNUbXcbB4rWKQiEDinzbqapklNiVZFkQGbyGINrwbeMSTwU6vPVhnrrablMOyoqYVIB
	 ZkPj0IaLZE4JQHfqdDF3LkcERqxz3KbxQYsfJdUqFtey0ojP3Eu2j9yhvTzPmOybYSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tWi7/q6v";
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA2606A334
	for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2026 06:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CA2606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tWi7/q6v
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3250126b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 22:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895565; x=1795500365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fn/7Nz6sEtWAi655Kzihh8bKMNCzwwsZZnavj9Q/a3U=;
        b=tWi7/q6vl+7+X0c8AHeIlPtB1P3zi9lys0vDqtm9cI0df1oFwj0GGruQmuxMfwEKiP
         Xvq26YKyWHF3hcJy0fdM2hrqpYAtw2jBCV/+R/03nHhKia8DmFmUExRQTkCcNIlt36f0
         tI1Dbny3jBaV/TPAa+EbI3wAFvTMVwiDOekDX38XhGHGuzkqD0/gBiK40ack13/ItbA0
         /0E19o6ShnYSdNojBqucpQEnp1QKszf6c899p7rLSCSqyuSo5Q34M7iCc7lrZsD/pcop
         maoUBTLffKO95rskK6Jn7FMhYvVuh/4oMUe5mmN83E5da2u34m9NRrSMZT4vmXJIhKKA
         QaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895565; x=1795500365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fn/7Nz6sEtWAi655Kzihh8bKMNCzwwsZZnavj9Q/a3U=;
        b=YduAQUPwKvlu2gpz/wJ6+0TY3GHTyp+rOgzvm4kuT5jGWZZjX5tCRVqm6u4qKqbHTp
         3T1T4aKd2dd+e2KPksdbPyylkRmTz/b54J7NrbBf1QiHr7mdl7+DkK3YSdzYd2y+6tQ9
         zTFdQVf5GVWBN4hgt748yFLyNWWy1tlUBAUaFXeLgXscm4/roIy7R8bwAUvXwDTgeXtH
         x7/JeFgXA4mZS8VOy12uwOzlPZuutNMTl7Ti3aKXdYNQoqWQ7KZY6Uk7DRT/Cwb+q2xW
         Ra0OGZwP8LFmyBecjcm0lcEFbzv8yZRpacCsh7qF73nEtiADVLFT4JGONkok5BV+uS++
         cW+g==
X-Forwarded-Encrypted: i=1; AL+hErFXJaF/1vROyEAVuGz6SAQTGLfq9ZXk4N3oLRP8LIdZykSsPL8UXw7JLj83xoFQmeWUAd6PNiU8tQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Gpha7Mo60bSOk1sF57MNH4sGLTFr3YdGQaOwrJDbdJEX5wmFS
	ljS4KP4Frktvoqoplf1/RANQTF87czw92D74lAGbgxPFylLKyA/5A39a
X-Gm-Gg: AYBFou0h2qrSNeQrh5fLQk6d4DmKFZ5CONzvORHPogwLYiK3t1bnTu55I8HLL9SJ9q7
	BuJ0ehQs2k6SartrMIpVB/BcIhhsm0tkiC4TCKRTlir7PqtJxmebI8Hx+jwpn6dKvZ3KqOQA0+7
	HW2BUey03NDl6KMaV0H81SBxrL6A7mVsfbZBhw6ljufPnOX56VHpnWx1D8z7rcJmPHwnQpXcWmk
	UJJhgpksoOg3r5klogsdbs4TTzsm4oDY5qIueLS7mStEGHohguExsE3yj2OgTE58MZrxtEkpfnJ
	muHXN6o1YNfsgooQkxgh8oyNacI6DP3vdAv0+wGxZdfdfZKg8J5fhclJD7dCP3hB4NOTxFT/Kh7
	fcswExYj8Bdb+idB0lfpfAs7huYfqu+mqB+gTj+220hnwgfIMNaQWU//rfmSvVRj+GIOc93sZfA
	0fTwRStv025E1UVUbICAG9zfXks24uT3JWc7m23o6rF5fDP44T0XtbcIU937IfsCCegHuag+XA8
	dX3LdjPJFZte5IbbC4YuZss9YoPP73ZQWUe0o28i29oHyDAy8YRsXJw7mUq6vJXqquQmffj+d95
	My7zI2sxP3tXX54dY4sqaJCWLGL3F1bkL/3NUl79yjCHItboMzuv3P5GWiJRqPihTb0Wx20FSSs
	8zjJ/qxIE050=
X-Received: by 2002:a05:6a00:1990:b0:8b5:efad:d088 with SMTP id d2e1a72fcca58-8beb609d4bbmr11260989b3a.9.1794895564913;
        Mon, 16 Nov 2026 22:06:04 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a8172sm4464623b3a.13.2026.11.16.22.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:06:04 -0800 (PST)
From: Zi-Yu Chen <zychennvt@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zi-Yu Chen <zychennvt@gmail.com>
Subject: [PATCH 1/4] dt-bindings: reset: nuvoton,ma35d1-reset: Add #thermal-sensor-cells
Date: Tue, 17 Nov 2026 14:04:58 +0800
Message-Id: <20261117060501.2611071-2-zychennvt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117060501.2611071-1-zychennvt@gmail.com>
References: <20261117060501.2611071-1-zychennvt@gmail.com>
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

The system management (SYS) block of the MA35D1 SoC also hosts the
on-chip temperature sensor. The sensor is controlled through a single
SYS register and has no resources of its own.

Allow the SYS node to act as a thermal sensor provider instead of
adding a child node that would only exist to instantiate a driver.

Reference the common thermal-sensor schema and update the title to
reflect that the node describes the whole SYS block. This makes
#thermal-sensor-cells a required property, which is fine as the sensor
is always present in the SoC and no driver depends on the property.

Signed-off-by: Zi-Yu Chen <zychennvt@gmail.com>
---
 .../bindings/reset/nuvoton,ma35d1-reset.yaml        | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
index 3ce7dcecd87a..a0cb0f98c1b1 100644
--- a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
+++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Nuvoton MA35D1 Reset Controller
+title: Nuvoton MA35D1 System Management (SYS) Block
 
 maintainers:
   - Chi-Fang Li <cfli0@nuvoton.com>
@@ -12,7 +12,10 @@ maintainers:
 
 description:
   The system reset controller can be used to reset various peripheral
-  controllers in MA35D1 SoC.
+  controllers in MA35D1 SoC. It also hosts the on-chip temperature sensor.
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
 
 properties:
   compatible:
@@ -26,12 +29,15 @@ properties:
   '#reset-cells':
     const: 1
 
+  '#thermal-sensor-cells':
+    const: 0
+
 required:
   - compatible
   - reg
   - '#reset-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   # system reset controller node:
@@ -41,6 +47,7 @@ examples:
         compatible = "nuvoton,ma35d1-reset", "syscon";
         reg = <0x40460000 0x200>;
         #reset-cells = <1>;
+        #thermal-sensor-cells = <0>;
     };
 ...
 
-- 
2.34.1

