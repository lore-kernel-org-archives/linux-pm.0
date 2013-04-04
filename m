From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/18] cpufreq: powerpc/platforms/cell: move cpufreq driver to drivers/cpufreq
Date: Thu, 4 Apr 2013 13:02:09 +0000
Message-ID: <201304041302.09995.arnd@arndb.de>
References: <cover.1365079581.git.viresh.kumar@linaro.org> <0f989533f2e47d4d632710029bf0273082bafee3.1365079581.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0f989533f2e47d4d632710029bf0273082bafee3.1365079581.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Thursday 04 April 2013, Viresh Kumar wrote:
> This patch moves cpufreq driver of powerpc platforms/cell to drivers/cpufreq.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Compile Tested only.
> 
>  arch/powerpc/platforms/cell/Kconfig                | 26 +---------------------
>  arch/powerpc/platforms/cell/Makefile               |  3 ---
>  drivers/cpufreq/Kconfig.powerpc                    | 18 +++++++++++++++
>  drivers/cpufreq/Makefile                           |  3 +++
>  .../cpufreq/ppc_cbe_cpufreq.c                      |  2 +-
>  .../cpufreq/ppc_cbe_cpufreq_pervasive.c            |  3 +--
>  .../cpufreq/ppc_cbe_cpufreq_pmi.c                  |  3 +--
>  .../linux/ppc_cbe_cpufreq.h                        |  4 ++--

Moving the files is good, but I don't see a reason to make the cbe_cpufreq.h
header globally visible in include/linux/. Isn't it just used by as the
interface between ppc_cbe_cpufreq_pmi.c  and ppc_cbe_cpufreq.c?

	Arnd
