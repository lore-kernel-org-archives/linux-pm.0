From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 05/12] PM / devfreq: Add support for policy notifiers
Date: Wed, 01 Aug 2018 10:22:16 +0900
Message-ID: <5B610B48.4030802@samsung.com>
References: <20180703234705.227473-1-mka@chromium.org>
        <CGME20180703234900epcas1p1cda806bab6bbe69228ca5ee56bc33f36@epcas1p1.samsung.com>
        <20180703234705.227473-6-mka@chromium.org> <5B3C6C2A.1070205@samsung.com>
        <20180706175301.GG129942@google.com>
        <5399c191-e140-e2b8-629b-72ddfbf99b0f@samsung.com>
        <20180716175050.GZ129942@google.com> <20180731193953.GH68975@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180731193953.GH68975@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
List-Id: linux-pm@vger.kernel.org

On 2018년 08월 01일 04:39, Matthias Kaehlcke wrote:
> On Mon, Jul 16, 2018 at 10:50:50AM -0700, Matthias Kaehlcke wrote:
>> On Thu, Jul 12, 2018 at 05:44:33PM +0900, Chanwoo Choi wrote:
>>> Hi Matthias,
>>>
>>> On 2018년 07월 07일 02:53, Matthias Kaehlcke wrote:
>>>> Hi Chanwoo,
>>>>
>>>> On Wed, Jul 04, 2018 at 03:41:46PM +0900, Chanwoo Choi wrote:
>>>>
>>>>> Firstly,
>>>>> I'm not sure why devfreq needs the devfreq_verify_within_limits() function.
>>>>>
>>>>> devfreq already used the OPP interface as default. It means that
>>>>> the outside of 'drivers/devfreq' can disable/enable the frequency
>>>>> such as drivers/thermal/devfreq_cooling.c. Also, when some device
>>>>> drivers disable/enable the specific frequency, the devfreq core
>>>>> consider them.
>>>>>
>>>>> So, devfreq doesn't need to devfreq_verify_within_limits() because
>>>>> already support some interface to change the minimum/maximum frequency
>>>>> of devfreq device. 
>>>>>
>>>>> In case of cpufreq subsystem, cpufreq only provides 'cpufreq_verify_with_limits()'
>>>>> to change the minimum/maximum frequency of cpu. some device driver cannot
>>>>> change the minimum/maximum frequency through OPP interface.
>>>>>
>>>>> But, in case of devfreq subsystem, as I explained already, devfreq support
>>>>> the OPP interface as default way. devfreq subsystem doesn't need to add
>>>>> other way to change the minimum/maximum frequency.
>>>>
>>>> Using the OPP interface exclusively works as long as a
>>>> enabling/disabling of OPPs is limited to a single driver
>>>> (drivers/thermal/devfreq_cooling.c). When multiple drivers are
>>>> involved you need a way to resolve conflicts, that's the purpose of
>>>> devfreq_verify_within_limits(). Please let me know if there are
>>>> existing mechanisms for conflict resolution that I overlooked.
>>>>
>>>> Possibly drivers/thermal/devfreq_cooling.c could be migrated to use
>>>> devfreq_verify_within_limits() instead of the OPP interface if
>>>> desired, however this seems beyond the scope of this series.
>>>
>>> Actually, if we uses this approach, it doesn't support the multiple drivers too.
>>> If non throttler drivers uses devfreq_verify_within_limits(), the conflict
>>> happen.
>>
>> As long as drivers limit the max freq there is no conflict, the lowest
>> max freq wins. I expect this to be the usual case, apparently it
>> worked for cpufreq for 10+ years.
>>
>> However it is correct that there would be a conflict if a driver
>> requests a min freq that is higher than the max freq requested by
>> another. In this case devfreq_verify_within_limits() resolves the
>> conflict by raising p->max to the min freq. Not sure if this is
>> something that would ever occur in practice though.
>>
>> If we are really concerned about this case it would also be an option
>> to limit the adjustment to the max frequency.
>>
>>> To resolve the conflict for multiple device driver, maybe OPP interface
>>> have to support 'usage_count' such as clk_enable/disable().
>>
>> This would require supporting negative usage count values, since a OPP
>> should not be enabled if e.g. thermal enables it but the throttler
>> disabled it or viceversa.
>>
>> Theoretically there could also be conflicts, like one driver disabling
>> the higher OPPs and another the lower ones, with the outcome of all
>> OPPs being disabled, which would be a more drastic conflict resolution
>> than that of devfreq_verify_within_limits().
>>
>> Viresh, what do you think about an OPP usage count?
> 
> Ping, can we try to reach a conclusion on this or at least keep the
> discussion going?
> 
> Not that it matters, but my preferred solution continues to be
> devfreq_verify_within_limits(). It solves conflicts in some way (which
> could be adjusted if needed) and has proven to work in practice for
> 10+ years in a very similar sub-system.

It is not true. Current cpufreq subsystem doesn't support external OPP
control to enable/disable the OPP entry. If some device driver
controls the OPP entry of cpufreq driver with opp_disable/enable(),
the operation is not working. Because cpufreq considers the limit
through 'cpufreq_verify_with_limits()' only.

As I already commented[1], there is different between cpufreq and devfreq.
[1] https://lkml.org/lkml/2018/7/4/80

Already, subsystem already used OPP interface in order to control
specific OPP entry. I don't want to provide two outside method
to control the frequency of devfreq driver. It might make the confusion.

I want to use only OPP interface to enable/disable frequency
even if we have to modify the OPP interface.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
