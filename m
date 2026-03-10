Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C88243D4F8
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134950; cv=none; b=ZBoP0Dlfc04a1ucxC0kRgY4HA4XkhbasY8MmxvXEGtzIkyCOqyetiP+o3wwrr03h7O1jBiGjX7HBSV2eyYVd2llLi5K8Tz/uOZfRuU5vAHaFKfplRHKoiirmW66kGAaz3v46N6cR1zuxty7uw5ieNfijx1ASEDIpApg5bWVxnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134950; c=relaxed/simple;
	bh=V5YSqsc7mks2SF/nUdlDxogCbbBj+0pDE2z2UGEJ4Ro=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NT3jQz/bODtv8l03AY+8Mmls/ZvT4YarvDhKJMgSjMEnnfVPSPjTWfYA456o6DApxrpvzbVkRF62CnrP7DT6J37z4oKg+Da+ibP6dZn4077KiKFZvwStKouDoT+RqNxwuxQPKcgJRm7K2PTjhofxRBVVcalHgQBuwLMLZakWsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Jz88+QXG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Jz88+QXG"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-485409ab264so8824725e9.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773134947; x=1773739747; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpA639p95WypbYLFKutmL4S7cIH8gNiEyA3iWl4bY1M=;
        b=Jz88+QXGSlJ5l3TkAm6BOqMKfOW8Xjc43znlACW8FdGQKtPRcNcVi9Kq2blfoH7GFK
         swkfKm5YVOMWdD7d/fDZvfvBvADe0zSd5ybyV229CT0JaKux6lP8CmwYeEWi9N0olgsM
         ibmfG1jYFtWWqqmHDGduy8t95HI2aDlyXF/rVy2P53w34ixEeXMFdoW9e1vOnDkWiA2d
         Ioi49j+b8OTZQIh4nkCXU8cY8bdZ+s6tSbWCm6+5MQSuxCUqUEQx0gg2YSXmy6q1VQ94
         kjXt5cWOA55CeNCG8pbcoQdQZtrgNEDecjBna10wIYpGMi3zHiltIwTRdBIf4EK1lOU1
         1kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773134947; x=1773739747;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpA639p95WypbYLFKutmL4S7cIH8gNiEyA3iWl4bY1M=;
        b=C04+Lsvo+GVi2ytX+BH/INnCiE+ZytEHAjpKmMX4LbfXkgx1d2sORu4oyK5QACIspT
         OfEx+dkLfF05oAi5g6dqdu3FcHRziQwGuB6gs3rr+Ck+pEBwoC3ognTpseILGM+N+LQi
         U2/klrIa6mBqRS7RddlRyJ9aMVdQzFEQcgzy3pTIUVeC0C/I603Z5UbXmOR6fhHFymqH
         pmIyKIgCVIEQ3RzM3ZcnBzbCXAZZv56RW+MZUbBCJAaJXP8uuqdhHUcvxoI2Nl2GgGGV
         /uLAC0tcaEtbCqZNFwOpfoSNtcjZI6n0nk7MvgyIuJHjI3auAFlxaNDJyvcBbDWsMbtQ
         MlCw==
X-Forwarded-Encrypted: i=1; AJvYcCXmphdxn+IQU1iztziwLyoh9KdGCIcrdoE2pWtQV7igaImKID0l5IqipRhd7focF9qhecFSE/jXiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzskn3D+i32L8Pw8YIlSm9eKfPTY+stEMaI5eNk1yuozN3LPNzX
	3ryguRO+J6TyCKohqUvceZVnW2ood/QLXHgLkzwpqNqvZLzLgjrp0bkyOyuCbxJutwU=
X-Gm-Gg: ATEYQzwGH+1eY/fcz/MNjXIqYRkLwhvsdxVZZhsZpCoXsX6mNUkOJDgisc54PDdyF6H
	aIrpax6pppaeAIJ5q98/Y8PbWTPVMKOZnUrzOpcnTKttZJx0HTocudC1xJmHf/7yBv0WYCsp/30
	k5dxZ1YDcBjxtwHKplDNTgSpCXlHz9M6kAaHIFFpGVsN6ZRDxR3hmkYaFEDNt9dWMnaqlTm7W6i
	Z0LN/KK/o9VGc8GkWgX0jS05naa3GPhDpUSRGa22MTdWHgrkaRInGpzfDD6B5qVfL5ps0ZW8DQb
	wNe/JAJ3wrpci9dSitzS2rp2smRJzqphXHuQ39hI2t25gTKvm0tcLs9RTctUFLxS/4JA9K1CAkJ
	wl0nKcn1w5p34STN2i1FVtBRI8FQl35iy3II7Pime+B/q7oVy2YberblQHVMMtDBm5LeYQAPsSR
	geTFZnoim7WD+y7Emchip2WbCs0yNyV63B/wHY3P9WNLqAOx6uQpv9Lp/CvfHmjKw4e0+7DSfBh
	uap6vg7sG8GLn6A
