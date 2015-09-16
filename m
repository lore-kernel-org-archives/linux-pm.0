From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 2/2] add property of "linux,wakeup" for juno.dts
Date: Wed, 16 Sep 2015 09:59:16 +0100
Message-ID: <55F92F64.50904@arm.com>
References: <1442386021-5113-1-git-send-email-zhaoyang.huang@linaro.org>
 <1442386021-5113-2-git-send-email-zhaoyang.huang@linaro.org>
 <55F92B31.2060608@arm.com>
 <CAN2waFukpBgLM-NawcyqRMEbqC_v3VVoPSP=j0sJ6tJ1vMikqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54456 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002AbbIPI7U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Sep 2015 04:59:20 -0400
In-Reply-To: <CAN2waFukpBgLM-NawcyqRMEbqC_v3VVoPSP=j0sJ6tJ1vMikqw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhaoyang Huang <zhaoyang.huang@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>

Hi Zhaouyang,

On 16/09/15 09:53, Zhaoyang Huang wrote:
> Hi Sudeep,

Please stop top-posting, I have told you many times now in private.

> Sorry for the confusions I made. I am testing the suspend to idle on
> juno, which is similar to suspend to ram, while the difference is the
> cpu will go into idle itself(you can refer the function freeze_enter())
> instead of running cpu_suspend finally. I find that the pl011 can wakeup
> the system by receiving from the tty.
>

No, it shouldn't be allowed to be configured as wakeup if it can't
wakeup from S2R. So please stop sending this patch. I need to see real
use case for PL011 as a wakeup source.

Also, if we go by your definition, we can make any interrupt as wakeup
source. You need to understand that we hardware support for an interrupt
to be a wakeup irq.

Regards,
Sudeep
