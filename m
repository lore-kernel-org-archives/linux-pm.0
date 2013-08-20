From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH] cpufreq/intel_pstate: Change to scale off of max P-state
Date: Tue, 20 Aug 2013 11:37:41 -0700
Message-ID: <5213B775.6090008@gmail.com>
References: <1374162523-2777-1-git-send-email-dirk.j.brandewie@gmail.com> <loom.20130801T194134-745@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:49759 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab3HTSho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Aug 2013 14:37:44 -0400
Received: by mail-pb0-f44.google.com with SMTP id xa7so723992pbc.17
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2013 11:37:44 -0700 (PDT)
In-Reply-To: <loom.20130801T194134-745@post.gmane.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guilherme Salazar <gmesalazar@gmail.com>
Cc: linux-pm@vger.kernel.org, dirk.brandewie@gmail.com

On 08/01/2013 10:56 AM, Guilherme Salazar wrote:
>   <dirk.brandewie <at> gmail.com> writes:
>
>>
>> From: Dirk Brandewie <dirk.j.brandewie <at> intel.com>
>>
>> Change to using max P-state instead of max turbo P-state.  This change
>> resolves two issues.
>>
>> On a quiet system intel_pstate can fail to respond to a load change.
>>     https://bugzilla.kernel.org/show_bug.cgi?id=59481
>>
>> On CPU SKUs that have a limited number of P-states and no turbo range
>> intel_pstate fails to select the highest available P-state.
>>
>> This change is suitable for stable v3.9+
>>
>> Reported-by: arjan <at> linux.intel.com
>> Reported-by: dsmythies <at> telus.net
>> Tested-by: arjan <at> linux.intel.com
>> Tested-by: dsmythies <at> telus.net
>>
>> CC: stable <at> vger.kernel.org
>> CC: dsmythies <at> telus.net
>> Signed-off-by: Dirk Brandewie <dirk.j.brandewie <at> intel.com>
>
> Hi,
>
> I've just tested the patch and, even though it works (the frequency now sits
> around 1.3-1.5 GHz), I noticed that if I suspend the laptop and then resume
> it, the abnormal behavior (frequency sitting above 2 GHz) returns.
>
There is a separate bug against the suspend resume behaviour. It is coming
from a bug in the cpufreq core.

https://bugzilla.kernel.org/show_bug.cgi?id=59781

The fix is disscussed in https://lkml.org/lkml/2013/7/29/692 and is queue for 3.12

> Before suspending, the value in
> /sys/devices/system/cpu/intel_pstate/min_perf_pct was 37; afterwards, 100.
>
> cpuinfo: http://pastebin.com/C6zR90HC
>
> I'd be glad to give any further details.
>
> Best,
> Guilherme
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

