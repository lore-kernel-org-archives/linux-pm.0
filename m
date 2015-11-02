From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Mon, 2 Nov 2015 17:40:34 +0530
Message-ID: <20151102121034.GA3639@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
 <1446461181.10039.28.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446461181.10039.28.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 02-11-15, 18:46, dawei chien wrote:
> On Wed, 2015-10-28 at 21:14 +0530, Viresh Kumar wrote:
> > Sorry for being extremely late in reviewing this stuff. You are
> > already on v3 and I haven't reviewed it once. Mostly due to bad timing
> > of my holidays and other work pressure.
> 
> You're welcome, truly thank you for your kindly reviewing

Thanks for understanding.

> > Now, there are few things that I feel are not properly addressed here,
> > and I may be wrong:
> > - Where are the bindings for static-power-points and
> >   dynamic-power-coefficient. Sorry I failed to see them in this or
> >   other series you mentioned.
> 
> Please refer to following document (2-1,2-2) for dynamic-power &
> static-power in detail. Besides, do I need to add another document for
> our own MT8173 IC.
> http://lxr.free-electrons.com/source/Documentation/thermal/cpu-cooling-api.txt

That's about the power-API, but I am talking about the Device Tree
bindings here. So, when you add any new DT bindings (Or a new property
in device tree blobs), you need to add its documentation in
Documentation/devicetree/bindings/... and get it approved by DT
maintainers as well. You perhaps missed that completely, otherwise you
would have been told really early that the new bindings aren't going
to help.

> > - Even then, why should we be adding another table into DT for
> >   voltage/power ? And not reuse and extend the opp-v2 stuff which is
> >   already mainlined now.
> 
> We could reuse opp-v2 for static power points after OPPV2 back port to
> our currently branch.

Your current branch doesn't matter to us. All that matters here is
mainline, that's where you are adding code to. And you must test your
stuff on the latest upstream branch only, not on some old kernel
release. You can include other dependency patches though, that are
required to make it work and mention them in cover-letter.

> However, as far as I know, there is no "power" in opp.c (suck like

s/suck/such ?

> opp-hz) as far, so I need to add something in opp.c for my purpose, suck
> like add power in _opp_add_static_v2, and add something for return
> "power", right? I may be wrong, please kindly give me your suggestion,
> thank you.

You first need to propose a change in DT bindings for OPPs:
Documentation/devicetree/bindings/opp/opp.txt

And then we can change the code properly.

> Actually, I am considering to remove the part of static power point
> since it is optional for Power Model. Could you agree with this?

If its not important for your platform, then I don't have any issues
with that..

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
