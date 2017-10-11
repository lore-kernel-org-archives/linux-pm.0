From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/2] ARM: cpuidle: Correct driver unregistration if
 init fails
Date: Wed, 11 Oct 2017 11:48:52 +0200
Message-ID: <7baafe73-7bed-fb1c-cd9b-f9bff2c1ea76@linaro.org>
References: <1507614476-16054-1-git-send-email-leo.yan@linaro.org>
 <CAJZ5v0h6BMTpFb1L5-ZAaupAiFApz+i-hYjDgfW4Fs0Dk_J1dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:53629 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753030AbdJKJs4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Oct 2017 05:48:56 -0400
Received: by mail-wm0-f41.google.com with SMTP id q132so3303137wmd.2
        for <linux-pm@vger.kernel.org>; Wed, 11 Oct 2017 02:48:55 -0700 (PDT)
In-Reply-To: <CAJZ5v0h6BMTpFb1L5-ZAaupAiFApz+i-hYjDgfW4Fs0Dk_J1dg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 11/10/2017 00:00, Rafael J. Wysocki wrote:
> On Tue, Oct 10, 2017 at 7:47 AM, Leo Yan <leo.yan@linaro.org> wrote:
>> If cpuidle init fails, the code misses to unregister the driver for
>> current CPU. Furthermore, we also need to rollback to cancel all
>> previous CPUs registration; but the code retrieves driver handler by
>> using function cpuidle_get_driver(), this function returns back
>> current CPU driver handler but not previous CPU's handler, which leads
>> to the failure handling code cannot unregister previous CPUs driver.
>>
>> This commit fixes two mentioned issues, it adds error handling path
>> 'goto out_unregister_drv' for current CPU driver unregistration; and
>> it is to replace cpuidle_get_driver() with cpuidle_get_cpu_driver(),
>> the later function can retrieve driver handler for previous CPUs
>> according to the CPU device handler so can unregister the driver
>> properly.
>>
>> This patch also adds extra error handling paths 'goto out_kfree_dev'
>> and 'goto out_kfree_drv' and adjusts the freeing sentences for previous
>> CPUs; so make the code more readable for freeing 'dev' and 'drv'
>> structures.
>>
>> Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> Fixes: d50a7d8acd78 ("ARM: cpuidle: Support asymmetric idle definition")
> 
> Daniel, any comments here and on the [2/2]?

Hi Rafael,

I'm ok with both.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
