From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Sun, 26 Jul 2015 00:46:41 +0200
Message-ID: <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan>
	<20150724140943.GC16336@linux>
	<1509688.KKhdi8M36y@vostro.rjw.lan>
	<11080992.c5Q5Du7n5n@vostro.rjw.lan>
	<20150725130002.GC1691@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150725130002.GC1691@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Sat, Jul 25, 2015 at 3:00 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 25-07-15, 00:17, Rafael J. Wysocki wrote:
>> To avoid that warning, use the observation that cpufreq doesn't
>> need to care about CPUs that have never been online.
>
> I have concerns over the very philosophy behind the patch and so
> wanted to discuss more on that.
>
> It will be really confusing to have a scenario where:
> - we have a four related CPUs: 0-3.
> - 0-1 are online and have /sys/devices/system/cpu/cpuX/cpufreq directory
> - 2 is offline but was once online and so still has a directory
> - 3 never came online after the cpufreq driver is registered (we need
>   to think about cpufreq driver being a module here, its possible CPU
>   was online earlier) and so it doesn't have a directory.
>
> How will the user distinguish between cpu 3 and 4, both being offline
> and user may not know one of them was never online. And the related
> CPUs of 0-2 will include CPU 3 as well..

So the problem is that a CPU (which is present) listed by related_cpus
does not have a symbolic link to the policy, right?

That is a valid point, although related_cpus can list CPUs that aren't
present even in theory.  That is a super corner case, however.

> I think, we just moved into the wrong direction. We have a valid
> policy for CPU4, with all valid data. Why not show it up in sysfs?

And why do we care?  The CPU is offline and may never go online before
the cpufreq driver is unloaded.

> So, what we discussed over IRC earlier was, cpufreq shouldn't care
> about CPUs, which are offline and that don't have a policy allocated
> for them. So if all the CPUs of a policy never came online after the
> driver is registered, we shouldn't care about them.

That's an alternative really.  Either we don't care about offline CPUs
and only preserve their sysfs stuff once it's been created (just in
case we need it again when the CPU goes online), or we do care about
offline CPUs that share a policy object wirh at least one online CPU.
The code is slightly simpler in the former case and the information
seen by user space is slightly more consistent in the latter case.

We need to make a choice and you seem to be preferring the second
option.  I'm fine with that, if we choose this one, it really only
makes sense to create all of the links from present CPUs to the policy
object at the time that object is created to avoid havig a (presumably
small) window in which inconsistent information may be seen by user
space.

> I think, for know your earlier version of the patch was just fine,
> with the improvements I suggested. And we should go ahead with
> solution like what I gave, the diff of that was quite big for an rc
> fix and so I said your patch looks better.

OK, I'll prepare a new version of that patch then, but as I said this
choice means that we'll be creating the links to the policy at the
policy creation time going forward.

Thanks,
Rafael
