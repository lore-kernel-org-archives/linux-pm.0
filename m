From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 6/10] cpufreq: Support for fast frequency switching
Date: Sat, 5 Mar 2016 01:18:41 +0100
Message-ID: <CAJZ5v0gqnDR8BJ6JUKBB7-T8MAhNge9TPngZ9Crc45TRzm04vQ@mail.gmail.com>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
	<2409306.qzzMXcm4dm@vostro.rjw.lan>
	<15684081.T4iOMUSHCY@vostro.rjw.lan>
	<56DA09B1.4010005@linaro.org>
	<CAJZ5v0jENyu8j0fq1-BhU64QwRHAjvcjQktYc2sa9QmhktoEnQ@mail.gmail.com>
	<CAJZ5v0jd6sXQnvZ87=_L1MQgu2QsBJtYb8jwn=0=m7eRdKVvhA@mail.gmail.com>
	<CAJZ5v0jh7qcmYjDXCdO3Pid4XyuuxQfsKAmWDLXYcrkx0t-phw@mail.gmail.com>
	<56DA20C0.1070803@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56DA20C0.1070803@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 5, 2016 at 12:56 AM, Steve Muckle <steve.muckle@linaro.org> wrote:
> On 03/04/2016 03:18 PM, Rafael J. Wysocki wrote:
>> In fact, the mechanism may be relatively simple if I'm not mistaken.
>>
>> In the "fast switch" case, the governor may spawn a work item that
>> will just execute cpufreq_get() on policy->cpu.  That will notice that
>> policy->cur is different from the real current frequency and will
>> re-adjust.
>>
>> Of course, cpufreq_driver_fast_switch() will need to be modified so it
>> doesn't update policy->cur then perhaps with a comment that the
>> governor using it will be responsible for that.
>>
>> And the governor will need to avoid spawning that work item too often
>> (basically, if one has been spawned already and hasn't completed, no
>> need to spawn a new one, and maybe rate-limit it?), but all that looks
>> reasonably straightforward.
>
> It is another option though definitely a compromise. The semantics seem
> different since you'd potentially have multiple freq changes before a
> single notifier went through, so stuff might still break.

Here I'm not worried.  That's basically equivalent to someone doing a
"get" and seeing an unexpected frequency in the driver output which is
covered already and things need to cope with it or they are just
really broken.

> The fast path would also be more expensive given the workqueue activity that could
> translate into additional task wakeups.

That's a valid concern, so maybe there can be a driver flag to
indicate that this has to be done if ->fast_switch is in use?  Or
something like fast_switch_notify_rate that will tell the governor how
often to notify things about transitions if ->fast_switch is in use
with either 0 or all ones meaning "never"?  That might be a policy
property even, so the driver may set this depending on what platform
it is used on.

> Honestly I wonder if it's better to just try the "no notifiers with fast
> drivers" approach to start. The notifiers could always be added if
> platform owners complain that they absolutely require them.

Well, I'm not sure what happens if we start to fail notifier
registrations.  It may not be a well tested error code path. :-)

Besides, there is the problem with registering notifiers before the
driver and I don't think we can fail driver registration if notifiers
have already been registered.  We may not be able to register a "fast"
driver at all in that case.

But that whole thing is your worry, not mine. :-)

Had I been worrying about that, I would have added some bandaid for
that to the patches.

Thanks,
Rafael
