From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 5/9] mips: cpufreq: move cpufreq driver to drivers/cpufreq
Date: Sun, 31 Mar 2013 09:31:07 +0530
Message-ID: <CAKohpom4sckvmB12=KRX4aMJDJjpT=nN++_xyL=p_0ZY7v6oMQ@mail.gmail.com>
References: <cover.1364229828.git.viresh.kumar@linaro.org>
	<199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:47033 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab3CaEBH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Mar 2013 00:01:07 -0400
Received: by mail-ob0-f169.google.com with SMTP id oi10so1182894obb.28
        for <linux-pm@vger.kernel.org>; Sat, 30 Mar 2013 21:01:07 -0700 (PDT)
In-Reply-To: <199e0d0a282290544ff562b904a0028a104aad45.1364229828.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arnd.bergmann@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On 25 March 2013 22:24, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch moves cpufreq driver of MIPS architecture to drivers/cpufreq.
>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/mips/Kconfig                                  |  9 ++++-
>  arch/mips/kernel/Makefile                          |  2 --
>  arch/mips/kernel/cpufreq/Kconfig                   | 41 ----------------------
>  arch/mips/kernel/cpufreq/Makefile                  |  5 ---
>  drivers/cpufreq/Kconfig                            | 18 ++++++++++
>  drivers/cpufreq/Makefile                           |  1 +
>  .../kernel => drivers}/cpufreq/loongson2_cpufreq.c |  0
>  7 files changed, 27 insertions(+), 49 deletions(-)
>  delete mode 100644 arch/mips/kernel/cpufreq/Kconfig
>  delete mode 100644 arch/mips/kernel/cpufreq/Makefile
>  rename {arch/mips/kernel => drivers}/cpufreq/loongson2_cpufreq.c (100%)

Ralf or any other mips guy,

Can i have your ack or comments for this patch?
