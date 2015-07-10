From: Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Fri, 10 Jul 2015 15:59:11 +0800
Message-ID: <559F7B4F.9010307@atmel.com>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com> <20150709120335.GW28632@lukather> <559F36CC.7020203@atmel.com> <20150710065440.GY28632@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from nasmtp01.atmel.com ([192.199.1.245]:5316 "EHLO
	DVREDG01.corp.atmel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753865AbbGJH7S (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2015 03:59:18 -0400
In-Reply-To: <20150710065440.GY28632@lukather>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org

On 7/10/2015 2:54 PM, Maxime Ripard wrote:
> On Fri, Jul 10, 2015 at 11:06:52AM +0800, Josh Wu wrote:
>> Hi, Maxime
>>
>> On 7/9/2015 8:03 PM, Maxime Ripard wrote:
>>> Hi,
>>>
>>> On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
>>>> As since sama5d3, to reset the chip, we don't need to shutdown the ddr
>>>> controller.
>>>>
>>>> So add a new compatible string and new restart function for sama5d3 and
>>>> later chips. As we don't use sama5d3 ddr controller, so remove it as
>>>> well.
>>>>
>>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>> ---
>>>>
>>>>   drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
>>>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
>>>> index 36dc52f..8944b63 100644
>>>> --- a/drivers/power/reset/at91-reset.c
>>>> +++ b/drivers/power/reset/at91-reset.c
>>>> @@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_block *this, unsigned long mode,
>>>>   	return NOTIFY_DONE;
>>>>   }
>>>> +static int sama5d3_restart(struct notifier_block *this, unsigned long mode,
>>>> +			void *cmd)
>>>> +{
>>>> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST),
>>>> +				at91_rstc_base);
>>>> +	return NOTIFY_DONE;
>>>> +}
>>>> +
>>>>   static void __init at91_reset_status(struct platform_device *pdev)
>>>>   {
>>>>   	u32 reg = readl(at91_rstc_base + AT91_RSTC_SR);
>>>> @@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platform_device *pdev)
>>>>   static const struct of_device_id at91_ramc_of_match[] = {
>>>>   	{ .compatible = "atmel,at91sam9260-sdramc", },
>>>>   	{ .compatible = "atmel,at91sam9g45-ddramc", },
>>>> -	{ .compatible = "atmel,sama5d3-ddramc", },
>>>>   	{ /* sentinel */ }
>>>>   };
>>>>   static const struct of_device_id at91_reset_of_match[] = {
>>>>   	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9260_restart },
>>>>   	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
>>>> +	{ .compatible = "atmel,sama5d3-rstc", .data = sama5d3_restart },
>>>>   	{ /* sentinel */ }
>>>>   };
>>>> @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_device *pdev)
>>>>   		return -ENODEV;
>>>>   	}
>>>> -	for_each_matching_node(np, at91_ramc_of_match) {
>>>> -		at91_ramc_base[idx] = of_iomap(np, 0);
>>>> -		if (!at91_ramc_base[idx]) {
>>>> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
>>>> -			return -ENODEV;
>>>> +	match = of_match_node(at91_reset_of_match, pdev->dev.of_node);
>>>> +	at91_restart_nb.notifier_call = match->data;
>>>> +
>>>> +	if (match->data != sama5d3_restart) {
>>> Using of_device_is_compatible seems more appropriate.
>>>
>>> Also, why are you changing the order of this loop and the notifier
>>> registration?
>> I moved this order because I use the match->data to compare whether is
>> sama5d3_restart. So I need to move this function (of_match_node) up.
> Ah right, my bad.
>
> Still, testing against the kernel pointer is not that great.
>
> It would be great to use something explicit instead, like
> of_device_is_compatible.

I agree. I will use of_device_is_compatible() in v2. And that can avoid 
the order change in the loop as well. Thanks.

Best Regards,
Josh Wu

>
> Maxime
>

