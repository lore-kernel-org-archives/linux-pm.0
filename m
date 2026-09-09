Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB62B52ED3A
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997708; cv=none; b=J/PqbonP7N+grzs7yy4xYfOuESX0RZvaLlLENEnC7x6+TLrLjU5UHrs3Nx8b+9d6e5klzO5CulSb7XVtJJWTaIfwfoUpXiryQ/KwvDfKTGnzJGDEoDyuhTmpREXMaCzJPRGx5p58MC7e70qvXvNiXA/gl1BkSu+DaN/b8g9xQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997708; c=relaxed/simple;
	bh=G+K6yZL86J94n5ErSMRjznPkkKACsHzlBBj5w8KooVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRIj3rfwQ1ws0LF5lZoYhRffWc6VC8u/j6e6JSlHzms1Bj5QUElaH8qhQz9mnJ+93Xxhp99m+xj3yrAay5n+OdhUxJQRjO9WoBhtdlTgEvt+HDUCtVUGZ0gdZ8xzf0ShheIlF3zmd4MBuqOeBH2vwdqvw9FXZlXKypxcDGrKuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tBWGWRYY; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBWGWRYY"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b81a2d33f7so348507e87.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788997705; x=1789602505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8Y4b3ddmCAFwqmVgH5ZGdYAfFuI96RtEoGFK9BOGP0=;
        b=tBWGWRYYjJrE6BZxUBY1ZqCaDY8qPibbPSdnmZO8I695Qw+OxAbU4ITco3cGxJcgbM
         w5TgdA3xXk470bY1UDsinzI2yV9PB7UboB9p5e+Yv6qpH7Dfbwii8M64M3fKe+eJl2gH
         FO/7SMdpuZWEIodXA92XrEuE9P5QPMhQzS/GXm7B/79TnPfOG2hufsprcHEmhq2QnmNs
         CwmppdIeP44grH5v5gpKMu4I8pNDRKqJfmRqru+SVYFdRWtxjEzwDoKKBsPj0MLuvnOw
         qkQH2mTgMofQ+IYZLsd2IRtXwkeUIoUeDuVBzUhXqTlLKtXZVuK9AMeCDCoumPtYmNTs
         caCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997705; x=1789602505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8Y4b3ddmCAFwqmVgH5ZGdYAfFuI96RtEoGFK9BOGP0=;
        b=Y3R4t6rRNdt0clGJ8S08jSwsW4dyXznphi9yshA13MkKOI4gPD+YZBqxtWBCMriu92
         CVH+sdJJeqVriB1a3z8UFErPFd7iRD8lQMW1jocaPbt/acSrQcUoNS89QwT8YFDj9QWd
         hCo2H9OXBvKo5U7ZC9/30uP/R4JdzRIbhmiNK4SkT4kJx+iXuvKea8qTHLsAO55SbTUG
         DewR/es5dd9Kca4iB8wnAFDNWfXHgl1ckweOUTZKKYVTkrRHWfSJoT3D2qOOE/+lsv3z
         ktto+uUgJpPXOVoTugRLxT2Y9MbkyJscIg/P29yFMR35j0bq6k+lD2hO0l+AY3BSpjz+
         TwHw==
X-Forwarded-Encrypted: i=1; AKwUvBz8BUwcZ+ZH8HotGO1h1WhwRfm9BsjzfU4U94ZQhTLSYHD+DPLajRMub4EIqLR3R2RrQccA5a3tJQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mjnFjn/wuNYfgeR8D8NsAlUHBgFor/epWdXgE8bkp1/CyTKNgm
	hWpn9yD1hmXkiV99lNsO4PZqR+FYrUU0i86cesgNBR1dY55IlnKkuSW8
X-Gm-Gg: AYBFou0Hl78xR211GiiKGvWZHsbjHq3Oe8GTw47k0yrRNkuVV2AV963R08M8cKGpK39
	z2pohgUNOu1ctQ6ZNpCioBdRyoao2f0m53jqdemGIPExoIaqNcKDqji5g0q5vZqbvNeDnJ3CsfP
	hrGwneHgdDEPOgQVtcxRvecH5vsZ/AvczZCSdojunPhWpxOjSm1GBpudJ/WiaCOkIZ+ORTBYELe
	cvNgfPgN9Osnp6f0D5mlQiiOsVPdTWU2O7gfN/UDNcrixSh4zQ6+RHgC0j16wH7Il3suaQ88e6t
	D3QXHmbSxkl78MmJ2BbojOV+ZTjdSDTyUj/T6o0rFfJMqBDwcyQZZPSzgPwEwS2TBf40nNCDpp1
	6iCHi/0PcQN9Mck6mOoLLFc9jd8Wz8n1rJ13lxAwk0d8MyH902LQRNYox1UHs1FryWAEHF1CPUt
	wnHNkGFwLJX+YzNrI4md1C2ekXh/0JP2YsrqNg7UILL6OMWQMgxDKOF40Bh5L97Jo+UdgUY4R38
	2t7UuTceapLha4OxSaE1nw6q9E0707w6GvqQZYV
X-Received: by 2002:a05:6512:3b85:b0:5b6:1a7c:59cd with SMTP id 2adb3069b0e04-5b61a7c5a4fmr6010294e87.39.1788997704650;
        Wed, 09 Sep 2026 16:48:24 -0700 (PDT)
Received: from notebook ([93.189.200.242])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b6166ed4cesm4153300e87.26.2026.09.09.16.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 16:48:23 -0700 (PDT)
From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: David Heidelberg <david@ixit.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F . Davis" <afd@ti.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: power: supply: bq27xxx: add generic compatible
Date: Thu, 10 Sep 2026 02:47:42 +0300
Message-ID: <20260909234744.1177153-2-rinat.muhamedgaliev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
References: <20260829205258.26955-1-rinat.muhamedgaliev@gmail.com>
 <20260909234744.1177153-1-rinat.muhamedgaliev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a generic compatible for I2C fuel gauges whose device type is
determined at probe time.

Signed-off-by: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/bq27xxx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
index bc05400..f2e0170 100644
--- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - ti,bq27200
       - ti,bq27210
+      - ti,bq27xxx
       - ti,bq27500 # deprecated, use revision specific property below
       - ti,bq27510 # deprecated, use revision specific property below
       - ti,bq27520 # deprecated, use revision specific property below
-- 
2.55.0

