From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 0/5] Cpufreq frequency serialization fixes
Date: Tue, 29 Apr 2014 11:29:32 +0530
Message-ID: <535F3FC4.7050906@linux.vnet.ibm.com>
References: <20140428185331.28755.899.stgit@srivatsabhat.in.ibm.com> <9665161.ytKRFCMQPA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <9665161.ytKRFCMQPA@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: mroos@linux.ee, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 04/29/2014 05:17 AM, Rafael J. Wysocki wrote:
> On Tuesday, April 29, 2014 12:23:54 AM Srivatsa S. Bhat wrote:
>>
>> Hi,
>>
>> Meelis Roos reported hangs during boot in the longhaul cpufreq driver, after
>> commit 12478cf0c55 (cpufreq: Make sure frequency transitions are serialized).
>> The root-cause of this issue is the extra invocation of the
>> cpufreq_freq_transition_begin() and cpufreq_freq_transition_end() APIs in the
>> longhaul driver. I found similar issues in the powernow-k6 and powernow-k7
>> drivers as well. This patchset fixes the issue in all the 3 drivers and also
>> adds a debug infrastructure to catch such issues easily.
>>
>> Patches 1-4 fix the regression in longhaul, powernow-k6 and powernow-k7
>> drivers. (Patch 2 fixes a different bug in powernow-k6, and it is kept as a
>> separate patch instead of merging it with patch 3, because I felt that it was
>> a bit subtle and needed attention in a separate patch).
>>
>> Patch 5 adds a debug infrastructure to the cpufreq core to catch such problems
>> more easily in the future.
> 
> I've queued up patches [1-4/5] for 3.15, the last one I need to have another
> look at tomorrow.

Great! Thanks a lot!

> 
> BTW, when you fix regressions, please always add a Fixes: tag to the changelog.
>

Oh, ok, will keep that in mind from next time. Thank you!
 
Regards,
Srivatsa S. Bhat

