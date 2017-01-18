From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Tue, 17 Jan 2017 16:07:04 -0800
Message-ID: <m2ziip2puf.fsf@baylibre.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
        <20170104205536.15963-3-d-gerlach@ti.com>
        <20170109175012.sg7eze7llqq7qevd@rob-hp-laptop>
        <7bd282d9-df6f-f4c6-1f7f-c8ed81c78af3@ti.com>
        <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg@mail.gmail.com>
        <3bb89649-fd2a-acc6-6968-e54a00842ce2@ti.com>
        <CAL_JsqL+L1oHAOv7tLevzbtRFSKRs9J01SgF=HR_vNNqNV+4+Q@mail.gmail.com>
        <84d7d49b-933b-8b26-f18a-3a5054738cb1@ti.com>
        <CAL_JsqJ9RitNC7ihC8ckJgV+49kaHk=W9tgdNBSjEfydhQS46A@mail.gmail.com>
        <0eaa9914-83f1-7716-cf04-1e3dd44df647@ti.com>
        <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com> (Tero Kristo's
        message of "Tue, 17 Jan 2017 09:48:12 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pm@vger.kernel.org

Tero Kristo <t-kristo@ti.com> writes:

> On 17/01/17 00:12, Dave Gerlach wrote:
>> On 01/13/2017 08:40 PM, Rob Herring wrote:
>>> On Fri, Jan 13, 2017 at 2:28 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>> On 01/13/2017 01:25 PM, Rob Herring wrote:
>>>>>
>>>>> On Thu, Jan 12, 2017 at 9:27 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>>>>
>>>>>> Rob,
>>>>>>
>>>>>> On 01/11/2017 03:34 PM, Rob Herring wrote:
>>>>>>>
>>>>>>>
>>>>>>> On Mon, Jan 9, 2017 at 11:57 AM, Dave Gerlach <d-gerlach@ti.com>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> Rob,
>>>>>>>>
>>>>>>>> On 01/09/2017 11:50 AM, Rob Herring wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Wed, Jan 04, 2017 at 02:55:34PM -0600, Dave Gerlach wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Add a generic power domain implementation, TI SCI PM Domains, that
>>>>>>>>>> will hook into the genpd framework and allow the TI SCI
>>>>>>>>>> protocol to
>>>>>>>>>> control device power states.
>>>>>>>>>>
>>>>>>>>>> Also, provide macros representing each device index as understood
>>>>>>>>>> by TI SCI to be used in the device node power-domain references.
>>>>>>>>>> These are identifiers for the K2G devices managed by the PMMC.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>>>>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>>>>>>>> ---
>>>>>>>>>> v2->v3:
>>>>>>>>>>         Update k2g_pds node docs to show it should be a child
>>>>>>>>>> of pmmc
>>>>>>>>>> node.
>>>>>>>>>>         In early versions a phandle was used to point to pmmc and
>>>>>>>>>> docs
>>>>>>>>>> still
>>>>>>>>>>         incorrectly showed this.
>>>>>>>>>>
>>>>>>>>>>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 59
>>>>>>>>>> ++++++++++++++
>>>>>>>>>>  MAINTAINERS                                        |  2 +
>>>>>>>>>>  include/dt-bindings/genpd/k2g.h                    | 90
>>>>>>>>>> ++++++++++++++++++++++
>>>>>>>>>>  3 files changed, 151 insertions(+)
>>>>>>>>>>  create mode 100644
>>>>>>>>>> Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>>>>>  create mode 100644 include/dt-bindings/genpd/k2g.h
>>>>>>>>>>
>>>>>>>>>> diff --git
>>>>>>>>>> a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>>>>> b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..4c9064e512cb
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>>>>> @@ -0,0 +1,59 @@
>>>>>>>>>> +Texas Instruments TI-SCI Generic Power Domain
>>>>>>>>>> +---------------------------------------------
>>>>>>>>>> +
>>>>>>>>>> +Some TI SoCs contain a system controller (like the PMMC, etc...)
>>>>>>>>>> that
>>>>>>>>>> is
>>>>>>>>>> +responsible for controlling the state of the IPs that are
>>>>>>>>>> present.
>>>>>>>>>> +Communication between the host processor running an OS and the
>>>>>>>>>> system
>>>>>>>>>> +controller happens through a protocol known as TI-SCI [1].
>>>>>>>>>> This pm
>>>>>>>>>> domain
>>>>>>>>>> +implementation plugs into the generic pm domain framework and
>>>>>>>>>> makes
>>>>>>>>>> use
>>>>>>>>>> of
>>>>>>>>>> +the TI SCI protocol power on and off each device when needed.
>>>>>>>>>> +
>>>>>>>>>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>>>>>>>> +
>>>>>>>>>> +PM Domain Node
>>>>>>>>>> +==============
>>>>>>>>>> +The PM domain node represents the global PM domain managed by the
>>>>>>>>>> PMMC,
>>>>>>>>>> +which in this case is the single implementation as documented
>>>>>>>>>> by the
>>>>>>>>>> generic
>>>>>>>>>> +PM domain bindings in
>>>>>>>>>> Documentation/devicetree/bindings/power/power_domain.txt.
>>>>>>>>>> +Because this relies on the TI SCI protocol to communicate with
>>>>>>>>>> the
>>>>>>>>>> PMMC
>>>>>>>>>> it
>>>>>>>>>> +must be a child of the pmmc node.
>>>>>>>>>> +
>>>>>>>>>> +Required Properties:
>>>>>>>>>> +--------------------
>>>>>>>>>> +- compatible: should be "ti,sci-pm-domain"
>>>>>>>>>> +- #power-domain-cells: Must be 0.
>>>>>>>>>> +
>>>>>>>>>> +Example (K2G):
>>>>>>>>>> +-------------
>>>>>>>>>> +       pmmc: pmmc {
>>>>>>>>>> +               compatible = "ti,k2g-sci";
>>>>>>>>>> +               ...
>>>>>>>>>> +
>>>>>>>>>> +               k2g_pds: k2g_pds {
>>>>>>>>>> +                       compatible = "ti,sci-pm-domain";
>>>>>>>>>> +                       #power-domain-cells = <0>;
>>>>>>>>>> +               };
>>>>>>>>>> +       };
>>>>>>>>>> +
>>>>>>>>>> +PM Domain Consumers
>>>>>>>>>> +===================
>>>>>>>>>> +Hardware blocks that require SCI control over their state must
>>>>>>>>>> provide
>>>>>>>>>> +a reference to the sci-pm-domain they are part of and a unique
>>>>>>>>>> device
>>>>>>>>>> +specific ID that identifies the device.
>>>>>>>>>> +
>>>>>>>>>> +Required Properties:
>>>>>>>>>> +--------------------
>>>>>>>>>> +- power-domains: phandle pointing to the corresponding PM domain
>>>>>>>>>> node.
>>>>>>>>>> +- ti,sci-id: index representing the device id to be passed
>>>>>>>>>> oevr SCI
>>>>>>>>>> to
>>>>>>>>>> +            be used for device control.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> As I've already stated before, this goes in power-domain cells.
>>>>>>>>> When
>>>>>>>>> you
>>>>>>>>> have a single thing (i.e. node) that controls multiple things, then
>>>>>>>>> you
>>>>>>>>> you need to specify the ID for each of them in phandle args.
>>>>>>>>> This is
>>>>>>>>> how
>>>>>>>>> irqs, gpio, clocks, *everything* in DT works.
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> You think the reasoning for doing it this way provided by both
>>>>>>>> Ulf and
>>>>>>>> myself on v2 [1] is not valid then?
>>>>>>>>
>>>>>>>> From Ulf:
>>>>>>>>
>>>>>>>> To me, the TI SCI ID, is similar to a "conid" for any another
>>>>>>>> "device
>>>>>>>> resource" (like clock, pinctrl, regulator etc) which we can describe
>>>>>>>> in DT and assign to a device node. The only difference here, is that
>>>>>>>> we don't have common API to fetch the resource (like clk_get(),
>>>>>>>> regulator_get()), but instead we fetches the device's resource from
>>>>>>>> SoC specific code, via genpd's device ->attach() callback.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Sorry, but that sounds like a kernel problem to me and has nothing to
>>>>>>> do with DT bindings.
>>>>>>>
>>>>>>>> From me:
>>>>>>>>
>>>>>>>> Yes, you've pretty much hit it on the head. It is not an index
>>>>>>>> into a
>>>>>>>> list
>>>>>>>> of genpds but rather identifies the device *within* a single
>>>>>>>> genpd. It
>>>>>>>> is
>>>>>>>> a
>>>>>>>> property specific to each device that resides in a ti-sci-genpd,
>>>>>>>> not a
>>>>>>>> mapping describing which genpd the device belongs to. The generic
>>>>>>>> power
>>>>>>>> domain binding is concerned with mapping the device to a specific
>>>>>>>> genpd,
>>>>>>>> which is does fine for us, but we have a sub mapping for devices
>>>>>>>> that
>>>>>>>> exist
>>>>>>>> inside a genpd which, we must describe as well, hence the ti,sci-id.
>>>>>>>>
>>>>>>>>
>>>>>>>> So to summarize, the genpd framework does interpret the phandle
>>>>>>>> arg as
>>>>>>>> an
>>>>>>>> index into multiple genpds, just as you've said other frameworks do,
>>>>>>>> but
>>>>>>>> this is not what I am trying to do, we have multiple devices within
>>>>>>>> this
>>>>>>>> *single* genpd, hence the need for the ti,sci-id property.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Fix the genpd framework rather than work around it in DT.
>>>>>>
>>>>>>
>>>>>>
>>>>>> I still disagree that this has nothing to do with DT bindings, as the
>>>>>> current DT binding represents something different already. I am
>>>>>> trying to
>>>>>> extend it to give me additional information needed for our
>>>>>> platforms. Are
>>>>>> you saying that we should break what the current DT binding already
>>>>>> represents to mean something else?
>>>>>
>>>>>
>>>>> No idea because what's the current binding? From the patch, looks like
>>>>> a new binding to me.
>>>>
>>>>
>>>> Yes, ti,sci-id is a new binding. I am referring to the current
>>>> meaning of
>>>> the "power-domains" binding, which is where you are asking this
>>>> property to
>>>> be added, in "power-domains" cells. This is documented here [1] in the
>>>> kernel, although looking at it I must admit it is not very clear.
>>>>
>>>> The power-domains cell represents an offset into an array of power
>>>> domains,
>>>> if you choose to use it. That's what the genpd framework is hard
>>>> coded to
>>>> interpret it as. This is correct, as it is an index into a static
>>>> list of
>>>> power domains, used to identify which power domain a device belongs to,
>>>> which is exactly what the genpd framework itself is concerned with.
>>>> This is
>>>> already how it is used in the kernel today.
>>>
>>> Strictly speaking, the cells are purely for the interpretation of the
>>> phandle they are associated with. If some controller wants to have 20
>>> cells, then it could assuming a good reason. The reality is we tend to
>>> align the meaning of the cells. If genpd is interpreting the cells and
>>> not letting the driver for the power domain controller interpret them,
>>> then still, genpd needs to be fixed.
>>
>> Ok, perhaps the genpd folks on the thread can jump in here with any
>> thoughts that they have.
>>
>>>
>>> IIRC, initially it was said genpd required 0 cells, hence my confusion.
>>>
>>>> My ti,sci-id is not an index into a list of power domains, so it
>>>> should not
>>>> go in the power-domains cells and go against what the power-domains
>>>> binding
>>>> says that the cell expects. We have one single power domain, and the new
>>>> ti,sci-id binding is not something the genpd framework itself is
>>>> concerned
>>>> with as it's our property to identify a device inside a power domain,
>>>> not to
>>>> identify which power domain it is associated with.
>>>
>>> What is the id used for? I can understand why you need to know what
>>> power domain a device is in (as power-domains identifies), but not
>>> what devices are in a power domain.
>>
>> We have a system control processor that provides power management
>> services to the OS and it responsible for handling the power state of
>> each device. This control happens over a communication interface we have
>> called TI SCI (implemented at drivers/firmware/ti-sci.c). The
>> communication protocol uses these ids to identify each device within the
>> power domain so that the control processor can do what is necessary to
>> enable that device.
>
> I think a minor detail here that Rob might be missing right now is,
> that the ti,sci-id is only controlling the PM runtime handling, and
> providing the ID per-device for this purpose only. AFAIK, it is not
> really connected to the power domain anymore as such, as we don't have
> power-domains / per device anymore as was the case in some earlier
> revision of this work.

