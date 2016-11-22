From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] PM / Domains: Introduce domain-performance-state
 binding
Date: Tue, 22 Nov 2016 08:47:17 +0530
Message-ID: <20161122031717.GE10014@vireshk-i7>
References: <cover.1479459752.git.viresh.kumar@linaro.org>
 <cce951c7159aa235792959ce27546be3aaa554ec.1479459752.git.viresh.kumar@linaro.org>
 <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161121150708.j4gosfr2uetc7mwp@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lina Iyer <lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nayak Rajendra <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 21-11-16, 09:07, Rob Herring wrote:
> On Fri, Nov 18, 2016 at 02:53:12PM +0530, Viresh Kumar wrote:
> > Some platforms have the capability to configure the performance state of
> > their Power Domains. The performance levels are represented by positive
> > integer values, a lower value represents lower performance state.
> > 
> > The power-domains until now were only concentrating on the idle state
> > management of the device and this needs to change in order to reuse the
> > infrastructure of power domains for active state management.
> > 
> > This patch introduces a new optional property for the consumers of the
> > power-domains: domain-performance-state.
> > 
> > If the consumers don't need the capability of switching to different
> > domain performance states at runtime, then they can simply define their
> > required domain performance state in their node directly. Otherwise the
> > consumers can define their requirements with help of other
> > infrastructure, for example the OPP table.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/power/power_domain.txt | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> > index e1650364b296..db42eacf8b5c 100644
> > --- a/Documentation/devicetree/bindings/power/power_domain.txt
> > +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> > @@ -106,6 +106,12 @@ domain provided by the 'parent' power controller.
> >   - power-domains : A phandle and PM domain specifier as defined by bindings of
> >                     the power controller specified by phandle.
> >  
> > +Optional properties:
> > +- domain-performance-state: A positive integer value representing the minimum
> > +  performance level (of the parent domain) required by the consumer for its
> > +  working. The integer value '1' represents the lowest performance level and the
> > +  highest value represents the highest performance level.
> 
> How does one come up with the range of values?

Why would we need a range here? The value here represents the minimum 'state'
and the assumption is that everything above that level would be fine. So the
range is automatically: domain-performance-state -> MAX.

> It seems like you are 
> just making up numbers. Couldn't the domain performance level be an OPP 
> in the sense that it is a collection of clock frequencies and voltage 
> settings?

The clock is going to be handled by the device itself (at least for the case we
have today) and the performance-state lies with the power-domain which is
configured separately. If the performance level includes both clk and voltage,
then why would we need to show the clock rates in the DT ? Wouldn't a
performance level be enough in such cases?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
