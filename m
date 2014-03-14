From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 8/8] devfreq: exynos4: Add busfreq driver for
 exynos4210/exynos4x12
Date: Fri, 14 Mar 2014 19:56:13 +0900
Message-ID: <5322E04D.2060801@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-9-git-send-email-cw00.choi@samsung.com>
 <20140313175308.GE25870@e106331-lin.cambridge.arm.com>
 <5322AC5D.9070200@samsung.com>
 <20140314103552.GK25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <20140314103552.GK25870@e106331-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "nm@ti.com" <nm@ti.com>, "b.zolnierkie@samsaung.com" <b.zolnierkie@samsaung.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 03/14/2014 07:35 PM, Mark Rutland wrote:
> On Fri, Mar 14, 2014 at 07:14:37AM +0000, Chanwoo Choi wrote:
>> Hi Mark,
>>
>> On 03/14/2014 02:53 AM, Mark Rutland wrote:
>>> On Thu, Mar 13, 2014 at 08:17:29AM +0000, Chanwoo Choi wrote:
>>>> This patch add busfreq driver for Exynos4210/Exynos4x12 memory interface
>>>> and bus to support DVFS(Dynamic Voltage Frequency Scaling) according to PPMU
>>>> counters. PPMU (Performance Profiling Monitorings Units) of Exynos4 SoC provides
>>>> PPMU counters for DMC(Dynamic Memory Controller) to check memory bus utilization
>>>> and then busfreq driver adjusts dynamically the operating frequency/voltage
>>>> by using DEVFREQ Subsystem.
>>>>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  .../devicetree/bindings/devfreq/exynos4_bus.txt    | 49 ++++++++++++++++++++++
>>>>  1 file changed, 49 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>> new file mode 100644
>>>> index 0000000..2a83fcc
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>>> @@ -0,0 +1,49 @@
>>>> +
>>>> +Exynos4210/4x12 busfreq driver
>>>> +-----------------------------
>>>> +
>>>> +Exynos4210/4x12 Soc busfreq driver with devfreq for Memory bus frequency/voltage
>>>> +scaling according to PPMU counters of memory controllers
>>>> +
>>>> +Required properties:
>>>> +- compatible	: should contain Exynos4 SoC type as follwoing:
>>>> +		  - "samsung,exynos4x12-busfreq" for Exynos4x12
>>>> +		  - "samsung,exynos4210-busfreq" for Exynos4210
>>>
>>> Is there a device called "busfreq"? What device does this binding
>>> describe?
>>
>> I'll add detailed description of busfreq as following:
>>
>> "busfreq(bus frequendcy)" driver means that busfreq driver control dynamically
>> memory bus frequency/voltage by checking memory bus utilization to optimize
>> power-consumption. When checking memeory bus utilization, exynos4_busfreq driver
>> would use PPMU(Performance Profiling Monitoring Units).
> 
> This still sounds like a description of the _driver_, not the _device_.
> The binding should describe the hardware, now the high level abstraction
> that software is going to build atop of it.
> 
> It sounds like this is a binding for the DMC PPMU?
> 
> Is the PPMU a component of the DMC, or is it bolted on the side?

PPMU(Performance Profiling Monitoring Unit) is to profile performance event of
various IP on Exynos4. Each PPMU provide perforamnce event for each IP.
We can check various PPMU as following:

PPMU_3D
PPMU_ACP
PPMU_CAMIF
PPMU_CPU
PPMU_DMC0
PPMU_DMC1
PPMU_FSYS
PPMU_IMAGE
PPMU_LCD0
PPMU_LCD1
PPMU_MFC_L
PPMU_MFC_R
PPMU_TV
PPMU_LEFT_BUS
PPMU_RIGHT_BUS

DMC (Dynamic Memory Controller) control the operation of DRAM in Exynos4 SoC.
If we need to get memory bust utilization of DMC, we can get memory bus utilization
from PPMU_DMC0/PPMU_DMC1.

So, Exynos4's busfreq used two(PPMU_DMC0/PPMU_DMC1) among upper various PPMU list.

> 
>>
>>
>>>
>>>> +- reg		: offset and length of the ppmudmc0/1
>>>> +		  - PPMU (Performance Profiling Monitoring Units)
>>>
>>> You seem to require a particular order here. It would be good to be
>>> explicit about it.
>>
>> OK, I'll modify it as following:
>> the offset and length of the PPMU_DMC0 / PPMU_DMC1
>> PPMU_DMC0/PPMU_DMC1 show memory buy utilization to exynos4_bus driver.
>>
>>>
>>>> +		  : It is to profile performance event of DMC(Dynamic Memory
>>>> +		  Controller) So, exynos4_bus.c can check memory bus utilization
>>>> +		  by using PPMU of Exynos4 SoC.
>>>
>>> This is superfluous, and Linux-specific. The binding document shouldn't
>>> need to refer to drivers.
>>
>> I'll remove this description.
>>
>>>
>>>> +- clocks	: clock number of ppmudmc0/1
>>>> +- clock-names	: clock name of ppmudmc0/1
>>>
>>> Are these two clocks, or one clock with a slash in the name?
>>>
>>> Please list each name separately.
>>
>> I'll expalin clocks as following:
>> 	"ppmudmc0", "ppmudmc1"
>>
>>>
>>>> +- vdd_int-supply: regulator for interface block of Exynos4
> 
> How does the interface block relate to the DMC / PPMU?

If vdd_int is connected to buck3 of PMIC(Power Management IC),

We can see the flow of provided power as following:
: external power --> buck3 pin of PMIC --> vdd_int pin of Exynos4 SoC --> DMC IP and PPMU IP of Exynos4 SoC

Thanks,
Chanwoo Choi
