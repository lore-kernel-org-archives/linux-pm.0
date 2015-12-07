From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 0/8] CPUs capacity information for heterogeneous
 systems
Date: Mon, 7 Dec 2015 15:41:12 +0000
Message-ID: <20151207154112.GK14571@e106622-lin>
References: <1448288921-30307-1-git-send-email-juri.lelli@arm.com>
 <20151207120244.GE14571@e106622-lin>
 <20151207121135.GN8644@n2100.arm.linux.org.uk>
 <20151207123654.GG14571@e106622-lin>
 <20151207131843.GP8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151207131843.GP8644-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 07/12/15 13:18, Russell King - ARM Linux wrote:
> On Mon, Dec 07, 2015 at 12:36:54PM +0000, Juri Lelli wrote:
> > On 07/12/15 12:11, Russell King - ARM Linux wrote:
> > > It looks like the second patch doesn't yet have the backing from the DT
> > > people, which prevents the remainder of the patch set progressing.  That's
> > > the sticking point which needs to be resolved.
> > > 
> > 
> > Agreed. That is exactly the point for which I was seeking more feedback.
> > OTOH, 7/8 and 8/8 may potentially work without the DT bindings, as they
> > simply expose a sysfs attribute. If you, and others, see value in them,
> > I can easily put them at the top of the series and post a v2. Thoughts?
> 
> I've no idea, sorry.  When it comes to stuff like CPU level power
> management, the hardware I have is very limited in its capabilities
> (no support even for S2RAM.)  I've also never managed to get
> big.LITTLE working on my platforms that should support it.
> 

No problem. Thanks a lot for your feedback anyway.

> Eg, I gave up with the TC2 tile in Versatile Express.  I forget the
> details, but getting it booting was exceedingly difficult, and no one
> really seemed interested in helping.  So my TC2 tile is collecting
> dust while the CA9x4 tile lives in the platform - which is now part of
> the nightly build/boot test farm.
> 

I guess I could provide some support for the TC2 bits, if you didn't yet
give up completely on it :-). Please, don't hesitate to let me know,
even privately, about that.

Best,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
