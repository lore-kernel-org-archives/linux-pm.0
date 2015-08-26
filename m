From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Wed, 26 Aug 2015 16:36:28 +0100
Message-ID: <55DDDCFC.8070107@arm.com>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>	<55CDC9D4.3020709@linaro.org> <CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com> <55DDC697.4080107@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45649 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203AbbHZPgd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 26 Aug 2015 11:36:33 -0400
In-Reply-To: <55DDC697.4080107@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>



On 26/08/15 15:00, Daniel Lezcano wrote:
> On 08/26/2015 03:02 PM, Zhaoyang Huang wrote:
>> The following functions don't work on pl011 for setting it as wakeup irq.
>> device_init_wakeup(dev, true);	dev_pm_set_wake_irq(dev, irq);

I did a quick hack in pl011 driver and it works fine to me, though I am
not sure if that feature is an upstream material as intended by your
patch. I don't this PL011 especially when used as a console needs to be
configured as wakeup(may be when used for bluetooth ?)

>
> Hi Zhaoyang,
>
> if I understood correctly, dev_pm_set_wake_irq is the new API to set a
> wake up device up. You are the first one using it, so perhaps there is
> something missing.
>

I had tested those APIs with RTC a while ago, it work just fine.

> I recommend you have a look at the slides [1] showed at the LPC2015.
>
> I added Sudeep so he can give more informations about that.
>

Thanks Daniel for the add.

Regards,
Sudeep
