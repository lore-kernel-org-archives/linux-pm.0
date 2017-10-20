From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 01/18] thermal/drivers/hisi: Fix missing interrupt
 enablement
Date: Fri, 20 Oct 2017 08:35:29 +0200
Message-ID: <d82e759c-21a8-231e-16ff-aa3ab3b719a0@linaro.org>
References: <6ac48f08-7fe6-92e9-0801-6ed3bcd05ff1@linaro.org>
 <1508432760-17847-1-git-send-email-daniel.lezcano@linaro.org>
 <20171020015205.GA10997@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:55100 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751351AbdJTGfd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Oct 2017 02:35:33 -0400
Received: by mail-wm0-f41.google.com with SMTP id r68so684521wmr.3
        for <linux-pm@vger.kernel.org>; Thu, 19 Oct 2017 23:35:32 -0700 (PDT)
In-Reply-To: <20171020015205.GA10997@localhost.localdomain>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org

On 20/10/2017 03:52, Eduardo Valentin wrote:
> On Thu, Oct 19, 2017 at 07:05:43PM +0200, Daniel Lezcano wrote:
>> The interrupt for the temperature threshold is not enabled at the end of the
>> probe function, enable it after the setup is complete.
>>
>> On the other side, the irq_enabled is not correctly set as we are checking if
>> the interrupt is masked where 'yes' means irq_enabled=false.
>>
>> 	irq_get_irqchip_state(data->irq, IRQCHIP_STATE_MASKED,
>> 				&data->irq_enabled);
>>
>> As we are always enabling the interrupt, it is pointless to check if
>> the interrupt is masked or not, just set irq_enabled to 'true'.
> 
> 
> Why only 18 patches this time? Can you please add a cover letter (0/X)
> next time?

Yes sure.

Actually, I grouped the different series (acked and reviewed) into a git
pull request instead of having them around. I thought that could help
you. I sent a pull request with all these patches under this pull
request along with a description. Did you receive it? Note without the
threaded email view, it is easy to miss it.

> What happened to the other 7 patches?

As stated in the PR, I put them apart to solve the multi threshold issue
before resubmitting, probably by folding Kevin's latest change. I will
resend them very shortly.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
