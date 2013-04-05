From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 07/18] cpufreq: s3c24xx: move cpufreq driver to
 drivers/cpufreq
Date: Fri, 05 Apr 2013 15:48:29 +0900
Message-ID: <2a5901ce31c9$95160980$bf421c80$%kim@samsung.com>
References: <cover.1365079581.git.viresh.kumar@linaro.org>
 <927100d30bf40d4fec477cc7d8d464669a22d167.1365079581.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:60499 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765390Ab3DEGsg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Apr 2013 02:48:36 -0400
In-reply-to: <927100d30bf40d4fec477cc7d8d464669a22d167.1365079581.git.viresh.kumar@linaro.org>
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, 'Ben Dooks' <ben-linux@fluff.org>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Viresh Kumar wrote:
> 
> This patch moves cpufreq driver of Samsung's ARM based s3c24xx platform to
> drivers/cpufreq.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig                                   | 46 ---------------
>  arch/arm/mach-s3c24xx/Kconfig                      | 66
+++++++++-------------
>  arch/arm/mach-s3c24xx/Makefile                     |  6 --
>  arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h |  0
>  arch/arm/mach-s3c24xx/iotiming-s3c2412.c           |  2 +-
>  arch/arm/plat-samsung/include/plat/cpu-freq-core.h | 10 ++--
>  arch/arm/plat-samsung/include/plat/cpu-freq.h      |  6 +-
>  drivers/cpufreq/Kconfig.arm                        | 58
+++++++++++++++++++
>  drivers/cpufreq/Makefile                           |  5 ++
>  .../cpufreq/s3c2410-cpufreq.c                      |  0
>  .../cpufreq/s3c2412-cpufreq.c                      |  3 +-
>  .../cpufreq/s3c2440-cpufreq.c                      |  0
>  .../cpufreq/s3c24xx-cpufreq-debugfs.c              |  0
>  .../cpufreq.c => drivers/cpufreq/s3c24xx-cpufreq.c |  0
>  14 files changed, 100 insertions(+), 102 deletions(-)
>  rename arch/arm/mach-s3c24xx/{ => include/mach}/s3c2412.h (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2410.c =>
> drivers/cpufreq/s3c2410-cpufreq.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2412.c =>
> drivers/cpufreq/s3c2412-cpufreq.c (99%)
>  rename arch/arm/mach-s3c24xx/cpufreq-s3c2440.c =>
> drivers/cpufreq/s3c2440-cpufreq.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq-debugfs.c =>
> drivers/cpufreq/s3c24xx-cpufreq-debugfs.c (100%)
>  rename arch/arm/mach-s3c24xx/cpufreq.c => drivers/cpufreq/s3c24xx-
> cpufreq.c (100%)
> 
Basically, this moving looks good to me, but should be re-worked based on
for-next of samsung tree because this touches too many samsung stuff so this
should be sent to upstream via samsung tree.

See below,

Applying: cpufreq: s3c24xx: move cpufreq driver to drivers/cpufreq
error: patch failed: arch/arm/Kconfig:2166
error: arch/arm/Kconfig: patch does not apply
error: patch failed: arch/arm/mach-s3c24xx/Kconfig:28
error: arch/arm/mach-s3c24xx/Kconfig: patch does not apply
error: patch failed: arch/arm/mach-s3c24xx/Makefile:17
error: arch/arm/mach-s3c24xx/Makefile: patch does not apply
error: patch failed: drivers/cpufreq/Makefile:63
error: drivers/cpufreq/Makefile: patch does not apply
error: drivers/cpufreq/s3c2412-cpufreq.c: does not exist in index
Patch failed at 0001 cpufreq: s3c24xx: move cpufreq driver to
drivers/cpufreq

Thanks.

- Kukjin

