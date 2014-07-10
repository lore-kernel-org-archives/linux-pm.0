From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: kirkwood: Reinstate cpufreq driver for ARCH_KIRKWOOD
Date: Thu, 10 Jul 2014 15:50:36 +0530
Message-ID: <CAKohpo=kj9qsz2qRDdF5M4T3zSyZTa_HHOJH27Q4Y3mnhKw4gA@mail.gmail.com>
References: <1404987355.23201.65.camel@samson1.armitage.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:33895 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbaGJKUg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jul 2014 06:20:36 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so9637410oag.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jul 2014 03:20:36 -0700 (PDT)
In-Reply-To: <1404987355.23201.65.camel@samson1.armitage.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Quentin Armitage <quentin@armitage.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>

On 10 July 2014 15:45, Quentin Armitage <quentin@armitage.org.uk> wrote:
> Commit ff1f0018cf66080d8e6f59791e552615648a033a ("drivers: Enable
> building of Kirkwood drivers for mach-mvebu") added Kirkwood into
> mach-mvebu, adding MACH_KIRKWOOD to ARCH_KIRKWOOD in the KConfig files.
>
> The change for ARM_KIRKWOOD_CPUFREQ replaced ARCH_KIRKWOOD with
> MACH_KIRKWOOD, whereas all the other changes were ARCH_KIRKWOOD ||
> MACH_KIRKWOOD.
>
> As a consequence of this change, the cpufreq driver is no longer enabled
> for ARCH_KIRKWOOD. This patch reinstates ARM_KIRKWOOD_CPUFREQ for
> ARCH_KIRKWOOD.
>
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> ---
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index ebac671..24778f0 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -118,7 +118,7 @@ config ARM_INTEGRATOR
>           If in doubt, say Y.
>
>  config ARM_KIRKWOOD_CPUFREQ
> -       def_bool MACH_KIRKWOOD
> +       def_bool ARCH_KIRKWOOD || MACH_KIRKWOOD
>         help
>           This adds the CPUFreq driver for Marvell Kirkwood
>           SoCs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
