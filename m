From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Mon, 17 Nov 2014 11:14:16 -0800
Message-ID: <7h389h3aif.fsf@deeprootsystems.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
	<5331397.OQCQmJO78C@wuerfel> <5460F806.3040305@ti.com>
	<1600093.60yAP0Qpua@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1600093.60yAP0Qpua@wuerfel> (Arnd Bergmann's message of "Mon, 10
	Nov 2014 21:36:55 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> writes:

> On Monday 10 November 2014 19:38:14 Grygorii Strashko wrote:
>> Hi Arnd,
>> 
>> On 11/10/2014 05:06 PM, Arnd Bergmann wrote:
>> > On Monday 10 November 2014 16:59:16 Grygorii Strashko wrote:
>> >> --- /dev/null
>> >> +++ b/Documentation/devicetree/bindings/power/ti,keystone-powerdomain.txt
>> >> @@ -0,0 +1,31 @@
>> >> +* TI Keystone 2 Generic PM Controller
>> >> +
>> >> +The TI Keystone 2 Generic PM Controller is responsible for Clock gating
>> >> +for each controlled IP module.
>> >> +
>> >> +Required properties:
>> >> +- compatible: Should be "ti,keystone-powerdomain"
>> >> +- #power-domain-cells: Should be 0, see below:
>> >> +
>> >> +The PM Controller node is a PM domain as documented in
>> >> +Documentation/devicetree/bindings/power/power_domain.txt.
>> >> +
>> >> +Example:
>> >> +
>> >> +       pm_controller: pm-controller {
>> >> +               compatible = "ti,keystone-powerdomain";
>> >> +               #power-domain-cells = <0>;
>> >> +       };
>> >> +
>> >> +       netcp: netcp@2090000 {
>> >> +               reg = <0x2620110 0x8>;
>> >> +               reg-names = "efuse";
>> >> +               ...
>> >> +               #address-cells = <1>;
>> >> +               #size-cells = <1>;
>> >> +               ranges;
>> >> +               power-domains = <&pm_controller>;
>> >> +
>> >> +               clocks = <&clkpa>, <&clkcpgmac>, <&chipclk12>;
>> >> +               dma-coherent;
>> >> +       }
>> > 
>> > I don't get it. What keystone specific about a "ti,keystone-powerdomain"
>> > device? It seems that the device has no registers whatsoever and the
>> > driver doesn't really do anything that relates to the platform.
>> 
>> That's true. but it was the only one acceptable way  to enable
>> Generic clock manipulation PM callbacks for the DT-boot case.
>> After several unsuccessful attempts the idea to use GPD
>> was introduced by Kevin there:
>>   https://lkml.org/lkml/2014/9/8/643
>> 
>> So, The Keystone 2 Generic PM Controller is just a proxy PM layer here between
>> device and Generic clock manipulation PM callbacks.
>> It fills per-device clock list when device is attached to GPD and
>> ensures that all clocks from that list enabled/disabled when device is
>> started/stopped.
>
> The idea of such a generic power domain implementation sounds useful, but
> it has absolutely no business in platform specific code.

Yes it does.  This isn't a generic power domain implementation, but
rather just the platform-specific glue that hooks up the clocks to the
right devices and power-domains so that the generic power-domain and
generic pm_clocks code does the right thing.

> I suggest you either remove the power domain proxy from your drivers
> and use the clocks directly, 

No.  That's a step in the wrong direction.  This change isn't affecting
drivers directly.  It's the runtime PM and generic power domain layers
that handle this, and runtime PM adapted drivers don't need any changes.
 
> or come up with an implementation that can be used across other
> platforms and CPU architectures.

We already have those in the generic power domain and the pm_clock
layers.  This series is just hooking those up for Keystone.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
