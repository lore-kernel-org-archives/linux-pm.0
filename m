From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 01/17] rtc: pl031: remove misuse of IRQF_NO_SUSPEND flag
Date: Fri, 2 Oct 2015 11:45:18 +0100
Message-ID: <560E603E.8080603@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39769 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbbJBKpW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 2 Oct 2015 06:45:22 -0400
In-Reply-To: <CACRpkdaa+J76vMGHrZsTZukUS-VyDQFPqwg6teV=m050a=P8Pg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>



On 02/10/15 11:40, Linus Walleij wrote:
> On Mon, Sep 21, 2015 at 8:46 AM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>> The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
>> be left enabled so as to allow them to work as expected during the
>> suspend-resume cycle, but doesn't guarantee that it will wake the system
>> from a suspended state, enable_irq_wake is recommended to be used for
>> the wakeup.
>>
>> This patch removes the use of IRQF_NO_SUSPEND flags and uses newly
>> introduce PM wakeup APIs dev_pm_{set,clear}_wake_irq.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: rtc-linux@googlegroups.com
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Looks correct to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>

Thanks, while you are at it, do you know what interrupt stv2_pl031
shares so that I can fix the TODO in the comment or the code(whichever
applicable).

Regards,
Sudeep
