Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3EC2D8391
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292553; cv=none; b=DCMPOjf19buLlEi27NZELCJ475yzpq2iDrL2rQtpDp4FYCVbIh8YMjZv+7yaF2PHjDdXyHgd/6oho/y6cRi5ZsZxwbF4mJwdHav7Xh1bPZxOexdEpCYQtXUgefztwFvMbAoK/pfXdFw58/reoP56FykxVbVxIqqaRh9z8JAYmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292553; c=relaxed/simple;
	bh=OME4iRZ9Ykq7ao0fF8hkOXAZOgTqs3ImOztunYTtt98=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RaMIE13xZ2GquhG4Ubu/h7Iokfrc2WJQz7VozrrQ4wKyqmiYLWleYIRYpUrgFVxYOlPHWH/Ht75s+TVEdqC8DkyDq4ZAZE7CGNrSpHYzlXAeSa2f58MUB8U4VBoir8I4j2yxRQJD/39gaVMioeRiGIy7YhpK30zkwwtk3azL72k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvLMhsli; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvLMhsli"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso56469555e9.3
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779292548; x=1779897348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jLqtTlusJPJ3GUT/Wg/5pbHzqJxtC12bc+X9tA+WV24=;
        b=TvLMhslixZgBPKYpA7Zvc8fIcGicTv7G9TPiPTDGLJ3oqrnsUog/FnaQsZc5iJHZAI
         9zdLGDfR6XcaXz1f+vhYh8/W8gDYUVmL/jJsHAvp73kfNeEbdtH45JXUrFCQEzHSi5Ve
         j70fiJt/iMTdA53zqDG5+7ZvK1LEC76QOJtXaslXwsthKs59COS/v0AdsoPR8h6zk/p6
         XnIr6I4HD/E+y62wrYc+fH/jPDHl++rNkvjARaHDGpSx6P4vjGv5cwGTCqp1RyJ4Y+I0
         cQNMb92Pypr+v6KyN6ZuI+tBTXC/5zg1dv7exKJNrnIZzE++cNzj2xidVvjJK/zoVAYL
         ApHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779292548; x=1779897348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLqtTlusJPJ3GUT/Wg/5pbHzqJxtC12bc+X9tA+WV24=;
        b=F1hrCnKqUj6ybGjqpQ4GUWIn8UV7sdbXtZFcdjoS7oKqAVBnB4txvMga7N3iWE+7s5
         HDymcqs5E5JMESSfsqmrzcDwr1rdOXdEDoO4kVZML2CUeqTw+HoYVcXKr+jSpJafRDnY
         NKf92/kePc0PvKaM3McKUido28d6zuNN8xOlaY6JFgKeYGg439ND6slw1D68rj2ieOnw
         H6qSTC/vLVr/ZUp+sxHS0QvC//8/AtnkT2z7nbFruIyvOmdSbQodepcG7HYPN7iaULkC
         qTRObGYJeQSSRLrc+dhVh4U7oeNfWGRH/srs0H0CRbJlBLn8Tj6Lk0WnmKysntPqEk2v
         ybSA==
X-Forwarded-Encrypted: i=1; AFNElJ+GmyufP8BMDgXtYVJxbiFv5aLb1qvue9GLhwom5EQfYMX+osEf+Fvlyju7V8MhX3YBzmiH47ykAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziWyoUey92Jj0hSirg6Vd4kT38PnfBPkjCLCieuLG4sl82/bja
	ikGaf9oMboIS5fnPmxdQt4TcODB8Kas0F2Ltb8PHLAJh1o0m+8ViAYEB
X-Gm-Gg: Acq92OFpHSVXYi7sIFjK0ggxbfYQ/9aMgj2SIhhwoGg8dhRAO7CcfYE0syERkcBfn7r
	KTQGBmAYhrkZIW4Q5+1tEuL8WH3TAr+ZGiGxbXJH6SDQY1K7L634fkNqXS1o2tNEtSNVY4D0lUf
	K65eS5zpnIJAoxD9+wUM53ZxnfUz+Kb51b6kgLedItoXsjPnnQ5IFiYdoDstUYTXypmemOfPjDh
	g/T/Lu9hzX8PMNgF7d8muIIXsXcpUUeCq6QORV4CKuFSowZ8+CMDDzmZGSTHrN/WpB8uwyFnmJ5
	DsEHKbg9T+GOwOIjsqqRLCNQgVN7g30s5SlGliIiTLmLL3+lKI6P1p/vC1T/a9MNm8qSYcCkGCZ
	nUxmK5xYH+YF0ckUUZFzshqH00Fzs6KL8j3P75yB2hXLf0bvZivjAetvuiWvpl3xF5eJxGA0mmA
	47ZeBKk71qlF827qzFMDSa9NHDWx6WiSnvw8Gi8L2HuXSBtl5wYfMg/skgEwRZcys=
X-Received: by 2002:a05:600c:3506:b0:48f:e44c:e058 with SMTP id 5b1f17b1804b1-48fe60e13e7mr364388525e9.1.1779292547501;
        Wed, 20 May 2026 08:55:47 -0700 (PDT)
Received: from Ansuel-XPS24 (host-79-22-5-99.retail.telecomitalia.it. [79.22.5.99])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fed253f93sm132123215e9.16.2026.05.20.08.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 08:55:46 -0700 (PDT)
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
Subject: [PATCH v5 0/7] thermal/drivers: airoha: Add support for AN7583
Date: Wed, 20 May 2026 17:55:13 +0200
Message-ID: <20260520155525.22239-1-ansuelsmth@gmail.com>
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

Changes v5:
- Fix alpabetical order in Documentation patch
- Address suggested change by AI Bot
Changes v4:
- Rebase on top of linux-next
Changes v3:
- Property use chip-scu for thermal sensor
Changes v2:
- Update DT schema patch to implement dedicated schema

Christian Marangi (7):
  thermal/drivers: airoha: fix copy paste error on clamp_t low temp
  thermal/drivers: airoha: fix copy paste error for sen internal
  thermal/drivers: airoha: Convert to regmap API
  thermal/drivers: airoha: Generalize probe function
  thermal/drivers: airoha: Generalize get_thermal_ADC and set_mux
    function
  dt-bindings: arm: airoha: Add the chip-scu node for AN7583 SoC
  thermal/drivers: airoha: Add support for AN7583 Thermal Sensor

 .../bindings/arm/airoha,en7581-chip-scu.yaml  |  14 +
 drivers/thermal/airoha_thermal.c              | 380 +++++++++++++++---
 2 files changed, 327 insertions(+), 67 deletions(-)

-- 
2.53.0

