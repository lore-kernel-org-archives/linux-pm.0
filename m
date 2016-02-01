From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC PATCH 11/19] cpufreq: assert policy->rwsem is held in __cpufreq_governor
Date: Mon, 1 Feb 2016 11:22:27 +0100
Message-ID: <CAJZ5v0gzKkoKsbv_KG0qL-7=j4a3DU-nOTCG71fZcoumQ0UZUw@mail.gmail.com>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
	<20160112102025.GC1084@ubuntu>
	<56AC04E3.8090900@codeaurora.org>
	<1703921.2AHaiQoggk@vostro.rjw.lan>
	<20160201060943.GH13476@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160201060943.GH13476@vireshk>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Saravana Kannan <skannan@codeaurora.org>, Juri Lelli <juri.lelli@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Turquette <mturquette@baylibre.com>, Steve Muckle <steve.muckle@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, dietmar.eggemann@arm.com
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 1, 2016 at 7:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 30-01-16, 12:49, Rafael J. Wysocki wrote:
>> On Friday, January 29, 2016 04:33:39 PM Saravana Kannan wrote:
>> > AFAIR, the ABBA issue was between the sysfs lock and the policy lock.
>
> Yeah, to be precise here it is:
>
> CPU0 (sysfs read)               CPU1 (exit governor)
>
> sysfs-read                      set_policy()-> lock policy->rwsem
> sysfs-active lock               Remove sysfs files
> lock policy->rwsem              sysfs-active lock
> Actual read
>
>> > The fix for that issue should not be dropping the lock around
>> > POLICY_EXIT.
>>
>> Right.  Dropping the lock is a mistake (which I overlooked, sadly).
>
> I joined the party at around time of 3.10, and we had this problem and
> hacky solution then as well. We tried to get rid of it multiple times,
> but sadly failed.

I kind of like your idea of accessing governor attributes without
holding the policy rwsem.

I looked at that code and it seems doable to me.  The problem to solve
there would be to ensure that the dbs_data pointer is valid when
show/store runs for those attributes.

The fact that we make the distinction between global and policy
governors in there doesn't really help, but it looks like getting rid
of that bit wouldn't be too much effort.  Let me take a deeper look at
that.

Thanks,
Rafael