X-Received: by 2002:a05:600c:628b:b0:485:3cef:d6ea with SMTP id 5b1f17b1804b1-48541a0d032mr35337915e9.13.1773134946685;
        Tue, 10 Mar 2026 02:29:06 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529f019a4sm104214285e9.12.2026.03.10.02.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:29:06 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v3 00/11] Add support for the TI BQ25792 battery charger
Date: Tue, 10 Mar 2026 13:28:24 +0400
Message-Id: <20260310-bq25792-v3-0-02f8e232d63b@flipper.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjkr2kC/2WOQQ6CMBBFr0Jmbc3Q0hFceQ/jAmGQSQzUljQaw
 t0tbNS4fD/zXmaGwF44wDGbwXOUIOOQwOwyaPp6uLGSNjFo1IQGjbo+tD1UWmFudN2UVBbUQrp
 2njt5bqXzJXEvYRr9awvHfF3/GzFXqJjYMqIxhS1P3V2cY78feIK1EvW3SR8zPaDIVlYXVUtM3
 a+5LMsb8BzTqtoAAAA=
X-Change-ID: 20260303-bq25792-0132ac86846d
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3119; i=alchark@flipper.net;
 h=from:subject:message-id; bh=V5YSqsc7mks2SF/nUdlDxogCbbBj+0pDE2z2UGEJ4Ro=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWSuf+Ic+nTDQqay1V+7rFP9Pi/rFviz71P6psmsVh7S6
 yYd8D2Z2TGRhUGMi8FSTJFl7rcltlON+Gbt8vD4CjOHlQlkiLRIAwMQsDDw5SbmlRrpGOmZahvq
 GRrqGOsYMXBxCsBU97Qw/NN8+WXRggWbJr/J//DwbfZ54zLFU5kp0trnrzuoHVgwPfgww//8HZv
 aZvyv3SumJ9v0bG1nXOTinlsOPyey5C7cJ8t0yoMVAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

This adds support for the TI BQ25792 battery charger, which is similar in
overall logic to the BQ25703A, but has a different register layout and
slightly different lower-level programming logic.

The series is organized as follows:
- Patch 1 adds the new variant to the existing DT binding, including the
  changes in electrical characteristics
- Patches 2-4 are minor cleanups to the existing BQ25703A OTG regulator
  driver, slimming down the code and making it more reusable for the new
  BQ25792 variant
- Patch 5 is a logical fix to the BQ25703A clamping logic for VSYSMIN
  (this is a standalone fix which can be applied independently and may be
  backported to stable)
- Patches 6-8 are slight refactoring of the existing BQ25703A charger
  driver to make it more reusable for the new BQ25792 variant
- Patch 9 adds platform data to distinguish between the two variants in
  the parent MFD driver, and binds it to the new compatible string
- Patches 10-11 add variant-specific code to support the new BQ25792
  variant in the regulator part and the charger part respectively,
  selected by the platform data added in patch 9

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
Changes in v3:
- Move MFD cell definitions back out of the probe function (Lee Jones)
- Collect tags from Mark Brown, Krzysztof Kozlowski and Chris Morgan (thanks!)
- Enable ship FET functionality at init for BQ25792
- Link to v2: https://lore.kernel.org/r/20260306-bq25792-v2-0-6595249d6e6f@flipper.net

Changes in v2:
- Fix an error in DT schema (thanks Rob's bot)
- Ensure the broadest constraints for all variants remain in the common
  part of the schema, per writing-schema doc (thanks Krzysztof)
- Link to v1: https://lore.kernel.org/r/20260303-bq25792-v1-0-e6e5e0033458@flipper.net

---
Alexey Charkov (11):
      dt-bindings: mfd: ti,bq25703a: Expand to include BQ25792
      regulator: bq257xx: Remove reference to the parent MFD's dev
      regulator: bq257xx: Drop the regulator_dev from the driver data
      regulator: bq257xx: Make OTG enable GPIO really optional
      power: supply: bq257xx: Fix VSYSMIN clamping logic
      power: supply: bq257xx: Make the default current limit a per-chip attribute
      power: supply: bq257xx: Consistently use indirect get/set helpers
      power: supply: bq257xx: Add fields for 'charging' and 'overvoltage' states
      mfd: bq257xx: Add BQ25792 support
      regulator: bq257xx: Add support for BQ25792
      power: supply: bq257xx: Add support for BQ25792

 .../devicetree/bindings/mfd/ti,bq25703a.yaml       |  73 ++-
 drivers/mfd/bq257xx.c                              |  64 ++-
 drivers/power/supply/bq257xx_charger.c             | 535 ++++++++++++++++++++-
 drivers/regulator/bq257xx-regulator.c              | 123 ++++-
 include/linux/mfd/bq257xx.h                        | 415 ++++++++++++++++
 5 files changed, 1170 insertions(+), 40 deletions(-)
---
base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
change-id: 20260303-bq25792-0132ac86846d

Best regards,
-- 
Alexey Charkov <alchark@flipper.net>

