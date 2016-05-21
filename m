From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Sat, 21 May 2016 02:30:27 +0200
Message-ID: <CAJZ5v0hX1dZ+79-KCyumf57o02WKivxcRLJ1Zi8akrqu_2CZEQ@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
	<4080948.V5DMHR9bsk@vostro.rjw.lan>
	<CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
	<CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
	<CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
	<CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
	<CAOMZO5C=v8AzSX7CNkJOkwtRM5dekZ8rpdAfZyggecbdcQK5gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35518 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbcEUAa3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 20:30:29 -0400
Received: by mail-wm0-f49.google.com with SMTP id i142so4347503wmf.0
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 17:30:28 -0700 (PDT)
In-Reply-To: <CAOMZO5C=v8AzSX7CNkJOkwtRM5dekZ8rpdAfZyggecbdcQK5gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

On Sat, May 21, 2016 at 2:12 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, May 20, 2016 at 6:59 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> Can you please try to boot and change the cpufreq governor to
>> performance and back and see if that works?
>
> I cannot change to governor with 9be4fd2c7723a305.
>
> After running 'cat performance >
> /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor'
> the system hangs silently.

So this means that irq_work doesn't really work on your system at all.
It looks like queuing up an irq_work sort of works (because the
IRQ_WORK_BUSY), but then the queue is never processed.

> Reverting 9be4fd2c7723a305 allows me to change to performace.

What exactly do you mean by reverting here?  It surely cannot be
reverted by itself and there are many things that depend on it.

>> Is this an SMP board, actually?
>
> Yes, this is a single core CortexA7.

Hmm.  Single core means non-SMP rather?
