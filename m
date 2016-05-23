From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Mon, 23 May 2016 23:03:01 +0200
Message-ID: <CAJZ5v0jO++9d7bpXAg9Zs5GOPPZvg6E+OY3avDmNdor8EDxn4w@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
	<CAOMZO5CD08cX0yDBZTdFV+iwgr__fjSaaWvgjimotr5L1yrbaQ@mail.gmail.com>
	<2148724.oQlEHos3jS@vostro.rjw.lan>
	<20160523182807.GY19428@n2100.arm.linux.org.uk>
	<CAJZ5v0ipPVsZmu+RVfrPChA7banMGFNsfMt=if0V3XfVdstRNQ@mail.gmail.com>
	<CAJZ5v0j0VbyHNT_ZmThsdQfRWzf7SG65A8-bPxoAUxZJgR96og@mail.gmail.com>
	<CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38106 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbcEWVDE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 May 2016 17:03:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id n129so347032wmn.1
        for <linux-pm@vger.kernel.org>; Mon, 23 May 2016 14:03:03 -0700 (PDT)
In-Reply-To: <CAOMZO5Cbue9L2JGA0kv7nTZ=78oKDhNu6WLRUmcsSuLHscDVUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Viresh Kumar <viresh.kumar@linaro.org>, Peter Zijlstra <peterz@infradead.org>

On Mon, May 23, 2016 at 10:59 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, May 23, 2016 at 5:23 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> For one, if that platform is not capable of raising interrupts for IRQ
>> works, I'm not sure why arch_irq_work_has_interrupt() returns true on
>> it.
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

First, why don't the other ARM UP platforms have this problem when SMP
kernels are run on them?

Second, quite evidently, the platform says "I can raise interrupts for
IRQ works", but then it doesn't do that.  That doesn't seem
particularly consistent to me ...
