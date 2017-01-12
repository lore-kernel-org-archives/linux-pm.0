From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Thu, 12 Jan 2017 09:27:02 -0600
Message-ID: <3bb89649-fd2a-acc6-6968-e54a00842ce2@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
 <20170104205536.15963-3-d-gerlach@ti.com>
 <20170109175012.sg7eze7llqq7qevd@rob-hp-laptop>
 <7bd282d9-df6f-f4c6-1f7f-c8ed81c78af3@ti.com>
 <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Rob,
On 01/11/2017 03:34 PM, Rob Herring wrote:
> On Mon, Jan 9, 2017 at 11:57 AM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
>> Rob,
>>
>> On 01/09/2017 11:50 AM, Rob Herring wrote:
>>>
>>> On Wed, Jan 04, 2017 at 02:55:34PM -0600, Dave Gerlach wrote:
>>>>
>>>> Add a generic power domain implementation, TI SCI PM Domains, that
>>>> will hook into the genpd framework and allow the TI SCI protocol to
>>>> control device power states.
>>>>
>>>> Also, provide macros representing each device index as understood
>>>> by TI SCI to be used in the device node power-domain references.
>>>> These are identifiers for the K2G devices managed by the PMMC.
>>>>
>>>> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
>>>> Signed-off-by: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>> v2->v3:
>>>>         Update k2g_pds node docs to show it should be a child of pmmc
>>>> node.
>>>>         In early versions a phandle was used to point to pmmc and docs
>>>> still
>>>>         incorrectly showed this.
>>>>
>>>>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 59 ++++++++++++++
>>>>  MAINTAINERS                                        |  2 +
>>>>  include/dt-bindings/genpd/k2g.h                    | 90
>>>> ++++++++++++++++++++++
>>>>  3 files changed, 151 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>  create mode 100644 include/dt-bindings/genpd/k2g.h
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>> b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>> new file mode 100644
>>>> index 000000000000..4c9064e512cb
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>> @@ -0,0 +1,59 @@
>>>> +Texas Instruments TI-SCI Generic Power Domain
>>>> +---------------------------------------------
>>>> +
>>>> +Some TI SoCs contain a system controller (like the PMMC, etc...) that is
>>>> +responsible for controlling the state of the IPs that are present.
>>>> +Communication between the host processor running an OS and the system
>>>> +controller happens through a protocol known as TI-SCI [1]. This pm
>>>> domain
>>>> +implementation plugs into the generic pm domain framework and makes use
>>>> of
>>>> +the TI SCI protocol power on and off each device when needed.
>>>> +
>>>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>> +
>>>> +PM Domain Node
>>>> +==============
>>>> +The PM domain node represents the global PM domain managed by the PMMC,
>>>> +which in this case is the single implementation as documented by the
>>>> generic
>>>> +PM domain bindings in
>>>> Documentation/devicetree/bindings/power/power_domain.txt.
>>>> +Because this relies on the TI SCI protocol to communicate with the PMMC
>>>> it
>>>> +must be a child of the pmmc node.
>>>> +
>>>> +Required Properties:
>>>> +--------------------
>>>> +- compatible: should be "ti,sci-pm-domain"
>>>> +- #power-domain-cells: Must be 0.
>>>> +
>>>> +Example (K2G):
>>>> +-------------
>>>> +       pmmc: pmmc {
>>>> +               compatible = "ti,k2g-sci";
>>>> +               ...
>>>> +
>>>> +               k2g_pds: k2g_pds {
>>>> +                       compatible = "ti,sci-pm-domain";
>>>> +                       #power-domain-cells = <0>;
>>>> +               };
>>>> +       };
>>>> +
>>>> +PM Domain Consumers
>>>> +===================
>>>> +Hardware blocks that require SCI control over their state must provide
>>>> +a reference to the sci-pm-domain they are part of and a unique device
>>>> +specific ID that identifies the device.
>>>> +
>>>> +Required Properties:
>>>> +--------------------
>>>> +- power-domains: phandle pointing to the corresponding PM domain node.
>>>> +- ti,sci-id: index representing the device id to be passed oevr SCI to
>>>> +            be used for device control.
>>>
>>>
>>> As I've already stated before, this goes in power-domain cells. When you
>>> have a single thing (i.e. node) that controls multiple things, then you
>>> you need to specify the ID for each of them in phandle args. This is how
>>> irqs, gpio, clocks, *everything* in DT works.
>>
>>
>> You think the reasoning for doing it this way provided by both Ulf and
>> myself on v2 [1] is not valid then?
>>
>> From Ulf:
>>
>> To me, the TI SCI ID, is similar to a "conid" for any another "device
>> resource" (like clock, pinctrl, regulator etc) which we can describe
>> in DT and assign to a device node. The only difference here, is that
>> we don't have common API to fetch the resource (like clk_get(),
>> regulator_get()), but instead we fetches the device's resource from
>> SoC specific code, via genpd's device ->attach() callback.
>
> Sorry, but that sounds like a kernel problem to me and has nothing to
> do with DT bindings.
>
>> From me:
>>
>> Yes, you've pretty much hit it on the head. It is not an index into a list
>> of genpds but rather identifies the device *within* a single genpd. It is a
>> property specific to each device that resides in a ti-sci-genpd, not a
>> mapping describing which genpd the device belongs to. The generic power
>> domain binding is concerned with mapping the device to a specific genpd,
>> which is does fine for us, but we have a sub mapping for devices that exist
>> inside a genpd which, we must describe as well, hence the ti,sci-id.
>>
>>
>> So to summarize, the genpd framework does interpret the phandle arg as an
>> index into multiple genpds, just as you've said other frameworks do, but
>> this is not what I am trying to do, we have multiple devices within this
>> *single* genpd, hence the need for the ti,sci-id property.
>
> Fix the genpd framework rather than work around it in DT.

I still disagree that this has nothing to do with DT bindings, as the 
current DT binding represents something different already. I am trying 
to extend it to give me additional information needed for our platforms. 
Are you saying that we should break what the current DT binding already 
represents to mean something else?

Regards,
Dave

>
> Rob
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
