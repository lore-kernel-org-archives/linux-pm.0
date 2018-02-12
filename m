From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Mon, 12 Feb 2018 10:52:13 +0100
Message-ID: <f361b9a0-08ac-9d19-76b2-83e67a6a2406@linaro.org>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
 <20180207102446.GS28462@vireshk-i7>
 <11fbba25-7029-8a13-476e-ea2f2de6fbf9@linaro.org>
 <20180209064211.GY28462@vireshk-i7>
 <539699c7-9509-dea2-2b31-c5f6749c99c4@linaro.org>
 <20180209092421.GL28462@vireshk-i7>
 <5722441d-c8be-4d29-fab7-28b4e5716961@linaro.org>
 <20180212061015.GO28462@vireshk-i7>
 <0b73e1aa-a88f-fe4b-b33a-0f589000e148@linaro.org>
 <20180212085242.GQ28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180212085242.GQ28462@vireshk-i7>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit.Agrawal-5wv7dgnIgG8@public.gmane.org, ionela.voinescu-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 12/02/2018 09:52, Viresh Kumar wrote:
> On 12-02-18, 09:39, Daniel Lezcano wrote:
>> On 12/02/2018 07:10, Viresh Kumar wrote:
>>> On 09-02-18, 13:14, Daniel Lezcano wrote:
>>>> Putting apart the device binding changes discussion for the moment. Why
>>>> not register the cpufreq driver in all the cases and then drop
>>>
>>> s/cpufreq driver/cpufreq cooling driver/ ??
>>
>> yes.
>>
>>>> cooling-cells ? So when the opps are present, its registers in the
>>>> cpufreq->ready callback.
>>>
>>> How will someone tell if they don't need the cooling infrastructure ?
>>> Specially for multiplatform thing.
>>
>> They don't define a cooling device in the DT ?
> 
> Sorry but I am getting a bit confused on what you are suggesting.
> Maybe you need to rephrase it once more for me, from the very
> beginning :)

Not sure it is worth to go further in the discussion. I realize the
*-cells is widely used everywhere. I was wondering if cooling-cells
still have a meaning if we remove the min|max-levels as it is always
two. But so far it is used as a cooling property for the device in any
case and removing it *is* inconsistent with the rest of the code.

Just to clarify my comment above, I understood you were asking how to
not use the cpu as a cooling device. As the binding between the cooling
device and the thermal zone happens when the DT nodes are the same, when
registering the cpufreq driver as a cooling device and when the
cooling-device registers itself at the cooling-map parsing time, if we
remove the cooling-device in the cooling-map, the binding never happens
thus the cpu is never used as a cooling device.  However, these are all
required fields, so the only way to do that is to remove the entire
thermal zone node, not sure it is what we want :)


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
