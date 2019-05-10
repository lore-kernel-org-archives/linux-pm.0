From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
 zone node
Date: Fri, 10 May 2019 09:16:32 +0200
Message-ID: <9fb2e306-38c7-2af7-5470-ff5bc4e23370@linaro.org>
References: <20190423022507.34969-1-andy.tang@nxp.com>
 <20190510031335.GD15856@dragon>
 <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB4333D24227603D1497BA3CB9F30C0@VI1PR04MB4333.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Tang <andy.tang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Leo Li <leoyang.li@nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 10/05/2019 05:40, Andy Tang wrote:
>> -----Original Message-----
>> From: Shawn Guo <shawnguo@kernel.org>
>> Sent: 2019Äê5ÔÂ10ÈÕ 11:14
>> To: Andy Tang <andy.tang@nxp.com>
>> Cc: Leo Li <leoyang.li@nxp.com>; robh+dt@kernel.org;
>> mark.rutland@arm.com; linux-arm-kernel@lists.infradead.org;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
>> linux-pm@vger.kernel.org; daniel.lezcano@linaro.org; rui.zhang@intel.com;
>> edubezval@gmail.com
>> Subject: [EXT] Re: [PATCH v6] arm64: dts: ls1088a: add one more thermal
>> zone node
>>
>> Caution: EXT Email
>>
>> On Tue, Apr 23, 2019 at 10:25:07AM +0800, Yuantian Tang wrote:
>>> Ls1088a has 2 thermal sensors, core cluster and SoC platform. Core
>>> cluster sensor is used to monitor the temperature of core and SoC
>>> platform is for platform. The current dts only support the first sensor.
>>> This patch adds the second sensor node to dts to enable it.
>>>
>>> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
>>> ---
>>> v6:
>>>         - add cooling device map to cpu0-7 in platform node.
> I like to explain a little. I think it makes sense that multiple thermal zone map to same cooling device. 
> In this way, no matter which thermal zone raises a temp alarm, it can call cooling device to chill out.
> I also asked cpufreq maintainer about the cooling map issue, he think it would be fine.
> I have tested and no issue found. 
> 
> Daniel, what's your thought?

If there are multiple thermal zones, they will be managed by different
instances of a thermal governor. Each instances will act on the shared
cooling device and will collide in their decisions:

 - If the sensors are closed, their behavior will be similar regarding
the temperature. The governors may take the same decision for the
cooling device. But in such case having just one thermal zone managed is
enough.

 - If the sensors are not closed, their behavior will be different
regarding the temperature. The governors will take different decision
regarding the cooling device (one will decrease the freq, other will
increase the freq).

As the thermal governors are not able to manage several thermal zones
and there is one cooling device (the cpu cooling device), this setup
won't work as expected IMO.

The setup making sense is having a thermal zone per 'cluster' and a
cooling device per 'cluster'. That means the platform has one clock line
per 'cluster'. The thermal management happens in a self-contained
thermal zone (one cooling device - one governor - one thermal zone).

In the case of HMP, other combinations are possible to be optimal.



-- 
 <http://www.linaro.org/> Linaro.org ©¦ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