I think this gets to the heart of things.  IMO The confusion arises
because we're throwing around the term "power domain" when there isn't
an actual hardware power domain here.

Unfortunately, the genpd bindings have used the terminology power-domain
when in fact genpd is more generic than that and can be used not just
for hardware power domains, but for arbitrary grouping of devices that
have common PM properties.  That's why genpd actually stands for generic
PM domain, not power domain.  Unfortunately, the bindings have grown
primarily out of the usage for hardware power domains.

> One could argue though that the whole usage of power-domains is now
> moot, as we basically only have implemented one genpd in the whole
> SoC, which doesn't really reflect the reality. I wonder if better
> approach would be to have this replaced with proper power domains at
> some point (if needed), and just have a runtime-pm implementation in
> place for the devices that require it.
>
> So, as an example in DT, we would only have:
>
> uart0: serial@02530c00 {
>   compatible = "xyz";
>   ...
>   ti,sci-id = <K2G_DEV_UART0>;
> };
>
> This is somewhat analogous to what OMAP family of SoCs have in place
> now, under "ti,hwmods" property. I also wonder if the "ti,sci-id"
> should be replaced with something like "ti,sci-dev-id" to make its
> purpose clearer.

Unless I'm missing something, that still begs the question of who reads
that property and takes care of the call into TI-SCI though.

Kevin
