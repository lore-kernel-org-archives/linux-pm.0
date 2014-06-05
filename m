From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [RFC PATCH 06/16] arm: topology: Define TC2 sched energy and
 provide it to scheduler
Date: Thu, 05 Jun 2014 08:03:15 -0700
Message-ID: <539086B3.2010804@gmail.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com> <20140604160230.GS29593@e103034-lin> <20140604172712.GJ13930@laptop.programming.kicks-ass.net> <2484761.vkWavnsDx3@vostro.rjw.lan> <20140605065205.GA3213@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140605065205.GA3213@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: dirk.brandewie@gmail.com, Morten Rasmussen <morten.rasmussen@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

On 06/04/2014 11:52 PM, Peter Zijlstra wrote:
> On Wed, Jun 04, 2014 at 11:56:55PM +0200, Rafael J. Wysocki wrote:
>> On Wednesday, June 04, 2014 07:27:12 PM Peter Zijlstra wrote:
>
>>> Well, we eventually want to go there I think. Although we still needed
>>> to come up with something for Intel, because I'm not at all sure how all
>>> that works.
>>
>> Do you mean power numbers or how P-states work on Intel in general?
>
> P-states, I'm still not at all sure how all that works on Intel and what
> we can sanely do with them.
>
> Supposedly Intel has a means of setting P-states (there's a driver after
> all), but then is completely free to totally ignore it and do something
> entirely different anyhow.

You can request a P state per core but the package does coordination at
a package level for the P state that will be used based on all requests.
This is due to the fact that most SKUs have a single VR and PLL. So
the highest P state wins.  When a core goes idle it loses it's vote
for the current package P state and that cores clock it turned off.

>
> And while APERF/MPERF allows observing what it did, its afaik, nigh on
> impossible to predict wtf its going to do, and therefore any such energy
> computation is going to be a PRNG at best.
>
> Now, given all that I'm not sure what we need that P-state driver for,
> so supposedly I'm missing something.

intel_pstate tries to keep the core P state as low as possible to satisfy
the given load, so when various cores go idle the package P state can be
as low as possible.  The big power win is a core going idle.

>
> Ideally Len (or someone equally in-the-know) would explain to me how
> exactly all that works and what we can rely upon. All I've gotten so far
> is, you can't rely on anything, and magik. Which is entirely useless.
>
The only thing you can rely on is that you will get "at least" the P state
requested in the presence of hardware coordination.
