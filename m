From: "dbasehore ." <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v5 3/4] DT/arm,gic-v3-its: add reset-on-suspend property
Date: Wed, 7 Feb 2018 18:59:38 -0800
Message-ID: <CAGAzgso=NqNmJtRHWxzxjtiXRtT7aBYcwGHMxGmEirMY5DkhJw@mail.gmail.com>
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-4-dbasehore@chromium.org> <b4c7bc62-6861-3851-513e-be8d7a440c91@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <b4c7bc62-6861-3851-513e-be8d7a440c91-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Soby Mathew <Soby.Mathew-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-pm mailing list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Wysocki, Rafael J" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 7, 2018 at 1:21 AM, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
> On 07/02/18 01:41, Derek Basehore wrote:
>> This adds documentation for the new reset-on-suspend property. This
>> property enables saving and restoring the ITS for when it loses state
>> in system suspend.
>>
>> Signed-off-by: Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> index 0a57f2f4167d..a470147d4f14 100644
>> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
>> @@ -78,6 +78,9 @@ These nodes must have the following properties:
>>  Optional:
>>  - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
>>    address and size of the pre-ITS window.
>> +- reset-on-suspend: Boolean property. Indicates that the ITS state is
>> +  reset on suspend. The state is then saved on suspend and restored on
>> +  resume.
>
> By whom? It is important to be clear about the respective
> responsibilities, as this forms a binding contract between firmware and OS.
>
> Mark: Can you have a look at how to formulate this? I'm not sure we have
> other instances of a non-architected behaviour involving FW
> participation, aside from PSCI.

I'll wait for Mark's reply to reword this.

>
>>
>>  The main GIC node must contain the appropriate #address-cells,
>>  #size-cells and ranges properties for the reg property of all ITS
>>
>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
