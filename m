From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Date: Wed, 8 May 2019 10:28:03 +0200
Message-ID: <d48d6629-f171-aae3-ba5a-ae4c13d29407@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
        <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
        <20190430223629.GA22317@bogus>
        <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
        <CAL_JsqJcm9Z6vYFHGyAZ+h3-kmSv6e=3NtO-fjJn3-QT0JoX+w@mail.gmail.com>
        <97277857-666d-7720-9d85-19120c977682@partner.samsung.com>
        <3d221027-292b-7d0d-2510-f230a81f4b52@partner.samsung.com>
        <CAL_Jsq+K-bdhTBnW5R4M0nDoikfFRdz-BeZf9Rf-hSmACj4B2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_Jsq+K-bdhTBnW5R4M0nDoikfFRdz-BeZf9Rf-hSmACj4B2w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kukjin Kim <kgene@kernel.org>, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 5/7/19 6:50 PM, Rob Herring wrote:
> On Tue, May 7, 2019 at 4:05 AM Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Rob,
>>
>> On 5/6/19 12:29 PM, Lukasz Luba wrote:
>>> Hi Rob,
>>>
>>> On 5/2/19 10:24 PM, Rob Herring wrote:
>>>> On Thu, May 2, 2019 at 3:52 AM Lukasz Luba
>>>> <l.luba@partner.samsung.com> wrote:
>>>>>
>>>>> Hi Rob,
>>>>>
>>>>> On 5/1/19 12:36 AM, Rob Herring wrote:
>>>>>> On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
>>>>>>> Extend the documenation by events description with new
>>>>>>> 'event-data-type'
>>>>>>> field. Add example how the event might be defined in DT.
>>>>>>
>>>>>> Why do we need event types in DT? We don't do this for other h/w
>>>>>> such as
>>>>>> ARM PMU.
>>>>> In ARM PMU all the events are hard-coded into the driver code i.e. in v7
>>>>> arch/arm/kernel/perf_event_v7.c
>>>>> and are seen from perf. They are different type and for different
>>>>> purpose. The Ecynos PPMU events are not seen in perf, they are
>>>>> for internal monitoring and must not be reset by other actors like perf.
>>>>> They are used by the 'bus drivers' to made some heuristics and tune the
>>>>> internal settings, like frequency.
>>>>>
>>>>> Chanwoo has written PPMU driver which relies on DT definition.
>>>>> The DT events are used by other DT devices by phandle.
>>>>
>>>> How is that done? I don't see anything in the binding for that.
>>> Here are the DT devices and how they are pinned together:
>>> - declared devfreq events:
>>> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412-ppmu-common.dtsi
>>>
>>> - devfreq events pinned to the bus device:
>>> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412-odroid-common.dtsi#L107
>>>
>>> - the bus device itself:
>>> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/exynos4412.dtsi#L457
>>>
>>>
>>> Regards,
>>> Lukasz
>>>
>>>>
>>>> Rob
>>>>
>>>>
>> Can I send the next version of the patch set, which has Chanwoo's
>> suggestions, or do you have some objections to this PPMU entries?
> 
> I think the existing binding which this is based on needs some
> changes, so it's pointless really for me to comment on additions.
Maybe the bindings description is not perfect, but it contains
examples which might help clarifying the idea.
Regarding the real value of the patch set, it is needed for some
research. Currently, the Odroid xu3/4 is the best 'mainline' platform
with big.LITTLE, has good performance and these counters.
Willy, who is doing his PhD, wants to experiment with it. I agree that
it could be better documented but it requires more effort.
I will extend the documentation it in my free time slots (it is not my
main task for now).

For now, I have received comments and parts of code from Chanwoo which
made the next patch set mature and ready to merge (IMHO).

If you have suggestions how to improve these bindings or links for good
examples, I would really appreciate. Thank you for your time and review.

Regards,
Lukasz
