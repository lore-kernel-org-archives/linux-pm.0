From: Peter De Schrijver <pdeschrijver@nvidia.com>
Subject: Re: [PATCH V3 0/4] cpuidle : multiple drivers support
Date: Wed, 7 Nov 2012 15:32:36 +0200
Message-ID: <20121107133236.GA1962@tbergstrom-lnx.Nvidia.com>
References: <1351701888-19963-1-git-send-email-daniel.lezcano@linaro.org>
 <20121102131950.GA4432@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:1609 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab2KGNcv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Nov 2012 08:32:51 -0500
Content-Disposition: inline
In-Reply-To: <20121102131950.GA4432@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linaro-dev@lists.linaro.org" <linaro-dev@lists.linaro.org>

On Fri, Nov 02, 2012 at 02:19:50PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Oct 31, 2012 at 04:44:44PM +0000, Daniel Lezcano wrote:
> > The discussion about having different cpus on the system with
> > different latencies bring us to a first attemp by adding a
> > pointer in the cpuidle_device to the states array.
> > 
> > But as Rafael suggested, it would make more sense to create a
> > driver per cpu [1].
> > 
> > This patch adds support for multiple cpuidle drivers.
> > 
> > It creates a per cpu cpuidle driver pointer.
> > 
> > In order to not break the different drivers, the function cpuidle_register_driver
> > assign for each cpu, the driver.
> > 
> > The multiple driver support is optional and if it is not set, the cpuide driver
> > core code remains the same (except some code reorganisation).
> > 
> > I did the following tests compiled, booted, tested without/with CONFIG_CPU_IDLE,
> > with/without CONFIG_CPU_IDLE_MULTIPLE_DRIVERS.
> > 
> > Tested on Core2 Duo T9500 with acpi_idle [and intel_idle]
> > Tested on ARM Dual Cortex-A9 U8500 (aka Snowball)
> > 
> > V1 tested on Tegra3 and Vexpress TC2
> 
> V3 tested on TC2, hence, on the whole series
> 
> Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 

V3 tested on Tegra3, so:

Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>

