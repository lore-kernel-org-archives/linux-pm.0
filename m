From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point
 indicator
Date: Mon, 6 Aug 2018 10:43:43 +0100
Message-ID: <20180806094342.lonjz4g3lspcatcy@queper01-lin>
References: <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin>
 <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin>
 <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin>
 <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
 <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
 <20180803155547.sxlhxpmhwcoappit@queper01-lin>
 <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtBT-p-Z0EneirfOTwUw=5jEeDGa+4_EE4ogi2Ht7GU9Bg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 Aug 2018 at 10:40:46 (+0200), Vincent Guittot wrote:
> On Fri, 3 Aug 2018 at 17:55, Quentin Perret <quentin.perret@arm.com> wrote:
> For every new task, the cpu selection is done assuming it's a heavy
> task with the max possible load_avg,  and it looks for the idlest cpu.
> This means that if the system is lightly loaded, scheduler will select
> most probably a idle big core.

Agreed, that is what should happen if the system is lightly loaded.
However, I'm still not totally convinced this is wrong. It's
definitely not _always_ wrong, at least. Just like starting new tasks
on little CPUs isn't always wrong either.

> selecting big or Little is not the problem here. The problem is that
> we don't use Energy Model so we will most probably do the wrong
> choice. Nevertheless,  putting a task on big is clearly the wrong
> choice  in the case I mentioned above " shell script on hikey960".

_You_ can say it's wrong because _you_ know the task composition. The
scheduler has no way to tell. You could come up with a script that
spawns heavy tasks every once in a while, and in this case putting
those on big cores would be beneficial ...

> Having something in the middle like taking into account load and/org
> utilization of the parent in order to mitigate big task starting with
> small utilization and small task starting with big utilization.
> It's probably not perfect because big tasks can create small ones and
> the opposite but if there are already big tasks, assuming that the new
> one is also a big one should have less power impact as we are already
> consuming power for the current bigs. At the opposite, if little are
> running, assuming that new task is little will not harm the power
> consumption unnecessarily.

Right, we can definitely come up with something more conservative than
what I'm currently proposing. I had a quick chat with Morten about this
the other day and one suggestion he had was to pick the CPU with the max
spare cap in the frequency domain in which the parent task is running ...

In any case, I really feel like there isn't an obvious right decision
here, so I'd prefer to keep things simple for now. This patch-set is a
first step, and fine-grained tuning for new tasks is probably something
that can be done later, if need be. What do you think ?

Thanks,
Quentin
