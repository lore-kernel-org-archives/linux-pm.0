From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/4] BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
Date: Tue, 7 Feb 2017 13:42:25 +0100
Message-ID: <CAJZ5v0j2qcQyZctjq4xEpM2QTjpw_DnH8+Knt2o0PpsqgZUL7g@mail.gmail.com>
References: <20170206215119.87099-1-code@mmayer.net> <20170206215119.87099-3-code@mmayer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34987 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdBGMm1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 07:42:27 -0500
In-Reply-To: <20170206215119.87099-3-code@mmayer.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Markus Mayer <code@mmayer.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Feb 6, 2017 at 10:51 PM, Markus Mayer <code@mmayer.net> wrote:
> From: Markus Mayer <mmayer@broadcom.com>
>
> Turn on CPU_SUPPORTS_CPUFREQ and MIPS_EXTERNAL_TIMER for BMIPS.
>
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

An ACK from the MIPS maintainers is requisite here.

> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b3c5bde..e137eed 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1703,6 +1703,8 @@ config CPU_BMIPS
>         select WEAK_ORDERING
>         select CPU_SUPPORTS_HIGHMEM
>         select CPU_HAS_PREFETCH
> +       select CPU_SUPPORTS_CPUFREQ
> +       select MIPS_EXTERNAL_TIMER
>         help
>           Support for BMIPS32/3300/4350/4380 and BMIPS5000 processors.
>
> --

Thanks,
Rafael
