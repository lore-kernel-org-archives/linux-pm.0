From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Fri, 9 Feb 2018 13:14:45 +0100
Message-ID: <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33381 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeBIMOt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Feb 2018 07:14:49 -0500
Received: by mail-wm0-f43.google.com with SMTP id x4so3706731wmc.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Feb 2018 04:14:48 -0800 (PST)
In-Reply-To: <20180209092421.GL28462@vireshk-i7>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, linux-pm@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org, Punit.Agrawal@arm.com, ionela.voinescu@arm.com

On 09/02/2018 10:24, Viresh Kumar wrote:
> On 09-02-18, 10:15, Daniel Lezcano wrote:
>> On 09/02/2018 07:42, Viresh Kumar wrote:
>>> On 07-02-18, 11:45, Daniel Lezcano wrote:
>>>> Yes, that is my understanding. cooling-min-level and cooling-max-level
>>>> are not used in the thermal framework code today.
>>>
>>> Right.
>>>
>>>> So if they are defined, we should check the cooling-device max and min
>>>> are in the boundaries (if they are different from no-limit).
>>>
>>> Hmm, I am not sure. We do compare those values (from maps) with the
>>> max reported by the cooling driver, so there is some boundary check
>>> happening. And I don't think it is worth comparing the min/max values
>>> from DT cooling device's nodes. Why not just leave those for the
>>> driver to return (which is already happening btw).
>>>
>>> I don't think it would be correct for the thermal core to go and look
>>> at the min/max properties of the cooling device directly, as those are
>>> more for the thermal driver's help. The thermal core should just call
>>> the get_max_state() callback and that's it.
>>>
>>> Anyway, we can take decision on the binding itself after some time but
>>> I will send some patches to get rid of this property from CPU nodes
>>> for now. It doesn't make sense to have it there (anyway it is
>>> optional), as the cpu cooling devices are kind of virtual cooling
>>> devices which rely on OPP or freq-table currently. Maybe I will begin
>>> by just updating one platform and once that is merged, update
>>> everything else as well.
> 
> So I eventually updated everything as very small number of platforms
> were actually using it.
> 
> https://lkml.kernel.org/r/cover.1518166039.git.viresh.kumar@linaro.org

Yep, saw them.

>> What about the "cooling-cells" ? Its usage is unclear in the code and
>> I'm not sure it is really needed.
> 
> As I can see, it is actually used (sometimes a bit indirectly).

(yeah, that was the meaning of 'unclear')

> - This field is used to check if a device is a cooling device or not.
>   For example, the cpu-cooling device wouldn't be registered by the
>   cpufreq drivers unless this property is present in the CPU node. So
>   this is actually used.
>
> - This field (and its value) also comes into picture while parsing the
>   "cooling-maps". The "cooling-device" property in the map needs to
>   have "cooing-cells" + 1 fields. The first one is the cooling-device
>   phandle, followed by min/max states.

Right. The semantic is unclear. The expected cooling-cells value is
always 2 (the code ignore values greater than two and yell if it is less
than 2). And the cooling-device binding tells there are two states.

So the question is why do we need a cooling-cells as the information is
pointless here (always 2) ?

I see this field is artificially used to tell the cpufreq driver "please
register me as a cooling device". This is inconsistent from my pov.

Furthermore, the thermal-zone with the cooling device binds with the CPU
phandle, not the cooling-cells.

Putting apart the device binding changes discussion for the moment. Why
not register the cpufreq driver in all the cases and then drop
cooling-cells ? So when the opps are present, its registers in the
cpufreq->ready callback.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
