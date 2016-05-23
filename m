From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 23:05:14 +0100
Message-ID: <20160523220514.GB19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
 <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
 <CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
 <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
 <20160523210738.GZ19428@n2100.arm.linux.org.uk>
 <CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55272 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbcEWWFd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 18:05:33 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5DjjgNk+uHyH7Avvfrt_TNPaZ+SUtHzON5fPU=25_gKOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 06:38:31PM -0300, Fabio Estevam wrote:
> On Mon, May 23, 2016 at 6:07 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > Read the code again.  There's three states:
> >
> > 1. CONFIG_SMP=n - it always returns false.
> > 2. CONFIG_SMP=y, CONFIG_SMP_ON_UP=n - it always returns true.  Such a
> >    kernel can _only_ be run on SMP capable systems.
> > 3. CONFIG_SMP=y, CONFIG_SMP_ON_UP=y - it returns depending on whether
> >    we detect that the CPU is SMP capable.
> 
> Yes, I meant that on imx6ul we have option 2 above with imx_v6_v7_defconfig.

I don't think so, unless you specifically turn off CONFIG_SMP_ON_UP.
It defaults to 'y', so imx_v6_v7_defconfig should result in this being
'y'.

> Also tested option 3 and is_smp() returns true as well.

So that means the MPIDR register is telling the kernel...

* The boot CPU has multiprocessor extensions.
* The boot CPU is not part of a uniprocessor system.

> I will try to see why GIC on this SoC cannot work in SMP.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
