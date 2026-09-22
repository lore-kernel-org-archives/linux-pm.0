Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43094382368;
	Tue, 22 Sep 2026 06:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790058799; cv=none; b=uKzaV8r+bR1F2/GN0hSUTB4yybEPKt6NZ338BnH/dzBJDd3D8Zyi/E6FT5gSNYmWYcGFCc4Uyv+uvOjqPlItFB1XT9FIHokx4W4GxugsaSq/EDJl85jhp5yRSnSVpU3DupSAHqGELnQ3FeStrNyALCWzAGLEM0JNUcn0QTUTelk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790058799; c=relaxed/simple;
	bh=9ORWwR/mv+I22Vgwms4d3LBBOTjKImZE8xuOc3g+STc=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=HtjTD/ASRUaeXwz7vO5kiXlmlYjQxBe7npRPbNm3EKUVy725WmHvzcZs6lVquxxJmfhQrfZXv+AAdXmWClG9WeSvQFYdRJMS84tc1Jj9Un9BXu0k8kRrUESwPFQvHXUyF4IWFa/kF6EDxjcMcZ1ZwKPZogqni2zR2thZ4zZK9Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=j0Motv1D; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=8reELHar; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="j0Motv1D";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="8reELHar"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790058782; bh=UkrtqxQ06g+JNZDlOhWL45V
	fcsmMEzFGL3rq7zrxp5w=; b=j0Motv1DYY2WnnO0GoXp414XDGVLlHPvVzSvA1LdR8dxGg/Bdu
	Al2z+WUq6nbhNXQSuuioqdGjYbVLf40m1kJKvPsVvasOmHoloX2bGuPxyKv0tC8I2mROw5I4+NE
	5y1WuNsaW0zo4uwlwW2NsU18yD5Zrbg/hF1LSQPNCWdh7KgG7/VTrDl9X5dthaaDwYWZsuy8MgW
	HoK4f8fuGHW0y5bZh+hQj8WJpGTIkSE4BHy++hhSSYgPasPJtbMeXrxhUWESAS5b/ESVgAQzuqg
	ROebPzk+MS+h4xFkTjI75y6vwTczSjZK8z8Nx+G5nmtPBG7/JuvA4WhsZ5v2y3NrdGw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790058782; bh=UkrtqxQ06g+JNZDlOhWL45V
	fcsmMEzFGL3rq7zrxp5w=; b=8reELHar/PZ9pyX5REzczi++PWP7E8QndY1rZ42yGUu2wYQSDM
	iFWAI2PSGo1aLWX2QEvH20Qjc4T68e4zkyAA==;
Date: Tue, 22 Sep 2026 07:33:03 +0100
From: Bradley Morgan <brads@mainlining.org>
To: faruque.ansari@oss.qualcomm.com
CC: avaneesh.dwivedi@oss.qualcomm.com, bleung@chromium.org, broonie@kernel.org,
 chrome-platform@lists.linux.dev, daniel.lezcano@kernel.org,
 francesco@valla.it, groeck@chromium.org, kernel@pengutronix.de,
 lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lukasz.luba@arm.com,
 mazziesaccount@gmail.com, o.rempel@pengutronix.de, rafael@kernel.org,
 rui.zhang@intel.com, sebastian.reichel@collabora.com, sre@kernel.org,
 tzungbi@kernel.org, umang.chheda@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v14_0/6=5D_power?=
 =?US-ASCII?Q?=3A_reset=3A_Introduce_the_Pow?=
 =?US-ASCII?Q?er_State_Change_Reasons_Recording_=28PSCRR=29_framework?=
