From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Wed, 18 Jan 2017 17:03:18 -0600
Message-ID: <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
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
 <m2ziip2puf.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <m2ziip2puf.fsf@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 17, 2017 at 6:07 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> Tero Kristo <t-kristo@ti.com> writes:
>> On 17/01/17 00:12, Dave Gerlach wrote:
>>> On 01/13/2017 08:40 PM, Rob Herring wrote:
>>>> On Fri, Jan 13, 2017 at 2:28 PM, Dave Gerlach <d-gerlach@ti.com> wrote:

[...]

>>>>> My ti,sci-id is not an index into a list of power domains, so it
>>>>> should not
>>>>> go in the power-domains cells and go against what the power-domains
>>>>> binding
>>>>> says that the cell expects. We have one single power domain, and the new
>>>>> ti,sci-id binding is not something the genpd framework itself is
>>>>> concerned
>>>>> with as it's our property to identify a device inside a power domain,
>>>>> not to
>>>>> identify which power domain it is associated with.
>>>>
>>>> What is the id used for? I can understand why you need to know what
>>>> power domain a device is in (as power-domains identifies), but not
>>>> what devices are in a power domain.
>>>
>>> We have a system control processor that provides power management
>>> services to the OS and it responsible for handling the power state of
>>> each device. This control happens over a communication interface we have
>>> called TI SCI (implemented at drivers/firmware/ti-sci.c). The
>>> communication protocol uses these ids to identify each device within the
>>> power domain so that the control processor can do what is necessary to
>>> enable that device.
>>
>> I think a minor detail here that Rob might be missing right now is,
>> that the ti,sci-id is only controlling the PM runtime handling, and
>> providing the ID per-device for this purpose only. AFAIK, it is not
>> really connected to the power domain anymore as such, as we don't have
>> power-domains / per device anymore as was the case in some earlier
>> revision of this work.
>
> I think this gets to the heart of things.  IMO The confusion arises
> because we're throwing around the term "power domain" when there isn't
> an actual hardware power domain here.

I thought there was 1.

> Unfortunately, the genpd bindings have used the terminology power-domain
> when in fact genpd is more generic than that and can be used not just
> for hardware power domains, but for arbitrary grouping of devices that
> have common PM properties.  That's why genpd actually stands for generic
> PM domain, not power domain.  Unfortunately, the bindings have grown
> primarily out of the usage for hardware power domains.

Now it makes some sense.

So the question is does this PM domain grouping need to be described
in DT or not, and if so what does that look like?

We could continue to use the power domain binding (maybe we already
are and that ship has sailed). I'm not totally against the idea even
if there is no power domain, but I'm not sold on it either. If we do
go this route, then I still say the id should be a cell in the
power-domain phandle.

Another option is create something new either common or TI SCI
specific. It could be just a table of ids and phandles in the SCI
node. I'm much more comfortable with an isolated property in one node
than something scattered throughout the DT.

>> One could argue though that the whole usage of power-domains is now
>> moot, as we basically only have implemented one genpd in the whole
>> SoC, which doesn't really reflect the reality. I wonder if better
>> approach would be to have this replaced with proper power domains at
>> some point (if needed), and just have a runtime-pm implementation in
>> place for the devices that require it.
>>
>> So, as an example in DT, we would only have:
>>
>> uart0: serial@02530c00 {
>>   compatible = "xyz";
>>   ...
>>   ti,sci-id = <K2G_DEV_UART0>;
>> };
>>
>> This is somewhat analogous to what OMAP family of SoCs have in place
>> now, under "ti,hwmods" property. I also wonder if the "ti,sci-id"
>> should be replaced with something like "ti,sci-dev-id" to make its
>> purpose clearer.
>
> Unless I'm missing something, that still begs the question of who reads
> that property and takes care of the call into TI-SCI though.
>
> Kevin
