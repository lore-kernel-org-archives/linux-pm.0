From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/1] cpupower: Add cpuidle library
Date: Thu, 28 Apr 2016 15:23:05 +0200
Message-ID: <9049803.y9XhT0fdX4@skinner>
References: <1685056.NeGEfvDZMv@skinner> <2574684.bDi1t35TAq@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33090 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbcD1NXH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 Apr 2016 09:23:07 -0400
In-Reply-To: <2574684.bDi1t35TAq@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org

On Tuesday, April 26, 2016 10:20:00 PM Rafael J. Wysocki wrote:
> On Monday, April 25, 2016 04:30:09 PM Thomas Renninger wrote:
> > Hi,
> > 
> > this is a cleanup I wanted to do for a long time.

> > I already added the change to our build service and things
> > still build against the same archs like arm, ppc, x86:
> > https://build.opensuse.org/package/show/hardware/cpupower
> > 
> > It would be nice to get the one or other review.
> > 
> > Rafael: If you could queue this up for mainline inclusion at some
> > point of time, I would very much appreciate it!
> 
> I can do it right now, but there are a few cpupower patches in Patchwork
> that I'm not sure what to do with.

Where do I find the patchwork stuff?

> Do you want me to drop those on the floor?

No, please not.

I went through the list and found some patches.
Not critical, but valid fixes.
The one from Mattia already was in, in another form.

I will send them right now.

This should now more or less match with what patchwork
gives you?

Thanks,

     Thomas
