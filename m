From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/2] PM / Domains: Introduce domain-performance-states
 binding
Date: Fri, 6 Jan 2017 14:57:02 +0530
Message-ID: <20170106092702.GH21926@vireshk-i7>
References: <cover.1481539827.git.viresh.kumar@linaro.org>
 <dd95df02a1c3efd00bd4890f8aceeb717ad38788.1481539827.git.viresh.kumar@linaro.org>
 <586F596C.7000807@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <586F596C.7000807-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 06-01-17, 14:16, Rajendra Nayak wrote:
> 
> On 12/12/2016 04:26 PM, Viresh Kumar wrote:
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are represented by positive
> > integer values, a lower value represents lower performance state.
> > 
> > The power-domains until now were only concentrating on the idle state
> > management of the device and this needs to change in order to reuse the
> > infrastructure of power domains for active state management.
> > 
> > This patch adds binding to describe the performance states of a power
> > domain.
> 
> The bindings would also need to take into account the fact that a device
> could (and is quite often the case with qcom platforms) have 2 separate
> powerdomains, one for idle state management and another to manage active
> states. I guess the below bindings assume that there's just one.

I have answered a similar question here..

https://marc.info/?l=linux-kernel&m=148067565219477&w=2

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
