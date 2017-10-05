From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 21/22] cpufreq: add support for CPU DVFS based on SCMI
 message protocol
Date: Thu, 5 Oct 2017 12:26:14 +0100
Message-ID: <d7aa31d7-f68a-b81a-05fe-75d42cf88ed0@arm.com>
References: <1506604306-20739-1-git-send-email-sudeep.holla@arm.com>
 <1506604306-20739-22-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a3pAFKM+Dq_yb7KYhB+xeneVuODBq_4nacEuw9creT6Yw@mail.gmail.com>
 <5efbd0a7-8b62-5b30-98e6-dfaff64e2628@arm.com>
 <CAK8P3a18i-=6PE2WAZ5LkYHty5CrVjMhTF_qJjtGGE3aCxLOuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a18i-=6PE2WAZ5LkYHty5CrVjMhTF_qJjtGGE3aCxLOuw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, ALKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Roy Franz <roy.franz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Harb Abdulhamid <harba-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Loc Ho <lho-qTEPVZfXA3Y@public.gmane.org>, Alexey Klimov <alexey.klimov-5wv7dgnIgG8@public.gmane.org>, Ryan Harkin <Ryan.Harkin-5wv7dgnIgG8@public.gmane.org>, Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 05/10/17 12:20, Arnd Bergmann wrote:
> On Wed, Oct 4, 2017 at 5:01 PM, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org> wrote:
>>>> +
>>>> +static struct platform_driver scmi_cpufreq_platdrv = {
>>>> +       .driver = {
>>>> +               .name   = "scmi-cpufreq",
>>>> +       },
>>>> +       .probe          = scmi_cpufreq_probe,
>>>> +       .remove         = scmi_cpufreq_remove,
>>>> +};
>>>
>>> You appear to have split this driver into the 'cpufreq' side and
>>> the 'protocol' handler in a different file. I already commented that
>>> the way the main scmi driver knows about all the protocols looks
>>> bad, here we can see another aspect of the same problem.
>>>
>>> Rather than manually register a platform_device for the purpose
>>> of connecting it to the cpufreq driver, there should be a way
>>> to dynamically register the protocol from the cpufreq driver
>>> and then have both in the same file.
>>>
>>
>> I agree that should be possible. I took this approach for 2 reasons:
>>
>> 1. to avoid all sorts of probe ordering issues
>> 2. we may have system with multiple instances of SCMI. E.g. a system
>>    may have multiple remote processors, each controlling dvfs/power mgmt
>>    of a subset of CPUs/devices controller in OS.
>>
>> I have to admit that I haven't thought too much in details yet. That's
>> the main idea behind scmi_handle and restricting access to that only to
>> sub-nodes in it. I am open to suggestions.
> 
> How about introducing a separate bus_type for protocols?
> The platform_device you use here isn't really the best abstraction,
> and with a new bus_type, you can handle multiple instances of
> scmi as well as decoupling them from the protocol drivers.
> 

Yes based on some discussion on this thread yesterday, I started
exploring and seem to have come to same conclusions. I will try to hack
and see how that evolves. Thanks for the suggestion.

-- 
Regards,
Sudeep
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
