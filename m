From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] cpufreq: imx6: rework getting clocks and regulators
Date: Tue, 20 Oct 2015 14:47:31 +0200
Message-ID: <20151020124731.GS14476@pengutronix.de>
References: <1445342218-12895-1-git-send-email-s.hauer@pengutronix.de>
 <1445344018.3716.16.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54983 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbJTMrd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 08:47:33 -0400
Content-Disposition: inline
In-Reply-To: <1445344018.3716.16.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, kernel@pengutronix.de, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 20, 2015 at 02:26:58PM +0200, Lucas Stach wrote:
> Am Dienstag, den 20.10.2015, 13:56 +0200 schrieb Sascha Hauer:
> > Use devm_* functions for getting clocks and regulators. This simplfifies
> > the error path. Also return the error from the failing call instead of
> > collating all regulator and clock errors to -ENOENT. With this the
> > driver can properly handle -EPROBE_DEFER. Handling deferred probing
> > becomes necessary once the SoC internal regulators get supplies. While
> > the SoC internal regulators are registered early in architecture code,
> > the supplies may be regular I2C devices which may be probed after the
> > cpufreq driver.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> NACK
> 
> This has come up several times before, maybe we should get a comment in
> the code.

Indeed, yes. This would help not wasting developing time.

Anyway, the driver needs to handle -EPROBE_DEFER properly, if not with
devm_ then without it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
