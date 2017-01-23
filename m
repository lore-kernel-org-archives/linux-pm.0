From: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Mon, 23 Jan 2017 14:11:02 -0600
Message-ID: <ec2f1697-4c60-fd88-6593-2a69ca7f5c83@ti.com>
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
 <58821CA2.4050701@ti.com>
 <CAPDyKFpTyn2isNahywmOOSWiZKov9xsudyWi_i-FejXjC+1AZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpTyn2isNahywmOOSWiZKov9xsudyWi_i-FejXjC+1AZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lokesh Vutla <lokeshvutla-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/20/2017 10:52 AM, Ulf Hansson wrote:
> [...]
>
>>>> Another option is create something new either common or TI SCI
>>>> specific. It could be just a table of ids and phandles in the SCI
>>>> node. I'm much more comfortable with an isolated property in one node
>>>> than something scattered throughout the DT.
>>>
>>> To me, this seems like the best possible solution.
>>>
>>> However, perhaps we should also consider the SCPI Generic power domain
>>> (drivers/firmware/scpi_pm_domain.c), because I believe it's closely
>>> related.
>>> To change the power state of a device, this PM domain calls
>>> scpi_device_set|get_power_state() (drivers/firmware/arm_scpi.c), which
>>> also needs a device id as a parameter. Very similar to our case with
>>> the TI SCI domain.
>>>
>>> Currently these SCPI device ids lacks corresponding DT bindings, so
>>> the scpi_pm_domain tries to work around it by assigning ids
>>> dynamically at genpd creation time.
>>>
>>> That makes me wonder, whether we should think of something common/generic?
>>
>> When you say something common/generic, do you mean a better binding for genpd,
>> or something bigger than that like a new driver? Because I do think a phandle
>> cell left open for the genpd provider to interpret solves both the scpi and
>> ti-sci problem we are facing here in the best way. Using generic PM domains lets
>> us do exactly what we want apart from interpreting the phandle cell with our
>> driver, and I feel like anything else we try at this point is just going to be
>> to work around that. Is bringing back genpd xlate something we can discuss?
>
> Bringing back xlate, how would that help? Wouldn't that just mean that
> you will get one genpd per device? That's not an option, I think we
> are all in agreement to that.

Sure, perhaps the custom xlate wouldn't be the right way to do it, as we 
wouldn't be able to associate a device directly to a phandle, at least 
with how it was implemented before, but I think we can skip that 
entirely. Does opening up the interpretation of the cells of the 
'power-domains' phandle not solve all of these issues? Is that out of 
the question?

genpd_xlate_simple currently just makes sure the args_count of the 
'power-domains' phandle was zero and bails if it was not. Why couldn't 
we remove this check and let the driver interpret it while still using 
of_genpd_add_provider_simple to register the provider? It's still a 
'simple' provider from the perspective of the genpd framework and the 
actual pm domain mapping will not change, but now the driver can parse 
the cells and do whatever it needs to, such as reading a device id.

I think that's a bit more flexible and will avoid breaking anything that 
is there today.

Regards,
Dave

>
> Or am I missing something here?
>
> Regarding something "common/generic", I was merely thinking of some
> common bindings describing the list of phandle to device ids mapping.
> However, let's not make this more complicated than it is already. So
> please just ignore my suggestion so we can make this work for your
> case first.
>
> However, maybe I didn't fully understood Rob's suggestion. Perhaps Rob
> can clarify once more.
>
> Anyway, this is how interpreted Rob's suggestion:
>
> TISCI_PM_DOMAIN_DEVLIST: tisci-pm-domain-devlist {
>      devs = <&serial0>, <&mmc0>;
>      devids = <5 10>;
> }
>
> With this, you should be to extract the devid which corresponds to the
> device that has been attached to the TI SCI PM domain. Don't you
> think?
>
> Kind regards
> Uffe
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
