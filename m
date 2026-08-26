Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F5400988
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769517; cv=none; b=FMtIsKRVobUTvuW6u6UjbLSHitMkpI6Nhv4cTojcg8x6lgJOk45l2eNgVE3U3FpRgAjWnipDv67lYvsCVQmF77EFtj0N6mZNd+8Y0Ezkg1UK91QfRy6sQbtMInuHHBn+Ly2TKS1GRSF+QWoHlJTT0k/puuz8TzRomBszllZKHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769517; c=relaxed/simple;
	bh=a0SCaZJ7sTZ0C5PezKa77Vpx+22P/KdPFjfBQCy7FF4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tpZ2smnkaTaIXUmDt9QD+mTwiPiaNkdpILUzPGmpcL31FxkYNZMVAOmnKTA/V4MiuoLwplM9ENuoyjnDbbTpED3R8NfvXiX6NGRh3QVVYw7IRZPYYnOYoFFR2+v80OYv4WgXuYnDS902LrYDmZ9j4Vsu+emDkXOGtG5oOr5a6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C34g0FpJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C34g0FpJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C361F000E9
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 18:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787769505;
	bh=/gCAVniLX3E0NkJo3jXJ7s6s8n++bS//gwCeoIN1iSg=;
	h=From:Date:Subject:To:Cc;
	b=C34g0FpJhfr7HYFayDJN/D2I6B+u0JPET+47PNcmnAELuxBCa2n1j21FL5YDu+8u3
	 mI/5ev1RcwD4PHWA5pXk7zKC+ZzW8VkHD1qLVv95pnCW8Ij57UaoFKv2KWN47hJosc
	 vwjMKqYQ7JcpQFViYfDk0b8/U5RQAIE7SZJYKwWdQfBYgn680/BnJDUe+LxqiUoZp/
	 5E46STQXUJfYVEdD8OwBE3aQ22z2Mnn/I/pwoR3MDfbNkS6W39DiKL1TXz9j028fjK
	 Pg3fqyPIHpLPwvox6RxbFV+yn/rBUObJUt4Ig9wDGjyaOlH0A5cUTx7f/uK5JDebuK
	 phnv2iwjgHktw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso1414563e87.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:38:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoiTNVrhFmDWyGI9SqqlOtS/0aCspxySWUwPQ3Zrf1rmsCKs8+SXvLJMwhlSdkwxSBhSOwHbUKNzw==@vger.kernel.org
X-Gm-Message-State: AFuF++muFFxp5WvNi8F27azXQGD7s0XzmbZ7sFMh4Tt1wjZYAHI8LjoZ
	FDSTyOO4/Zs3TOfiMeO4SDRhyRyXF5HAkvq7OunvQuHj0Ug5MXQ+fp4oDKHP8x8gHNzK1qzRiAy
	T3Vnft2i+lruBBs0S07gHOYx331WtAI0=
X-Received: by 2002:a05:6512:8381:b0:5b2:e95a:491d with SMTP id
 2adb3069b0e04-5b4a90579bbmr2382838e87.9.1787769503853; Wed, 26 Aug 2026
 11:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 26 Aug 2026 20:37:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jdSjMH_kYu6GQ1-AQ2TXHji2Vd1+v5YP8_CxXM3PUa6A@mail.gmail.com>
X-Gm-Features: AcwNN1VtrMiz0zZhCTUSAvasLFrvwBziZCTREV0w_8th_19faQzUv6stuSDgShM
Message-ID: <CAJZ5v0jdSjMH_kYu6GQ1-AQ2TXHji2Vd1+v5YP8_CxXM3PUa6A@mail.gmail.com>
Subject: [GIT PULL] More ACPI support updates for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.3-rc1-2

with top-most commit ea10c0b334e0dca944de2b5ecf57cf7e366674f4

 Merge branches 'acpi-battery', 'acpi-button', 'acpi-soc' and 'acpi-pfrut'

on top of commit 0d508f1745b57272d4d4a3d50dc35aa2a3682238

 Merge tag 'acpi-7.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive more ACPI support updates for 7.3-rc1.

