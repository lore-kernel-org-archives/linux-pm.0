From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 5/8] CPPC: Add a CPUFreq driver for use with CPPC
Date: Tue, 21 Jul 2015 00:07:35 +0200
Message-ID: <3774934.MfIr66XDWO@vostro.rjw.lan>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org> <e8464849d98e4a4f64e9b23501d84b1f843aa994.1436464513.git.ashwin.chaugule@linaro.org> <55AD0411.4000603@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44143 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756806AbbGTVku (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 17:40:50 -0400
In-Reply-To: <55AD0411.4000603@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>

On Monday, July 20, 2015 03:22:09 PM Sudeep Holla wrote:
> 
> On 09/07/15 19:04, Ashwin Chaugule wrote:
> > This driver utilizes the methods introduced in the previous
> > patch - "ACPI: Introduce CPU performance controls using CPPC"
> > and enables usage with existing CPUFreq governors.
> >
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > Reviewed-by: Al Stone <al.stone@linaro.org>
> > ---
> >   drivers/cpufreq/Kconfig.arm    |  16 ++++
> >   drivers/cpufreq/Makefile       |   2 +
> >   drivers/cpufreq/cppc_cpufreq.c | 197 +++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 215 insertions(+)
> >   create mode 100644 drivers/cpufreq/cppc_cpufreq.c
> >
> > diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> > index 4f3dbc8..578384d 100644
> > --- a/drivers/cpufreq/Kconfig.arm
> > +++ b/drivers/cpufreq/Kconfig.arm
> > @@ -272,3 +272,19 @@ config ARM_PXA2xx_CPUFREQ
> >   	  This add the CPUFreq driver support for Intel PXA2xx SOCs.
> >
> >   	  If in doubt, say N.
> > +
> > +config ACPI_CPPC_CPUFREQ
> > +	tristate "CPUFreq driver based on the ACPI CPPC spec"
> > +	depends on ACPI_CPPC_LIB
> > +	default n
> > +	help
> > +	  This adds a CPUFreq driver which uses CPPC methods
> > +	  as described in the ACPIv5.1 spec. CPPC stands for
> > +	  Collaborative Processor Performance Controls. It
> > +	  is based on an abstract continuous scale of CPU
> > +	  performance values which allows the remote power
> > +	  processor to flexibly optimize for power and
> > +	  performance. CPPC relies on power management firmware
> > +	  for its operation.
> 
> Why is this ARM specific ? It might be used only on ARM but doesn't mean
> it should be visible only on ARM ACPI systems.

Why bother people with considering Kconfig options that are useless to them?

Thanks,
Rafael

