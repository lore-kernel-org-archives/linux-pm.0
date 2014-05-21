From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] cpufreq: Catch double invocations of cpufreq_freq_transition_begin/end
Date: Wed, 21 May 2014 18:02:51 +0530
Message-ID: <537C9CF3.60503@linux.vnet.ibm.com>
References: <20140505072129.14454.25747.stgit@srivatsabhat.in.ibm.com> <alpine.SOC.1.00.1405051152370.17122@math.ut.ee> <5367553C.1040701@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <5367553C.1040701@linux.vnet.ibm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: ego@linux.vnet.ibm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/05/2014 02:39 PM, Srivatsa S. Bhat wrote:
> On 05/05/2014 02:23 PM, Meelis Roos wrote:
>>>
>>> Changes in v3:
>>> Expanded the comment in the code to briefly mention why ASYNC_NOTIFICATION
>>> drivers are left out from the check, as suggested by Gautham R. Shenoy.
>>> No code changes in this version.
>>>
>>> v2: https://lkml.org/lkml/2014/4/29/283
>>> v1: https://lkml.org/lkml/2014/4/28/469
>>
>> Seems to work on VIA EPIA with 3.15-rc2 (no other cpufreq fixes):
>>
> 
> Great! Thanks a lot for testing this!
> 
> Rafael/Viresh, can you please add Meelis' Tested-by while taking
> this patch?

Rafael, any thoughts on this patch?

It has been Acked by Viresh and tested by Meelis. Hope you'll consider
picking up this patch for 3.16.

Thank you!

Regards,
Srivatsa S. Bhat

