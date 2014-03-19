From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2 8/8] devfreq: exynos4: Add busfreq driver for
 exynos4210/exynos4x12
Date: Wed, 19 Mar 2014 18:47:20 +0900
Message-ID: <532967A8.6030602@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-9-git-send-email-cw00.choi@samsung.com>
 <20140313175308.GE25870@e106331-lin.cambridge.arm.com>
 <5322AC5D.9070200@samsung.com>
 <20140314103552.GK25870@e106331-lin.cambridge.arm.com>
 <5322E04D.2060801@samsung.com> <53233DE7.2030902@samsung.com>
 <532685E0.6040405@samsung.com> <53286A6C.5090108@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <53286A6C.5090108-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "nm-l0cyMroinI0@public.gmane.org" <nm-l0cyMroinI0@public.gmane.org>, "b.zolnierkie-dV+d2yDoH2tWk0Htik3J/w@public.gmane.org" <b.zolnierkie-dV+d2yDoH2tWk0Htik3J/w@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Tomasz,

On 03/19/2014 12:46 AM, Tomasz Figa wrote:
> On 17.03.2014 06:19, Chanwoo Choi wrote:
>> Hi Tomasz,
>>
>> On 03/15/2014 02:35 AM, Tomasz Figa wrote:
>>> Hi Chanwoo, Mark,
>>>
>>> On 14.03.2014 11:56, Chanwoo Choi wrote:
>>>> Hi Mark,
>>>>
>>>> On 03/14/2014 07:35 PM, Mark Rutland wrote:
>>>>> On Fri, Mar 14, 2014 at 07:14:37AM +0000, Chanwoo Choi wrote:
>>>>>> Hi Mark,
>>>>>>
>>>>>> On 03/14/2014 02:53 AM, Mark Rutland wrote:
>>>>>>> On Thu, Mar 13, 2014 at 08:17:29AM +0000, Chanwoo Choi wrote:
>>>>>>>> This patch add busfreq driver for Exynos4210/Exynos4x12 memory interface
>>>>>>>> and bus to support DVFS(Dynamic Voltage Frequency Scaling) according to PPMU
>>>>>>>> counters. PPMU (Performance Profiling Monitorings Units) of Exynos4 SoC provides
>>>>>>>> PPMU counters for DMC(Dynamic Memory Controller) to check memory bus utilization
>>>>>>>> and then busfreq driver adjusts dynamically the operating frequency/voltage
>>>>>>>> by using DEVFREQ Subsystem.
>>>>>>>>
>>>>>>>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>>>>>>>> ---
>>>>>>>>    .../devicetree/bindings/devfreq/exynos4_bus.txt    | 49 ++++++++++++++++++++++
>>>>>>>>    1 file changed, 49 insertions(+)
>>>>>>>>    create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..2a83fcc
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>>>>>> @@ -0,0 +1,49 @@
>>>>>>>> +
>>>>>>>> +Exynos4210/4x12 busfreq driver
>>>>>>>> +-----------------------------
>>>>>>>> +
>>>>>>>> +Exynos4210/4x12 Soc busfreq driver with devfreq for Memory bus frequency/voltage
>>>>>>>> +scaling according to PPMU counters of memory controllers
>>>>>>>> +
>>>>>>>> +Required properties:
>>>>>>>> +- compatible    : should contain Exynos4 SoC type as follwoing:
>>>>>>>> +          - "samsung,exynos4x12-busfreq" for Exynos4x12
>>>>>>>> +          - "samsung,exynos4210-busfreq" for Exynos4210
>>>>>>>
>>>>>>> Is there a device called "busfreq"? What device does this binding
>>>>>>> describe?
>>>>>>
>>>>>> I'll add detailed description of busfreq as following:
>>>>>>
>>>>>> "busfreq(bus frequendcy)" driver means that busfreq driver control dynamically
>>>>>> memory bus frequency/voltage by checking memory bus utilization to optimize
>>>>>> power-consumption. When checking memeory bus utilization, exynos4_busfreq driver
>>>>>> would use PPMU(Performance Profiling Monitoring Units).
>>>>>
>>>>> This still sounds like a description of the _driver_, not the _device_.
>>>>> The binding should describe the hardware, now the high level abstraction
>>>>> that software is going to build atop of it.
>>>>>
>>>>> It sounds like this is a binding for the DMC PPMU?
>>>>>
>>>>> Is the PPMU a component of the DMC, or is it bolted on the side?
>>>>
>>>> PPMU(Performance Profiling Monitoring Unit) is to profile performance event of
>>>> various IP on Exynos4. Each PPMU provide perforamnce event for each IP.
>>>> We can check various PPMU as following:
>>>>
>>>> PPMU_3D
>>>> PPMU_ACP
>>>> PPMU_CAMIF
>>>> PPMU_CPU
>>>> PPMU_DMC0
>>>> PPMU_DMC1
>>>> PPMU_FSYS
>>>> PPMU_IMAGE
>>>> PPMU_LCD0
>>>> PPMU_LCD1
>>>> PPMU_MFC_L
>>>> PPMU_MFC_R
>>>> PPMU_TV
>>>> PPMU_LEFT_BUS
>>>> PPMU_RIGHT_BUS
>>>>
>>>> DMC (Dynamic Memory Controller) control the operation of DRAM in Exynos4 SoC.
>>>> If we need to get memory bust utilization of DMC, we can get memory bus utilization
>>>> from PPMU_DMC0/PPMU_DMC1.
>>>>
>>>> So, Exynos4's busfreq used two(PPMU_DMC0/PPMU_DMC1) among upper various PPMU list.
>>>
>>> Well, PPMUs and DMCs are separate hardware blocks found inside Exynos SoCs. Busfreq/devfreq is just a Linux-specific abstraction responsible for collecting data using PPMUs and controlling frequencies and voltages of appropriate power planes, vdd_int responsible for powering DMC0 and DMC1 blocks in this case.
>>>
>>
>> I knew already.
>>
>>> I'm afraid that the binding you're proposing is unfortunately incorrect, because it represents the software abstraction, not the real hardware.
>>
>> What is exactly incorrect part of this patch?
>>
> 
> Device tree contains information about hardware, not about OS-specific drivers or subsystems. Busfreq/devfreq is not a hardware block, but a Linux-specific driver, so it's not suitable to be described by DT directly, especially considering the fact that in future it might be replaced by or merged with another subsystem.
> 
> Only PPMUs are real hardware blocks present in the SoC. In addition, a SoC-level aspect of hardware description may be added, such as a list of power planes. See below for explanation.
> 

