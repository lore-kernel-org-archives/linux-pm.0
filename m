From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 10/17] thermal: intel_soc_dts_iosf: allow compile test
Date: Thu, 10 Sep 2015 08:25:01 +0200
Message-ID: <CAMuHMdVcThhXAR95m3bw1GP69_cG9V9Utn0Vz2bjDRpsXENu+A@mail.gmail.com>
References: <1441858273-4017-1-git-send-email-edubezval@gmail.com>
	<1441858273-4017-11-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:34331 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbIJGZD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 02:25:03 -0400
In-Reply-To: <1441858273-4017-11-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Sep 10, 2015 at 6:11 AM, Eduardo Valentin <edubezval@gmail.com> wrote:
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -284,7 +284,7 @@ config X86_PKG_TEMP_THERMAL
>
>  config INTEL_SOC_DTS_IOSF_CORE
>         tristate
> -       depends on X86
> +       depends on X86 || COMPILE_TEST

drivers/thermal/intel_soc_dts_iosf.c:21:26: error: asm/iosf_mbi.h: No
such file or directory

x86-only header file

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
