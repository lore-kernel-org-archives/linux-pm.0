From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Eas-dev] [PATCH V3 2/3] cpufreq: schedutil: Process remote
 callback for shared policies
Date: Thu, 20 Jul 2017 16:11:38 +0100
Message-ID: <fec9b074-49d2-18ea-a259-4b1b372deae7@arm.com>
References: <cover.1499927699.git.viresh.kumar@linaro.org>
 <3fbaa9aaba19bfff5ff25d2c4141e88fb83f1ea9.1499927699.git.viresh.kumar@linaro.org>
 <5968263D.1020801@codeaurora.org>
 <20170720122239.licc6yjd7jwipcvk@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720122239.licc6yjd7jwipcvk@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Saravana Kannan <skannan@codeaurora.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, smuckle.linux@gmail.com, eas-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org



On 20/07/17 13:22, Peter Zijlstra wrote:
> On Thu, Jul 13, 2017 at 07:02:37PM -0700, Saravana Kannan wrote:
>> In all Qualcomm chipsets (well, at least the ones that have been used in
>> Android devices so far), we can switch the frequency of any CPU from any
>> other CPU. If we can do that even without fast switching, why wouldn't any
>> theoretical fast switching be incapable of supporting this? Is this a
>> limitation specific to x86 that we are assuming all architectures and
>> platforms are going to have?
> 
> So the typical implementation of fast switching we're thinking of is the
> CPU writing the DVFS request into a machine register. Now machine
> registers are typically per logical CPU.
> 

But, if ARM decides to architect and move to it to a system/machine
register, we will end up with the same limitation :( IMO.

For now with SCMI kind of interface, there's no such limitation as
yoalready mentioned in the follow up email.
-- 
Regards,
Sudeep
