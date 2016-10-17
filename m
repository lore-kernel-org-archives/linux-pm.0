From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 REPOST 0/9] CPUs capacity information for
 heterogeneous systems
Date: Mon, 17 Oct 2016 17:46:58 +0100
Message-ID: <20161017164658.GE25339@e106622-lin>
References: <20161017154650.18779-1-juri.lelli@arm.com>
 <66c7bbfd-ec3f-ff43-9a06-ae644d9ee9d9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <66c7bbfd-ec3f-ff43-9a06-ae644d9ee9d9-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sudeep,

On 17/10/16 17:39, Sudeep Holla wrote:
> 
> 
> On 17/10/16 16:46, Juri Lelli wrote:
> >Hi all,
> >
> >this is a repost of version 7 of "CPUs capacity information for heterogeneous
> >systems" patchset [1] (please refer to previous postings to get some context).
> >I only added Juno r1 dts, as discussed off-line with Sudeep meanwhile (no code
> >changes at all, so that's why I'm saying this is a repost).
> >
> >I'm reposting as I didn't receive any comment (despite pinging people) on the
> >original v7 posting (apart from Vincent acking patches 2 and 4, thanks!). I
> >then waited until merge window for 4.9 was closed.
> >
> >I'm thus now assuming that everybody is OK with the patches and that they can
> >be queued for 4.10 (we certainly need this plumbing at this point). Please
> >speak if my assumption is wrong (and provide feedback! :).
> >Otherwise I'm going to:
> >
> > - use Russell's patching system for patches 2 and 8
> > - ask Sudeep to pull patches 3,5,6 and 7
> 
> I have applied 3 to [1] and 5,6,7 to [2]. Let me know if things change
> and you want me to drop them with some cosmetic subject change and
> updated changelog.
> 

Thanks!

Best,

- Juri

> -- 
> Regards,
> Sudeep
> 
> [1] git.kernel.org/sudeep.holla/linux/h/vexpress-dt/for-next
> [2] git.kernel.org/sudeep.holla/linux/h/juno-dt/for-next
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