In-Reply-To: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
Message-ID: <2F1E7C6E-897D-40BF-A37E-EAF42C4A0CA5@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 21 September 2026 18:44:15 BST, Faruque Ansari
<faruque.ansari@oss.qualcomm.com> wrote:
>Hello all,
>
>A system power-state transition - a shutdown or a reboot - rarely has a
>single, unambiguous cause, and no one component sees the whole picture:
>the
>PMIC, the watchdog, the SoC reset registers, the bootloader and software
>each
>only know their own part, so there is no single source of truth.
>
>PSCRR gives these sources one central place to report side by side. Every
>provider keeps its own view - several providers, and several reasons
>within a
>provider, can be reported at once and are deliberately not collapsed into
>a
>single "winning" cause (a bit of a minority report). On top of that it
>adds a
>software-backed recorder, so software-detected reasons - under-voltage,
>over-temperature, a watchdog pretimeout, a panic, a controlled reboot -
>are
>captured too and survive into the next boot.
>
>The NVMEM-cell binding a recorder needs to pick its storage is still
>deadlocked, and several projects already need the framework, so this v13
>posts the framework, its reboot/reason infrastructure and the sysfs
>documentation only; the provider drivers (NVMEM, PMIC, ...) and the tests
>follow separately once the binding is resolved. One built-in provider,
>reporting the bootloader's device-tree /chosen/reset-source, is kept so
>the
>framework is useful on its own without a new binding.
>
>For followup drivers, see:
> https://github.com/olerem/linux-2.6/tree/v7.2/topic/pscr-v12
>
>Changes in v14:
>- Ignore v13, it was mistakenly posted as a reply to Oleksij's v12
>  patch series.
>
>Changes in v13:
>- Rework pscrr_provider_register() based on review feedback from Francesco Valla:
>  move the pscrr_root check before allocation and narrow pscrr_lock scope.
>- Carry the series forward with Faruque Ansari as author and Oleksij
>  Rempel as co-developer, and vice versa where required.
>- Link to v12: https://lore.kernel.org/r/20260731095959.296056-1-o.rempel@pengutronix.de
>
>Changes in v12:
>- Drop all provider drivers and their tests; post the framework alone. The
>  NVMEM-cell binding a recorder needs to pick its storage is still
>  deadlocked, and several projects already need the framework - so unblock
>  the core now and let the providers (NVMEM, PMIC, ...) follow separately.
>- Rework into a multi-provider design (per-provider /sys/kernel/pscrr/
>  directories); add reason tokens and a built-in /chosen/reset-source
>  provider.
>
>Changes in v11:
>- add missing break reported by kernel test robot <lkp@intel.com>
>
>Changes in v10:
>- add some add Reviewed-by tags
>- regulator_handle_critical: set pscr = PSCR_UNKNOWN for default case
>- make g_pscrr static
>
>Changes in v9:
>- Remove redundant pr_crit() messages before hw_protection_trigger()
>- Replace psc_reason_to_str() switch with static const string array
>- Mark psc_last_reason as static
>
>Changes in v8:
>- Use DEFINE_GUARD() and guard(g_pscrr) for scoped locking of the global
>  pscrr_core struct
>- Replace manual mutex_lock/unlock with automatic cleanup-based guard() usage
>- Centralize backend and locking state in struct pscrr_core
>- Prepare for future multi-backend support with clean encapsulation
>- Improve sysfs documentation
>
>Changes in v7:
>- document expected values in sysfs documentation
>- make write support optional
>
>Changes in v6:
>- add sysfs documentation
>- push core part of the reset reason into kernel/reboot.c
>
>Changes in v5:
>- fix compile with NVMEM=n and potential issues with NVMEM=m
>
>Changes in v4:
>- fix compile with CONFIG_PSCRR=n
>
>Changes in v3:
>- rework to remove devicetree dependencies
>- extend NVMEM to search devices and cells by names
>
>Changes in v2:
>- rename the framework from PSCR to PSCRR (last R is for Recorder)
>- extend the power-on reason header and reuse it for the detected reason
>- rebase on top of v6.8-rc1

Hey, I dont see the use to PSCRR, are you planning to ship any providers?

>
>To: Sebastian Reichel <sre@kernel.org>
>To: Benson Leung <bleung@chromium.org>
>To: Tzung-Bi Shih <tzungbi@kernel.org>
>To: Guenter Roeck <groeck@chromium.org>
>To: Liam Girdwood <lgirdwood@gmail.com>
>To: Mark Brown <broonie@kernel.org>
>To: Matti Vaittinen <mazziesaccount@gmail.com>
>To: Rafael J. Wysocki <rafael@kernel.org>
>To: Daniel Lezcano <daniel.lezcano@kernel.org>
>To: Zhang Rui <rui.zhang@intel.com>
>To: Lukasz Luba <lukasz.luba@arm.com>
>To: Oleksij Rempel <o.rempel@pengutronix.de>
>To: Pengutronix Kernel Team <kernel@pengutronix.de>
>Cc: linux-arm-msm@vger.kernel.org
>Cc: linux-pm@vger.kernel.org
>Cc: linux-kernel@vger.kernel.org
>Cc: chrome-platform@lists.linux.dev
>Cc: avaneesh.dwivedi@oss.qualcomm.com
>Cc: Umang Chheda <umang.chheda@oss.qualcomm.com>
>
>Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
>---
>Faruque Ansari (6):
>      power: Extend power_on_reason.h for upcoming PSCRR framework
>      reboot: hw_protection_trigger: use standardized numeric shutdown/reboot reasons instead of strings
>      reboot: add parsable tokens for power state change reasons
>      reboot: extend psc_reason with power-on and reset causes
>      power: reset: Introduce PSCR Recording Framework for Non-Volatile Storage
>      Documentation: Add sysfs documentation for PSCRR
>
> Documentation/ABI/testing/sysfs-kernel-pscrr | 108 +++++
> MAINTAINERS                                  |  11 +
> drivers/platform/chrome/cros_ec_lpc.c        |   2 +-
> drivers/power/reset/Kconfig                  |   2 +
> drivers/power/reset/Makefile                 |   1 +
> drivers/power/reset/pscrr/Kconfig            |  33 ++
> drivers/power/reset/pscrr/Makefile           |   2 +
> drivers/power/reset/pscrr/pscrr.c            | 633
> +++++++++++++++++++++++++++
> drivers/regulator/core.c                     |  16 +-
> drivers/regulator/irq_helpers.c              |   9 +-
> drivers/thermal/thermal_core.c               |   3 +-
> include/linux/power/power_on_reason.h        |   5 +
> include/linux/pscrr.h                        | 107 +++++
> include/linux/reboot.h                       | 108 ++++-
> kernel/reboot.c                              | 165 ++++++-
> 15 files changed, 1183 insertions(+), 22 deletions(-)
>---
>base-commit: 5c4d4169604b335c38bbc79bc1fc03042981fc6f
>change-id: 20260921-pscrr-framework-25f48818efe8
>
>Best regards,
>

--- Thanks!
"I'm not a very positive person" - Linus torvalds
