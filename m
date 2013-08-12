From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Mon, 12 Aug 2013 14:59:31 +0100
Message-ID: <20130812135930.GA21780@e102568-lin.cambridge.arm.com>
References: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1375875813-13358-4-git-send-email-lorenzo.pieralisi@arm.com>
 <5203C098.9000701@linaro.org>
 <20130808161826.GB3742@e102568-lin.cambridge.arm.com>
 <5204F28E.1050204@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45434 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab3HLN7j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 09:59:39 -0400
In-Reply-To: <5204F28E.1050204@linaro.org>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

On Fri, Aug 09, 2013 at 02:45:50PM +0100, Daniel Lezcano wrote:
> On 08/08/2013 06:18 PM, Lorenzo Pieralisi wrote:
> > On Thu, Aug 08, 2013 at 05:00:24PM +0100, Daniel Lezcano wrote:
> >> On 08/07/2013 01:43 PM, Lorenzo Pieralisi wrote:
> >>> The big.LITTLE architecture is composed of two clusters of cpus. One cluster
> >>> contains less powerful but more energy efficient processors and the other
> >>> cluster groups the powerful but energy-intensive cpus.
> >>>
> >>> The TC2 testchip implements two clusters of CPUs (A7 and A15 clusters in
> >>> a big.LITTLE configuration) connected through a CCI interconnect that manages
> >>> coherency of their respective L2 caches and intercluster distributed
> >>> virtual memory messages (DVM).
> >>>
> >>> TC2 testchip integrates a power controller that manages cores resets, wake-up
> >>> IRQs and cluster low-power states. Power states are managed at cluster
> >>> level, which means that voltage is removed from a cluster iff all cores
> >>> in a cluster are in a wfi state. Single cores can enter a reset state
> >>> which is identical to wfi in terms of power consumption but simplifies the
> >>> way cluster states are entered.
> >>>
> >>> This patch provides a multiple driver CPU idle implementation for TC2
> >>> which paves the way for a generic big.LITTLE idle driver for all
> >>> upcoming big.LITTLE based systems on chip.
> >>>
> >>> The driver relies on the MCPM infrastructure to coordinate and manage
> >>> core power states; in particular MCPM allows to suspend specific cores
> >>> and hides the CPUs coordination required to shut-down clusters of CPUs.
> >>>
> >>> Power down sequences for the respective clusters are implemented in the
> >>> MCPM TC2 backend, with all code needed to clean caches and exit coherency.
> >>>
> >>> The multiple driver CPU idle infrastructure allows to define different
> >>> C-states for big and little cores, determined at boot by checking the
> >>> part id of the possible CPUs and initializing the respective logical
> >>> masks in the big and little drivers.
> >>>
> >>> Current big.little systems are composed of A7 and A15 clusters, as
> >>> implemented in TC2, but in the future that may change and the driver
> >>> will have evolve to retrieve what is a 'big' cpu and what is a 'little'
> >>> cpu in order to build the correct topology.
> >>>
> >>> Cc: Kevin Hilman <khilman@linaro.org>
> >>> Cc: Amit Kucheria <amit.kucheria@linaro.org>
> >>> Cc: Olof Johansson <olof@lixom.net>
> >>> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> >>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> >>> ---
> >>
> >> A nit below :/
> >>
> >> [ ... ]
> >>
> >>> +
> >>> +static struct cpuidle_driver bl_idle_big_driver = {
> >>> +	.name = "big_idle",
> >>> +	.owner = THIS_MODULE,
> >>> +	.states[0] = ARM_CPUIDLE_WFI_STATE,
> >>> +	.states[1] = {
> >>> +		.enter			= bl_enter_powerdown,
> >>> +
> >>> +		.exit_latency		= 500,
> >>
> >> Extra line between enter and exit_latency.
> > 
> > Gah, not anymore :)
> > 
> > Other than that, is it ready to go ? If nobody complains I have planned
> > to send a pull request early next week, as soon as a stable branch for
> > TC2 MCPM gets in arm-soc.
> 
> 
> It sounds good to me.

Ok. Olof, Kevin, I prepared a pull request based on top of:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/190067.html

we probably need to fix a simple niggle in that code,

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191303.html

do you want me to wait for it before asking to pull, or I can send a PR
straight away and we will deal with conflicts (if any) later ?

Thanks,
Lorenzo

