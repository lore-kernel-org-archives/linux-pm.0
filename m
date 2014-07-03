From: Saravana Kannan <skannan@codeaurora.org>
Subject: RFC: Leave sysfs nodes alone during hotplug
Date: Thu, 03 Jul 2014 14:59:11 -0700
Message-ID: <53B5D22F.2070308@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, Linux PM mailing list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

The adding and removing of sysfs nodes in cpufreq causes a ton of pain. 
There's always some stability or deadlock issue every few weeks on our 
internal tree. We sync up our internal tree fairly often with the 
upstream cpufreq code. And more of these issues are popping up as we 
start exercising the cpufreq framework for b.L systems or HMP systems.

It looks like we adding a lot of unnecessary complexity by adding and 
removing these sysfs nodes. The other per CPU sysfs nodes like:
/sys/devices/system/cpu/cpu1/power or cpuidle are left alone during 
hotplug. So, why are we not doing the same for cpufreq too?

Any objections to leaving them alone during hotplug? If those files are 
read/written to when the entire cluster is hotplugged off, we could just 
return an error. I'm not saying it would be impossible to fix all these 
deadlock and race issues in the current code -- but it seems like a lot 
of pointless effort to remove/add sysfs nodes.

Examples of issues caused by this:
1. Race when changing governor really quickly from userspace. The 
governors end up getting 2 STOP or 2 START events. This was introduced 
by [1] when it tried to fix another deadlock issue.

2. Incorrect policy/sysfs handling during suspend/resume. Suspend takes 
out CPU in the order n, n+1, n+2, etc and resume adds them back in the 
same order. Both sysfs and policy ownership transfer aren't handled 
correctly in this case. This obviously applies even outside 
suspend/resume if the same sequence is repeated using just hotplug.

I'd be willing to take a shot at this if there isn't any objection to 
this. It's a lot of work/refactor -- so I don't want to spend a lot of 
time on it if there's a strong case for removing these sysfs nodes.

Thoughts?

-Saravana
P.S: I always find myself sending emails to the lists close to one 
holiday or another. Sigh.

[1] - 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm/+/955ef4833574636819cd269cfbae12f79cbde63a%5E!/

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
