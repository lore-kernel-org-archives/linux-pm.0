From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] cpufreq: skip cpufreq resume if it's not suspended
Date: Thu, 15 Feb 2018 13:27:10 -0800
Message-ID: <5A85FB2E.2050407@codeaurora.org>
References: <1516744675-21233-1-git-send-email-byan@nvidia.com> <dc33ef16-9684-3d8d-f4cc-6e24697f007f@nvidia.com> <20180205040118.GB28462@vireshk-i7> <1710637.vo8uP0oTBm@aspire.rjw.lan> <20180205090546.GE28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180205090546.GE28462@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bo Yan <byan@nvidia.com>, sgurrappadi@nvidia.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 02/05/2018 01:05 AM, Viresh Kumar wrote:
> On 05-02-18, 09:50, Rafael J. Wysocki wrote:
>> By design (which I admit may be confusing) it should be fine to call
>> dpm_resume_end() after a failing dpm_suspend_start(), whatever the reason
>> for the failure is.  cpufreq_suspend/resume() don't take that into account,
>> everybody else does.
>
> Hmm, I see. Can't do much then, just fix the only broken piece of code :)
>

Sorry for the late reply, this email didn't get filtered into the right 
folder.

I think the design of dpm_suspend_start() and dpm_resume_end() generally 
works fine because we seem to keep track of what devices have been 
suspended so far (in the dpm_suspended_list) and call resume only of 
those. So, why isn't the right fix to have cpufreq get put into that 
list? Instead of just always call it on the resume path even if it 
wasn't suspended? That seems to be the real issue.

So, we should either have dpm_suspend/resume() have a flag to keep track 
of if cpufreq_suspend/resume() was called and make sure they are called 
in proper pairs. Or have cpufreq register in a way that gets it put in 
the suspend/resume list.

I'd still like to NACK this change.

-Saravana

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
