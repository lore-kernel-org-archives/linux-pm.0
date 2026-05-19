Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0523E9295
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 22:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229490; cv=none; b=X9AxW1LEGSm7FFeLnYcyAPbIE/7IgQPf9Jrk5h7ttFZGtC14Cg0zE+HH9xfgU79BjEeXwS9+Bq4KpGg5XOMFWON4PLmIWG6B0oHxscEabeCfrcWzbM/RrjfV9RcALRg4zX4DmObT8H0LRlTb2yjVs4zUEQ34PK6NS3B4tiW9XTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229490; c=relaxed/simple;
	bh=HwoOXI2DQhslZxgsAIlcz2VGOtrsHLPz/EOPgv42pPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Bq8lZeag5CGLi4YNJ2gBYyRP/rdDCdngSuS2kpssfXLI/TONe7PInXVSo/fnnVXfxaUFFPR/kT7LLlcrGfPQ6Lnx/Vrswxzb7o8JyF+whAGI9DPu7Cswkzns3lPYLXAq2qPshmJYh1BFVt2vtUS9clxXktuJCZms/3Mw1DfCOb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jupnkzye; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jupnkzye"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so24331865e9.3
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 15:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779229487; x=1779834287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=alEIzjJTMkVGPCvhQaB5zhzTrToEQ8tZzyGfprUfAoM=;
        b=JupnkzyexQ8FYtqRE5IPTXoLGp9FmRAD8CBWoJ5Y06YVveqb+jSzL0ekyx8pVGDeaA
         ILNBjXlj1paWv6GW0oCN4K3VJatL60A3GGMwB3IYEXKrDaJa9My5K2bTUKjZQ9lfAOKc
         FBEFkDHoFAFqAA8zb+mnb5xCw5DYxGVTdspKmi8u98g+3Vh7TDhqtcdgO+epcgIFlx4v
         hsH60+zRxXc4pCaJW4nfKch+enoL+rkLoUluCKEstME9zOcufQXrfApSl1PDJwDVb+1x
         w67BHxix9onqNMJ3yC6kx57CJHIDPxTDPllmDK4MVXZS3iMRbpB6cjTPuB1cv2nj1jCt
         WD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779229487; x=1779834287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alEIzjJTMkVGPCvhQaB5zhzTrToEQ8tZzyGfprUfAoM=;
        b=BalgPaTLeyC9IOeHnI299MiBtdRz2lFUgXdYyhKzO+9QmnvhMOuk+4d+533aGNQkw/
         w6c5OU1QgakMy80dNuXcH2kiJksLZVjKD4at+1hULxIia5He+fv4Jw22XDKTZtTDoSVB
         gTpNYhPHTCOA50ptxBRmbSbGnUZvMyu2D0PcbHZA+m2lelqXEbHP3k7XPUSsJfWdYoX7
         g5L2/ysky9b9danpTq0oO3q715kVxBK+6vMaI7IE1ijANl6emcRCSPO1praNjDwjmqQ7
         V8wxuQa3SNSVvOqVtO8nV/CFMhTlAjtJYqqn67Es4Udofi4X2mp3VK3R5IuOHNRTqZqQ
         r13Q==
X-Forwarded-Encrypted: i=1; AFNElJ8wGjTkMe6+1u7oCw0Cg39kpGySRd3VR8TcO24xCOjZjEg4poaay1knZR5FajNskdC8Hm5Olg4kGQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwD+Z6oByB+gfE/mlgXKKgYTVN0ycKJ1jnFjQs0C8/fhjKOMkiT
	choGmI/V5SD5TRQFBGUwWyE8+R09kHoO8daLE6yNw42BgKq51irBTKPy
X-Gm-Gg: Acq92OGHwH4ZOAPHmIOxXwccBiRlU07+mJbA6tt0l+3j9dGuEL6Ay3B2uiH0HXHpv0r
	Ritbq+JCJ29fi9fddor9TRUElfjdLQ5/ZEZU+xWeojLsbfWB5R2NlFdeHgoD0fEr64RG+uWB85u
	lp8KGp+5/pPzBwiqZOu79bi3jqkyoa9HVVDLhWTNc+lCk2OVMQb3sYA7UJ9c/9NDlBWoaGgZhI5
	uocIaRmScItGzf5KNnmvjJyobawT/rdzOxjIGykWv5k+DBZNRmgC0GtttUXilK95oBrJdGLiMvr
	24/RHwyvfeHa5EGDcCK/ffwtvMkw7pPN4mkDcfggLnOINWqgVCiJUhqKTRFkLh10T/4PUvq/wn+
	8995mL6OUbHvMFMDLwOV5usnFvn384LrSfNnjiPKjMN137SCJ401P1hM+XSzknL1S4S/Ny6YYcM
	eDTkSRY482MSSiN/QKty+dF2Ch7u2y9XaEawr6Xy+37mQ/8vGAQ6+w+ffNAaTH37qKZj/fwVdcy
	whg1oJUPA==
X-Received: by 2002:a05:600c:4fcb:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-48fe6613ab3mr317571325e9.28.1779229486487;
        Tue, 19 May 2026 15:24:46 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-55-252-101.retail.telecomitalia.it. [82.55.252.101])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm381097435e9.3.2026.05.19.15.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 15:24:46 -0700 (PDT)
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
Subject: [PATCH v4 0/5] thermal/drivers: airoha: Add support for AN7583
Date: Wed, 20 May 2026 00:24:21 +0200
Message-ID: <20260519222433.29684-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series implement all the required changes to
support Airoha AN7583 Thermal Sensor.

The SoC dropped the Monitor subsystem and only provide
temperature reading. Some generalization was required
to at least save the common code with also the help of
reg field API.

Changes v4:
- Rebase on top of linux-next
Changes v3:
- Property use chip-scu for thermal sensor
Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (5):
  thermal/drivers: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
 drivers/thermal/airoha_thermal.c              | 368 +++++++++++++++---
 2 files changed, 318 insertions(+), 64 deletions(-)

-- 
2.53.0

