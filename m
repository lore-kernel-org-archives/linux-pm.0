Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFEF349CF3
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647449; cv=none; b=WVPh3SkCf1CaeLtwIPGK6f3ByO/6pFpEQHBcdzyeMVdA4pf3SWjM38Wcb2dcVr1cg2sS7or91DNmDwwD7Zt3ugA/P3xKNbLWPeoPWeFXUbsyfTG8H3jVsHwhw3PSgJqwqi9ZsQwr3boE5hsSXnXo1+dXAlgvLbuktPWcG3NPr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647449; c=relaxed/simple;
	bh=Tr0Kp2ggzl1FXTGexdxSIQs6TzVga0sQ+GqiGQ4toQ8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IUsKMGyvFNtUSKgJcvHG4SdXH85kBeSie4E5VUXZ7jNDia0ptFNKsKZCKooONWaDiiJuwW047n3LBzda1PW1QSOayCO4bt/VC85SVA2QdsGK7t6d98uAAWRbRAfZ5DkE74LZogxxHLw53XJOuhRLKUsb+UA2ua1AEOg9M9oRiXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8GLaeSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8GLaeSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE441F00A3A
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786647448;
	bh=GK7Vhdi8BhZGrgIDpyUzJD9pUveI4wwO12j67GCeURo=;
	h=From:Date:Subject:To:Cc;
	b=c8GLaeSazNt32C3V6nKF6dqY0I1pkVZ+vLheJO4mFtLcPkzidwjTff+nHatO8fo4D
	 pbvbXLv/o6Nu8zpJADIctpkyLbmKwoDlQcRBlR5zllHNL2SLFYinoXOdrvXjcQ5Vbj
	 MBjf2noAEPNL7OSJoKgbs4zv8dn/FAILQecGZB/a9gLYKKFE65MXC5Z+bmKurokttV
	 IV1bo+9IzjsoaQLur6s/FsVQqKMcUyzSDzfh02OZHHds46XcrT0atcd08NiYW4NSEc
	 0NtUmT71Dt1a6RN5YplF6wZFg+NdBPZpiFfgJe1JTQRtJOX+NxZeJwaDQ90dBB4fVH
	 flFqYhyCgl8yw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b0117dda13so149682e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 11:57:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YxlVMytD1r/5XWMaljwMPIL1sgbzTO8AO8y9b54PuOfg/v0yrz2
	kL+A3+2rIRhZwOn44KaqTAMf2QhAN6alxS9qvNywzsnhTTX5Y4+/4rMK5NdHlMeMBRJk/Aj885b
	YKbFK56ToE2lEPUA8L7M36aJg3a0WFjo=
X-Received: by 2002:a05:6512:1310:b0:5b2:b004:ab9b with SMTP id
 2adb3069b0e04-5b45913c3bcmr12790e87.33.1786647447075; Thu, 13 Aug 2026
 11:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 20:57:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gnOPTz8m-eu4+SUG-O4gj2+QM6TzYs=w_WhCVec7Omew@mail.gmail.com>
X-Gm-Features: AUfX_myM3Epzs5irvbYBFpYNbWld1f1-y8y5WJNIw1kn67yNcneUIcYQJB_tueI
Message-ID: <CAJZ5v0gnOPTz8m-eu4+SUG-O4gj2+QM6TzYs=w_WhCVec7Omew@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for 7.3-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This goes early for your convenience.

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.3-rc1

with top-most commit 2d5667b6c3d7adf0f8551bbac7c707fb87155611

 Merge branches 'thermal-core', 'thermal-hwmon', 'thermal-intel' and
'thermal-tools'

on top of commit 7cbe91a4be8536a3f17fb00828fc3f024f0a1e61

 Merge tag 'thermal-7.2-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive the first part of thermal control updates for 7.3-rc1.

These include an introduction of Intel Directed Package Thermal
Interrupt support into the thermal throttling driver for Intel
processors, probe failure code path fixes and code cleanups in Intel
thermal drivers, a thermal core fix related to hwmon, a sysfs-related
cleanup of that code, and a thermometer utility fix:

 - Add support for the Directed Package-level Thermal Interrupt to
   the Intel thermal throttling driver to allow package-level thermal
   interrupts to go to one specific CPU in a processor package instead
   of going to all of the CPUs in it (Ricardo Neri)

 - Remove hwmon class devices created for thermal zones when the thermal
   zone devices holding them are removed (Rafael Wysocki)

 - Use sysfs_emit_at() in trans_table_show() (Thorsten Blum)

 - Clean up RFIM groups on DVFS failure and clean up ODVP on probe
   failures in the int340x thermal driver (Pengpeng Hou)

 - Remove redundant dev_err() from the int340x thermal driver and the
   bxt_pmic driver (Pan Chuang)

 - Simplify ptc_temperature_write() in the int340x thermal driver by
   using kstrtou32_from_user() (Dmitry Antipov)

 - Close fd on realloc() failure in the thermometer utility (Amarjeet)

Thanks!


---------------

Amarjeet (1):
      tools/thermal/thermometer: close fd on realloc() failure

Dmitry Antipov (1):
      thermal: intel: int340x: simplify ptc_temperature_write()

Pan Chuang (2):
      thermal: intel: int340x: Remove redundant dev_err()
      thermal: intel: bxt_pmic: Remove redundant dev_err()

Pengpeng Hou (2):
      thermal: intel: int340x: clean up RFIM groups on DVFS failure
      thermal: intel: int3400: clean up ODVP on probe failures

Rafael J. Wysocki (1):
      thermal: hwmon: Remove hwmon class device along with its parent

Ricardo Neri (5):
      x86/thermal: Add bit definitions for Intel Directed Package
Thermal Interrupt
      thermal: intel: Add resources to handle directed package-level
thermal interrupts
      thermal: intel: Enable the Directed Package-level Thermal Interrupt
      thermal: intel: Add syscore callbacks for suspend and resume
      thermal: intel: Add a syscore shutdown callback for kexec reboot

Thorsten Blum (1):
      thermal: sysfs: Use sysfs_emit_at() in trans_table_show()

---------------

 arch/x86/include/asm/cpufeatures.h                 |   2 +
 arch/x86/include/asm/msr-index.h                   |   2 +
 .../intel/int340x_thermal/int3400_thermal.c        |   4 +-
 .../int340x_thermal/platform_temperature_control.c |  13 +-
 .../int340x_thermal/processor_thermal_device_pci.c |   8 +-
 .../intel/int340x_thermal/processor_thermal_rfim.c |  11 +-
 drivers/thermal/intel/intel_bxt_pmic_thermal.c     |   4 +-
 drivers/thermal/intel/therm_throt.c                | 277 ++++++++++++++++++++-
 drivers/thermal/thermal_hwmon.c                    |  87 +++----
 drivers/thermal/thermal_sysfs.c                    |  49 ++--
 tools/thermal/thermometer/thermometer.c            |   1 +
 11 files changed, 352 insertions(+), 106 deletions(-)
