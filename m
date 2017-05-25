From: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [PATCH v4 0/8] Fix issues and factorize arm/arm64 capacity
 information code
Date: Thu, 25 May 2017 15:18:31 +0200
Message-ID: <20170525131831.GF16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170511084830.rn32pvi6weej2cna@e106622-lin>
 <20170511085952.GA6934@kroah.com>
 <20170511102718.qy54ajkzphasymhr@e106622-lin>
 <20170524144515.nuccflbdashlqmcs@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170524144515.nuccflbdashlqmcs@e106622-lin>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, May 24, 2017 at 03:45:15PM +0100, Juri Lelli wrote:
> Hi,
> 
> On 11/05/17 11:27, Juri Lelli wrote:
> > On 11/05/17 10:59, Greg KH wrote:
> > > On Thu, May 11, 2017 at 09:48:30AM +0100, Juri Lelli wrote:
> > > > Hi Greg,
> > > > 
> > > > I'm not sure what your plans are with this set. Are we targeting 4.12?
> > > > 
> > > > IMHO, if possible, it would be good to have this refactoring in now, so
> > > > that we can base further development on it for the next cycle.
> > > 
> > > It's way too late for new features that have not been in linux-next for
> > > a few weeks, to get merged into 4.12-rc1, sorry.  I'll review this
> > > patchset after -rc1 is out, and I get a chance to catch up on pending
> > > patches.
> > > 
> > 
> > Thanks for your reply, I perfecly understand.
> > 
> > OK, let's target 4.13 then. Looking forward to receive your comments
> > after -rc1 is out.
> > 
> 
> Did you have any chance to have a look at this set?

Now reviewed.  Looks fine except for the final names in the last patch,
naming is hard, I know :)

thanks,

greg k-h
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
