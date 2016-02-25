From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFCv7 PATCH 03/10] sched: scheduler-driven cpu frequency selection
Date: Thu, 25 Feb 2016 22:04:29 +0100
Message-ID: <1626887.BDY94X81Py@vostro.rjw.lan>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org> <8427745.Y8N2bqC3SO@vostro.rjw.lan> <20160225092150.GC6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160225092150.GC6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Ricky Liang <jcliang@chromium.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, February 25, 2016 10:21:50 AM Peter Zijlstra wrote:
> On Thu, Feb 25, 2016 at 04:55:57AM +0100, Rafael J. Wysocki wrote:
> > Well, I'm not familiar with static keys and how they work, so you'll need to
> > explain this part to me. 
> 
> See include/linux/jump_label.h, it has lots of text on them. There is
> also Documentation/static-keys.txt

Thanks for the pointers!

It looks like the author of the $subject patch hasn't looked at the latter
document lately.

In any case, IMO this might be used to hide the cpufreq_update_util() call
sites from the scheduler code in case no one has set anything via
cpufreq_set_update_util_data() for any CPUs.

That essentially is when things like the performance governor are in use,
so may be worth doing, but that's your judgement call mostly. :-)

Thanks,
Rafael
