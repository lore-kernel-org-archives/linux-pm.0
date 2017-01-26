From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: Add TI SCI PM Domains
Date: Thu, 26 Jan 2017 09:09:35 -0600
Message-ID: <fec2e1b2-df90-e9ba-4925-ecdc12d696b9@ti.com>
References: <20170104205536.15963-1-d-gerlach@ti.com>
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
 <ec2f1697-4c60-fd88-6593-2a69ca7f5c83@ti.com>
 <CAPDyKFq3zjyubxf3wc1V+F2W3rbnjj4ObFnHFvda+wCs4rBtnw@mail.gmail.com>
 <23936395-d653-56c8-13f9-6dfeb6e9257b@ti.com>
 <CAL_Jsq+9oEJJtHC4Gp_mWy_wJMLXsv2jgqKCMK8jm1MSWT-LRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+9oEJJtHC4Gp_mWy_wJMLXsv2jgqKCMK8jm1MSWT-LRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Tero Kristo <t-kristo@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Keerthy <j-keerthy@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Sudeep Holla <sudeep.holla@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-pm@vger.kernel.org

On 01/25/2017 04:32 PM, Rob Herring wrote:
> On Wed, Jan 25, 2017 at 10:59 AM, Dave Gerlach <d-gerlach@ti.com> wrote:
>> On 01/24/2017 04:03 AM, Ulf Hansson wrote:
>>>
>>> On 23 January 2017 at 21:11, Dave Gerlach <d-gerlach@ti.com> wrote:
>>>>
>>>> On 01/20/2017 10:52 AM, Ulf Hansson wrote:
>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>>> Another option is create something new either common or TI SCI
>>>>>>>> specific. It could be just a table of ids and phandles in the SCI
>>>>>>>> node. I'm much more comfortable with an isolated property in one node
>>>>>>>> than something scattered throughout the DT.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> To me, this seems like the best possible solution.
>>>>>>>
>>>>>>> However, perhaps we should also consider the SCPI Generic power domain
>>>>>>> (drivers/firmware/scpi_pm_domain.c), because I believe it's closely
>>>>>>> related.
>>>>>>> To change the power state of a device, this PM domain calls
>>>>>>> scpi_device_set|get_power_state() (drivers/firmware/arm_scpi.c), which
>>>>>>> also needs a device id as a parameter. Very similar to our case with
>>>>>>> the TI SCI domain.
>>>>>>>
>>>>>>> Currently these SCPI device ids lacks corresponding DT bindings, so
>>>>>>> the scpi_pm_domain tries to work around it by assigning ids
>>>>>>> dynamically at genpd creation time.
>>>>>>>
>>>>>>> That makes me wonder, whether we should think of something
>>>>>>> common/generic?
>>>>>>
>>>>>>
>>>>>>
>>>>>> When you say something common/generic, do you mean a better binding for
>>>>>> genpd,
>>>>>> or something bigger than that like a new driver? Because I do think a
>>>>>> phandle
>>>>>> cell left open for the genpd provider to interpret solves both the scpi
>>>>>> and
>>>>>> ti-sci problem we are facing here in the best way. Using generic PM
>>>>>> domains lets
>>>>>> us do exactly what we want apart from interpreting the phandle cell
>>>>>> with
>>>>>> our
>>>>>> driver, and I feel like anything else we try at this point is just
>>>>>> going
>>>>>> to be
>>>>>> to work around that. Is bringing back genpd xlate something we can
>>>>>> discuss?
>>>>>
>>>>>
>>>>>
>>>>> Bringing back xlate, how would that help? Wouldn't that just mean that
>>>>> you will get one genpd per device? That's not an option, I think we
>>>>> are all in agreement to that.
>>>>
>>>>
>>>>
>>>> Sure, perhaps the custom xlate wouldn't be the right way to do it, as we
>>>> wouldn't be able to associate a device directly to a phandle, at least
>>>> with
>>>> how it was implemented before, but I think we can skip that entirely.
>>>> Does
>>>> opening up the interpretation of the cells of the 'power-domains' phandle
>>>> not solve all of these issues? Is that out of the question?
>>>>
>>>> genpd_xlate_simple currently just makes sure the args_count of the
>>>> 'power-domains' phandle was zero and bails if it was not. Why couldn't we
>>>> remove this check and let the driver interpret it while still using
>>>> of_genpd_add_provider_simple to register the provider? It's still a
>>>> 'simple'
>>>> provider from the perspective of the genpd framework and the actual pm
>>>> domain mapping will not change, but now the driver can parse the cells
>>>> and
>>>> do whatever it needs to, such as reading a device id.
>>>>
>>>> I think that's a bit more flexible and will avoid breaking anything that
>>>> is
>>>> there today.
>>>
>>>
>>> Would you mind providing an example? Perhaps also some code snippets
>>> dealing with the parsing?
>>
>>
>> So again the goal of this is to move the ti,sci-id value back to
>> power-domains phandle instead of having a separate property, so that would
>> be step one in the DT. Then in the power-domains node change
>> #power-domain-cells to one. And then from there, the only change to the
>> genpd framework is this:
>
> I'd still like to understand how the ID is used in order to understand
> if as a power-domain cell is appropriate. I think the test is this: is
> the ID meaningful to (or defined by) the device or the power domain
> controller? The former should be a property in the device node. The
> latter should be phandle args.

The device itself doesn't care about the ID or ever need to know what it is. The 
power domain controller is the only user of the ID. The power domain controller 
needs the ID for a specific device to be able to turn it on, so during probe of 
each device the power-domain controller makes this association which is why I 
included it in each device node, so I think it fits as a phandle arg based on 
your test.

>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a5e1262b964b..b82e61f0bcfa 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1603,8 +1603,6 @@ static struct generic_pm_domain genpd_xlate_simple
>>                                       struct of_phandle_args *genpdspec,
>>                                       void *data)
>>  {
>> -       if (genpdspec->args_count != 0)
>> -               return ERR_PTR(-EINVAL);
>>         return data;
>>  }
>>
>>
>> because genpd_xlate_simple only checks that the phandle is zero so that it
>> can fail if it is not, but there's no functional reason it needs to do this.
>> The genpd framework works as it did before no matter what the cells are set
>> to if using of_genpd_add_provider_simple. Then in the attach_dev callback
>> inside the ti_sci_pm_domains driver instead of doing
>>
>>         ret = of_property_read_u32(np, "ti,sci-id", &idx);
>>
>> to read the ti,sc-id for a device into idx we can now do:
>>
>>        ret = of_parse_phandle_with_args(np, "power-domains",
>>                                    "#power-domain-cells", 0, &pd_args);
>>        idx = pd_args.args[0];
>>
>> or even simpler from within our driver
>>
>>         ret = of_property_read_u32_index(np, "power-domains", 1, &idx);
>
> This you should not be doing. The client driver shouldn't care how
> many cells or what their values are.

Client drivers in other places use xlate functions, like in the drivers/reset 
framework, to interpret the cells. Is doing it this way really that different?

Regards,
Dave

>
> Rob
>
