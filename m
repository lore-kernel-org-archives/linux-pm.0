From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/17] thermal: u8500: allow compile test
Date: Thu, 10 Sep 2015 08:35:41 +0200
Message-ID: <CAMuHMdX7wBQfR+scXZS5mRRMDqQho9ugz_DQDQ4cpTpj-4Yz2g@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-7-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33451 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829AbbIJGfm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:35:42 -0400
In-Reply-To: <1441858273-4017-7-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.com>=
 wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -224,7 +224,7 @@ config DOVE_THERMAL
>
>  config DB8500_THERMAL
>         bool "DB8500 thermal management"
> -       depends on ARCH_U8500
> +       depends on ARCH_U8500 || COMPILE_TEST

In file included from drivers/thermal/db8500_thermal.c:23:
include/linux/mfd/dbx500-prcmu.h:437: error: redefinition of =E2=80=98p=
rcmu_abb_read=E2=80=99
include/linux/mfd/db8500-prcmu.h:648: error: previous definition of
=E2=80=98prcmu_abb_read=E2=80=99 was here
include/linux/mfd/dbx500-prcmu.h:442: error: redefinition of =E2=80=98p=
rcmu_abb_write=E2=80=99
include/linux/mfd/db8500-prcmu.h:653: error: previous definition of
=E2=80=98prcmu_abb_write=E2=80=99 was here
include/linux/mfd/dbx500-prcmu.h:453: error: redefinition of
=E2=80=98prcmu_config_clkout=E2=80=99
include/linux/mfd/db8500-prcmu.h:618: error: previous definition of
=E2=80=98prcmu_config_clkout=E2=80=99 was here
include/linux/mfd/dbx500-prcmu.h:520: error: redefinition of =E2=80=98p=
rcmu_ac_wake_req=E2=80=99
include/linux/mfd/db8500-prcmu.h:658: error: previous definition of
=E2=80=98prcmu_ac_wake_req=E2=80=99 was here
include/linux/mfd/dbx500-prcmu.h:524: error: redefinition of
=E2=80=98prcmu_ac_sleep_req=E2=80=99
include/linux/mfd/db8500-prcmu.h:662: error: previous definition of
=E2=80=98prcmu_ac_sleep_req=E2=80=99 was here

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
