From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6: rework getting clocks and regulators
Date: Tue, 20 Oct 2015 15:17:23 +0200
Message-ID: <20151020131723.GT14476@pengutronix.de>
References: <1445342218-12895-1-git-send-email-s.hauer@pengutronix.de>
 <1445344018.3716.16.camel@pengutronix.de>
 <20151020124731.GS14476@pengutronix.de>
 <CAFSsGVtHaDkXDmnV4-X5z-2y48GM_erSWAYK-6bxR3wv4wHybg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:57143 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbJTNR1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 09:17:27 -0400
Content-Disposition: inline
In-Reply-To: <CAFSsGVtHaDkXDmnV4-X5z-2y48GM_erSWAYK-6bxR3wv4wHybg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 20, 2015 at 02:56:51PM +0200, Heiner Kallweit wrote:
> On Tue, Oct 20, 2015 at 2:47 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > On Tue, Oct 20, 2015 at 02:26:58PM +0200, Lucas Stach wrote:
> >> Am Dienstag, den 20.10.2015, 13:56 +0200 schrieb Sascha Hauer:
> >> > Use devm_* functions for getting clocks and regulators. This simplfifies
> >> > the error path. Also return the error from the failing call instead of
> >> > collating all regulator and clock errors to -ENOENT. With this the
> >> > driver can properly handle -EPROBE_DEFER. Handling deferred probing
> >> > becomes necessary once the SoC internal regulators get supplies. While
> >> > the SoC internal regulators are registered early in architecture code,
> >> > the supplies may be regular I2C devices which may be probed after the
> >> > cpufreq driver.
> >> >
> >> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >>
> >> NACK
> >>
> >> This has come up several times before, maybe we should get a comment in
> >> the code.
> >
> > Indeed, yes. This would help not wasting developing time.
> >
> > Anyway, the driver needs to handle -EPROBE_DEFER properly, if not with
> > devm_ then without it.
> >
> About two days ago I sent two patches fixing this. Meanwhile Viresh
> accepted them
> so they should show up in the next kernel very soon.

Thanks for the hint, just found the patches in the archives.
Unfortunately your patches do not work properly, but I'll reply to your
patch.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
