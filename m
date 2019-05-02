From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH v3 3/4] Documentation: devicetree: add PPMU events
 description
Date: Thu, 2 May 2019 10:52:25 +0200
Message-ID: <1fd44623-4a59-f014-1ae9-a7cc605ad30f@partner.samsung.com>
References: <1555681688-19643-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190419134822eucas1p29c6eff0f500311749b33c4f556123cf0@eucas1p2.samsung.com>
        <1555681688-19643-4-git-send-email-l.luba@partner.samsung.com>
        <20190430223629.GA22317@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190430223629.GA22317@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com, krzk@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, myungjoo.ham@samsung.com, kgene@kernel.org, willy.mh.wolff.ml@gmail.com
List-Id: linux-pm@vger.kernel.org

Hi Rob,

On 5/1/19 12:36 AM, Rob Herring wrote:
> On Fri, Apr 19, 2019 at 03:48:07PM +0200, Lukasz Luba wrote:
>> Extend the documenation by events description with new 'event-data-type'
>> field. Add example how the event might be defined in DT.
> 
> Why do we need event types in DT? We don't do this for other h/w such as
> ARM PMU.
In ARM PMU all the events are hard-coded into the driver code i.e. in v7
arch/arm/kernel/perf_event_v7.c
and are seen from perf. They are different type and for different
purpose. The Ecynos PPMU events are not seen in perf, they are
for internal monitoring and must not be reset by other actors like perf.
They are used by the 'bus drivers' to made some heuristics and tune the
internal settings, like frequency.

Chanwoo has written PPMU driver which relies on DT definition.
The DT events are used by other DT devices by phandle.
In Exynos 5x SoCs we have many 'bus devices' which use events to
monitor their usage and react accordingly.
---------------8<------------------------
[    4.140923] exynos-bus: new bus device registered: soc:bus_wcore ( 
84000 KHz ~ 400000 KHz)
[    4.149179] exynos-bus: new bus device registered: soc:bus_noc ( 
67000 KHz ~ 100000 KHz)
[    4.156825] exynos-bus: new bus device registered: soc:bus_fsys_apb 
(100000 KHz ~ 200000 KHz)
[    4.165071] exynos-bus: new bus device registered: soc:bus_fsys 
(100000 KHz ~ 200000 KHz)
[    4.173577] exynos-bus: new bus device registered: soc:bus_fsys2 ( 
75000 KHz ~ 150000 KHz)
[    4.182141] exynos-bus: new bus device registered: soc:bus_mfc ( 
96000 KHz ~ 333000 KHz)
[    4.190099] exynos-bus: new bus device registered: soc:bus_gen ( 
89000 KHz ~ 267000 KHz)
[    4.197953] exynos-bus: new bus device registered: soc:bus_peri ( 
67000 KHz ~  67000 KHz)
[    4.206523] exynos-bus: new bus device registered: soc:bus_g2d ( 
84000 KHz ~ 333000 KHz)
[    4.214516] exynos-bus: new bus device registered: soc:bus_g2d_acp ( 
67000 KHz ~ 267000 KHz)
[    4.222850] exynos-bus: new bus device registered: soc:bus_jpeg ( 
75000 KHz ~ 300000 KHz)
[    4.231052] exynos-bus: new bus device registered: soc:bus_jpeg_apb ( 
84000 KHz ~ 167000 KHz)
[    4.239202] exynos-bus: new bus device registered: soc:bus_disp1_fimd 
(120000 KHz ~ 200000 KHz)
[    4.248033] exynos-bus: new bus device registered: soc:bus_disp1 
(120000 KHz ~ 300000 KHz)
[    4.256304] exynos-bus: new bus device registered: 
soc:bus_gscl_scaler (150000 KHz ~ 300000 KHz)
[    4.265397] exynos-bus: new bus device registered: soc:bus_mscl ( 
84000 KHz ~ 400000 KHz)
-------------------------->8----------------------------------------
The PPMU driver made some assumption, though. It always monitors only
'read+write data bytes' as an event data type.
Thus, it is not possible to monitor other stuff and maybe improve the
heuristics.

This simple modification allows to define different data type, which is
acquired by the counter, still being compatible with all the Exynos
drivers in the existing implementation.

Regards,
Lukasz

> 
>>
>> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
>> ---
>>   .../devicetree/bindings/devfreq/event/exynos-ppmu.txt  | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> index 3e36c1d..47feb5f 100644
>> --- a/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> +++ b/Documentation/devicetree/bindings/devfreq/event/exynos-ppmu.txt
>> @@ -145,3 +145,21 @@ Example3 : PPMUv2 nodes in exynos5433.dtsi are listed below.
>>   			reg = <0x104d0000 0x2000>;
>>   			status = "disabled";
>>   		};
>> +
>> +The 'event' type specified in the PPMU node defines 'event-name'
>> +which also contains 'id' number and optionally 'event-data-type'.
>> +
>> +Example:
>> +
>> +		events {
>> +			ppmu_leftbus_0: ppmu-event0-leftbus {
>> +				event-name = "ppmu-event0-leftbus";
>> +				event-data-type = <PPMU_RO_DATA_CNT>;
>> +			};
>> +		};
>> +
>> +The 'event-data-type' defines the type of data which shell be counted
>> +by the counter. You can check include/dt-bindings/pmu/exynos_ppmu.h for
>> +all possible type, i.e. count read requests, count write data in bytes,
>> +etc. This field is optional and when it is missing, the driver code will
>> +use default data type.
>> -- 
>> 2.7.4
>>
> 
> 
