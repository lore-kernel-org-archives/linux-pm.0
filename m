From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V2] PM / Domains: Return -EPROBE_DEFER if we fail to init
 or turn-on domain
Date: Tue, 4 Aug 2015 14:57:39 +0100
Message-ID: <55C0C4D3.2050600@nvidia.com>
References: <1438334400-26367-1-git-send-email-jonathanh@nvidia.com> <CAMuHMdX7ia09PtnKRCWPBfwb9aMnewvXheHADm+5U=d0rpguQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1581 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbbHDN5r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 09:57:47 -0400
In-Reply-To: <CAMuHMdX7ia09PtnKRCWPBfwb9aMnewvXheHADm+5U=d0rpguQA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Geert,

On 04/08/15 14:03, Geert Uytterhoeven wrote:
> Hi Jon,
> 
> Now this ended up in pm/linux-next, I gave it a try, also with a special
> test case.
> 
> On Fri, Jul 31, 2015 at 11:20 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>> When a device is probed, the function dev_pm_domain_attach() is called
>> to see if there is a power-domain that is associated with the device and
>> needs to be turned on. If dev_pm_domain_attach() does not return
>> -EPROBE_DEFER then the device will be probed.
>>
>> For devices using genpd, dev_pm_domain_attach() will call
>> genpd_dev_pm_attach(). If genpd_dev_pm_attach() does not find a power
>> domain associated with the device then it returns an error code not
>> equal to -EPROBE_DEFER to allow the device to be probed. However, if
> 
> Your patch description doesn't say this behavior was changed...

Sorry if this was not clear, but ...

>> genpd_dev_pm_attach() does find a power-domain that is associated with
>> the device, then it does not return -EPROBE_DEFER on failure and hence
>> the device will still be probed. Furthermore, genpd_dev_pm_attach() does
>> not check the error code returned by pm_genpd_poweron() to see if the
>> power-domain was turned on successfully.
>>
>> Fix this by checking the return code from pm_genpd_poweron() and
>> returning -EPROBE_DEFER from genpd_dev_pm_attach on failure, if there
>> is a power-domain associated with the device.

... does the above not state the behaviour was changed?

>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>> Acked-by: Kevin Hilman <khilman@linaro.org>
>> ---
>> V2 changes:
>> - Updated description per Kevin's feedback and added Kevin's ACK.
>>
>>  drivers/base/power/domain.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index a1abe16dfe16..7666a1cbaf95 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1947,7 +1947,10 @@ static void genpd_dev_pm_sync(struct device *dev)
>>   * Both generic and legacy Samsung-specific DT bindings are supported to keep
>>   * backwards compatibility with existing DTBs.
>>   *
>> - * Returns 0 on successfully attached PM domain or negative error code.
>> + * Returns 0 on successfully attached PM domain or negative error code. Note
>> + * that if a power-domain exists for the device, but it cannot be found or
> 
> ... but here it does.
> 
>> + * turned on, then return -EPROBE_DEFER to ensure that the device is not
>> + * probed and to re-try again later.
>>   */
>>  int genpd_dev_pm_attach(struct device *dev)
>>  {
>> @@ -1984,7 +1987,7 @@ int genpd_dev_pm_attach(struct device *dev)
>>                 dev_dbg(dev, "%s() failed to find PM domain: %ld\n",
>>                         __func__, PTR_ERR(pd));
>>                 of_node_put(dev->of_node);
>> -               return PTR_ERR(pd);
>> +               return -EPROBE_DEFER;
> 
> And it really does.
> 
> This causes a regression for platforms where:
>   1. DT describes the hardware power domains, and
>   2. The boot loader or reset state has enabled all power domains, and
>   3. Linux doesn't have a driver for the power controller yet.
> 
> Before, devices for which the PM domain couldn't be found just probed and
> worked, Now, these devices don't probe anymore, and the kernel fails to boot.

I see. Sounds like a chicken or the egg scenario. Why not just disable
PM_GENERIC_DOMAINS in the config in that case?

> Note that I only managed to trigger this by explicitly disabling my power
> controller driver (the platforms I'm interested in already have power
> controller drivers). But I think it will hamper bring-up of new boards, as you
> can no longer write a "perfect and stable" .dts first, and implement kernel
> support incrementally.
> 
> Hence I think it's worthwhile to revert just this hunk.
> If you agree, I can send a patch.

But what about the case where we do have device that does have a power
controller driver? Don't we want to defer in case it has not been probed
yet? I am concerned we could try to probe a device before the power
controller has been probed.

Cheers Jon

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
