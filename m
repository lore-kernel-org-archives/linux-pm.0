From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/3] Cpufreq frequency serialization fixes
Date: Tue, 29 Apr 2014 00:17:44 +0530
Message-ID: <535EA250.5060700@linux.vnet.ibm.com>
References: <20140425081728.10258.63980.stgit@srivatsabhat.in.ibm.com> <alpine.SOC.1.00.1404252028410.11626@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <alpine.SOC.1.00.1404252028410.11626@math.ut.ee>
Sender: cpufreq-owner@vger.kernel.org
To: Meelis Roos <mroos@linux.ee>
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/25/2014 10:59 PM, Meelis Roos wrote:
>> Meelis Roos reported hangs during boot in the longhaul cpufreq driver, after
>> commit 12478cf0c55 (cpufreq: Make sure frequency transitions are serialized).
>> The root-cause of this issue is the extra invocation of the
>> cpufreq_freq_transition_begin() and cpufreq_freq_transition_end() APIs in the
>> longhaul driver. I found similar issues in the powernow-k6 and powernow-k7
>> drivers as well. This patchset fixes the issue in all the 3 drivers.
>>
>>  Srivatsa S. Bhat (3):
>>       cpufreq, powernow-k7: Fix double invocation of cpufreq_freq_transition_begin/end
>>       cpufreq, powernow-k6: Fix double invocation of cpufreq_freq_transition_begin/end
>>       cpufreq, longhaul: Fix double invocation of cpufreq_freq_transition_begin/end
> 
> This set fixes it for me on VIA EPIA with longhaul.
> 

Thanks a lot for testing this Meelis! I'll send out the v2
soon.

Regards,
Srivatsa S. Bhat

