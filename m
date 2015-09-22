From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/17] input: tegra-kbc: drop use of IRQF_NO_SUSPEND flag
Date: Mon, 21 Sep 2015 17:43:58 -0700
Message-ID: <CAKdAkRRWWxwWREiBiBcqBwBcZ6q0GHDgR1pyKfBXw=trP3cX_A@mail.gmail.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
	<1442850433-5903-8-git-send-email-sudeep.holla@arm.com>
	<20150921232132.GE11284@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36534 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756836AbbIVAn6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Sep 2015 20:43:58 -0400
In-Reply-To: <20150921232132.GE11284@x1>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Samuel Ortiz <sameo@linux.intel.com>

On Mon, Sep 21, 2015 at 4:21 PM, Lee Jones <lee.jones@linaro.org> wrote:
> The $SUBJECT is not correct.
>
>> The driver handles wakeup irq correctly using irq_set_irq_wake. There's
>> no need to use IRQF_NO_SUSPEND while registering the interrupt.
>>
>> This patch removes the use of IRQF_NO_SUSPEND flag.
>>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/mfd/qcom_rpm.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> ... code is fine though:
>
> Acked-by: Lee Jones <lee.jones@linaro.org>
>
> Please re-submit with the subject line fixed.

What's wrong with the subject?

Thanks.

-- 
Dmitry
