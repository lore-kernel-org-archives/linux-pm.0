From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: Add TI SCI PM Domains
Date: Fri, 11 Nov 2016 13:34:48 +0100
Message-ID: <CAPDyKFofZdFfGA8gbS9FJxAX5Ub-s8yZWDcNVOgwiEBpho4oyw@mail.gmail.com>
References: <20161019203347.17893-1-d-gerlach@ti.com>
 <20161019203347.17893-3-d-gerlach@ti.com>
 <7heg39pmgb.fsf@baylibre.com> <7f4754bb-7ded-6ce3-9558-a45b0d2b3888@ti.com>
 <7h1sz51y3p.fsf@baylibre.com>
 <CAL_JsqJvm8+L0-pFQRQGYhvSzvqubWsBp8Q5kU-BPSiDmMau0A@mail.gmail.com>
 <5811FE09.8000006@ti.com> <90e91588-d2fc-19be-5a28-63c801a8d061@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <90e91588-d2fc-19be-5a28-63c801a8d061@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>, Rob Herring <robh@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Keerthy <j-keerthy@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 10 November 2016 at 20:56, Dave Gerlach <d-gerlach@ti.com> wrote:
> Rob, Ulf, Jon,
>
> On 10/27/2016 08:15 AM, Dave Gerlach wrote:
>>
>> +Jon
>> On 10/26/2016 04:59 PM, Rob Herring wrote:
>>>
>>> On Mon, Oct 24, 2016 at 12:00 PM, Kevin Hilman <khilman@baylibre.com>
>>> wrote:
>>>>
>>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>>
>>>>> Hi,
>>>>> On 10/21/2016 01:48 PM, Kevin Hilman wrote:
>>>>>>
>>>>>> Dave Gerlach <d-gerlach@ti.com> writes:
>>>>>>
>>>>>>> Add a generic power domain implementation, TI SCI PM Domains, that
>>>>>>> will hook into the genpd framework and allow the TI SCI protocol to
>>>>>>> control device power states.
>>>>>>>
>>>>>>> Also, provide macros representing each device index as understood
>>>>>>> by TI SCI to be used in the device node power-domain references.
>>>>>>> These are identifiers for the K2G devices managed by the PMMC.
>>>>>>>
>>>>>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>>>>>> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
>>>>>>> ---
>>>>>>>  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   | 54
>>>>>>> +++++++++++++
>>>>>>>  MAINTAINERS                                        |  2 +
>>>>>>>  include/dt-bindings/genpd/k2g.h                    | 90
>>>>>>> ++++++++++++++++++++++
>>>>>>>  3 files changed, 146 insertions(+)
>>>>>>>  create mode 100644
>>>>>>> Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>>  create mode 100644 include/dt-bindings/genpd/k2g.h
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>> b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..32f38a349656
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
>>>>>>> @@ -0,0 +1,54 @@
>>>>>>> +Texas Instruments TI-SCI Generic Power Domain
>>>>>>> +---------------------------------------------
>>>>>>> +
>>>>>>> +Some TI SoCs contain a system controller (like the PMMC, etc...)
>>>>>>> that is
>>>>>>> +responsible for controlling the state of the IPs that are present.
>>>>>>> +Communication between the host processor running an OS and the
>>>>>>> system
>>>>>>> +controller happens through a protocol known as TI-SCI [1]. This pm
>>>>>>> domain
>>>>>>> +implementation plugs into the generic pm domain framework and makes
>>>>>>> use of
>>>>>>> +the TI SCI protocol power on and off each device when needed.
>>>>>>> +
>>>>>>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>>>>> +
>>>>>>> +PM Domain Node
>>>>>>> +==============
>>>>>>> +The PM domain node represents the global PM domain managed by the
>>>>>>> PMMC,
>>>>>>> +which in this case is the single implementation as documented by the
>>>>>>> generic
>>>>>>> +PM domain bindings in
>>>>>>> Documentation/devicetree/bindings/power/power_domain.txt.
>>>>>>> +
>>>>>>> +Required Properties:
>>>>>>> +--------------------
>>>>>>> +- compatible: should be "ti,sci-pm-domain"
>>>>>>> +- #power-domain-cells: Must be 0.
>>>>>>> +- ti,sci: Phandle to the TI SCI device to use for managing the
>>>>>>> devices.
>>>>>>>
>>>>>>> +Example:
>>>>>>> +--------------------
>>>>>>> +k2g_pds: k2g_pds {
>>>>>>
>>>>>>
>>>>>> should use generic name like "power-contoller", e.g. k2g_pds:
>>>>>> power-controller
>>>>>
>>>>>
>>>>> Ok, that makes more sense.
>>>>>
>>>>>>
>>>>>>> +        compatible = "ti,sci-pm-domain";
>>>>>>> +        #power-domain-cells = <0>;
>>>>>>> +        ti,sci = <&pmmc>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +PM Domain Consumers
>>>>>>> +===================
>>>>>>> +Hardware blocks that require SCI control over their state must
>>>>>>> provide
>>>>>>> +a reference to the sci-pm-domain they are part of and a unique
>>>>>>> device
>>>>>>> +specific ID that identifies the device.
>>>>>>> +
>>>>>>> +Required Properties:
>>>>>>> +--------------------
>>>>>>> +- power-domains: phandle pointing to the corresponding PM domain
>>>>>>> node.
>>>>>>> +- ti,sci-id: index representing the device id to be passed oevr SCI
>>>>>>> to
>>>>>>> +        be used for device control.
>>>>>>
>>>>>>
>>>>>> This ID doesn't look right.
>>>>>>
>>>>>> Why not use #power-domain-cells = <1> and pass the index in the DT?
>>>>>> ...
>>>
>>>
>>> Exactly. ti,sci-id is a NAK for me.
>>
>>
>> I was told not to use the onecell during v1 discussion. I agree this would
>> be
>> ideal but I cannot due to what the bindings represent, the phandle
>> parameter is
>> an index into a list of genpds, whereas we need an actual ID number we can
>> use
>> and I do not have the ability to get that from the phandle.
>>
>> @Ulf/Jon, is there any hope of bringing back custom xlate functions for
>> genpd
>> providers? I don't have a good background on why it was even removed. I
>> can
>> maintain a single genpd for all devices but I need a way to parse this ID,
>> whether it's from a separate property or a phandle. It is locked now to
>> indexing
>> into a list of genpds but I need additional per device information for
>> devices
>> bound to a genpd and I need either a custom parameter or the ability to
>> parse
>> the phandle myself.
>>
>
> Any comments here? The meaning of the phandle onecell is fixed in the genpd
> framework so I'm not sure how we want to move forward with this, I need to
> pass a power domain ID to the genpd driver, and if this shouldn't be a new
> property I'm not sure what direction we should take.
>
> Regards,
> Dave
>
>
>>>
>>>>>>
>>>>>>> +See dt-bindings/genpd/k2g.h for the list of valid identifiers for
>>>>>>> k2g.
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +--------------------
>>>>>>> +uart0: serial@02530c00 {
>>>>>>> +   compatible = "ns16550a";
>>>>>>> +   ...
>>>>>>> +   power-domains = <&k2g_pds>;
>>>>>>> +   ti,sci-id = <K2G_DEV_UART0>;
>>>>>>
>>>>>>
>>>>>> ... like this:
>>>>>>
>>>>>>      power-domains = <&k2g_pds K2G_DEV_UART0>;
>>>>>
>>>>>
>>>>> That's how I did it in version one actually. I was able to define my
>>>>> own xlate function to parse the phandle and get that index, but Ulf
>>>>> pointed me to this series by Jon Hunter [1] that simplified genpd
>>>>> providers and dropped the concept of adding your own xlate. This locks
>>>>> the onecell approach to using a fixed static array of genpds that get
>>>>> indexed into (without passing the index to the provider, just the
>>>>> genpd that's looked up), which doesn't fit our usecase, as we don't
>>>>> want a 1 to 1 genpd to device mapping based on the comments provided
>>>>> in v1. Now we just use the genpd device attach/detach hooks to parse
>>>>> the sci-id and then use it in the genpd device start/stop hooks.
>>>
>>>
>>> I have no idea what any of this means. All sounds like driver
>>> architecture, not anything to do with bindings.
>>
>>
>> This was a response to Kevin, not part of binding description.
>>
>>>
>>>>
>>>> Ah, right.  I remember now.  This approach allows you to use a single
>>>> genpd as discussed earlier.
>>>>
>>>> Makes sense now, suggestion retracted.
>>>
>>>
>>> IIRC, the bindings in Jon's case had a node for each domain and didn't
>>> need any additional property.
>>
>>
>> Yes but we only have one domain and index into it, not into a list of
>> domains,

Exactly. And this my main point as well. We are not talking about a
domain property but a device property.

>> so the additional property is solving a different problem.

Yes.

Perhaps you could try to elaborate about what the TI SCI ID really
represents for the device, as to help Rob understand the bigger
picture?

To me, the TI SCI ID, is similar to a "conid" for any another "device
resource" (like clock, pinctrl, regulator etc) which we can describe
in DT and assign to a device node. The only difference here, is that
we don't have common API to fetch the resource (like clk_get(),
regulator_get()), but instead we fetches the device's resource from
SoC specific code, via genpd's device ->attach() callback.

Hope that helps.

Kind regards
Uffe
