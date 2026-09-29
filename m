Received: from mail-lr2-f35.google.com (mail-lr2-f35.google.com [74.125.230.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19753B613
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790700760; cv=none; b=PLuvbTjrzujv6ij9+NW89hecoiWxumEtJOkUAe277xi0BG73iTMBdIPYQ9M+PXcYuVCXsWAq6AzJjQvBYe88brNhLxg8z1q+EFCnrXM869sd/wrWRSu7DlR0mNDUenVLUIcqLnebd2RCBaxULTMQ11i4CcQeqcqmcTJnZKVWYEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790700760; c=relaxed/simple;
	bh=uLBhz9AW5lUeQ1VBBZ4BLdqgKs0ZrJxGiU4f9ODmksI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/OnI/n5bTbpIbtVIgTIGsHXOxwpoiNWXixz0zkh6yh6zYIjRYkQR1GYOZkYWaKZfzKxORu58aeXje6pQxULevcqiXCEi7YkIQgWsm4q8hn/8VTch2a6nRAQypydhI7XvgkPnP73rBShsts3sHgY3DPcrvjAMDAVRx2fvix8/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bClN/PGY; arc=none smtp.client-ip=74.125.230.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bClN/PGY"
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a60e33d456so34560851fa.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790700753; x=1791305553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MLqCht8vi02ko9LVVdoV/+Z17LWnTuXLunBgzjyMkvs=;
        b=bClN/PGYC/g+uKuJvt/1ji4QQXLAdPCYe0WOCi9dmxg9UUKokqS8XmHPjh2Ibvk0y/
         b1b8myIvZYo70GW7u3DXb4l6srFdRGA933Bbim995xLV0D9X9QF0s7xT/2YMeStk++N0
         YF3OgoooyNsZTQsgrWm1MXehoqNWOqu8D+kbFZ5DKrhK9ldEOD2cSni3KbEnlSoWwisr
         MzLULxty/GE5or5tK2RyQaF0cXGGeUJ+jzODCJrId0aZhNQmcomORMyruRkEA1+m9CPa
         odaNCYT29rBuVF8k4yD7GwAcucfPsaGPqKEHZs7l0v9bsBs2H2kdTvKC/fb5OZUc5yZO
         wXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790700753; x=1791305553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MLqCht8vi02ko9LVVdoV/+Z17LWnTuXLunBgzjyMkvs=;
        b=ek6YazNPEDqRH1Z++wg7T+IR9zmn9sdLeDCbY3Pa8KfRnXUtEvFlGWkns5IonbL2nz
         YUPYMGVFmRhdjQU67oEcjIm33o6bB0bDTnJSadYd7FZqVZmil7hQUhBQh144oQzOm7V4
         bKTqnBmrYXdHAvIfiraaWxDTSZeYO0c2am7wz2Mf8Htzi1URuytoPt6pWX/lKdvTXMYq
         puWcVESPoT6PvZv3uOTLcFnQoceEFz8SXlxofHNv68fj+FZe5oh1nukVQ2HxEXj6sBm7
         LPOQLQVzwmycOVZf4zqZLJuqzbCct2ShqEHYqFtimk2PEWHyD7pW0TPI4nI+MsAKXBeg
         A+Gg==
X-Forwarded-Encrypted: i=1; AKwUvBzyrT/L4ciVPMZ8+vCgyUzhyAN0KtnbyNi5h4iVu6obKv1eOi9SQUc+NaBNgX5lyKR7zlfszlXAzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4WO31aP3TdGuruCW8aUvI5pHsfJkHfWrg1xZjaDzyFpteVd9u
	JUAuGF10pwz+d8Ce7d+NFxPxIeMoF4VD3aWM04avDLKK+zGgfXVat7o=
X-Gm-Gg: AYBFou2xaR782fc6uQlxFhGkZCHTS29KhE1fFk7uTT1yV1PKCWy9d6suc4b4iN1YPRG
	+NaN0rEviyGqhArbUR1SfST6FV5vrkbW+kB3PWtQuZahWQJI8l7mrHVl8zmW0mSJ4Dyct4pn5vk
	8dEB2mifyEN+JXpQTLiMAvzxFS4PK2yHfnIXvI7rlXxCjiGwXPxPNbVekF7ZanQBOL3+E5fZW8o
	8aVnLsdNv5qgsy8kLlSwurIrIbTmXxbh5CccqFv/FyNdxXE+0MZa1yz8rKy4zzYIsbJ+bKYW3ZZ
	7oGKQVL25pR0utTbsX2xfqa452e00jFIvqUG2e3Q8MS2eUGadFYsrI5n2gNKKoerZvAmOeybTDd
	WhFhETYKiAHwy8ZRTgwFO0hrjGX43tO1LnkscmaTt00QuKLhhIjzIuyrtn3Ve2m7yHdPmcOMEKS
	Cqo20k9lUr6x5+SRy2FT75XebvUFSRnQu4R/y1ZHvxcKdFN3UbdyYEjyyGLPTzIH42mvM0IB8=
X-Received: by 2002:a05:651c:19a8:b0:3a6:687e:9cfa with SMTP id 38308e7fff4ca-3a7719452cfmr283341fa.18.1790700753249;
        Tue, 29 Sep 2026 09:52:33 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a771947b14sm137751fa.32.2026.09.29.09.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:52:32 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH v3 3/4] dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
Date: Tue, 29 Sep 2026 19:52:08 +0300
Message-ID: <20260929165209.69669-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929165209.69669-1-sochnev.v.74@gmail.com>
References: <20260929165209.69669-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AN7583 has three temperature sensors behind the chip SCU: bandgap, GbE
and CPU. With no cells a thermal zone can only refer to the bandgap
sensor.

Use one cell to select the sensor. The AN7583 compatible is new in
7.3-rc1 and no device tree uses the property yet.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/arm/airoha,en7581-chip-scu.yaml        | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
index cc564dc7b414..4a10d024f5fa 100644
--- a/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
+++ b/Documentation/devicetree/bindings/arm/airoha,en7581-chip-scu.yaml
@@ -26,7 +26,8 @@ properties:
     maxItems: 1
 
   '#thermal-sensor-cells':
-    const: 0
+    description: Sensor index, 0 bandgap, 1 GbE, 2 CPU.
+    const: 1
 
 required:
   - compatible
-- 
2.55.0

