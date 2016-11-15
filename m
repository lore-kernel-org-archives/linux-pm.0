From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/9] PM / OPP: Reword binding supporting multiple
 regulators per device
Date: Mon, 14 Nov 2016 19:59:52 -0600
Message-ID: <20161115015952.steomn4azdl5iv6z@rob-hp-laptop>
References: <cover.1477463128.git.viresh.kumar@linaro.org>
 <28119b44689921f3c3cc00be49bff2bb99b32162.1477463128.git.viresh.kumar@linaro.org>
 <20161109145828.p6vvsd5bygkzjcmh@sirena.org.uk>
 <20161110040440.GA11670@vireshk-i7>
 <20161110163659.rk67qrmnrovq2ktf@sirena.org.uk>
 <20161110180940.GD11670@vireshk-i7>
 <20161110225126.GK16026@codeaurora.org>
 <20161111031120.GE11670@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111031120.GE11670@vireshk-i7>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, nm-l0cyMroinI0@public.gmane.org, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, d-gerlach-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 11, 2016 at 08:41:20AM +0530, Viresh Kumar wrote:
> On 10-11-16, 14:51, Stephen Boyd wrote:
> > On 11/10, Viresh Kumar wrote:
> > > On 10-11-16, 16:36, Mark Brown wrote:
> > > > On Thu, Nov 10, 2016 at 09:34:40AM +0530, Viresh Kumar wrote:
> > > > > On 09-11-16, 14:58, Mark Brown wrote:
> > > > > > On Wed, Oct 26, 2016 at 12:02:56PM +0530, Viresh Kumar wrote:
> > > > 
> > > > > > > +  Entries for multiple regulators shall be provided in the same field separated
> > > > > > > +  by angular brackets <>. The OPP binding doesn't provide any provisions to
> > > > > > > +  relate the values to their power supplies or the order in which the supplies
> > > > > > > +  need to be configured.
> > > > 
> > > > > > I don't understand how this works.  If we have an unordered list of
> > > > > > values to set for regulators how will we make sense of them?
> > > > 
> > > > > The platform driver is responsible to identify the order and pass it on to the
> > > > > OPP core. And the platform driver needs to have that hard coded.
> > > > 
> > > > That *really* should be in the binding.
> > > 
> > > Okay, how do you suggest doing that? Will a property like supply-names
> > > in the OPP table be fine? Like this:
> > > 
> > > @@ -369,13 +378,16 @@ Example 4: Handling multiple regulators
> > >                         compatible = "arm,cortex-a7";
> > >                         ...
> > >  
> > > -                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> > > +                       vcc0-supply = <&cpu_supply0>;
> > > +                       vcc1-supply = <&cpu_supply1>;
> > > +                       vcc2-supply = <&cpu_supply2>;
> > >                         operating-points-v2 = <&cpu0_opp_table>;
> > >                 };
> > >         };
> > >  
> > >         cpu0_opp_table: opp_table0 {
> > >                 compatible = "operating-points-v2";
> > > +               supply-names = "vcc0", "vcc1", "vcc2";
> > >                 opp-shared;
> > > 
> > 
> > No. The supply names (and also clock names/index) should be left
> > up to the consumer of the OPP table. We don't want to encode any
> > sort of details like this between the OPP table and the consumer
> > of it in DT because then it seriously couples the OPP table to
> > the consumer device. "The binding" in this case that needs to be
> > updated is the consumer binding, to indicate that it correlated
> > foo-supply and bar-supply to index 0 and 1 of the OPP table
> > voltages.
> 
> Are you saying that we shall have a property like this then?
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index ee91cbdd95ee..733946df2fb8 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -389,7 +389,10 @@ Example 4: Handling multiple regulators
>                         compatible = "arm,cortex-a7";
>                         ...
>  
> -                       cpu-supply = <&cpu_supply0>, <&cpu_supply1>, <&cpu_supply2>;
> +                       vcc0-supply = <&cpu_supply0>;
> +                       vcc1-supply = <&cpu_supply1>;
> +                       vcc2-supply = <&cpu_supply2>;
> +                       opp-supply-names = "vcc0", "vcc1", "vcc2";

Uh, no. You already have the names in the *-supply properties. Yes, they 
are a PIA to retrieve compared to a *-names property, but that is the 
nature of this style of binding.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
