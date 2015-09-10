From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 13/17] thermal: int340x: allow compile test
Date: Thu, 10 Sep 2015 08:31:47 +0200
Message-ID: <CAMuHMdXd5=qZd17czeYPQMBDaUYyC7JCB+1S49dVPfgm=Xp_iQ@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-14-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35614 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbbIJGbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:31:48 -0400
In-Reply-To: <1441858273-4017-14-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, "lan,Tianyu" <tianyu.lan@intel.com>, Ilkka Koskinen <ilkka.koskinen@linux.intel.com>

On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.com>=
 wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -317,7 +317,7 @@ config INTEL_QUARK_DTS_THERMAL
>
>  config INT340X_THERMAL
>         tristate "ACPI INT340X thermal drivers"
> -       depends on X86 && ACPI
> +       depends on (X86 && ACPI) || COMPILE_TEST
>         select THERMAL_GOV_USER_SPACE
>         select ACPI_THERMAL_REL
>         select ACPI_FAN

This driver selects INTEL_SOC_DTS_IOSF_CORE, which uses an x86-specific
header file.

drivers/thermal/int340x_thermal/int3400_thermal.c: In function
=E2=80=98int3400_thermal_get_uuids=E2=80=99:
drivers/thermal/int340x_thermal/int3400_thermal.c:120: error:
dereferencing pointer to incomplete type

Missing #include <linux/fs.h>

drivers/thermal/int340x_thermal/acpi_thermal_rel.c: In function
=E2=80=98acpi_parse_trt=E2=80=99:
drivers/thermal/int340x_thermal/acpi_thermal_rel.c:85: error: implicit
declaration of function =E2=80=98acpi_has_method=E2=80=99

Missing #include <acpi/acpi_bus.h>

drivers/thermal/int340x_thermal/acpi_thermal_rel.c: In function
=E2=80=98acpi_parse_trt=E2=80=99:
drivers/thermal/int340x_thermal/acpi_thermal_rel.c:125: error:
implicit declaration of function =E2=80=98acpi_bus_get_device=E2=80=99

Definition depends on CONFIG_ACPI

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
