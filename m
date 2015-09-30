From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 6/7] ARM64: smp: Add runtime PM support for CPU hotplug
Date: Wed, 30 Sep 2015 14:36:07 +0200
Message-ID: <CAMuHMdWVCHRxhMHTzussPFXEu_CAed+nyfOSGF9vmA-z9X9OaQ@mail.gmail.com>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
	<1441310314-8857-7-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35537 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547AbbI3MgI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Sep 2015 08:36:08 -0400
Received: by obbzf10 with SMTP id zf10so30031544obb.2
        for <linux-pm@vger.kernel.org>; Wed, 30 Sep 2015 05:36:08 -0700 (PDT)
In-Reply-To: <1441310314-8857-7-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Hi Lina,

On Thu, Sep 3, 2015 at 9:58 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index dbdaacd..4076962 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -135,6 +135,7 @@ asmlinkage void secondary_start_kernel(void)
>  {
>         struct mm_struct *mm = &init_mm;
>         unsigned int cpu = smp_processor_id();
> +       struct device *cpu_dev;
>
>         /*
>          * All kernel threads share the same mm context; grab a
> @@ -185,6 +186,11 @@ asmlinkage void secondary_start_kernel(void)
>         local_irq_enable();
>         local_async_enable();
>
> +       /* We are running, enable runtime PM for the CPU. */
> +       cpu_dev = get_cpu_device(cpu);
> +       if (cpu_dev)
> +               pm_runtime_get_sync(cpu_dev);

arch/arm64/kernel/smp.c:192:3: error: implicit declaration of function
'pm_runtime_get_sync' [-Werror=implicit-function-declaration]

Adding #include <linux/pm_runtime.h> fixes compilation.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
