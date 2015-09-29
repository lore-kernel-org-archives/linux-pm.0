From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Voltage setting on chained regulators, how?
Date: Tue, 29 Sep 2015 10:00:44 +0200
Message-ID: <20150929080044.GS7858@pengutronix.de>
References: <20150925090724.GH7858@pengutronix.de>
 <20150925164726.GI30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60259 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785AbbI2IAv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Sep 2015 04:00:51 -0400
Content-Disposition: inline
In-Reply-To: <20150925164726.GI30445@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, Sep 25, 2015 at 09:47:26AM -0700, Mark Brown wrote:
> On Fri, Sep 25, 2015 at 11:07:24AM +0200, Sascha Hauer wrote:
> 
> > Any idea how such a scenario could be implemented? The regulator
> > framework already has some idea of supply regulators, but it only takes
> > care of en/disabling the supplies and will not change the voltage on the
> > supplies. Should this be implemented in the regulator framework?  Some
> > first experiments brought me into a locking hell quite fast.
> 
> It's just a case of implementation, but yes the locking is fun.  I don't
> think it's that big a deal to rethink it, it's partly complicated since
> the existing locking is designed to be really simple and easy to review.

Ok, it seems you're generally ok with putting this into the regulator
core. I'll try and see what I can come up with. Maybe I leave the
locking part for later to see if this otherwise solves my problem or if
there are other pitfalls I don't see yet.

> 
> > For added fun ideally we want to put the LDOs in bypass mode instead of
> > configuring them for minimum dropout. The bypass mode doesn't work for
> > the 1.2GHz operating point though since the ripple on the switching
> > regulator gets too high. So we can't just statically configure bypass
> > mode but have to enable it dynamically based on the operating points.
> 
> I suspect you always want the LDO in there to clean the supply up, it's
> just a more serious issue when more power is being drawn.

I just had a look at the i.MX6 datasheets and saw that while it's
possible to put the LDOs in bypass mode the expected lifetime of the SoC
decreases without the LDOs. So it seems better to let them enabled and
just make the voltage drop as small as possible.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
