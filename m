From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 9/9] powerpc: cpufreq: move cpufreq driver to drivers/cpufreq
Date: Sun, 31 Mar 2013 09:33:08 +0530
Message-ID: <CAKohpo=LOJ3DfaGzCm6a6ev2+dNUgEpJd+04pGMhdSpkyZNR9A@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:59314 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab3CaEDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Mar 2013 00:03:08 -0400
Received: by mail-oa0-f49.google.com with SMTP id j6so1270137oag.36
        for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2013 21:03:08 -0700 (PDT)
In-Reply-To: <4180fd5b43906421fc155126e8b7bea5fb3ff375.1364229828.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch moves cpufreq driver of powerpc platform to drivers/cpufreq.
>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/powerpc/platforms/Kconfig                     | 31 ----------------------
>  arch/powerpc/platforms/pasemi/Makefile             |  1 -
>  arch/powerpc/platforms/powermac/Makefile           |  2 --
>  drivers/cpufreq/Kconfig.powerpc                    | 26 ++++++++++++++++++
>  drivers/cpufreq/Makefile                           |  3 +++
>  .../cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c  |  0
>  .../cpufreq/pmac32-cpufreq.c                       |  0
>  .../cpufreq/pmac64-cpufreq.c                       |  0
>  8 files changed, 29 insertions(+), 34 deletions(-)
>  rename arch/powerpc/platforms/pasemi/cpufreq.c => drivers/cpufreq/pasemi-cpufreq.c (100%)
>  rename arch/powerpc/platforms/powermac/cpufreq_32.c => drivers/cpufreq/pmac32-cpufreq.c (100%)
>  rename arch/powerpc/platforms/powermac/cpufreq_64.c => drivers/cpufreq/pmac64-cpufreq.c (100%)

Benjamin/Paul/Olof,

Any comments on this?
