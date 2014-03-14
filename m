From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv2 8/8] devfreq: exynos4: Add busfreq driver for
 exynos4210/exynos4x12
Date: Fri, 14 Mar 2014 16:14:37 +0900
Message-ID: <5322AC5D.9070200@samsung.com>
References: <1394698649-20996-1-git-send-email-cw00.choi@samsung.com>
 <1394698649-20996-9-git-send-email-cw00.choi@samsung.com>
 <20140313175308.GE25870@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140313175308.GE25870@e106331-lin.cambridge.arm.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "kyungmin.park@samsung.com" <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "nm@ti.com" <nm@ti.com>, "b.zolnierkie@samsaung.com" <b.zolnierkie@samsaung.com>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Mark,

On 03/14/2014 02:53 AM, Mark Rutland wrote:
> On Thu, Mar 13, 2014 at 08:17:29AM +0000, Chanwoo Choi wrote:
>> This patch add busfreq driver for Exynos4210/Exynos4x12 memory interface
>> and bus to support DVFS(Dynamic Voltage Frequency Scaling) according to PPMU
>> counters. PPMU (Performance Profiling Monitorings Units) of Exynos4 SoC provides
>> PPMU counters for DMC(Dynamic Memory Controller) to check memory bus utilization
>> and then busfreq driver adjusts dynamically the operating frequency/voltage
>> by using DEVFREQ Subsystem.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/devfreq/exynos4_bus.txt    | 49 ++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>> new file mode 100644
>> index 0000000..2a83fcc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/devfreq/exynos4_bus.txt
>> @@ -0,0 +1,49 @@
>> +
>> +Exynos4210/4x12 busfreq driver
>> +-----------------------------
>> +
>> +Exynos4210/4x12 Soc busfreq driver with devfreq for Memory bus frequency/voltage
>> +scaling according to PPMU counters of memory controllers
>> +
>> +Required properties:
>> +- compatible	: should contain Exynos4 SoC type as follwoing:
>> +		  - "samsung,exynos4x12-busfreq" for Exynos4x12
>> +		  - "samsung,exynos4210-busfreq" for Exynos4210
> 
> Is there a device called "busfreq"? What device does this binding
> describe?

I'll add detailed description of busfreq as following:

"busfreq(bus frequendcy)" driver means that busfreq driver control dynamically
memory bus frequency/voltage by checking memory bus utilization to optimize
power-consumption. When checking memeory bus utilization, exynos4_busfreq driver
would use PPMU(Performance Profiling Monitoring Units).


> 
>> +- reg		: offset and length of the ppmudmc0/1
>> +		  - PPMU (Performance Profiling Monitoring Units)
> 
> You seem to require a particular order here. It would be good to be
> explicit about it.

OK, I'll modify it as following:
the offset and length of the PPMU_DMC0 / PPMU_DMC1
PPMU_DMC0/PPMU_DMC1 show memory buy utilization to exynos4_bus driver.

> 
>> +		  : It is to profile performance event of DMC(Dynamic Memory
>> +		  Controller) So, exynos4_bus.c can check memory bus utilization
>> +		  by using PPMU of Exynos4 SoC.
> 
> This is superfluous, and Linux-specific. The binding document shouldn't
> need to refer to drivers.

I'll remove this description.

> 
>> +- clocks	: clock number of ppmudmc0/1
>> +- clock-names	: clock name of ppmudmc0/1
> 
> Are these two clocks, or one clock with a slash in the name?
> 
> Please list each name separately.

I'll expalin clocks as following:
	"ppmudmc0", "ppmudmc1"

> 
>> +- vdd_int-supply: regulator for interface block of Exynos4
>> +
>> +Optional properties:
>> +- vdd_mif-supply: regulator for DMC block of Exynos4x12 if Exynos4x12 Soc
>> +- regs-name	: register name of ppmudmc0/1
> 
> This is completely nonstandard. Did you mean reg-names?

I'll remove it about 'regs-name'.

> 
> Please be explicit about the names you expect. Write them in full,
> quoted, and describe the relationship to the reg property.
> 
>> +
>> +All the required listed above must be defined under code busfreq with devfreq
> 
> I'm having some difficulty figuring out what exactly this is intended to
> mean.

I'll add detailed opeation method and role of exynos4_busfreq driver.

Thanks,
Chanwoo Choi
