From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 22:07:38 +0100
Message-ID: <20160523210738.GZ19428@n2100.arm.linux.org.uk>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
 <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
 <CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
 <2148724.oQlEHos3jS@vostro.rjw.lan>
 <20160523182807.GY19428@n2100.arm.linux.org.uk>
 <CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
 <CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
 <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55164 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbcEWVH5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:07:57 -0400
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 05:59:37PM -0300, Fabio Estevam wrote:
> On Mon, May 23, 2016 at 5:23 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > For one, if that platform is not capable of raising interrupts for IRQ
> > works, I'm not sure why arch_irq_work_has_interrupt() returns true on
> > it.
> 
> It returns true because the kernel was built with CONFIG_SMP=y.
> 
> On ARM we have:
> 
> static inline bool arch_irq_work_has_interrupt(void)
> {
>     return is_smp();
> }
> 
> and then:
> 
> static inline bool is_smp(void)
> {
> #ifndef CONFIG_SMP
>     return false;
> #elif defined(CONFIG_SMP_ON_UP)
>     extern unsigned int smp_on_up;
>     return !!smp_on_up;
> #else
>     return true;
> #endif
> }
> 
> So if CONFIG_SMP=y,  is_smp() returns 1.
> 
> As I mentioned before, the reboot problem does not happen with CONFIG_SMP=n.

Read the code again.  There's three states:

1. CONFIG_SMP=n - it always returns false.
2. CONFIG_SMP=y, CONFIG_SMP_ON_UP=n - it always returns true.  Such a
   kernel can _only_ be run on SMP capable systems.
3. CONFIG_SMP=y, CONFIG_SMP_ON_UP=y - it returns depending on whether
   we detect that the CPU is SMP capable.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
