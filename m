From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
Date: Tue, 20 Nov 2018 10:29:50 +0100
Message-ID: <93eff9f1-922f-f5c1-9a88-debacdd68168@linaro.org>
References: <1540362909-32481-1-git-send-email-Anson.Huang@nxp.com>
 <28d501b1-8016-cc1a-3f7c-ac485ab81aa2@linaro.org>
 <DB3PR0402MB391662A8DA6A1F43F26F095BF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <e4cf8bad-9a4f-32e5-2f0e-be44257b5fe2@linaro.org>
 <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB3PR0402MB391604AB207C160F09D3595EF5D90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On 20/11/2018 09:58, Anson Huang wrote:
> Hi, Daniel
> 
> Best Regards!
> Anson Huang
> 
>> -----Original Message-----
>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>> Sent: 2018年11月20日 16:54
>> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
>> edubezval@gmail.com; linux-pm@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: dl-linux-imx <linux-imx@nxp.com>
>> Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
>>
>> On 20/11/2018 09:47, Anson Huang wrote:
>>> Hi, Daniel
>>>
>>> Best Regards!
>>> Anson Huang
>>>
>>>> -----Original Message-----
>>>> From: Daniel Lezcano [mailto:daniel.lezcano@linaro.org]
>>>> Sent: 2018年11月20日 16:45
>>>> To: Anson Huang <anson.huang@nxp.com>; rui.zhang@intel.com;
>>>> edubezval@gmail.com; linux-pm@vger.kernel.org;
>>>> linux-kernel@vger.kernel.org
>>>> Cc: dl-linux-imx <linux-imx@nxp.com>
>>>> Subject: Re: [PATCH] thermal: imx: fix for dependency on cpu-freq
>>>>
>>>> On 24/10/2018 08:39, Anson Huang wrote:
>>>>> The thermal driver is a standalone driver for monitoring SoC
>>>>> temperature by enabling thermal sensor, so it can be enabled even
>>>>> when CONFIG_CPU_FREQ is NOT set. So remove the dependency with
>>>> CPU_THERMAL.
>>>>>
>>>>> Add CONFIG_CPU_FREQ check for cpu-freq related operation in thermal
>>>>> driver to make thermal driver probe successfully when
>>>>> CONFIG_CPU_FREQ is NOT set.
>>>>>
>>>>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>>>>> ---
>>>>
>>>> Why not simply kill this legacy code ?
>>>
>>> Because killing legacy code will have old dtb compatible issue, old
>>> dtb will NOT have cpufreq cooling function.
>>
>> Yeah, I imagine that is the reason why you want to keep the legacy code but do
>> you really care about old DTB based boards? Are they still updated with newer
>> *upstream vanilla* kernels?
> 
> I am NOT sure if there is someone care about it, but I did receive many comments
> about old dtb compatible when I sent out other patches, so is it a solid requirement
> of old dtb compatible when doing upstream, or each sub-system or maintainer has
> different requirement about it? Actually I am happy to just remove the legacy
> code, because it makes the code more clean and easy reading. Who can make the
> decision?

Yes, making sure to not break the compatibility makes the patch
submission easier. However, sometime it makes sense to put in question
if keeping old (and hackish) code really matters.

Old boards are rarely updated with newer kernels and when that happens,
usually the DT is updated also.

IMO, this decision is in the hands of the platform maintainers. I
suggest to send a patch removing the legacy code Cc'ing all of them.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