These update documentation to reflect recent changes in the upstream
ACPICA project, fix issues in the core ACPI device enumeration code
(one of which has been introduced recently), improve the primary
"physical" device lookup for ACPI device objects in that code, and
update ACPI device drivers:

 - Update MAINTAINERS, CREDITS and ACPI subsystem documentation to
   reflect recent changes in the upstream ACPICA project (Rafael
   Wysocki)

 - Prevent the core ACPI enumeration code from combining device
   resources that overlap completely in order to avoid resource
   conflicts during platform device registration because there are
   drivers that expect such resources to be present (Rafael Wysocki)

 - Defer device power initialization during ACPI-based device
   enumeration to the point when the given device is known to be present
   and functional and all of its dependencies have been met (Peixin Xie)

 - Fix bus ID cleanup on device_add() failures during ACPI device object
   registration (Hongyan Xu)

 - Introduce a new helper function for looking up the primary "physical"
   device for a given ACPI device object and update the core ACPI device
   enumeration code to use that function (Rafael Wysocki)

 - Protect all battery properties with a separated mutex in the ACPI
   battery driver to prevent race conditions from occurring and avoid
   evaluating the _BST ACPI control method multiple times in parallel
   for the same battery device (Rong Zhang)

 - Add DMI quirk for the Razer Blade Pro 17 early 2020 lid switch to the
   ACPI button driver (Robin Everaars)

 - Convert fixed clock rates in the ACPI driver for AMD SoCs (APD) to
   use HZ_PER_MHZ and add a clock frequency for the HJMC01 I2C
   controller to it (Hongnan Li and Xiangyang Yu)

 - Fix a stack buffer overflow in query_capability() in the ACPI
   platform firmware runtime update driver (Anirudh Prasad)

This material had a merge conflict against the driver core tree in
linux-next as per

https://lore.kernel.org/lkml/aoMvR5MHCsykmdEO@sirena.org.uk/

Thanks!


---------------

Anirudh Prasad (1):
      ACPI: pfr_update: fix stack buffer overflow in query_capability()

Hongnan Li (1):
      ACPI: APD: Convert fixed clock rates to use HZ_PER_MHZ

Hongyan Xu (1):
      ACPI: scan: fix bus ID cleanup on device_add() failures

Peixin Xie (1):
      ACPI: scan: Defer device power initialization

Rafael J. Wysocki (7):
      ACPI: bus: Introduce acpi_bus_get_primary_device()
      ACPI: platform: Use acpi_bus_get_primary_device()
      ACPI: scan: Use acpi_bus_get_primary_device()
      ACPI: Add Bob Moore to CREDITS
      ACPI: Update MAINTAINERS entry for ACPICA
      ACPI: Update upstream ACPICA repository URL in documentation
      ACPI: scan: Do not combine resources that overlap completely

Robin Everaars (1):
      ACPI: button: Add DMI quirk for Razer Blade Pro 17 early 2020 lid switch

Rong Zhang (1):
      ACPI: battery: Protect all properties with a separated mutex

Xiangyang Yu (1):
      ACPI: APD: Add clock frequency for HJMC01 I2C controller

---------------

 CREDITS                                            |   4 +
 Documentation/driver-api/acpi/linuxized-acpica.rst |  10 +-
 MAINTAINERS                                        |   6 +-
 drivers/acpi/acpi_apd.c                            |  35 +++--
 drivers/acpi/acpi_platform.c                       |  24 ++--
 drivers/acpi/battery.c                             | 147 ++++++++++++++-------
 drivers/acpi/bus.c                                 |  54 +++++---
 drivers/acpi/button.c                              |  11 ++
 drivers/acpi/pfr_update.c                          |  45 ++++---
 drivers/acpi/power.c                               |   1 +
 drivers/acpi/scan.c                                |  37 +++---
 include/acpi/acpi_bus.h                            |   6 +
 12 files changed, 246 insertions(+), 134 deletions(-)