You means that PPMU must need separate framework from devfreq subsystem?
If PPMU framework will be implemented, PPMU framework provides API to external device driver
as common clk framework, regulator framework.
And then,exynos4 busfreq with devfreq have to use PPMU framework to monitor memory utilization.

Is this right?

>>>
>>> Instead, this should be separated into several independent bindings:
>>>
>>>   - PPMU bindings to list all the PPMU instances present in the SoC and resources they need,
>>>
>>>   - power plane bindings, which define a power plane in which multiple IP blocks might reside, can be monitored by one or more PPMU units and frequency and voltage of which can be configured according to determined performance level. Needed resources will be clocks and regulators to scale and probably also operating points.
>>>
>>> Then, exynos-busfreq driver should bind to such power planes, parse necessary data from DT (list of PPMUs and IP blocks, clocks, regulators and operating points) and register a devfreq entity.
>>
>> What is 'power plane'? I don't know 'power plane'.
> 
> Power plane is a part of the SoC (set of IP blocks and buses) that is powered by the same power source. For example in Exynos4412 a power plane would be VDD_ARM, containing 4 Cortex A9 cores, two L2 cache blocks, L2 cache controller, SCU, and several other blocks. Another example in Exynos4412 would be VDD_INT plane, which contains MFC, AudioSS, LCD0, ISP, TV, CAM and several other blocks.
> 
> In addition, such power plane might contain certain facilities, such as PPMU blocks, that let you estimate bus bandwidth utilization and scale certain performance and power parameters of such power plane, e.g. frequencies of internal buses and voltage of external regulator used to power it.
> 
>> If you suggest 'power plane' concept and then merge this concept to mainline,
>> After merged 'power plane' concept, I will apply 'power plane' concept to Exynos4's busfreq driver.
>>
>> I prefer to handle 'power plane' concept on other patchset for Exynos4's busfreq driver.
> 
> This is a necessary prerequisite for having Exynos busfreq facilities described properly in device tree. This is not a concept of high level generic framework, but just a concept of hardware description that can be parsed by Linux drivers, such as Exynos busfreq.
> 
> As I said above, a requirement is that DT does not describe Linux-specific internals, but the hardware that is used by them.
> 

exynos4 busfreq with devfreq must need to execute .probe().
So, exynos4 busfreq with devfreq should add dt node for exynos4 busfreq.
But,
You means that exynos4 busfreq can't add dt node of exynos4 busfreq
because this driver has not the hardware block. ?

Best Regards,
Chanwoo Choi

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
