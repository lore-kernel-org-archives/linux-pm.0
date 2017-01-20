From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Fri, 20 Jan 2017 15:00:02 +0100
Message-ID: <CAPDyKFqzs59N5bc89X-96Fgy9b=_+s8zYmHHshQeDrJCnaqprA@mail.gmail.com>
References: <20170104205536.15963-1-d-gerlach@ti.com> <20170104205536.15963-3-d-gerlach@ti.com>
 <20170109175012.sg7eze7llqq7qevd@rob-hp-laptop> <7bd282d9-df6f-f4c6-1f7f-c8ed81c78af3@ti.com>
 <CAL_JsqKxU4c=KSn0=xX9kmbk498fhqpiXMeGjcoe8Ah48FAzUg@mail.gmail.com>
 <3bb89649-fd2a-acc6-6968-e54a00842ce2@ti.com> <CAL_JsqL+L1oHAOv7tLevzbtRFSKRs9J01SgF=HR_vNNqNV+4+Q@mail.gmail.com>
 <84d7d49b-933b-8b26-f18a-3a5054738cb1@ti.com> <CAL_JsqJ9RitNC7ihC8ckJgV+49kaHk=W9tgdNBSjEfydhQS46A@mail.gmail.com>
 <0eaa9914-83f1-7716-cf04-1e3dd44df647@ti.com> <4cb25cf9-216f-2e18-f45d-ef7e48fa6c5e@ti.com>
 <m2ziip2puf.fsf@baylibre.com> <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_Jsq+Vp8iYrAUmuSRzeeY_G6CUqFqG6XB6erDxo1RYo3g4=g@mail.gmail.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

+ Sudeep

On 19 January 2017 at 00:03, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 17, 2017 at 6:07 PM, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> wrote:
>> Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> writes:
>>> On 17/01/17 00:12, Dave Gerlach wrote:
>>>> On 01/13/2017 08:40 PM, Rob Herring wrote:
>>>>> On Fri, Jan 13, 2017 at 2:28 PM, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> wrote:
>
> [...]
>
>>>>>> My ti,sci-id is not an index into a list of power domains, so it
>>>>>> should not
>>>>>> go in the power-domains cells and go against what the power-domains
>>>>>> binding
>>>>>> says that the cell expects. We have one single power domain, and the new
>>>>>> ti,sci-id binding is not something the genpd framework itself is
>>>>>> concerned
>>>>>> with as it's our property to identify a device inside a power domain,
>>>>>> not to
>>>>>> identify which power domain it is associated with.
>>>>>
>>>>> What is the id used for? I can understand why you need to know what
>>>>> power domain a device is in (as power-domains identifies), but not
>>>>> what devices are in a power domain.
>>>>
>>>> We have a system control processor that provides power management
>>>> services to the OS and it responsible for handling the power state of
>>>> each device. This control happens over a communication interface we have
>>>> called TI SCI (implemented at drivers/firmware/ti-sci.c). The
>>>> communication protocol uses these ids to identify each device within the
>>>> power domain so that the control processor can do what is necessary to
>>>> enable that device.
>>>
>>> I think a minor detail here that Rob might be missing right now is,
>>> that the ti,sci-id is only controlling the PM runtime handling, and
>>> providing the ID per-device for this purpose only. AFAIK, it is not
>>> really connected to the power domain anymore as such, as we don't have
>>> power-domains / per device anymore as was the case in some earlier
>>> revision of this work.
>>
>> I think this gets to the heart of things.  IMO The confusion arises
>> because we're throwing around the term "power domain" when there isn't
>> an actual hardware power domain here.
>
> I thought there was 1.
>
>> Unfortunately, the genpd bindings have used the terminology power-domain
>> when in fact genpd is more generic than that and can be used not just
>> for hardware power domains, but for arbitrary grouping of devices that
>> have common PM properties.  That's why genpd actually stands for generic
>> PM domain, not power domain.  Unfortunately, the bindings have grown
>> primarily out of the usage for hardware power domains.
>
> Now it makes some sense.
>
> So the question is does this PM domain grouping need to be described
> in DT or not, and if so what does that look like?

Yes, it's needed and already being done. For example, we have clock
domains for several Renesas platforms.

>
> We could continue to use the power domain binding (maybe we already
> are and that ship has sailed). I'm not totally against the idea even
> if there is no power domain, but I'm not sold on it either. If we do
> go this route, then I still say the id should be a cell in the
> power-domain phandle.
>
> Another option is create something new either common or TI SCI
> specific. It could be just a table of ids and phandles in the SCI
> node. I'm much more comfortable with an isolated property in one node
> than something scattered throughout the DT.

To me, this seems like the best possible solution.

However, perhaps we should also consider the SCPI Generic power domain
(drivers/firmware/scpi_pm_domain.c), because I believe it's closely
related.
To change the power state of a device, this PM domain calls
scpi_device_set|get_power_state() (drivers/firmware/arm_scpi.c), which
also needs a device id as a parameter. Very similar to our case with
the TI SCI domain.

Currently these SCPI device ids lacks corresponding DT bindings, so
the scpi_pm_domain tries to work around it by assigning ids
dynamically at genpd creation time.

That makes me wonder, whether we should think of something common/generic?

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
