From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: RFC: Leave sysfs nodes alone during hotplug
Date: Tue, 8 Jul 2014 08:06:56 +0530
Message-ID: <CAKohponkZrJNeFxTTDi9bsbvFfey2K_guCGZGsraA1qeeRW3pw@mail.gmail.com>
References: <53B5D22F.2070308@codeaurora.org>
	<CAKohpomuPshe4HpvWSzmZ3vvAjV-zHucfHBVbhB6dUBrrYH8pw@mail.gmail.com>
	<53BAF540.9080904@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <53BAF540.9080904@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Srivatsa S. Bhat" <srivatsa@mit.edu>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM mailing list <linux-pm@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 8 July 2014 01:00, Saravana Kannan <skannan@codeaurora.org> wrote:
> Rafael's email is bounced. Looks like I used a stale ID. Fixing it in this
> email.

Because you have the wrong address initially, which I fixed and told you
below. You missed that and again added the wrong address :)

Fixing it yet again. Don't change it now :)

> On 07/07/2014 04:01 AM, Viresh Kumar wrote:
>> Though these are the requirements I have from them:
>> - On hotplug files values should get reset ..
>> - On suspend/resume values must be retained.
>
>
> Hmm... There's actually enough interest in NOT reseting across hotplug
> because it's also used by thermal when a CPU gets too hot and then it's
> plugged in later. So, userspace has no way to cleanly restore the values.
> But that's a separate topic.

Okay, will think about it more and see what's the right thing to do apart
from the requirements we have.

> My point is more of a, do we even need to allow this problem to happen
> instead of trying and fixing it. I see no benefit at all in removing/adding
> the files during hotplug.

We can surely think separately if leaving these sysfs directories is the
right thing to do, but we need to see why this bug is shown up again.

>> I was talking about [1] offline with Srivatsa, and one of us might look in
>> detail why [1] was actually required.
>
>
> I believe it has to do with a race that's something along these lines:
> 1. Echo/store into a sysfs node grabbing a sysfs lock (inside sysfs code)
> before trying to grab one of the cpufreq locks
> 2. The hotplug path grabbing one of the cpufreq locks before trying to
> remove the sysfs group.
>
> The two START/STOP happens because of [1]. It can happen when userspace is
> quickly changes governors back to back. Or say, multiple threads trying to
> store the same governor. The double START/STOP happens because the 2nd
> request is able to slip in when you unlock the rwsem for sending the policy
> INIT/EXIT.

Yeah, we still need to see how can we avoid dropping of locks before exit.

>> But I don't know how exactly can we get 2 STOP/START in latest mainline
>> code. As we have enough protection against that now.
>>
>> So, we would really like to see some reports against mainline for this.
>
>
> Is the above sufficient enough? It's really easy to trigger if you have a
> b.L system. Just slam scaling_governor between performance and another
> governor (or it might have been the same value). b.L is important because if
> you don't have multi-cluster, you don't get POLICY_EXIT often.

Hmm, b.L. isn't new to cpufreq. I did worked a lot with it over one and half
year back which working on TC2, and that's when I came very close to
cpufreq internals.

There were lots of problems around hotplug paths, etc, but all are fixed
now and nothing pending is in my knowledge.

And inside Linaro we do have automated testing going on TC2 with
hotplug/suspend/resume tests and nothing is reported since sometime.
We also have Juno (64 bit b.L.) onboard now, and nothing reported on
that as well.

> Not sure what you mean by "what you have in mind". Just simple

I meant the problem you are trying to mention.

> suspend/resume is broken. Again, easier to reproduce in b.L system since you
> need to actually have POLICY_EXIT happen.

Oh, I want to believe that but couldn't. This has been tested well on
TC2. Can you show something against mainline to prove this issue?
I tend to believe that you are working with some old version of tree..

> Just hotplug all CPUs in a cluster in one order and bring it up in another.
> It should crash or panic about sysfs. Basically, the kobj of the real sysfs
> stays with the last CPU that went down, but the first CPU that comes up owns
> the policy without owning the real kobj.

These issues were already fixed, can you try mainline please?

> We might be able to throw around more locks, etc to fix this. But again, my
> main point is that all this seems pointless.

No more locks. But I do agree that we need some simplicity in code here.
Will address that separately, lets fix your issues first.
