From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: RFC: Leave sysfs nodes alone during hotplug
Date: Mon, 07 Jul 2014 12:30:08 -0700
Message-ID: <53BAF540.9080904@codeaurora.org>
References: <53B5D22F.2070308@codeaurora.org> <CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Rafael's email is bounced. Looks like I used a stale ID. Fixing it in 
this email.

On 07/07/2014 04:01 AM, Viresh Kumar wrote:
> Cc'ing Srivatsa and fixing Rafael's id.
>
> On 4 July 2014 03:29, Saravana Kannan <skannan@codeaurora.org> wrote:
>> The adding and removing of sysfs nodes in cpufreq causes a ton of pain.
>> There's always some stability or deadlock issue every few weeks on our
>> internal tree. We sync up our internal tree fairly often with the upstream
>> cpufreq code. And more of these issues are popping up as we start exercising
>> the cpufreq framework for b.L systems or HMP systems.
>>
>> It looks like we adding a lot of unnecessary complexity by adding and
>> removing these sysfs nodes. The other per CPU sysfs nodes like:
>> /sys/devices/system/cpu/cpu1/power or cpuidle are left alone during hotplug.
>> So, why are we not doing the same for cpufreq too?
>
> This is how it had been since ever, don't know which method is correct.

Rafael, If you don't have any objections, I would like to simplify it.

> Though these are the requirements I have from them:
> - On hotplug files values should get reset ..
> - On suspend/resume values must be retained.

Hmm... There's actually enough interest in NOT reseting across hotplug 
because it's also used by thermal when a CPU gets too hot and then it's 
plugged in later. So, userspace has no way to cleanly restore the 
values. But that's a separate topic.

>> Any objections to leaving them alone during hotplug? If those files are
>> read/written to when the entire cluster is hotplugged off, we could just
>> return an error. I'm not saying it would be impossible to fix all these
>> deadlock and race issues in the current code -- but it seems like a lot of
>> pointless effort to remove/add sysfs nodes.
>
> Lets understand the problem first and then can take the right decision.

My point is more of a, do we even need to allow this problem to happen 
instead of trying and fixing it. I see no benefit at all in 
removing/adding the files during hotplug.

>
>> Examples of issues caused by this:
>> 1. Race when changing governor really quickly from userspace. The governors
>> end up getting 2 STOP or 2 START events. This was introduced by [1] when it
>> tried to fix another deadlock issue.
>
> I was talking about [1] offline with Srivatsa, and one of us might look in
> detail why [1] was actually required.

I believe it has to do with a race that's something along these lines:
1. Echo/store into a sysfs node grabbing a sysfs lock (inside sysfs 
code) before trying to grab one of the cpufreq locks
2. The hotplug path grabbing one of the cpufreq locks before trying to 
remove the sysfs group.

The two START/STOP happens because of [1]. It can happen when userspace 
is quickly changes governors back to back. Or say, multiple threads 
trying to store the same governor. The double START/STOP happens because 
the 2nd request is able to slip in when you unlock the rwsem for sending 
the policy INIT/EXIT.

>
> But I don't know how exactly can we get 2 STOP/START in latest mainline
> code. As we have enough protection against that now.
>
> So, we would really like to see some reports against mainline for this.

Is the above sufficient enough? It's really easy to trigger if you have 
a b.L system. Just slam scaling_governor between performance and another 
governor (or it might have been the same value). b.L is important 
because if you don't have multi-cluster, you don't get POLICY_EXIT often.

>> 2. Incorrect policy/sysfs handling during suspend/resume. Suspend takes out
>> CPU in the order n, n+1, n+2, etc and resume adds them back in the same
>> order. Both sysfs and policy ownership transfer aren't handled correctly in
>> this case.
>
> I know few of these, but can you please tell what you have in mind?

Not sure what you mean by "what you have in mind". Just simple 
suspend/resume is broken. Again, easier to reproduce in b.L system since 
you need to actually have POLICY_EXIT happen.

>> This obviously applies even outside suspend/resume if the same
>> sequence is repeated using just hotplug.
>
> Again, what's the issue?

Just hotplug all CPUs in a cluster in one order and bring it up in 
another. It should crash or panic about sysfs. Basically, the kobj of 
the real sysfs stays with the last CPU that went down, but the first CPU 
that comes up owns the policy without owning the real kobj.

>> I'd be willing to take a shot at this if there isn't any objection to this.
>> It's a lot of work/refactor -- so I don't want to spend a lot of time on it
>> if there's a strong case for removing these sysfs nodes.
>
> Sure, I fully understand this but still wanna understand the issue first.

We might be able to throw around more locks, etc to fix this. But again, 
my main point is that all this seems pointless.

We should just leave the sysfs nodes alone. We won't break any backward 
compatibility since userspace can't be depending on these to be present 
when a CPU was OFFLINE. Anything that depended on that would be broken 
userspace code anyway.

>> P.S: I always find myself sending emails to the lists close to one holiday
>> or another. Sigh.
>
> Sorry for being late to reply to this. I saw it on friday, but couldn't reply
> whole day. Was following something with ticks core. :(

No worries. This was a fast enough :)

>
>> [1] -
>> https://kernel.googlesource.com/pub/scm/linux/kernel/git/rafael/linux-pm/+/955ef4833574636819cd269cfbae12f79cbde63a%5E!/

-Saravana

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
