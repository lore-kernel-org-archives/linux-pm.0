From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] modify pl011 driver to work as wakeup source
Date: Thu, 27 Aug 2015 11:51:02 +0100
Message-ID: <55DEEB96.5090908@arm.com>
References: <1439547886-5093-1-git-send-email-zhaoyang.huang@linaro.org>	<55CDC9D4.3020709@linaro.org>	<CAN2waFv+8KM_TCw=iy1BOn-KmYuZRVmr5jKAniJwCaxBjqXvNQ@mail.gmail.com>	<55DDC697.4080107@linaro.org>	<55DDDCFC.8070107@arm.com> <CAN2waFtcVHoSX6QGZQFzJJ2fkYVk1mUsgMn1HYGGd-+TT-XMjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48154 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbbH0KvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 06:51:05 -0400
In-Reply-To: <CAN2waFtcVHoSX6QGZQFzJJ2fkYVk1mUsgMn1HYGGd-+TT-XMjw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>



On 27/08/15 09:25, Zhaoyang Huang wrote:
> Sudeep,
> Have you check if the pl011 can wakeup the system. I notice that the
> calling of dev_pm_set_wake_irq can set the node of <device>/power/wakeup
> to be enabled but can not wakeup the system.
>

Yes I did, and it does wakeup the system.

> By basic debugging, I find that when calling of dev_pm_set_wake_irq
> within pl011_probe, the real device which we operate is the
> /sys/devices/platform/7ff80000.uart instead of the ttyAMA0.
>

No, if you are expecting the wakeup by sending some character on the
console, then it's ttyAMA0 which uses the pl011 UART. May be you can
also generate wakeup by toggling RTS/CTS hardware flow signals.

> By checking the sysfs, I find that the value of
> "sys/devices/platform/7ff80000.uart/power/wakeup" is "enabled", which
> can also prove above information. However, the value of
> "dev.power.wakeup->wakeirq->irq" for uart is 24 which is the same with
> ttyAMA0.

Ah, you need to use /sys/class/tty/ttyAMA0/power/wakeup

Regards,
Sudeep
