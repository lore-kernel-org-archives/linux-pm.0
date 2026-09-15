Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EFA4AEBEC
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492403; cv=none; b=HYYo0M4qOAnC7pDp9uHTdwlxpSn2S2kfwK3y/9JlkOtlx8PRs9WovN7cvinXpnwgfFhOIRvkOzLF7FBqluwiTn60IEpR0fHgX8ndhYSjMLUObImgNMIfvtB3WLKnQ61wpjFKfc+Z1qdEiU6WdsfwmWt5gt39Lc1qibDZZ43aPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492403; c=relaxed/simple;
	bh=uqGrsfhQVXplRsdUQGFvRbPRKj8lI1bt0w9YLpudhHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geLWRpHwyTUuJej/uzqO2mlxi7STma5gmilrWldDcwsaxh9tUuJ1vOZ3dY5u7o58K2xCMVvbKHcuMMtOnRCoMkGvBfQmNzhwoYU80n+SF6KVCSACvOcrZc7KObDMdoFLUqfYgTq8G9WOYtJzvGqrwf612Y0ortPvrYirhnKuCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcO3CCYm; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcO3CCYm"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b79784a6edso3607273e87.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492399; x=1790097199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crm5nugieczeEoBXBtWI2YHGx1NS43N1iIME//CgsMQ=;
        b=kcO3CCYm4h13lTkKJ/DVNN14Wf7YGEGB2l0blocauL1o5J5Hc+LxJufeWxK63srb4o
         gdbA5TWw+DNlJwG/UPOEmfXvwfs353tTAO6d82PBjHWUzBuAX5GIARf9VXPmfOPB4ck5
         nhgNX/ZhljTN8JP6xMCahIcQwIxrsdJzBDQJD1avhowTssuO9a3ZOLoWLNCZYmpv9h8T
         BHe2uQ97J06SGkLn99Rb6z8E64uh9MZR3R/++jKaV+c9/rFQWHXbWInNw/CCeeRgGemi
         UU9GdBfjsh6Vs9NXF/1fIBI80d2Ie400Kz+Epr962VpZTnbdJKm1/QKOzV1kRVkjAsCW
         GbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492399; x=1790097199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crm5nugieczeEoBXBtWI2YHGx1NS43N1iIME//CgsMQ=;
        b=dRIv5k/XgyWQqG1V9Sm728JQb44+WTB9OzWPrq7Peajs6uWJv3USjdaYXGUWITtwXD
         4okc4lC1QivE8e0nsocm/CTzdDMcD+/6UBnqkoInCd+xE3nCNv7PHVsyhaMpfYEt2dST
         gJwY3oFY2vpBuxiHazyT+XK6K/Z2+na02Qwevcvk6uKK4ZypzU3To+6thAtwmF0rr4u5
         CL53BbImIvqgMX2pljbMdVAUCHJ0S2ajjW55Dk1esp6dcWIpZSKA3aFGXkgeCIl/5ooC
         xD4nBTrauLYbHCIdUfiouNFF27fikWQoklqNvkRqJyhskZIPm5mQxBXf+HOx68ZZAIxZ
         0Nvg==
X-Forwarded-Encrypted: i=1; AKwUvBzN/Qa14dr8GdSiOX+oiLHDjKfD87qlqQd5p4hhw7Ej/S1C6i7/vzxOmGbWKCH1mBX73CBuqH8Uyg==@vger.kernel.org
X-Gm-Message-State: AFuF++nHb34Q3njY8tUu89C3hklhRYWXe5qE8o1Xphr/pehezcbjhmQp
	HMKGb+/CnB+l91jkq/u7W+x+dF2AmS7NvbPcYnMzqubf0PhgzLuO7mY=
X-Gm-Gg: AYBFou1nkVjjCvg+5Nrbsh3LxQ71aP2xjrHo5dQ/rLw1jmtb3LNa6q8aaSoV/+c0Y1i
	dYjTV+YMLr68aA782sy/aNKFQLtBoXtXuVnEXFd198LOKDl5a2308zO5CY1OjqEcO+/KKlAgOTg
	Zfu6e38FiKr4wm7C+cPCoJmTqXqtUXigVy08/jgJwKxagf0KyH/03d3d9g7bGPlAyIjmu1zb7dx
	ytgkn7gJt5hUWLpyc5nnsmSD3kU55ZmGujUttxbd5jMoOpXaWrmALl8BZxATUDRApxtqwqoxKW4
	74A29DUYcboYyDW4d0FgmX65DO9bNTJiQpBGbRo9RxCN4NDXVOo89JRUXsKXMc7hreOiRDfrK95
	HZNsx59JcNbPOdvqA8YpP3YWMd4sqsUX7C/2j0yXDZiLU8ydHXT5SrKZl3imSn0Xy7Erh5vM3lU
	mRRtj/zI41XwWoVGvEcDHSkypTOE7uTzVRJHCcFdBs4PmpUYLD2myGttur6149ww==
X-Received: by 2002:a05:6512:1388:b0:5b2:e947:b3de with SMTP id 2adb3069b0e04-5b8ae6847acmr1952542e87.7.1789492399189;
        Tue, 15 Sep 2026 10:13:19 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57eb908sm91791e87.79.2026.09.15.10.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:13:18 -0700 (PDT)
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
Subject: [PATCH v2 3/4] dt-bindings: arm: airoha: Use one thermal sensor cell for AN7583
Date: Tue, 15 Sep 2026 20:11:30 +0100
Message-ID: <20260915191131.25214-4-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915191131.25214-1-sochnev.v.74@gmail.com>
References: <20260915191131.25214-1-sochnev.v.74@gmail.com>
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

