From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 0/2] PM / Domains / OPP: Introduce
 domain-performance-state binding
Date: Tue, 3 Jan 2017 16:37:54 +0530
Message-ID: <20170103110754.GA14137@vireshk-i7>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <20161222181422.2cpmdfzeyxdi6vpa@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161222181422.2cpmdfzeyxdi6vpa@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 22-12-16, 12:14, Rob Herring wrote:
> On Mon, Dec 12, 2016 at 04:26:17PM +0530, Viresh Kumar wrote:
> > Hello,
> > 
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are represented by positive
> > integer values, a lower value represents lower performance state.
> > 
> > We had some discussions about it in the past on the PM list [1], which is
> > followed by discussions during the LPC. The outcome of all that was that we
> > should extend Power Domain framework to support active state power management
> > as well.
> > 
> > The power-domains until now were only concentrating on the idle state
> > management of the device and this needs to change in order to reuse the
> > infrastructure of power domains for active state management.
> 
> >From a h/w perspective, are idle states really different from 
> performance states? 
> 
> > 
> > To get a complete picture of the proposed plan, following is what we
> > need to do:
> > - Create DT bindings to get domain performance state information for the
> >   platforms.
> 
> I would do this last so you can evolve things if you're not certain 
> about what the bindings should look like. You can always start with 
> things in the kernel and add to DT later.

Okay, I have just posted some code for this:

lkml.kernel.org/r/cover.1483439894.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org

Thanks for your inputs.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
