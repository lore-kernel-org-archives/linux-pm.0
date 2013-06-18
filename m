From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [GIT PULL] CPUFreq Kconfig Fixes: Select CPU_FREQ_TABLE
Date: Tue, 18 Jun 2013 19:06:28 +0530
Message-ID: <CAKohpok5QvdJ58ytTLMPdwniczzFzJ1C6Uu46MaBMfD96TFESw@mail.gmail.com>
References: <CAKohponB-sR_CBbaootrAZMORs6Q-63N7_PuUneZL9G1GU3cYA@mail.gmail.com>
	<CAKohpom6wyHRZMrcOD1tweWLPdcY4ro3iySNMrwd0JNiVzf0_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:50007 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756001Ab3FRNgf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Jun 2013 09:36:35 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so4567033obq.21
        for <linux-pm@vger.kernel.org>; Tue, 18 Jun 2013 06:36:34 -0700 (PDT)
In-Reply-To: <CAKohpom6wyHRZMrcOD1tweWLPdcY4ro3iySNMrwd0JNiVzf0_Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

** I am sending it again as I sent it from my phone earlier, that
happened in html and was rejected by few lists :( **

Hi Rafael,

The following changes since commit 7d132055814ef17a6c7b69f342244c410a5e000f:

Linux 3.10-rc6 (2013-06-15 11:51:07 -1000)

are available in the git repository at:

git://git.linaro.org/people/vireshk/linux.git cpufreq-kconfig-fixes

for you to fetch changes up to dbcc9f845efc604564f34a5fa62f939c2bebfff6:

cpufreq: X86_AMD_FREQ_SENSITIVITY: select CPU_FREQ_TABLE (2013-06-18
13:53:11 +0530)

----------------------------------------------------------------
Viresh Kumar (11):
cpufreq: blackfin: enable driver for CONFIG_BFIN_CPU_FREQ
cpufreq: cris: select CPU_FREQ_TABLE
cpufreq: davinci: select CPU_FREQ_TABLE
cpufreq: exynos: select CPU_FREQ_TABLE
cpufreq: highbank: remove select CPU_FREQ_TABLE
cpufreq: imx: select CPU_FREQ_TABLE
cpufreq: powerpc: CBE_RAS: select CPU_FREQ_TABLE
cpufreq: pxa: select CPU_FREQ_TABLE
cpufreq: S3C2416/S3C64XX: select CPU_FREQ_TABLE
cpufreq: tegra: create CONFIG_ARM_TEGRA_CPUFREQ
cpufreq: X86_AMD_FREQ_SENSITIVITY: select CPU_FREQ_TABLE

arch/arm/mach-davinci/Kconfig | 1 +
arch/arm/mach-pxa/Kconfig | 3 +++
arch/arm/mach-tegra/Kconfig | 3 ---
arch/cris/Kconfig | 2 ++
drivers/cpufreq/Kconfig.arm | 14 +++++++++++++-
drivers/cpufreq/Kconfig.powerpc | 1 +
drivers/cpufreq/Kconfig.x86 | 1 +
drivers/cpufreq/Makefile | 4 ++--
8 files changed, 23 insertions(+), 6 deletions(-)
