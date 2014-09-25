From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH v5 4/4] thermal: Add Tegra SOCTHERM thermal management
 driver
Date: Thu, 25 Sep 2014 10:55:19 +0300
Message-ID: <5423CA67.1060308@kapsi.fi>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com> <1408616242-21009-5-git-send-email-mperttunen@nvidia.com> <20140924191829.GA16529@developer> <54231C3D.6040900@kapsi.fi> <20140925055953.GA12423@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140925055953.GA12423@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>, rui.zhang@intel.com, swarren@wwwdotorg.org, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, juha-matti.tilli@iki.fi
List-Id: linux-pm@vger.kernel.org

On 09/25/2014 08:59 AM, Thierry Reding wrote:
> On Wed, Sep 24, 2014 at 10:32:13PM +0300, Mikko Perttunen wrote:
>> On 09/24/2014 10:18 PM, Eduardo Valentin wrote:
>>>
>>> Mikko,
>>>
>>> On Thu, Aug 21, 2014 at 01:17:22PM +0300, Mikko Perttunen wrote:
>>>> ...
>>>> +
>>>> +static int enable_tsensor(struct tegra_soctherm *tegra,
>>>> +			  const struct tegra_tsensor *sensor,
>>>> +			  struct tsensor_shared_calibration shared)
>>>> +{
>>>> +	void * __iomem base = tegra->regs + sensor->base;
>>>
>>> I get sparse complaining about this declaration. For the sake of keeping
>>> a clean static checks, can you please:
>>> -       void * __iomem base = tegra->regs + sensor->base;
>>> +       void __iomem * base = tegra->regs + sensor->base;
>>>
>>
>> Sure.
>>
>>> Can you also please check the remaining sparse errors?
>>>    CHECK   drivers/thermal/tegra_soctherm.c
>>>    drivers/thermal/tegra_soctherm.c:260:43: warning: incorrect type in
>>>    initializer (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:260:43:    expected void *[noderef]
>>>    <asn:2>base
>>>    drivers/thermal/tegra_soctherm.c:260:43:    got void [noderef]
>>>    <asn:2>*
>>>    drivers/thermal/tegra_soctherm.c:271:9: warning: incorrect type in
>>>    argument 2 (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:271:9:    expected void volatile
>>>    [noderef] <asn:2>*addr
>>>    drivers/thermal/tegra_soctherm.c:271:9:    got void *
>>>    drivers/thermal/tegra_soctherm.c:279:9: warning: incorrect type in
>>>    argument 2 (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:279:9:    expected void volatile
>>>    [noderef] <asn:2>*addr
>>>    drivers/thermal/tegra_soctherm.c:279:9:    got void *
>>>    drivers/thermal/tegra_soctherm.c:281:9: warning: incorrect type in
>>>    argument 2 (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:281:9:    expected void volatile
>>>    [noderef] <asn:2>*addr
>>>    drivers/thermal/tegra_soctherm.c:281:9:    got void *
>>>    drivers/thermal/tegra_soctherm.c:347:25: warning: incorrect type in
>>>    argument 1 (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:347:25:    expected void const *ptr
>>>    drivers/thermal/tegra_soctherm.c:347:25:    got void [noderef]
>>>    <asn:2>*regs
>>>    drivers/thermal/tegra_soctherm.c:349:37: warning: incorrect type in
>>>    argument 1 (different address spaces)
>>>    drivers/thermal/tegra_soctherm.c:349:37:    expected void const *ptr
>>>    drivers/thermal/tegra_soctherm.c:349:37:    got void [noderef]
>>>    <asn:2>*regs
>>>    drivers/thermal/tegra_soctherm.c:271:9: warning: dereference of
>>>    noderef expression
>>>    drivers/thermal/tegra_soctherm.c:279:9: warning: dereference of
>>>    noderef expression
>>>    drivers/thermal/tegra_soctherm.c:281:9: warning: dereference of
>>>    noderef expression
>>>
>>
>> Most of these seem to be caused by the above-mentioned swapping of __iomem
>> and *. The ones on lines 347 and 349 are more peculiar, though. Apparently
>> sparse doesn't like using IS_ERR and PTR_ERR on the void __iomem * pointer
>> returned by devm_ioremap_resource. Looks like this has been discussed before
>> (https://lkml.org/lkml/2013/6/17/216) and sparse should have been patched to
>> ignore this situation, so I'm not sure why it's complaining about it.
>> Anyway, there shouldn't be any issue here.
>
> If I apply the change suggested by Eduardo above then all of the above
> warnings go away for me. That's with sparse 0.5.0. According to the
> email thread above a patch for this was applied in 0.4.5.

Ah, good. I didn't actually run sparse, just checked by eye. Maybe I 
should have run it.

>
> Thierry
>
