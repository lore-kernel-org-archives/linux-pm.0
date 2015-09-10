From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 11/17] thermal: intel_soc_dts: allow compile test
Date: Thu, 10 Sep 2015 08:25:22 +0200
Message-ID: <CAMuHMdWo=dYhyN9Az9rosomap1eUmNGv7EFYxURLwKJmAWp8Yw@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-12-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:34862 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbIJGZX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:25:23 -0400
In-Reply-To: <1441858273-4017-12-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -294,7 +294,7 @@ config INTEL_SOC_DTS_IOSF_CORE
>
>  config INTEL_SOC_DTS_THERMAL
>         tristate "Intel SoCs DTS thermal driver"
> -       depends on X86
> +       depends on X86 || COMPILE_TEST

drivers/thermal/intel_soc_dts_thermal.c:20:31: error:
asm/cpu_device_id.h: No such file or directory

x86-only header file

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
