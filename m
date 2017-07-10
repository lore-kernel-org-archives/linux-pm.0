From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 1/3] cpufreq: mediatek: Add support of cpufreq to
 MT2701/MT7623 SoC
Date: Mon, 10 Jul 2017 14:05:53 +0200
Message-ID: <d77f367b-75db-ca23-f334-9bd6154ee26a@gmail.com>
References: <cover.1499399121.git.sean.wang@mediatek.com>
 <de42e68d86dd161bb18b4ca7f27774c63c1bd55d.1499399121.git.sean.wang@mediatek.com>
 <1499412649.4449.33.camel@suse.de> <1499495426.16278.9.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499495426.16278.9.camel@mtkswgap22>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Wang <sean.wang@mediatek.com>, Jean Delvare <jdelvare@suse.de>
Cc: viresh.kumar@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/08/2017 08:30 AM, Sean Wang wrote:
> On Fri, 2017-07-07 at 09:30 +0200, Jean Delvare wrote:
>> Hi Sean,
>>
>> On ven., 2017-07-07 at 11:56 +0800, sean.wang@mediatek.com wrote:
>>> From: Sean Wang <sean.wang@mediatek.com>
>>>
>>> MT2701/MT7623 is a 32-bit ARMv7 based quad-core (4 * Cortex-A7) with
>>> single cluster and this hardware is also compatible with the existing
>>> driver through enabling CPU frequency feature with operating-points-v2
>>> bindings. Also, this driver actually supports all MediaTek SoCs, the
>>> Kconfig menu entry and file name itself should be updated with more
>>> generic name to drop "MT8173"
>>>
>>> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>>   drivers/cpufreq/Kconfig.arm                         | 8 ++++----
>>>   drivers/cpufreq/Makefile                            | 2 +-
>>>   drivers/cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c} | 2 ++
>>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>>   rename drivers/cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c} (99%)
>>>
>>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>>> index 74ed7e9..79aece7 100644
>>> --- a/drivers/cpufreq/Kconfig.arm
>>> +++ b/drivers/cpufreq/Kconfig.arm
>>> @@ -87,14 +87,14 @@ config ARM_KIRKWOOD_CPUFREQ
>>>   	  This adds the CPUFreq driver for Marvell Kirkwood
>>>   	  SoCs.
>>>   
>>> -config ARM_MT8173_CPUFREQ
>>> -	tristate "Mediatek MT8173 CPUFreq support"
>>> +config ARM_MEDIATEK_CPUFREQ
>>> +	tristate "CPU Frequency scaling support for MediaTek SoCs"
>>>   	depends on ARCH_MEDIATEK && REGULATOR
>>> -	depends on ARM64 || (ARM_CPU_TOPOLOGY && COMPILE_TEST)
>>> +	depends on ARM || ARM64 || COMPILE_TEST
>>
>> This statement no longer serves any purpose. The whole Kconfig.arm file
>> depends on ARM || ARM64, so you can drop it. As a matter of fact no
>> other entry in this file has the dependency.
>>
> 
> Okay, the whole line seemed redundant for that's always true.
> I will drop it in the next version.
> 
>>>   	depends on !CPU_THERMAL || THERMAL
>>>   	select PM_OPP
>>>   	help
>>> -	  This adds the CPUFreq driver support for Mediatek MT8173 SoC.
>>> +	  This adds the CPUFreq driver support for MediaTek SoCs.
>>>   
>>>   config ARM_OMAP2PLUS_CPUFREQ
>>>   	bool "TI OMAP2+"
>>> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
>>> index b7e78f0..4956f5d 100644
>>> --- a/drivers/cpufreq/Makefile
>>> +++ b/drivers/cpufreq/Makefile
>>> @@ -58,7 +58,7 @@ obj-$(CONFIG_ARM_EXYNOS5440_CPUFREQ)	+= exynos5440-cpufreq.o
>>>   obj-$(CONFIG_ARM_HIGHBANK_CPUFREQ)	+= highbank-cpufreq.o
>>>   obj-$(CONFIG_ARM_IMX6Q_CPUFREQ)		+= imx6q-cpufreq.o
>>>   obj-$(CONFIG_ARM_KIRKWOOD_CPUFREQ)	+= kirkwood-cpufreq.o
>>> -obj-$(CONFIG_ARM_MT8173_CPUFREQ)	+= mt8173-cpufreq.o
>>> +obj-$(CONFIG_ARM_MEDIATEK_CPUFREQ)	+= mtk-cpufreq.o
>>
>> I would have preferred mediatek-cpufreq. 3-letter abbreviations are
>> likely to collide and cause confusion at some point in time. However it
>> seems I am late to the party, I see that there are already many files
>> named mtk-* or *-mtk.*... So, so be it.
>>
>> Also the file describing the bindings is named cpufreq-mediatek.txt,
>> which is inconsistent... But the situation is the same for a few other
>> cpufreq drivers already, so I suppose this is acceptable.
>>
> 
> Agreed. I also prefer using whole name with mediatek as the
> prefix than just abbreviation used. I will update it also in the
> next version.
> 
> As for the file naming for other drivers, i feel it's okay for me
> changing into mediatek as file prefix, but it still depends on
> maintainers or original authors if they likes this.
> 

If you want to clean that up, be my guest. Other low-hanging fruits to 
clean up would be the config options. Right now we have MEDIATEK, MTK 
and MT65 in kconfig, which is a mess.

Regards,
Matthias

> 
> 	Sean
> 
>>>   obj-$(CONFIG_ARM_OMAP2PLUS_CPUFREQ)	+= omap-cpufreq.o
>>>   obj-$(CONFIG_ARM_PXA2xx_CPUFREQ)	+= pxa2xx-cpufreq.o
>>>   obj-$(CONFIG_PXA3xx)			+= pxa3xx-cpufreq.o
>>> diff --git a/drivers/cpufreq/mt8173-cpufreq.c b/drivers/cpufreq/mtk-cpufreq.c
>>> similarity index 99%
>>> rename from drivers/cpufreq/mt8173-cpufreq.c
>>> rename to drivers/cpufreq/mtk-cpufreq.c
>>> index fd1886f..481ec77 100644
>>> --- a/drivers/cpufreq/mt8173-cpufreq.c
>>> +++ b/drivers/cpufreq/mtk-cpufreq.c
>>> @@ -575,6 +575,8 @@ static struct platform_driver mt8173_cpufreq_platdrv = {
>>>   
>>>   /* List of machines supported by this driver */
>>>   static const struct of_device_id mt8173_cpufreq_machines[] __initconst = {
>>> +	{ .compatible = "mediatek,mt2701", },
>>> +	{ .compatible = "mediatek,mt7623", },
>>>   	{ .compatible = "mediatek,mt817x", },
>>>   	{ .compatible = "mediatek,mt8173", },
>>>   	{ .compatible = "mediatek,mt8176", },
>>
>> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>>
> 
> 
