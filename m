From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Fri, 20 Jan 2017 08:20:18 -0600
Message-ID: <58821CA2.4050701@ti.com>
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
 <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com> <m2ziip2puf.fsf@baylibre.com>
 <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
 <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Keerthy <j-keerthy@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 01/20/2017 08:00 AM, Ulf Hansson wrote:
> + Sudeep
> 
> On 19 January 2017 at 00:03, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Jan 17, 2017 at 6:07 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>>> Tero Kristo <t-kristo@ti.com> writes:
>>>> On 17/01/17 00:12, Dave Gerlach wrote:
>>>>> On 01/13/2017 08:40 PM, Rob Herring wrote:
>>>>>> On Fri, Jan 13, 2017 at 2:28 PM, Dave Gerlach <d-gerlach@ti.com> wrote:
>>
>> [...]
>>
>>>>>>> My ti,sci-id is not an index into a list of power domains, so it
>>>>>>> should not
>>>>>>> go in the power-domains cells and go against what the power-domains
>>>>>>> binding
>>>>>>> says that the cell expects. We have one single power domain, and the new
>>>>>>> ti,sci-id binding is not something the genpd framework itself is
>>>>>>> concerned
>>>>>>> with as it's our property to identify a device inside a power domain,
>>>>>>> not to
>>>>>>> identify which power domain it is associated with.
>>>>>>
>>>>>> What is the id used for? I can understand why you need to know what
>>>>>> power domain a device is in (as power-domains identifies), but not
>>>>>> what devices are in a power domain.
>>>>>
>>>>> We have a system control processor that provides power management
>>>>> services to the OS and it responsible for handling the power state of
>>>>> each device. This control happens over a communication interface we have
>>>>> called TI SCI (implemented at drivers/firmware/ti-sci.c). The
>>>>> communication protocol uses these ids to identify each device within the
>>>>> power domain so that the control processor can do what is necessary to
>>>>> enable that device.
>>>>
>>>> I think a minor detail here that Rob might be missing right now is,
>>>> that the ti,sci-id is only controlling the PM runtime handling, and
>>>> providing the ID per-device for this purpose only. AFAIK, it is not
>>>> really connected to the power domain anymore as such, as we don't have
>>>> power-domains / per device anymore as was the case in some earlier
>>>> revision of this work.
>>>
>>> I think this gets to the heart of things.  IMO The confusion arises
>>> because we're throwing around the term "power domain" when there isn't
>>> an actual hardware power domain here.
>>
>> I thought there was 1.
>>
>>> Unfortunately, the genpd bindings have used the terminology power-domain
>>> when in fact genpd is more generic than that and can be used not just
>>> for hardware power domains, but for arbitrary grouping of devices that
>>> have common PM properties.  That's why genpd actually stands for generic
>>> PM domain, not power domain.  Unfortunately, the bindings have grown
>>> primarily out of the usage for hardware power domains.
>>
>> Now it makes some sense.
>>
>> So the question is does this PM domain grouping need to be described
>> in DT or not, and if so what does that look like?
> 
> Yes, it's needed and already being done. For example, we have clock
> domains for several Renesas platforms.
> 
>>
>> We could continue to use the power domain binding (maybe we already
>> are and that ship has sailed). I'm not totally against the idea even
>> if there is no power domain, but I'm not sold on it either. If we do
>> go this route, then I still say the id should be a cell in the
>> power-domain phandle.
>>
>> Another option is create something new either common or TI SCI
>> specific. It could be just a table of ids and phandles in the SCI
>> node. I'm much more comfortable with an isolated property in one node
>> than something scattered throughout the DT.
> 
> To me, this seems like the best possible solution.
> 
> However, perhaps we should also consider the SCPI Generic power domain
> (drivers/firmware/scpi_pm_domain.c), because I believe it's closely
> related.
> To change the power state of a device, this PM domain calls
> scpi_device_set|get_power_state() (drivers/firmware/arm_scpi.c), which
> also needs a device id as a parameter. Very similar to our case with
> the TI SCI domain.
> 
> Currently these SCPI device ids lacks corresponding DT bindings, so
> the scpi_pm_domain tries to work around it by assigning ids
> dynamically at genpd creation time.
> 
> That makes me wonder, whether we should think of something common/generic?

When you say something common/generic, do you mean a better binding for genpd,
or something bigger than that like a new driver? Because I do think a phandle
cell left open for the genpd provider to interpret solves both the scpi and
ti-sci problem we are facing here in the best way. Using generic PM domains lets
us do exactly what we want apart from interpreting the phandle cell with our
driver, and I feel like anything else we try at this point is just going to be
to work around that. Is bringing back genpd xlate something we can discuss?

Regards,
Dave

> 
> [...]
> 
> Kind regards
> Uffe
> 
