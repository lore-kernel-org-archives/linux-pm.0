Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB1D3542D4
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577364; cv=none; b=h650AKmocqXNsa+FuHfJIuNhAuOrllK8UtH8EgAz32WBm4i47nQ/E4Y386owiwaro3HP4gdjxPoZlofU2P4snljCxbZdwjFJ4j7MzOFr/SttYmqabwQZHZKXFBNMdpgm+F05dLYr9KVB7rqlBVESOaF3/YRLBj+zjqxGal3yUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577364; c=relaxed/simple;
	bh=dTbw3wSrZFQuB/Nkq3QnZP6ghP7nPWaMNBKGvmgfPHw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gTnQfaYzXpEuQgLmrAzbJVIyabkS2Yv/BQqoilFhvxDLZh7t+LFq/x4IHd87P1fPPXN36p1UbZydMSe1Fm36RRd0OfQTFYoYUR/fftwjwnyD+oKPSqmJOJJCcJSf+hRylZ8TaesiTSeiEqi1EwCms0msoG88/RFJBetqyKL9/g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZFwbIZf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZFwbIZf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A39C2BCB3
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 19:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777577364;
	bh=dTbw3wSrZFQuB/Nkq3QnZP6ghP7nPWaMNBKGvmgfPHw=;
	h=From:Date:Subject:To:Cc:From;
	b=SZFwbIZfqfvEvGBwTzcUB5tg3JafQdM2f5spJOhVSD5J1M+tncqXuTkSL6fnmlF20
	 d6YhB6srj3xotyW+e4hsJNCGKb/+Hy0HobVkhYIWuSVF+r72dlhLjhMj0j/y6aG9Pa
	 ChWAfBmx6UcW9HA1yxTMDfBaygOxGf7Eu97u+YEeXGPNZC8R1A7Qw0sZQMNJTar+JG
	 17yPivZPbDzxA/xyKv7S4LhApU6HdfTv76JspLIlNRpOC5aui9C3/sM7keJSpz+5zz
	 JcNsN8NdWwmaNuRxj9tuIglaRWWeyd4ySc5ovuiEXPpTDQ8ykkMC12MfR5IEB1b/rG
	 3D7FqDd0iBSxA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so1660382e87.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 12:29:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+53DOI4tr84SwAikDudICMKo1n+LMuTeY6QUvHm6+O9licNalHgGP1JhX3iTJWmwF2PoV1QyosQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbgq8XKY9bUREf/TMsvhJlFTkNr6RpL0YACnCXNK6lq1eCDT9G
	2Erkc1Lbx3i+sdDn1HPuR0/I0zxv7yvfjc9rRKkAxlDxuSammkH6XYf01EdTtmM1iID4x7QuQ5v
	xK75pbYzD5Kk34jQ6zkTxjFU4nWKCbEA=
X-Received: by 2002:a05:6512:b9c:b0:5a4:1902:3d17 with SMTP id
 2adb3069b0e04-5a8522bc1cfmr1429017e87.12.1777577362843; Thu, 30 Apr 2026
 12:29:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 21:29:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ibhdW57s-68e_kHCZ6b=YXi5o74ykS=pd5vRTiXnbsAQ@mail.gmail.com>
X-Gm-Features: AVHnY4J-HUSqyT3rD1_5p2ahJwaO3TazlQd8p_WtwzYeNOpp_bcvKMkj7INHwIM
Message-ID: <CAJZ5v0ibhdW57s-68e_kHCZ6b=YXi5o74ykS=pd5vRTiXnbsAQ@mail.gmail.com>
Subject: [GIT PULL] ACPI support fixes for v7.1-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-7.1-rc2

with top-most commit 36a96eda15bf66a18ca472aef9242e57551016ab

 Merge branches 'acpi-apei', 'acpi-bus', 'acpi-cppc' and 'acpi-video'

on top of commit 254f49634ee16a731174d2ae34bc50bd5f45e731

 Linux 7.1-rc1

to receive ACPI support fixes for 7.1-rc2.

These fix leftover issues in the ACPI Time and Alarm Device (TAD)
driver on top of the recently merged updates of it and address
assorted issues in the ACPI support code:

 - Fix removal code ordering in the ACPI TAD driver, refine timer value
   computations and checks in its RTC class device interface, make it
   use the __ATTRIBUTE_GROUPS() macro, and fix a comment in it (Rafael
   Wysocki)

 - Fix EINJV2 memory error injection in APEI (Tony Luck)

 - Add missing notifier_block structure forward declaration to
   acpi_bus.h (Bartosz Golaszewski)

 - Fix related_cpus inconsistency during CPU hotplug in the ACPI CPPC
   library (Jinjie Ruan)

 - Add a quirk to force native backlight on HP OMEN 16 (8A44) in the
   ACPI video bus driver (Shivam Kalra)

Thanks!


---------------

Bartosz Golaszewski (1):
      ACPI: bus: add missing forward declaration to acpi_bus.h

Jinjie Ruan (1):
      ACPI: CPPC: Fix related_cpus inconsistency during CPU hotplug

Rafael J. Wysocki (4):
      ACPI: TAD: Use __ATTRIBUTE_GROUPS() macro
      ACPI: TAD: Use devres for all driver cleanup
      ACPI: TAD: RTC: Refine timer value computations and checks
      ACPI: TAD: Fix up a comment in acpi_tad_probe()

Shivam Kalra (1):
      ACPI: video: force native backlight on HP OMEN 16 (8A44)

Tony Luck (2):
      ACPICA: Provide #defines for EINJV2 error types
      ACPI: APEI: EINJ: Fix EINJV2 memory error injection

---------------

 drivers/acpi/acpi_tad.c       | 35 ++++++++++++++++++---------------
 drivers/acpi/apei/einj-core.c | 45 ++++++++++++++++++++++++-------------------
 drivers/acpi/cppc_acpi.c      |  6 +++---
 drivers/acpi/video_detect.c   |  8 ++++++++
 include/acpi/acpi_bus.h       |  2 ++
 include/acpi/actbl1.h         |  6 ++++++
 6 files changed, 63 insertions(+), 39 deletions(-)
