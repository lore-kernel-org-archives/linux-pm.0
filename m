From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH 3/3] cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver
Date: Fri, 26 Jul 2013 16:56:45 +0100
Message-ID: <20130726155645.GD28084@e102568-lin.cambridge.arm.com>
References: <1374750866-750-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1374750866-750-4-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59866 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758011Ab3GZP4t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jul 2013 11:56:49 -0400
In-Reply-To: <alpine.LFD.2.03.1307261058510.15022@syhkavp.arg>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jon Medhurst <tixy@linaro.org>

On Fri, Jul 26, 2013 at 04:00:48PM +0100, Nicolas Pitre wrote:
> On Thu, 25 Jul 2013, Lorenzo Pieralisi wrote:
> 
> > +static int notrace bl_powerdown_finisher(unsigned long arg)
> > +{
> > +	/* MCPM works with HW CPU identifiers */
> > +	unsigned int mpidr = read_cpuid_mpidr();
> > +	unsigned int cluster = (mpidr >> 8) & 0xf;
> > +	unsigned int cpu = mpidr & 0xf;
> 
> You probably want to use the MPIDR_AFFINITY_LEVEL() macro here.

Bah, I am so used to this pattern I don't notice anymore. Changed.

Thanks !
Lorenzo

