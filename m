Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793456389;
	b=q7phOXliLxND/siH7w4f8joSAvxc6dmtBrWO0p2PPQ3pWntesvbaeuGfJeib8qfwoDhT
	 q/JE9xJEsiAHbLrc0FwN79T5BAr3V8LmZQ12js+q3tP9d/7d4wzOLWZLlc7R5SOPf+GcB
	 Zkydgk0hk13ZIgUnfVW9Opt0Awx4LH7xMpghPmkrEnJlqORCoEEcPCCjKMgu0U8kRCteh
	 oEFRKyRcs7BY00hHWuKP7wwcoLq5M7zU112M+amX8Hesydpnj0qK3wNVXWvCVXLo9hE3G
	 WoNY+imQ2r2usVV2i7p1YV7rb+6tqO+un3vgitsRJHMNrtMtbwCbE7clW098UVB1qbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DumkLdRaEi2aL/d8oCdFXZcLeE1nyTM9K2F0kvbSfy4=;
	b=L4yAr2l4ZQlpOdfcBsCT2umaxlIJ+jian9GELsPVWaIv7fKilSbvQbiQ7Fw6MFFDc8Es
	 XyHDZ26TYzPRLe5SySTplIdd9XNGCYcVM+NTYMrHpSmeVYQvzUjlf2hivE90sTMrgSGOH
	 1KoCpEhZ09mKMu1rNbl0K4F2iXS5FQA7034dEQkly0SR5/fmB4S/vcQPhlU72h/i3kEUA
	 VvQKes1lVmJYnCZFhjhNCGrvhXQpiHViFG6w+9AtxRnlbGZitU8kZNb/6B6j0/iMnoGVO
	 nC0GhmhIwX7lYnUv0VyU6hVhXkq/DeFWXaDOCcIFI1tHcDOkO98bn10VzdVniKMS6jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhioXdfr;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D20606A31C
	for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 14:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05D20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DhioXdfr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so18158405e9.2
        for <linux-pm@vger.kernel.org>; Sat, 31 Oct 2026 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793456387; x=1794061187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DumkLdRaEi2aL/d8oCdFXZcLeE1nyTM9K2F0kvbSfy4=;
        b=DhioXdfrgaJlZ22HTvGQPCeRUttiMsmL61Z+mzkS0AjXsZuhKzl0srNgL1jdlya6nD
         WwZOhxgk9Zl2+/au5urjac0KC+ppFbkcoSWXVgE3ToaxC2p2HLqtRLU3vREt9TI1BpFX
         fx4wGQimT6AOUgZkSD5XZsk2mtH+Fik5m+pe0C6e0htIBGnSgyQQxVjppnUyDVnARocG
         VUVgo0sE5dIFZxuIFTa4okxZMMeDfDl7pYVnIHtMaX4vnLo2ZdgDfM7olreZfn9yCX4R
         +fUm5JG/Yu3Ky9mrZBBJZtbf+b/ZZ9taexlyfhvq8+9SIBwfkNYHuL/RuiRCNGS/vD9o
         cYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793456387; x=1794061187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DumkLdRaEi2aL/d8oCdFXZcLeE1nyTM9K2F0kvbSfy4=;
        b=EYMKtbtA/vHs8b3gNI1T75PI2kepSYKFNfPu8fLaw4GuqNOVnOMRqdZ4fj+fyGFGKC
         rBZSvX54y4dIdiz6oQdr3iVnVMuAwyiUuVeVl3PO2yiqnOnwm4QkCy9VK4Cjn88G3RlR
         nvLZiXFBZxnkbHAdElOIuSx1QIQlaCUa94IHKrYCXJgtmbe9eIU/8j0hC4Y0ezQK1j79
         hwKmZsDdi5T6YZbY+v7xL8uXY7LebSDdBnE0zeVW1xkSPSfOnKFH46RaFZLq9qmxsgcw
         R1icbaJd6TmQlv5HyqVf32gs9W67uZjxzbrvn7LKmMG+XoLBOSVTat+Coxqs3I8pEs9Y
         6+5w==
X-Forwarded-Encrypted: i=1; AKwUvBzuLyIoDznRC18Gz3A+uTO/UZJplC1R5uY611jhOhCOiaffCZcMb7MZdoQiScsLg2XAWkiHVhhJyQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKwk6qPBMXI+//OD7I93au0wq47tqlgX8wtD076bKjOJZLebrs2
	oMjN2BmEVX7V7bMIfpFOIRqvrPeGtgohUppJ2QtB4lMD9g7cOo72Zsc=
X-Gm-Gg: AYBFou3q617q+ytsac3x6CrfMmksTJKzEFoHPxS/5yhvnekoH9CZTUofYzR4vH243eA
	cRqQximrchaTsqzX6k+XyQVYscHw67BGWqxr6s65ttKKjthTSYT3GSBl36blTL+y/oQyoBmzINv
	jpEPrJFTBVmYERigge9iPKAM58bEb/5US0HBdgPzK74I6OR+jUKnhCekeEpy9Cw85cHY/bAOTu2
	FBSZKpy5zS4KKl0ctiT8Nm4PtWNpeWaGyTS5u65UwZSnBUCNrRqk03kMI2WRWEkcPvpH92d5SYi
	6q+8jRJMzPx+8mquAOifGyD49R1KDccDdHGEc0bovYOjSQ8myiS71yzLptyA+z7osS0qnkCoApP
	DZGwcO+LYpdwCoLrDl7jcTHQxq6WTQmM8IGdpLz4RFqyw4csd5NKpoqtTR9RzdQNhsTPjNBGn3J
	9hL4arufM2BsyvnRFTWeI0RsGwAlTXVz3/y/EcH9sw4LSu3/QEt8bHtu94PANF4XntZEKjnne3S
	Savi/SCttCDrROa2Xl9yWM0VYaZIx9soPYUx1sfr5/XJoK4n5PEYjXHz/cxlSa2l06uA25+2z8G
	NE33zGlziImjS0QuG8M=
X-Received: by 2002:a05:600c:e54a:20b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4ac1c361ademr77200685e9.10.1793456387439;
        Sat, 31 Oct 2026 07:19:47 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04785sm209871275e9.4.2026.10.31.07.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:19:47 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: daniel.lezcano@kernel.org
Cc: rafael@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ansuelsmth@gmail.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH 1/2] dt-bindings: thermal: airoha: Allow sensor indices for EN7581
Date: Sat, 31 Oct 2026 16:19:11 +0200
Message-ID: <20261031141912.1664575-2-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
References: <20261031141912.1664575-1-sochnev.v.74@gmail.com>
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

Allow either the existing zero-cell form or a sensor index that
selects the main or CPU ADC.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 .../devicetree/bindings/thermal/airoha,en7581-thermal.yaml  | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
index ca0242ef03788..e7be20d1bd1ce 100644
--- a/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/airoha,en7581-thermal.yaml
@@ -24,7 +24,11 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle
 
   '#thermal-sensor-cells':
-    const: 0
+    description: >
+      With one cell, the phandle argument selects ADC 0 (main) or 1 (CPU).
+      Zero cells remain valid for existing device trees. Only the main ADC
+      has a hardware trip interrupt; CPU ADC zones with trips need polling.
+    enum: [0, 1]
 
 required:
   - compatible
-- 
2.55.0

