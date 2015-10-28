From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: cpufreq: i.MX6: -EPROBE_DEFER fixes
Date: Wed, 28 Oct 2015 08:59:56 +0100
Message-ID: <20151028075956.GU25308@pengutronix.de>
References: <1445503652-777-1-git-send-email-s.hauer@pengutronix.de>
 <1625342.QihRV1d1Kl@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49823 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964855AbbJ1H77 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 03:59:59 -0400
Content-Disposition: inline
In-Reply-To: <1625342.QihRV1d1Kl@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, kernel@pengutronix.de, Heiner Kallweit <hkallweit1@gmail.com>

On Wed, Oct 28, 2015 at 04:27:00AM +0100, Rafael J. Wysocki wrote:
> On Thursday, October 22, 2015 10:47:28 AM Sascha Hauer wrote:
> > The i.MX6 cpufreq driver can't cope with -EPROBE_DEFER returned from
> > regulator_get/clk_get. This series fix that and some other small issues.
> > 
> > This series supersedes
> > [PATCH 1/2] cpufreq: imx: fix regulator_get error handling
> > [PATCH 2/2] cpufreq: imx: fix regulator_get_optional error handling
> > from Heiner Kallweit.
> 
> I'm expecting a new version of this addressing the review comments to be
> submitted.

Sure, the new series is out.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
