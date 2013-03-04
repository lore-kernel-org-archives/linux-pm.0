From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 2/8] reset: Add reset controller API
Date: Mon, 04 Mar 2013 10:03:31 -0700
Message-ID: <5134D3E3.9000308@wwwdotorg.org>
References: <1361878774-6382-1-git-send-email-p.zabel@pengutronix.de>  <1361878774-6382-3-git-send-email-p.zabel@pengutronix.de>  <513108F8.30902@wwwdotorg.org> <1362386007.4988.34.camel@pizza.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44277 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757398Ab3CDRDf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 12:03:35 -0500
In-Reply-To: <1362386007.4988.34.camel@pizza.hi.pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 03/04/2013 01:33 AM, Philipp Zabel wrote:
> Hi Stephen,
> 
> Am Freitag, den 01.03.2013, 13:00 -0700 schrieb Stephen Warren:
>> On 02/26/2013 04:39 AM, Philipp Zabel wrote:
>>> This adds a simple API for devices to request being reset
>>> by separate reset controller hardware and implements the
>>> reset signal device tree binding.
>>
>>> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
>>
>>> +int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
>>> +			  const struct of_phandle_args *reset_spec, u32 *flags)
>>> +{
>>> +	if (WARN_ON(reset_spec->args_count < rcdev->of_reset_n_cells))
>>> +		return -EINVAL;
>>
>> Would != make more sense than < ?
> 
> I copied this from of_gpio_simple_xlate, because the parsing will work
> if args_count > of_reset_n_cells. In this case the device tree contains
> a #reset-cells larger than what the reset controller driver expects.
> Is this reason enough to assume the whole reset_spec is invalid?

Well, there's certainly something unexpected going on; what are those
extra cells expected to mean? I'd tend to make that an error myself to
avoid unexpected symptoms. I'd tend to want to make the same change to
of_gpio_simple_xlate().

>>> +
>>> +	if (reset_spec->args[0] >= rcdev->nr_resets)
>>> +		return -EINVAL;
>>> +
>>> +	if (flags)
>>> +		*flags = reset_spec->args[1];
>>
>> if (flags)
>>     if (reset_spec->args_count > 1)
>>         *flags = reset_spec->args[1];
>>     else
>>         *flags = 0;
>>
>> ?
> 
> In gpiolib, of_get_named_gpio_flags clears the flags, so that the xlate
> implementations don't have to do it. The core doesn't use the flags, so
> this is not a problem. I don't see the need for
> of_get_named_reset_flags, since the reset consumer drivers shouldn't
> care for those. Maybe it would be better to remove the flags parameter
> from the xlate function altogether.

Yes, since there are no flags, removing the parameter makes most sense.

