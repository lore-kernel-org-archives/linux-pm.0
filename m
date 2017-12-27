From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 3/3] OPP: Allow "opp-hz" and "opp-microvolt" to
 contain magic values
Date: Wed, 27 Dec 2017 14:26:45 +0530
Message-ID: <20171227085645.GF8312@vireshk-i7>
References: <cover.1513591822.git.viresh.kumar@linaro.org>
 <476d7ae69184d787ccc6d99f8df6069007fd0a91.1513591822.git.viresh.kumar@linaro.org>
 <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171226202955.32j7gzonrixtwdpt@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 26-12-17, 14:29, Rob Herring wrote:
> On Mon, Dec 18, 2017 at 03:51:30PM +0530, Viresh Kumar wrote:

> > +On some platforms the exact frequency or voltage may be hidden from the OS by
> > +the firmware and the "opp-hz" or the "opp-microvolt" properties may contain
> > +magic values that represent the frequency or voltage in a firmware dependent
> > +way, for example an index of an array in the firmware.
> 
> I'm still not convinced this is a good idea.

You were kind-of a few days back :)

lkml.kernel.org/r/CAL_JsqK-qtAaM_Ou5NtxcWR3F_q=8rMPJUm-VqGtKhbtWe5SAQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org

So here is the deal:

- I proposed "domain-performance-state" property for this stuff
  initially.
- But Kevin didn't like that and proposed reusing "opp-hz" and
  "opp-microvolt", which we all agreed to multiple times..
- And we are back to the same discussion now and its painful and time
  killing for all of us.

TBH, I don't have too strong preferences about any of the suggestions
you guys have and I need you guys to tell me what binding changes to
do here and I will do that.

> If you have firmware 
> partially managing things, then I think we should have platform specific 
> bindings or drivers. 

What about the initial idea then, like "performance-state" for the
power domains ? All platforms will anyway replicate that binding only.

> This is complex enough I'm not taking silence from Stephen as an okay.

Sure, but I am not sure how to make him speak :)

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
