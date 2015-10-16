From: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 01/16] PM / OPP: Add 'supply-names' binding
Date: Fri, 16 Oct 2015 12:16:58 -0700
Message-ID: <20151016191658.GA16437@codeaurora.org>
References: <cover.1441972771.git.viresh.kumar@linaro.org>
 <2b87b162eabd1570ae2311e1ef8655acda72f678.1441972771.git.viresh.kumar@linaro.org>
 <55F72C97.2030306@kernel.org>
 <20151016002243.GA23912@codeaurora.org>
 <20151016060227.GS19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151016060227.GS19018@linux>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 10/16, Viresh Kumar wrote:
> On 15-10-15, 17:22, Stephen Boyd wrote:
> > I'm lost why we need this property at all. What happened to using
> > 
> >  opp-microvolt-0 = <1 2 3>;
> >  opp-microvolt-1 = <1>;
> >  opp-microvolt-2 = <3 4 5>;
> >  etc.
> 
> Perhaps you are confusing this with the bindings we came up for
> picking right voltage levels based on the cuts/version of the hardware
> we are running on. The problem that Lee Jones mentioned and that can
> be used in your case as well.

Isn't that what this patch series is for?

> 
> > That seems to avoid any problem with 3 vs. 1 element properties
> > combined into one large array.
> 
> That's not the problem I was trying to solve here.

What problem are you trying to solve then?

> 
> > Having supply-names seems too
> > brittle and would tie us to a particular OPP user's decision to
> > call supplies by some name.
> 
> No. The name has to match the <name>-supply property present in the
> device's node, that's why we need this property :)

Why does it need to match? Sorry I'm totally lost now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
