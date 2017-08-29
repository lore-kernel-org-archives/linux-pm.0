From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 13/19] MIPS: Unify checks for sibling CPUs
Date: Tue, 29 Aug 2017 09:42:51 +0200
Message-ID: <c850dd48-abde-4268-0896-98561a0c657b@linaro.org>
References: <20170813024943.14989-1-paul.burton@imgtec.com>
 <20170813024943.14989-14-paul.burton@imgtec.com>
 <20170826122749.GI7433@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:33035 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdH2Hmy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 03:42:54 -0400
Received: by mail-wr0-f174.google.com with SMTP id k94so7600997wrc.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Aug 2017 00:42:54 -0700 (PDT)
In-Reply-To: <20170826122749.GI7433@linux-mips.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: linux-mips@linux-mips.org

On 26/08/2017 14:27, Ralf Baechle wrote:
> Hi,
> 
> Paul didn't cc the other maintainers.  Tglx gave me his Ack on IRC so I
> now only still need one of a drivers/cpuidle/ maintainer.
> 
> Thanks,
> 
>   Ralf
> 
> On Sat, Aug 12, 2017 at 07:49:37PM -0700, Paul Burton wrote:
>> Date:   Sat, 12 Aug 2017 19:49:37 -0700
>> From: Paul Burton <paul.burton@imgtec.com>
>> To: linux-mips@linux-mips.org
>> CC: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>
>> Subject: [PATCH 13/19] MIPS: Unify checks for sibling CPUs
>> Content-Type: text/plain
>>
>> Up until now we have open-coded checks for whether CPUs are siblings,
>> with slight variations on whether we consider the package ID or not.
>>
>> This will only get more complex when we introduce cluster support, so in
>> preparation for that this patch introduces a cpus_are_siblings()
>> function which can be used to check whether or not 2 CPUs are siblings
>> in a consistent manner.
>>
>> By checking globalnumber with the VP ID masked out this also has the
>> neat side effect of being ready for multi-cluster systems already.
>>
>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> Cc: linux-mips@linux-mips.org
>> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
