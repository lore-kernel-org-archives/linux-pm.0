From: Bill Huang <bilhuang@nvidia.com>
Subject: Re: [PATCH v2 3/4] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Fri, 13 Sep 2013 19:00:42 -0700
Message-ID: <1379124042.2475.6.camel@bilhuang-vm1>
References: <1378985091-9447-1-git-send-email-bilhuang@nvidia.com>
	 <1378985091-9447-4-git-send-email-bilhuang@nvidia.com>
	 <52339106.4020601@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-9"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <52339106.4020601@wwwdotorg.org>
Sender: cpufreq-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "rjw@sisk.pl" <rjw@sisk.pl>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2013-09-14 at 06:26 +0800, Stephen Warren wrote:
> On 09/12/2013 05:24 AM, Bill Huang wrote:
> > Re-model Tegra cpufreq driver to support all Tegra series of SoCs.
> > 
> > * Make tegra-cpufreq.c a generic Tegra cpufreq driver.
> > * Move Tegra20 specific codes into tegra20-cpufreq.c.
> > * Bind Tegra cpufreq dirver with a fake device so defer probe would work
> >   when we're going to get regulator in the driver to support voltage
> >   scaling (DVFS).
> 
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> 
> > @@ -232,6 +232,12 @@ config ARM_TEGRA_CPUFREQ
> >  	bool "TEGRA CPUFreq support"
> >  	depends on ARCH_TEGRA
> >  	select CPU_FREQ_TABLE
> > +
> > +config ARM_TEGRA20_CPUFREQ
> > +	bool "NVIDIA TEGRA20"
> > +	depends on ARM_TEGRA_CPUFREQ && ARCH_TEGRA_2x_SOC
> >  	default y
> >  	help
> > -	  This adds the CPUFreq driver support for TEGRA SOCs.
> > +	  This adds the CPUFreq driver for NVIDIA TEGRA20 SoC.
> > +
> > +	  If in doubt, say N.
> 
> This patch removes the following from "config ARM_TEGRA_CPUFREQ":
> 
> 	default y
> 	help
> 	  This adds the CPUFreq driver support for TEGRA SOCs.
> 
> I think that option should be left unchanged, such that this patch
> *just* adds the new option without changing the existing one. If you do
> that, then you can completely drop patch 4/4.

Thanks, I'll change and rebase in next version after Viresh's cleanup
patch series is merged.
> 
> Other than that, this series looks fine.


