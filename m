From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Support asymmetric idle definition
Date: Thu, 22 Jun 2017 14:25:19 +0200
Message-ID: <9c00e3ed-693d-4ea7-7a9f-be158b7eb7c5@linaro.org>
References: <20170612155441.GE2261@mai>
 <1497282910-19085-1-git-send-email-daniel.lezcano@linaro.org>
 <1497282910-19085-2-git-send-email-daniel.lezcano@linaro.org>
 <2056969.dMlCPX6XND@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33811 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdFVMZX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Jun 2017 08:25:23 -0400
Received: by mail-wr0-f170.google.com with SMTP id 77so21326292wrb.1
        for <linux-pm@vger.kernel.org>; Thu, 22 Jun 2017 05:25:22 -0700 (PDT)
In-Reply-To: <2056969.dMlCPX6XND@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Leo Yan <leo.yan@linaro.org>, open list <linux-kernel@vger.kernel.org>

On 12/06/2017 20:49, Rafael J. Wysocki wrote:
> On Monday, June 12, 2017 05:55:10 PM Daniel Lezcano wrote:
>> Some hardware have clusters with different idle states. The current code does
>> not support this and fails as it expects all the idle states to be identical.
>>
>> Because of this, the Mediatek mtk8173 had to create the same idle state for a
>> big.Little system and now the Hisilicon 960 is facing the same situation.
>>
>> Solve this by simply assuming the multiple driver will be needed for all the
>> platforms using the ARM generic cpuidle driver which makes sense because of the
>> different topologies we can support with a single kernel for ARM32 or ARM64.
>>
>> Every CPU has its own driver, so every single CPU can specify in the DT the
>> idle states.
>>
>> This simple approach allows to support the future dynamIQ system, current SMP
>> and HMP.
>>
>> Tested on:
>>  - 96boards: Hikey 620
>>  - 96boards: Hikey 960
>>  - 96boards: dragonboard410c
>>  - Mediatek 8173
>>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Tested-by: Leo Yan <leo.yan@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> There seems to have been quite some discussion regarding this one and I'm not
> sure about the resolution of it.
> 
> I'd feel more comfortable with an ACK or Reviewed-by from Sudeep or Lorenzo here.


Hi Rafael,

just a gentle reminder, Sudeep acked the patch.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
