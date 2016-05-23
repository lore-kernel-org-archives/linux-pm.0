From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 22:11:14 +0100
Message-ID: <20160523211114.GA19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
 <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
 <CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
 <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
 <CAJZ5v0jO++9d7bpXAg9Zs5GOPPZvg6E+OY3avDmNdor8EDxn4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55182 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbcEWVL1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:11:27 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jO++9d7bpXAg9Zs5GOPPZvg6E+OY3avDmNdor8EDxn4w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 11:03:01PM +0200, Rafael J. Wysocki wrote:
> On Mon, May 23, 2016 at 10:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > On ARM we have:
> >
> > static inline bool arch_irq_work_has_interrupt(void)
> > {
> >     return is_smp();
> > }
> >
> > and then:
> >
> > static inline bool is_smp(void)
> > {
> > #ifndef CONFIG_SMP
> >     return false;
> > #elif defined(CONFIG_SMP_ON_UP)
> >     extern unsigned int smp_on_up;
> >     return !!smp_on_up;
> > #else
> >     return true;
> > #endif
> > }
> >
> > So if CONFIG_SMP=y,  is_smp() returns 1.
> >
> > As I mentioned before, the reboot problem does not happen with CONFIG_SMP=n.
> 
> First, why don't the other ARM UP platforms have this problem when SMP
> kernels are run on them?
> 
> Second, quite evidently, the platform says "I can raise interrupts for
> IRQ works", but then it doesn't do that.  That doesn't seem
> particularly consistent to me ...

Maybe someone has implemented a SoC which has a CPU capable of SMP
but the GIC isn't...  I'm just guessing again.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
