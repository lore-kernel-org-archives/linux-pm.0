From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC V7 2/2] OPP: Allow "opp-hz" and "opp-microvolt" to contain
 magic values
Date: Thu, 28 Dec 2017 10:02:36 +0530
Message-ID: <20171228043236.GA8652@vireshk-i7>
References: <20171101214333.GG30645@codeaurora.org>
 <20171102045155.GX4240@vireshk-i7>
 <20171102071533.GM30645@codeaurora.org>
 <20171102090033.GZ4240@vireshk-i7>
 <CAPDyKFryn5=GMs+hiRcxGOC1U=-LL9RQdnY3cWniyE+4pwQDog@mail.gmail.com>
 <20171130005029.GC19419@codeaurora.org>
 <20171130065907.GI11413@vireshk-i7>
 <CAL_Jsq+ntPMiSacpsx7M7VwSXsx+fRbHpX-KFNVpDj+bYdNCiQ@mail.gmail.com>
 <20171227044526.GE8312@vireshk-i7>
 <CAL_JsqJA-cCOLRwHC1ZegHEt9v7pMoxY6qXF7Taq3k19bU-k3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqJA-cCOLRwHC1ZegHEt9v7pMoxY6qXF7Taq3k19bU-k3w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 27-12-17, 15:36, Rob Herring wrote:
> On Tue, Dec 26, 2017 at 10:45 PM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On 26-12-17, 14:23, Rob Herring wrote:
> >> >         cpu_opp_table: cpu_opp_table {
> >> >                 compatible = "operating-points-v2";
> >> >                 opp-shared;
> >> >
> >> >                 opp00 {
> >> >                         opp-hz = /bits/ 64 <208000000>;
> >> >                         clock-latency-ns = <500000>;
> >> >                         power-domain-opp = <&domain_opp_1>;
> >>
> >> What is this? opp00 here is not a device. One OPP should not point to
> >> another. "power-domain-opp" is only supposed to appear in devices
> >> alongside power-domains properties.
> >
> > There are two type of devices:
> >
> > A.) With fixed performance state requirements and they will have the
> > new "required-opp" property in the device node itself as you said.
> >
> > B.) Devices which can do DVFS (CPU, MMC, LCD, etc) and those may need
> > a different performance state of the domain for their individual OPPs
> > and so we can't have this property in the device all the time.
> >
> > Does this make sense ?
> 
> No. From the definition for power-domain-opp
> 
> "+- power-domain-opp: This contains phandle to one of the OPP nodes of
> the master
> +  power domain. This specifies the minimum required OPP of the master
> domain for
> +  the functioning of the device in this OPP (where this property is present).

The per-opp thing was mentioned here.

> +  This property can only be set for a device if the device node contains the
> +  "power-domains" property.

This was trying to say something else, though it wasn't clear and so your
concerns.

I wanted to say that the device node or its OPP nodes can have the
"power-domain-opp" property only if the device node has a "power-domains"
property. i.e. you need to have power domain first and then only the
power-domain-opp property.

> Also, either all or none of the OPP nodes in an OPP
> +  table should have it set."
> 
> In the above example, you are violating the next to last sentence.
> 
> Though, I'm now confused by what the last sentence means.

Yeah, lets leave it as is as the V8 has changed this significantly and you
already Acked it :)

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
