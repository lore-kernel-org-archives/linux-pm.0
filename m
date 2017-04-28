From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V6 1/9] PM / OPP: Introduce "power-domain-opp" property
Date: Fri, 28 Apr 2017 15:48:03 -0500
Message-ID: <20170428204803.plu467okibtxga4d@rob-hp-laptop>
References: <cover.1493203884.git.viresh.kumar@linaro.org>
 <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <025acedb263eaa6089d354d9630214ada8013990.1493203884.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lina.iyer-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 26, 2017 at 04:27:05PM +0530, Viresh Kumar wrote:
> Power-domains need to express their active states in DT and the devices
> within the power-domain need to express their dependency on those active
> states. The power-domains can use the OPP tables without any
> modifications to the bindings.
> 
> Add a new property "power-domain-opp", which will contain phandle to the
> OPP node of the parent power domain. This is required for devices which
> have dependency on the configured active state of the power domain for
> their working.
> 
> For some platforms the actual frequency and voltages of the power
> domains are managed by the firmware and are so hidden from the high
> level operating system. The "opp-hz" property is relaxed a bit to
> contain indexes instead of actual frequency values to support such
> platforms.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/opp/opp.txt | 74 ++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp.txt b/Documentation/devicetree/bindings/opp/opp.txt
> index 63725498bd20..6e30cae2a936 100644
> --- a/Documentation/devicetree/bindings/opp/opp.txt
> +++ b/Documentation/devicetree/bindings/opp/opp.txt
> @@ -77,7 +77,10 @@ This defines voltage-current-frequency combinations along with other related
>  properties.
>  
>  Required properties:
> -- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer.
> +- opp-hz: Frequency in Hz, expressed as a 64-bit big-endian integer. In some
> +  cases the exact frequency in Hz may be hidden from the OS by the firmware and
> +  this field may contain values that represent the frequency in a firmware
> +  dependent way, for example an index of an array in the firmware.

Not really sure OPP binding makes sense here. What about all the other 
properties. We expose voltage, but not freq?

>  
>  Optional properties:
>  - opp-microvolt: voltage in micro Volts.
> @@ -154,6 +157,13 @@ properties.
>  
>  - status: Marks the node enabled/disabled.
>  
> +- power-domain-opp: Phandle to the OPP node of the parent power-domain. The
> +  parent power-domain should be configured to the OPP whose node is pointed by
> +  the phandle, in order to configure the device for the OPP node that contains
> +  this property. The order in which the device and power domain should be
> +  configured is implementation defined. The OPP table of a device can set this
> +  property only if the device node contains "power-domains" property.
> +

I don't even know what to say on this. The continual evolution of 
OPP bindings continues. This seems like further abuse of DT 
power-domains (being a region in a chip that can be powergated) with 
Linux PM domains.

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
