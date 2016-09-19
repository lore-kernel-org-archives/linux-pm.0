From: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 0/8] power: add power sequence library
Date: Mon, 19 Sep 2016 13:47:43 +0530
Message-ID: <364c3aa6-024a-1df5-3ae0-cab0535aae73@linaro.org>
References: <b1848eb2-9298-9089-ee4d-5356998c6c08@linaro.org>
 <20160824085335.GB27233@shlinux2> <20160829111045.GB3736@b29397-desktop>
 <3a45793f-18d9-0688-d2ab-ef79432c473c@linaro.org>
 <20160831095220.GA11938@b29397-desktop>
 <fd94340b-1c1d-2307-7e57-5b05f1655d2c@linaro.org>
 <20160902011046.GB11262@shlinux2>
 <eb032ff2-dac4-5efe-dda0-96404f290aa8@linaro.org>
 <CAPDyKFp0w0mBGNgu6uk7UevUka_ha6MvaVyOzXjCg3S8kdF7tg@mail.gmail.com>
 <ecbc3c0d-4ce7-758d-7f7d-4b3f3003c1ac@linaro.org>
 <20160919074637.GA10289@b29397-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160919074637.GA10289@b29397-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dwmw3-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, =?UTF-8?Q?Pawe=c5=82_Moll?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On Monday 19 September 2016 01:16 PM, Peter Chen wrote:
> On Mon, Sep 19, 2016 at 01:09:10PM +0530, Vaibhav Hiremath wrote:
>>
>> On Friday 09 September 2016 02:17 PM, Ulf Hansson wrote:
>>> [...]
>>>
>>>>>>> We had an agreement that keep mmc's pwrseq framework unchanging.
>>>>>>> Unless Ulf and rob both agree to change.
>>>>>> Why 2 separate approach for same problem ?
>>>>>> And I see this as possible duplication of code/functionality :)
>>>>> How the new kernel compatibles old dts? If we do not need to
>>>>> consider this problem, the mmc can try to use power sequence library
>>>>> too in future.
>>>> I think we should attempt to get both MMC and USB power seq
>>>> come on one agreement, so that it can be reused.
>>> That would be nice. Although, to do that you would have to allow some
>>> DT bindings to be deprecated in the new generic power seq bindings, as
>>> otherwise you would break existing DTBs.
>>>
>>> I guess that is what Rob was objecting to!?
>> yeah, thats right.
>>
>> So lets adopt similar implementation for USB as well instead of
>> library, but keeping MMC untouched as of now.
>>
>> What I am trying to propose here is,
>>
>> Lets have power-sequence framework (similar to V1 of this series),
>> with,
>>
>> pwrseq: Core framework for power sequence.
>> pwrseq_generic/simple: for all generic control, like reset and clock
>> pwrseq_emmc: probably duplication of existing code - the idea
>>                            here is, all future code should be using this new
>>                            binding, so that we can deprecate the
>> drivers/mmc/core/pwrseq
>> pwrseq_arche: The usecase which I am dealing with today, which is more
>>                           complex in nature.
>>
>> Then the respective drivers can add their drivers (if needed) based on
>> complexity.
>>
>> comments ??
> The key point here is DT maintainer (Rob) doesn't agree with adding new node
> for power sequence at dts.
>

Hmmm.
We haven't heard from Rob lately especially after introduction of complex
usecases. I hope he would revisit on above proposal.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
