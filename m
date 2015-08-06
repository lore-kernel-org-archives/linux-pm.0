From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] PM / Domains: Return -EPROBE_DEFER if we fail to init
 or turn-on domain
Date: Thu, 6 Aug 2015 10:26:39 +0100
Message-ID: <55C3284F.8070305@nvidia.com>
References: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com>	<55C0C4D3.2050600@nvidia.com>	<CAMuHMdW8H-mxG9poJpjijBCUHWs+Q4Xe3muXeTqnd7npBEzXRA@mail.gmail.com>	<1911839.6SetkcFuZL@vostro.rjw.lan>	<55C30FE4.9080206@nvidia.com>	<55C31AA9.8050202@nvidia.com> <CAMuHMdU3y-wn5W3-9BD8epkqdWu+0_16pYwktVhqBHku+Mo2mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16001 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbbHFJ0q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2015 05:26:46 -0400
In-Reply-To: <CAMuHMdU3y-wn5W3-9BD8epkqdWu+0_16pYwktVhqBHku+Mo2mg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 06/08/15 09:46, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> On Thu, Aug 6, 2015 at 10:28 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> On 06/08/15 08:42, Jon Hunter wrote:
>>> On 06/08/15 00:59, Rafael J. Wysocki wrote:
>>>> On Wednesday, August 05, 2015 04:06:12 PM Geert Uytterhoeven wrote:
>>>>> On Tue, Aug 4, 2015 at 3:57 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>> On 04/08/15 14:03, Geert Uytterhoeven wrote:
>>>>>>> Now this ended up in pm/linux-next, I gave it a try, also with a special
>>>>>>> test case.
>>>>>>>
>>>>>>> On Fri, Jul 31, 2015 at 11:20 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>>>>> When a device is probed, the function dev_pm_domain_attach() is called
>>>>>>>> to see if there is a power-domain that is associated with the device and
>>>>>>>> needs to be turned on. If dev_pm_domain_attach() does not return
>>>>>>>> -EPROBE_DEFER then the device will be probed.
>>>>>>>>
>>>>>>>> For devices using genpd, dev_pm_domain_attach() will call
>>>>>>>> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
>>>>>>>> domain associated with the device then it returns an error code not
>>>>>>>> equal to -EPROBE_DEFER to allow the device to be probed. However, if
>>>>>>>
>>>>>>> Your patch description doesn't say this behavior was changed...
>>>>>>
>>>>>> Sorry if this was not clear, but ...
>>>>>>
>>>>>>>> genpd_dev_pm_attach() does find a power-domain that is associated with
>>>>>>>> the device, then it does not return -EPROBE_DEFER on failure and hence
>>>>>>>> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
>>>>>>>> not check the error code returned by pm_genpd_poweron() to see if the
>>>>>>>> power-domain was turned on successfully.
>>>>>>>>
>>>>>>>> Fix this by checking the return code from pm_genpd_poweron() and
>>>>>>>> returning -EPROBE_DEFER from genpd_dev_pm_attach on failure, if there
>>>>>>>> is a power-domain associated with the device.
>>>>>>
>>>>>> ... does the above not state the behaviour was changed?
>>>>>>
>>>>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>>>>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>>>>>>> Acked-by: Kevin Hilman <khilman@linaro.org>
>>>>>>>> ---
>>>>>>>> V2 changes:
>>>>>>>> - Updated description per Kevin's feedback and added Kevin's ACK.
>>>>>>>>
>>>>>>>>  drivers/base/power/domain.c | 14 +++++++++-----
>>>>>>>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>>>>>>> index a1abe16dfe16..7666a1cbaf95 100644
>>>>>>>> --- a/drivers/base/power/domain.c
>>>>>>>> +++ b/drivers/base/power/domain.c
>>>>>>>> @@ -1947,7 +1947,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>>>>>>>>   * Both generic and legacy Samsung-specific DT bindings are supported to keep
>>>>>>>>   * backwards compatibility with existing DTBs.
>>>>>>>>   *
>>>>>>>> - * Returns 0 on successfully attached PM domain or negative error code.
>>>>>>>> + * Returns 0 on successfully attached PM domain or negative error code. Note
>>>>>>>> + * that if a power-domain exists for the device, but it cannot be found or
>>>>>>>
>>>>>>> ... but here it does.
>>>>>>>
>>>>>>>> + * turned on, then return -EPROBE_DEFER to ensure that the device is not
>>>>>>>> + * probed and to re-try again later.
>>>>>>>>   */
>>>>>>>>  int genpd_dev_pm_attach(struct device *dev)
>>>>>>>>  {
>>>>>>>> @@ -1984,7 +1987,7 @@ int genpd_dev_pm_attach(struct device *dev)
>>>>>>>>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>>>>>>>>                         __func__, PTR_ERR(pd));
>>>>>>>>                 of_node_put(dev->of_node);
>>>>>>>> -               return PTR_ERR(pd);
>>>>>>>> +               return -EPROBE_DEFER;
>>>>>>>
>>>>>>> And it really does.
>>>>>>>
>>>>>>> This causes a regression for platforms where:
>>>>>>>   1. DT describes the hardware power domains, and
>>>>>>>   2. The boot loader or reset state has enabled all power domains, and
>>>>>>>   3. Linux doesn't have a driver for the power controller yet.
>>>>>>>
>>>>>>> Before, devices for which the PM domain couldn't be found just probed and
>>>>>>> worked, Now, these devices don't probe anymore, and the kernel fails to boot.
>>>>>>
>>>>>> I see. Sounds like a chicken or the egg scenario. Why not just disable
>>>>>> PM_GENERIC_DOMAINS in the config in that case?
>>>>>
>>>>> Because it may be enabled for another platform in multi-platform kernels.
>>>>>
>>>>>>> Note that I only managed to trigger this by explicitly disabling my power
>>>>>>> controller driver (the platforms I'm interested in already have power
>>>>>>> controller drivers). But I think it will hamper bring-up of new boards, as you
>>>>>>> can no longer write a "perfect and stable" .dts first, and implement kernel
>>>>>>> support incrementally.
>>>>>>>
>>>>>>> Hence I think it's worthwhile to revert just this hunk.
>>>>>>> If you agree, I can send a patch.
>>>>>>
>>>>>> But what about the case where we do have device that does have a power
>>>>>> controller driver? Don't we want to defer in case it has not been probed
>>>>>> yet? I am concerned we could try to probe a device before the power
>>>>>> controller has been probed.
>>>>>
>>>>> That's indeed an issue.
>>>>>
>>>>> There's a similar problem with "dmas" properties and the (non)presence
>>>>> of the DMA controller.
>>>>
>>>> Well, should I drop the patch, then?
> 
> No, I wouldn't drop the whole patch.
> 
>>> Although I respect Geert's opinion, I am still not convinced that we
>>> should drop this because of the scenario that Geert is describing.
>>>
>>> IMO, the scenario would only impact early development and usually you
>>> may need to hack the kernel a bit to get things up a running initially
>>> anyway. Furthermore, I don't think that the kernel should make any
>>> assumptions about what a bootloader may or may not do.
>>>
>>> I think that it is best for the kernel to behave as we would want in a
>>> production environment and that is if the device has associated
>>> power-domains then we should defer the probe until the gpd provider is
>>> available.
>>
>> Furthermore, without this change, it means I need to ensure that the gpd
>> provider(s) is always probed before any device that is dependent upon
>> that provider (ie. faff with initcalls). Otherwise a device can be
>> probed before the provider and potentially crash/hang the system when
>> accessing the hardware. That's the real problem I am trying to solve
>> here. Sorry if that was not clear.
> 
> I had already realized your probe order issue before.
> 
> On Renesas SoCs, we have to initialize the PM Domain very early, as even
> critical infrastructure can be part of a power or clock domain.
> And as these days most critical infrastructure is initialized from some
> OF_DECLARE() variant (which doesn't support retry on EPROBE_DEFER!), we don't
> have much of a choice...

So from an SoC power-domain perspective I can think of at least 4
types/classes ...

1. Always-on (never turns off)
2. CPU domain
3. Core domain(s) (must be on for memory accesses and CPUs to operate)
4. Peripheral domains (various power-domains for various devices)

For tegra, certain power-domains, particularly those in the peripheral
space, are dependent on the regulator framework and we cannot make any
assumptions about them. Don't get me wrong the "core" and "cpu" domains
are also dependent on regulators as well for things like frequency
scaling and low-power modes. However, we know that the "core" and "cpu"
has to be on otherwise we would not be running.

These peripheral domains cannot be registered early because they need
the regulator framework. So I don't think OF_DECLARE() will work for all
devices.

It still sounds to me that the nodes should be disabled/removed from the
dtb. Having a dynamic way to do this would be useful, I can see.

Cheers
Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
