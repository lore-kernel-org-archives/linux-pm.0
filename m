From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 19:28:07 +0100
Message-ID: <20160523182807.GY19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:54857 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753158AbcEWS2a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 14:28:30 -0400
Content-Disposition: inline
In-Reply-To: <2148724.oQlEHos3jS@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Fabio Estevam <festevam@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Sat, May 21, 2016 at 02:56:20AM +0200, Rafael J. Wysocki wrote:
> The root of the problem seems to be arch_irq_work_raise() and specifically
> the __smp_cross_call function that appears to have problems.

We've been through this before.  The bottom line is that on ARM, there
is major wide-spread understanding that we want to be able to run a
kernel compiled for SMP on uniprocessor hardware.

This is something that's been going for years, and has worked fine for
years.

Now, someone has introduced this irq work stuff.  Great.  But they
haven't considered that people want to be able to run a SMP kernel
on UP hardware which _may_ have no hardware present which is capable
of raising IPIs.

I don't know what the situation is with the platform concerned here,
I don't know whether it uses the GIC (presumably, because it doesn't
NULL-pointer ref on calling smp_cross_call(), it is using the GIC.)
If so, the GIC isn't delivering the IPI because the IPI hardware is
missing.

Now, whether we could detect whether the GIC is IPI capable, I've
no idea, I don't have such a platform I could run tests on.  People
don't give me hardware anymore now that arm-soc is split off from
core ARM maintanence - it all goes into Linaro build farms.  So I'm
powerless to help here.

My attitude towards this is that it's a core kernel problem: the
core kernel is assuming that it can raise IPIs even on non-SMP
capable hardware.  Much non-SMP hardware doesn't have that ability.
While folk can try to push it into arch code, my feeling is that it
really needs to have a generic solution, even if it's some generic
solution that architectures in this situation can plug into.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
