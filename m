Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4833254B8
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777385946; cv=none; b=E5lQGQi/4u8mpVsfbfsEd/KCY1e8+h4ZcMFPZWYLBPh8dfCBXSfz1Mu+fseu+T86ao9S3cP+FPsqe8CCY+Qtw62MAKvTaATqRnvlZmyklZLtG0+TwlbFqaSn6RXOVsx9IfcFUfExYQvxO2Ej4YTJ0oaRHdoyDIjlZGoQ3O3cqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777385946; c=relaxed/simple;
	bh=B1Xhw+g3PdzwhuvhrsM1a9m2CPLx9i7HUaE+i6Yty1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joKiLplXuF2KeI63GQlKjwPUHl/8pL89utfJQDXEKLItBx+WqWcjYUGgp0djeyC8IEwVLBJ1U6BQu1DZJF5uj3gY8pzGos19Ic8em8p3dc7PzxYltiG8RQbjwBCWSt2cXk41EplAL29hcIr1bTJQ6byoDQqEgca47IpRuDrfjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPVsTwJV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPVsTwJV"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9b4f93f0so1966794a91.3
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777385938; x=1777990738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5/l/tvbICEbtVIUOb2tF/TKbrJ4oMCuMVruWpyDt6VA=;
        b=ZPVsTwJVs7OLtQ8CXFBjyGKN0PyiBawGjUofhCE1ZAYrPf/8Tw4LP5fbEf6GTBkgKD
         nS9KwYcKIR+pvv18G3OHMd0kWB7fjKjVAdL2OV0GpicRTQvbOsyGymYL6AI2CoHi1pmz
         ewnhIFcmxu1PnwRJgN4hYjQ9UA/RNm2zR8qBbQh3qGsC7A6/hU5fzfpTAGfMw0un81ue
         I/+7gS7LMhAycKRHFRBAL9ePnDfTHsgQV+b4MFLIxrHALaAvYsGsYSv436uU7FvZpleK
         kx2ggPhB3LUheqQIRTyRKhX/fi/vwQ6xaqoEExgXxALEHhmgwuH5DqZVaBmV0LhU1bRo
         LN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777385938; x=1777990738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5/l/tvbICEbtVIUOb2tF/TKbrJ4oMCuMVruWpyDt6VA=;
        b=fIgih7C6yQIQ+iiH2VMU4pEuvNxXNQc9KfAVDZnWg9OWxn8KyIWNVkK8+hB0A6aibH
         R6DGHdMemB7vMhTbyT5e56NV81AQEIx4LuzdPrIlaJSy47zuR84WxGZ0v7Ad6PA7lA/F
         xGYoYYLaCsuUnPXeqRUlWf+N6bndckQ0lgErmHqoh0wxU73FEEKkl5xHZOTj/a6MsxLa
         La+1JyoU41PsutXt4x0tG8XZ8/MVyrDhQZ3DSSRBuere+TipgGaS0cuSPooTaAeIvZne
         FMXng3lvCykCJJiN4d0fViTG2p0ZxLTB5MGKpB48tTdkFlU1OnqhCpOoS5dXkj0f+Eh5
         0MOA==
X-Forwarded-Encrypted: i=1; AFNElJ/crMrnQ4BfZeaX+8FD4SyvbFLAkovxItLkY/D9+44Jwwhi9roKdG6MAz2E4kfTqaVaXqF0QnOnPw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFP/WhMdh5914+/mdtf2Ay546MBv9y5MP23pXj1yOjMKR+w+yj
	rm4Cad7IjjPl55D5INSBybmlK0S76ip0329S8MUi1UcmK+zcqC04ivDY
X-Gm-Gg: AeBDieucsBc3Syc2V/1otuQ1y+RSKm0TEwctGk3htV+Y8ZsIOFczdvcUBvHIukCXaR8
	QqkwirY++wjVTzsdVVXZhUNZpfhqL9oVxDMQ6lcRiR6B2DaxQurvs8tmx2escSr8RK1+PlCSHBT
	ScWKCKv06UWRBijUjiJWK2qmZ9KP2r4urNmhFkCj/0Yg4woBo8bDR5cbRKMnbnVSpPbG5mk3bqz
	cOUcujXdbUB5q7/wviX9XPmyjzFtqDHcv3rBpw+Vm5RnfA91IdkEG2th2X/ZVn69hzl7Qe3nNuV
	W3RVCTRcsKbH/ACiPDWRa56+/zYy0UEEEgchWEq+3nCL0HdAX4/bye35L4rymVHiEfY7nnHttvT
	86BnknBo8UQ55Vg/S/r4aqRDoCYkMlf6BSm5me4e89i50L/JP7P0ZbTBoyJe/qGnqJiXzLQ170E
	Bcy4T8AgW61L2iagyHJJFGXyYWV1muIa5gkczoRd8x
X-Received: by 2002:a17:90b:3ecc:b0:35e:576c:7c1e with SMTP id 98e67ed59e1d1-36490ca7aa7mr2116371a91.4.1777385938195;
        Tue, 28 Apr 2026 07:18:58 -0700 (PDT)
Received: from magniquick ([45.112.148.109])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490fbfccesm3114485a91.14.2026.04.28.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:18:57 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: hansg@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	jorge.lopez2@hp.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	sre@kernel.org
Subject: Re: [RFC] HP laptop charge mode control via POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
Date: Tue, 28 Apr 2026 19:48:51 +0530
Message-ID: <20260428141851.549364-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <abfc9469-5d47-4e83-8c3c-03138f1b2ade@kernel.org>
References: <abfc9469-5d47-4e83-8c3c-03138f1b2ade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks, that was the right hint. The path from the EC to ACPI methods to WMI
has been fun to trace, and I learned quite a bit.

I checked the WMI path, and the charge methods are reachable through the
existing HP BIOS WMI GUID:

  5FB7F034-2C63-45E9-BE91-3D44E2C707E4

The _WDG entry exposes object "AA" as a method. In this firmware that maps to:

  \_SB.WMID.WMAA

and WMAA calls:

  \_SB.WMID.WHCM(Arg1, Arg2)

Inside WHCM, the command dispatch maps the charge-control methods like this:

  read  commandtype 0x1f -> \GBCC()
  read  commandtype 0x2b -> \GBCO()
  write commandtype 0x1f -> \SBCC(DDWD)
  write commandtype 0x2b -> \SBCO(DDWD)

Calling the WMI wrapper for the three modes works as expected:

  \SBCC 0x0000 -> normal charging / auto
  \SBCO 0x0500 -> inhibit charge
  \SBCO 0x0200 -> force discharge while on AC

So the raw ACPI methods do not need to be called directly; the existing HP BIOS
WMI transport reaches them.

Given that, I think the implementation can use hp_wmi_perform_query() with the
existing HPWMI_BIOS_GUID.

I am still unsure about where to put it. The smallest patch would be to add the
power_supply extension code directly to hp-wmi.c, but that file currently does
not have any battery-specific code paths. Should I add it to hp-wmi.c, add a
small HP-specific file under drivers/platform/x86/hp/, or is there another file
I missed?

Thanks,
Navon
