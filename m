From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] thermal/intel_powerclamp: pr_err()/pr_info() strings
 should end with newlines
Date: Tue, 10 Oct 2017 10:24:45 +0200
Message-ID: <0b3f271a-cbb4-b9bc-115e-8c26c0b324cb@linaro.org>
References: <277b8d12fc6980ec2ffd039a872f681ec0e49c19.1507549738.git.arvind.yadav.cs@gmail.com>
 <7555b065-f4de-2988-283b-b6800ce189ab@linaro.org>
 <1507610265.3552.20.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:46523 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755487AbdJJIYs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Oct 2017 04:24:48 -0400
Received: by mail-wm0-f46.google.com with SMTP id m72so2747010wmc.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Oct 2017 01:24:47 -0700 (PDT)
In-Reply-To: <1507610265.3552.20.camel@perches.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 10/10/2017 06:37, Joe Perches wrote:
> On Mon, 2017-10-09 at 14:33 +0200, Daniel Lezcano wrote:
>> On 09/10/2017 13:51, Arvind Yadav wrote:
>>> pr_err()/pr_info() messages should end with a new-line to avoid
>>> other messages being concatenated.
> []
>>> diff --git a/drivers/thermal/intel_powerclamp.c b/drivers/thermal/intel_powerclamp.c
>>> @@ -675,13 +675,13 @@ static int __init powerclamp_probe(void)
>>>  {
>>>  
>>>  	if (!x86_match_cpu(intel_powerclamp_ids)) {
>>> -		pr_err("CPU does not support MWAIT");
>>> +		pr_err("CPU does not support MWAIT\n");
> 
> [etc...]
> 
>> Hi Arvind,
>>
>> you are sending these fixes for all the drivers around. There is a way
>> to fix this once and for all: use the coccinelle tools [1], add the
>> script in the changelog with a big patchset and add the script in the
>> coccinelle scripts directory [2].
> 
> That can't work as any printk without a newline termination
> could be followed by a printk(KERN_CONT/pr_cont( in another
> function.
> 
> All of these must be hand-verified.

Ouch!

Fair enough. Thanks for the info.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
