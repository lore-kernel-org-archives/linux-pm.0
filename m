From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Crash after 'reboot' due to 9be4fd2c7723a
Date: Sat, 21 May 2016 00:31:24 +0200
Message-ID: <2720594.bAVGPyzWeg@vostro.rjw.lan>
References: <CAOMZO5A62LgnyT0sQw5N-xeHaD0nSGTjAFxUx=_6OpUm02robA@mail.gmail.com> <CAJZ5v0icSd72P1MpMhOsZtC7mgLLGy_5-FM4t0d13zLe2cG8-Q@mail.gmail.com> <1979704.U8oId5AOcb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51447 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751172AbcETW1t (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 May 2016 18:27:49 -0400
In-Reply-To: <1979704.U8oId5AOcb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ping Bai <ping.bai@nxp.com>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>

On Saturday, May 21, 2016 12:27:54 AM Rafael J. Wysocki wrote:
> On Friday, May 20, 2016 11:59:06 PM Rafael J. Wysocki wrote:
> > On Fri, May 20, 2016 at 11:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> > > On Fri, May 20, 2016 at 6:48 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > >> So what about if you comment out the cpufreq_suspend() line in
> > >> device_shutdown() (after applying the patch)?
> > >
> > > Then it reboots fine :-) Thanks
> > 
> > But that probably means that irq_work_sync() doesn't work on your system.
> > 
> > Can you please try to boot and change the cpufreq governor to
> > performance and back and see if that works?
> > 
> > Is this an SMP board, actually?
> 
> No, it isn't (checked the report again).
> 
> Silly question maybe: Is CONFIG_IRQ_WORK set in your .config?

Well, the kernel wouldn't have built for you without it, so it must be set.

