From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Fri, 20 May 2016 23:59:06 +0200
Message-ID: <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com>
	<CAOMZO5D_-3St-jqzMLzFHRn3dXXoSZGn4APSK4F63qCP3X=FfA@mail.gmail.com>
	<4080948.V5DMHR9bsk@vostro.rjw.lan>
	<CAOMZO5Di3s36=B_52g=S+sWjpdNQ2GozDjeT=3n0B5jNM9z8tA@mail.gmail.com>
	<CAJZ5v0h6qU8_BBmugSw8YGiWsmgYfZXtqOmGWkcNOM_O1mfD4g@mail.gmail.com>
	<CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38185 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbcETV7I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 17:59:08 -0400
Received: by mail-wm0-f48.google.com with SMTP id n129so1519186wmn.1
        for <linux-pm@vger.kernel.org>; Fri, 20 May 2016 14:59:07 -0700 (PDT)
In-Reply-To: <CAOMZO5ABUpb4yx19j09hvOL7_QpO+_33Q+LCYQ-44LoqFrAxEg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, May 20, 2016 at 11:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Fri, May 20, 2016 at 6:48 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>> So what about if you comment out the cpufreq_suspend() line in
>> device_shutdown() (after applying the patch)?
>
> Then it reboots fine :-) Thanks

But that probably means that irq_work_sync() doesn't work on your system.

Can you please try to boot and change the cpufreq governor to
performance and back and see if that works?

Is this an SMP board, actually?
