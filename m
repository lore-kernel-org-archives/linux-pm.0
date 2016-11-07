From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] cpufreq: powernv: Use PMSR to verify global and local
 pstate
Date: Mon, 7 Nov 2016 13:02:10 +0530
Message-ID: <ce785008-f387-3e3f-243d-5d701fafc572@linux.vnet.ibm.com>
References: <1478237255-4258-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1478237255-4258-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20161104064132.GB3414@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35939 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751012AbcKGHdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Nov 2016 02:33:16 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uA77SttR029973
        for <linux-pm@vger.kernel.org>; Mon, 7 Nov 2016 02:32:23 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
        by mx0a-001b2d01.pphosted.com with ESMTP id 26j6v3vkmx-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Mon, 07 Nov 2016 02:32:23 -0500
Received: from localhost
        by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <akshay.adiga@linux.vnet.ibm.com>;
        Mon, 7 Nov 2016 17:32:18 +1000
In-Reply-To: <20161104064132.GB3414@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Thanks Viresh for taking a look at it.

I will make the mentioned changes in the next version of the patch and
will add Shilpa and Gautham to the mail chain.

Regards

Akshay Adiga


On 11/04/2016 12:11 PM, Viresh Kumar wrote:
> On 04-11-16, 10:57, Akshay Adiga wrote:
>> As fast_switch may get called in interrupt disable mode, it does not
> s/in interrupt disable mode/with interrupts disabled
> s/it does/it may
>
>> update the global_pstate_info data structure. Hence the global_pstate_info
>> has stale data whenever pstate is updated through fast_swtich().
> s/has/may have
> s/swtich/switch
>
>> So the gpstate_timer can fire after a fast_switch() call has update
> s/So the/The
> s/a fast_swtich() call has update/the fast_switch() call has updated
>
>> the pstates to a different value. Hence the timer handler cannot rely
>> on the cached values of local and global pstate and needs to read it
>> from the PMSR.
>>
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>>
>> ---
>>   drivers/cpufreq/powernv-cpufreq.c | 32 ++++++++++++++++++++++----------
>>   1 file changed, 22 insertions(+), 10 deletions(-)
> I am not the best guy to judge the code changes here. Can you please include
> Shilpa and Gautham to the mail chain and get there feedback.
>
>
>


