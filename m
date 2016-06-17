From: Jisheng Zhang <jszhang@marvell.com>
Subject: RE: regression caused by bb6ab52f2bef ("intel_pstate: Do not set
 utilization update hook too early")
Date: Fri, 17 Jun 2016 15:53:40 +0000
Message-ID: <393b63b7caa7474a97baf248c4891b72@SC-EXCH02.marvell.com>
References: <20160617163023.5bb374f8@xhacker>
 <20160617164054.6339c5d4@xhacker>
 <CAJZ5v0hd9HKUHzEnnBnp4-DmcHXgy1GgMK-st=Bs36rxzYR5xw@mail.gmail.com>
 <20160617131651.GU3923@linux.vnet.ibm.com>
 <20160617140353.GQ30154@twins.programming.kicks-ass.net>
 <2c6f6aab934141e08d9636739a9f7a94@SC-EXCH02.marvell.com>
 <CAJZ5v0jEf0rYZMqL_x8aHaNo4RwAJGqSToO4VxRL7hfsv7BEfg@mail.gmail.com>,<CAJZ5v0hXAVA0B-GgdXKfbotLvU4x73OrHOEpjB1Lg0cfh8G88w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58583 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751097AbcFQPyK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 11:54:10 -0400
In-Reply-To: <CAJZ5v0hXAVA0B-GgdXKfbotLvU4x73OrHOEpjB1Lg0cfh8G88w@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Dear Rafael,

I used intel_pstate.

I just tested v4.7-rc3, which should include commit 4578ee7e1def intel_=
pstate: Avoid
unnecessary synchronize_sched() during initialization, I can still get =
the same=20
wakeups, so it's not sufficient.

Another clue maybe helpful, I found these top2 wakeup/s is consistent, =
e.g
rcu_sched always gives about 10 wakeups/s, and tick_sched_timer gave
5.6-5.9 wakeups/s,=20

            144.3 =B5s/s      10.0        Process        [rcu_sched]

            193.9 =B5s/s       5.7        Timer          tick_sched_tim=
er

Thanks,
Jisheng

________________________________________
=46rom:  Rafael J. Wysocki=20
Sent: Friday, June 17, 2016 23:42
To: Jisheng Zhang
Cc: Peter Zijlstra; Paul E. McKenney; Rafael J. Wysocki; Viresh Kumar; =
linux-pm@vger.kernel.org; Linux Kernel Mailing List
Subject: Re: regression caused by bb6ab52f2bef ("intel_pstate: Do not s=
et utilization update hook too early")

On Fri, Jun 17, 2016 at 5:40 PM, Rafael J. Wysocki  wrote:
> On Fri, Jun 17, 2016 at 5:32 PM, Jisheng Zhang  wrote:
>> Hi all,
>>
>> First of all, sorry for top post, only webmail is available now.
>>
>> Second, sorry again for report incorrect commit, I were too tired th=
is morning so I remember the wrong commit.  The regression is caused by=
 bb6ab52f2bef ("intel_pstate: Do not set utilization update hook too ea=
rly"), so I update the email title.
>
> OK, that makes much more sense. :-)
>
> And
>
> 4578ee7e1def intel_pstate: Avoid unnecessary synchronize_sched()
> during initialization
>
> is not sufficient I suppose?

I mean, it is not sufficient to reduce the number of wakeups again?
