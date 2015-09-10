From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/17] thermal: intel_quark: allow compile test
Date: Thu, 10 Sep 2015 08:25:41 +0200
Message-ID: <CAMuHMdVONmpT0m9rTG0Eg5SL=5DcJVW-O7W7_oR5XyD01P8StQ@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-13-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33290 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbbIJGZm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:25:42 -0400
In-Reply-To: <1441858273-4017-13-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -307,7 +307,7 @@ config INTEL_SOC_DTS_THERMAL
>
>  config INTEL_QUARK_DTS_THERMAL
>         tristate "Intel Quark DTS thermal driver"
> -       depends on X86_INTEL_QUARK
> +       depends on X86_INTEL_QUARK || COMPILE_TEST

drivers/thermal/intel_quark_dts_thermal.c:64:31: error:
asm/cpu_device_id.h: No such file or directory
drivers/thermal/intel_quark_dts_thermal.c:65:26: error:
asm/iosf_mbi.h: No such file or directory

x86-only header files

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
