From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Wed, 16 Nov 2016 08:38:46 +0530
Message-ID: <20161116030846.GC17245@vireshk-i7>
References: <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7>
 <20161110225126.GK16026@codeaurora.org>
 <20161111031120.GE11670@vireshk-i7>
 <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
 <20161115021302.GR5177@codeaurora.org>
 <20161115033151.GG4178@vireshk-i7>
 <20161115185645.GA25626@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161115185645.GA25626-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, d-gerlach-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 15-11-16, 10:56, Stephen Boyd wrote:
> This is also possible from C code though.

Right and this is what this patchset is doing right now. To make it
clear, the order of regulator names in the call
dev_pm_opp_set_regulators() is used now to communicate the order in
which entries are present in the OPP table.

> Or is there some case
> where it isn't possible if we're sharing the same table with two
> devices?

Even in that case it will be possible to set regulators separately, so
that's not a problem.

> I'm lost on when this would ever happen.

It would happen in case of Krait for example, where CPUs manage DVFS
separately but their tables may all be same.

> It feels like trying to keep the OPP table agnostic of the
> consuming device and the device's binding is more trouble than
> it's worth. Especially considering we have opp-shared and *-name
> now.

Right.

> > - The order in which the supplies need to be programmed. We have all
> >   agreed to do this in code instead of inferring it from DT and this
> >   patch series already does that.
> 
> Agreed. Encoding a sequence into DT doesn't sound very feasible.
> How is this going to be handled though? I don't see any users of
> the code we're reviewing here, so it's hard to grasp how things
> will work. It would be really useful if we had some user of the
> code included in the patch series to get the big picture.

The TI guys would be doing it soon. The sequence will be handled by
platform specific set_opp() callbacks now. So, there is nothing in the
core for that.

> > So, are you saying that the way this patchset does it is fine with you
> > ?
> 
> That's just to handle the ordering of operations?

Not just that. The blocking question here is that "Do we want to know
the sequence in which the entries for multiple regulators are present
in the OPP nodes from the DT? Or is it fine to handle that in code".

And AFAIU, you are saying that we better handle that in code as
handling that in DT is going to be nightmare without a new ugly
property.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
