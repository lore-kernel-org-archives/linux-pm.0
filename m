Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A240372B2B
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777141202; cv=none; b=J3EvPBSLb0XMiGNPdoOzMYn8lZtO4SW9xoAKjZT/q7TTD19dscELsQ6uhWltIMNthiF/b2YXK+eIYnBTL0AtrarmUdcChJQWuyREfVm18PXpoZPCSpCtaql6Mv9p7ikIe1fYVjiJuhsm60nEbO28IAxKZ/hab+8epnj+kYaTFp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777141202; c=relaxed/simple;
	bh=e4mtSZ55pAhi2usdNmNlCwHxPZTuRAQ5XRPju0RhuhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KOCKxe/yftABx7TdULFcUyDCXNy7Q/771JVyTtP7zhk/NVoYVLo+zCmatufwSBUExM8X0NBy/vFyfty4nc2LMq4TVAdBXL9y2usodUQsJ8OqeC8HDk2y5DM5+HJ346Urph+YQJgb2+2Wojylx1dfG6Bbg7z+l4yb8YUE0SyOLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5t+gRC0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5t+gRC0"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2b636b944so12002137e87.1
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777141198; x=1777745998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=735R+k0p0FEdSE4Zn8WQnt1UXjLLRLWfE1WDxqh8GTY=;
        b=D5t+gRC0vWDfkYwyBUGSdDWad6QtKIRSa7ffh3X9dnScLH/c8PwMrwg0nCpk6XymBG
         k8fa6x2Z78xvo0K5wdQ6SHbDHseDDolIoyk4IQXy0sBFmkArrYpXux151IfWe9Ywqdlp
         PvAXsDa8LDjrbQKbs5NOEHSD+sbuy9Bq7KTVBKTD3L4TGJU4p/Fm6LmP2IFs9ryPoRfv
         AaA1cTbMmZgD5I9e38M/V10gKU2T68p9I7SILI+qryfBb18fRBJ3zF+WBlDj2llFBroS
         MIscT21rwIglG5FYPMYEiPdSFOU6Cv3EV+X9yG9vzLOM8SnxdJhVD653a6K7bvxuYU5Q
         ovFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777141198; x=1777745998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=735R+k0p0FEdSE4Zn8WQnt1UXjLLRLWfE1WDxqh8GTY=;
        b=ElGeXmMj8fdVawB0DeGyq6Gou/oTlApr6XpX4ai/fz9piSpyvd8dnBFBOi9TBz3Rvy
         f+lvdYo9afs2X/3cG/vjmoo8ci+d8lXDtw14h/pIASE7DZ/eiwqXCJKzqywWuv2Df8/c
         97Zz3RKEbzCmIDfvMCtJV9O0zQg3ki6hkjf5MuvpVHEAZZUfv1wg8s0cZfzB5mVg6dK4
         ptmwtUNsrKp/vORjGL3DhPDb6l3s/VyC6VMUKnUtDkvSJA0p7GEbyhVjAnYf30JJs+gf
         C8cxINmbAQ5SK1AR46lfnj1udl9TwdkWjmG8/F4Llx9eCRL9Vfi1dN5E90VtqHMqd88F
         SpRA==
X-Forwarded-Encrypted: i=1; AFNElJ9R8vWQDE6TpveYLwg30MpLdDbVC/kyYyGllq+gfQZ9p8Pb0MWb7StjNvGUCpQjtizrj/I7SF2z0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQgv9I2skHOiBv6cJRsYvj6NMD4tn84/3ROlP7NOAdYd3Gu3St
	8g1NyJIja/EBPppHSXO4OR1KZRQRkVXmncOPB52gQQ2lPlDJquYxdzjcyje6Rn/D
X-Gm-Gg: AeBDievD/uS3BqA4bPkT1IhUF6pI6+7KtW0w4uCnp8OeiHciEkfhV8r4Bjfvmp2s54Q
	omM60+Q4Gsm03+Plc8J6hA0gKQ4udqS8HuNUnNRP7OCn+SPwrsD1ebCKxUQnWbJkgF+UOlVBlVT
	OxFb8RFiIxLU5AvXOJEYRepTvENhVBD9wyK4x3DPo0tO+X8hLpRs9frdmwEASSUZdeDDcTcASCE
	hz9iXIv+A0KHp3oA2f9U93C9M4INdm9AJQBfGQ8KGvj76bSM+AkgCLxhL0CUzVBddvbPC0J+zYS
	hfCWd9FMtAJRrxFykzIw62UUuRiuxH9Gd35vzX7MyIgPiTUPrQgzDvRRNY/JrRiLg+XaAKU00sd
	IHi97SvujRm2pJ4Q3glyNNXk5+zfF20POoPtpI7zGMfRrDnSvrFT0lnLhsaqDtWS+0AvFyk8esb
	Ox+TgPGxNTHChNvCzsQfptjEw=
X-Received: by 2002:a05:6512:1256:b0:5a3:ff77:aa05 with SMTP id 2adb3069b0e04-5a4172c33demr13006502e87.11.1777141198124;
        Sat, 25 Apr 2026 11:19:58 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7ad0sm6836577e87.58.2026.04.25.11.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:19:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v1 0/2] power: supply: Add support for Surface RT battery and charger
Date: Sat, 25 Apr 2026 21:19:34 +0300
Message-ID: <20260425181940.144028-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for Embedded Controller found in the Microsoft Surface RT and
used to monitor battery cell and charger input status and properties.
Controller works both for UEFI and APX booting.

Jonas Schwöbel (1):
  power: supply: Add support for Surface RT battery and charger

Svyatoslav Ryhel (1):
  dt-bindings: embedded-controller: Document Surface RT EC

 .../microsoft,surface-rt-ec.yaml              |  63 +++
 drivers/power/supply/Kconfig                  |  11 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/surface-rt-ec.c          | 415 ++++++++++++++++++
 4 files changed, 490 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/embedded-controller/microsoft,surface-rt-ec.yaml
 create mode 100644 drivers/power/supply/surface-rt-ec.c

-- 
2.51.0

