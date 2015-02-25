From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 2/2] drivers: cpuidle: add driver/device checks in
 cpuidle_enter_freeze()
Date: Wed, 25 Feb 2015 14:56:46 +0000
Message-ID: <20150225145646.GE20214@red-moon>
References: <1424800730-32059-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1424800730-32059-3-git-send-email-lorenzo.pieralisi@arm.com>
 <54EDDC99.40208@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:37795 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516AbbBYO4U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 09:56:20 -0500
Content-Disposition: inline
In-Reply-To: <54EDDC99.40208@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Wed, Feb 25, 2015 at 02:30:49PM +0000, Daniel Lezcano wrote:

[...]

> > diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> > index f47edc6c..344fe6c 100644
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c
> > @@ -44,6 +44,12 @@ void disable_cpuidle(void)
> >   	off = 1;
> >   }
> >
> > +static bool cpuidle_device_disabled(struct cpuidle_driver *drv,
> > +				    struct cpuidle_device *dev)
> > +{
> > +	return (off || !initialized || !drv || !dev || !dev->enabled);
> > +}
> 
> This is getting a bit fuzzy IMO. What means disabled ? :)
> 
> >   /**
> >    * cpuidle_play_dead - cpu off-lining
> >    *
> > @@ -124,6 +130,11 @@ void cpuidle_enter_freeze(void)
> >   	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
> >   	int index;
> 
> I think this is exploding before because of dev == NULL in the line above.

Actually not, cpuidle_get_cpu_driver() checks the dev pointer, so
we might end up with drv == NULL and dev == NULL, and the check I added
still applies and it is effective I think.

Lorenzo
