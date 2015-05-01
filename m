From: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Subject: Re: [PATCH 4/4] cpufreq: arm_big_little: add SCPI interface driver
Date: Fri, 01 May 2015 15:12:46 +0100
Message-ID: <1430489566.3045.64.camel@linaro.org>
References: <1430134846-24320-1-git-send-email-sudeep.holla@arm.com>
		 <1430134846-24320-5-git-send-email-sudeep.holla@arm.com>
	 <1430486378.3045.56.camel@linaro.org> <55438062.8050309@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smarthost01d.mail.zen.net.uk ([212.23.1.7]:53901 "EHLO
	smarthost01d.mail.zen.net.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753730AbbEAOMt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 10:12:49 -0400
In-Reply-To: <55438062.8050309@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, 2015-05-01 at 14:32 +0100, Sudeep Holla wrote:
> 
> On 01/05/15 14:19, Jon Medhurst (Tixy) wrote:
> > On Mon, 2015-04-27 at 12:40 +0100, Sudeep Holla wrote:
> >> On some ARM based systems, a separate Cortex-M based System Control
> >> Processor(SCP) provides the overall power, clock, reset and system
> >> control including CPU DVFS. SCPI Message Protocol is used to
> >> communicate with the SCPI.
> >>
> >> This patch adds a interface driver for adding OPPs and registering
> >> the arm_big_little cpufreq driver for such systems.
> >>
> >> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >> Cc: linux-pm@vger.kernel.org
> >> ---
> >>   drivers/cpufreq/Kconfig.arm    |   9 ++++
> >>   drivers/cpufreq/Makefile       |   1 +
> >>   drivers/cpufreq/scpi-cpufreq.c | 103 +++++++++++++++++++++++++++++++++++++++++
> >>   3 files changed, 113 insertions(+)
> >>   create mode 100644 drivers/cpufreq/scpi-cpufreq.c
> >>
> >> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> >> index 4f3dbc8cf729..9e678bf1687c 100644
> >> --- a/drivers/cpufreq/Kconfig.arm
> >> +++ b/drivers/cpufreq/Kconfig.arm
> >> @@ -24,6 +24,15 @@ config ARM_VEXPRESS_SPC_CPUFREQ
> >>             This add the CPUfreq driver support for Versatile Express
> >>   	  big.LITTLE platforms using SPC for power management.
> >>
> >> +config ARM_SCPI_CPUFREQ
> >> +        tristate "SCPI based CPUfreq driver"
> >> +	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
> >
> > And ARM_BIG_LITTLE_CPUFREQ depends on CONFIG_ARM, so we can't build this
> > for arm64, which is the only platform (Juno) we have to run these
> > patches on.
> 
> Yes I know
> 
> > Unless you're prepared for a horrid hack...
> > https://github.com/ARM-software/linux/commit/b9ceaa0cbd7c57d57ee7e69146cc627697570f6e
> 
> I need to check if it can be improved before I post on the list and
> hence dropped it in the first version of this patch-set.
> 
> > or a pair of less horrid ones...
> > http://git.linaro.org/kernel/linux-linaro-tracking.git/commit/4b5dd8ff98613b7e90c8f3214522a00ab6900fe9
> 
> No not this one, this was already discussed long back I believe.
> It doesn't make sense to add bl-switcher for ARM64 IMO.
> 
> > http://git.linaro.org/kernel/linux-linaro-tracking.git/commit/8641dbfe253f6a9061742ca11f769fc1d82c2aaa
> >
> 
> Yes the Kconfig changes looks better than what I have now.
> 
> > Any reason why the above two aren't suitable for mainline Linux? The
> > second was actually committed then reverted because it broke arm64
> > builds, but the other patch fixes that.
> >
> Yes IMO since arm-big-little also supports multi-cluster cpufreq(yes I
> know it can be merged into cpufreq-dt once we have OPPv2 bindings, but
> until then), it should handle the config where CONFIG_BL_SWITCHER=n and
> that's what I have attempted in my patch above.

OK, that all makes sense, just wanted to make sure things didn't get
overlooked, because having code that has no users in mainline seemed a
bit odd.

-- 
Tixy


