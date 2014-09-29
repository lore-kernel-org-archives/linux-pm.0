From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 6/6] ARM: imx53: add cpufreq support
Date: Mon, 29 Sep 2014 20:00:37 +0800
Message-ID: <20140929120035.GB14087@tiger>
References: <1411738864-26549-1-git-send-email-l.stach@pengutronix.de>
 <1411738864-26549-6-git-send-email-l.stach@pengutronix.de>
 <20140928041513.GI12999@dragon>
 <1411979628.2625.5.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1on0148.outbound.protection.outlook.com ([157.56.110.148]:3904
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753200AbaI2MBJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Sep 2014 08:01:09 -0400
Content-Disposition: inline
In-Reply-To: <1411979628.2625.5.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Mon, Sep 29, 2014 at 10:33:48AM +0200, Lucas Stach wrote:
> Am Sonntag, den 28.09.2014, 12:15 +0800 schrieb Shawn Guo:
> > On Fri, Sep 26, 2014 at 03:41:04PM +0200, Lucas Stach wrote:
> > > Instanciate device for the generic cpufreq-dt driver.
> > > 
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > 
> > I assume that I should only apply this patch after the cpufreq-dt change
> > gets merged and shows up on my base.
> > 
> > Shawn
> > 
> I would think its safe to merge this patch. The cpufreq-dt change will
> be merged with 3.18. Until then the worst that could happen is that the
> cpufreq driver doesn't bind to the mx5 cpu device.

Ah, right.  The device will not bind on my tree, so it's safe to apply
it right away.

Applied, thanks.
