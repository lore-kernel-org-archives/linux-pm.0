From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v5 09/14] sched: Add over-utilization/tipping point indicator
Date: Fri, 3 Aug 2018 15:49:24 +0200
Message-ID: <CAKfTPtDkJY=JYicZk8sM9_mJ-iq+Jwse0oVRbW=wpxXKKnEoeQ@mail.gmail.com>
References: <20180802141424.ju4jxxbk6pxw3kyq@queper01-lin> <CAKfTPtCzQZotmpt40X6uN9O0yAerq6c6bFgiFfqhhcbKsm7k4w@mail.gmail.com>
 <20180802153035.vjtmqwdwujvt7ojs@queper01-lin> <CAKfTPtCGGqykN027kxK+chvKvCpNu4bYYdvfZJ+3_7YzT3Utfg@mail.gmail.com>
 <20180802160009.uhwwj3tqrqmv7q5a@queper01-lin> <CAKfTPtB_tWgOPCB3q2Q2rESKczTPGBDUojcXDY7uP8YTQddBMg@mail.gmail.com>
 <20180802161027.v2ctgscuc4uxbb7u@queper01-lin> <CAKfTPtDtaF9Qs4NWkKWUSr8Ryi-ScYNmPyacocPQUPxT00XAYg@mail.gmail.com>
 <20180802165924.7ywgoxj2jwftxycz@queper01-lin> <CAKfTPtDsG4FJy5xBO8+6pJzehEM668=SZ4yQ-szVTduofN3QZg@mail.gmail.com>
 <20180803081850.hj7bp5ognuywapmd@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803081850.hj7bp5ognuywapmd@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Thara Gopinath <thara.gopinath@linaro.org>, viresh kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, "Cc: Steve Muckle" <smuckle@google.com>, adharmap@quicinc.com, "Kannan, Saravana" <skannan@quicinc.com>, pkondeti@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Fri, 3 Aug 2018 at 10:18, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Friday 03 Aug 2018 at 09:48:47 (+0200), Vincent Guittot wrote:
> > On Thu, 2 Aug 2018 at 18:59, Quentin Perret <quentin.perret@arm.com> wrote:
> > I'm not really concerned about re-enabling load balance but more that
> > the effort of packing of tasks in few cpus/clusters that EAS tries to
> > do can be broken for every new task.
>
> Well, re-enabling load balance immediately would break the nice placement
> that EAS found, because it would shuffle all tasks around and break the
> packing strategy. Letting that sole new task go in find_idlest_cpu()

Sorry I was not clear in my explanation. Re enabling load balance
would be a problem of course. I wanted to say that there is few chance
that this will re-enable the load balance immediately and break EAS
and I'm not worried by this case. But i'm only concerned by the new
task being put outside EAS policy.

For example, if you run on hikey960 the simple script below, which
can't really be seen as a fork bomb IMHO, you will see threads
scheduled on big cores every 0.5 seconds whereas everything should be
packed on little core  :
for i in {0..10}; do
echo "t"$i
sleep 0.5
done

> shouldn't impact the placement of existing tasks. That might have an energy
> cost for that one task, yes, but it's really hard to do anything smarter
> with new tasks IMO ... EAS simply can't work without a utilization value.
>
> > So I wonder what is better for EAS : Make sure to efficiently spread
> > newly created tasks in cas of fork bomb or  try to not break EAS task
> > placement with every newly created tasks
>
> That shouldn't break the placement per se, we're just making one
> temporary exception for new tasks. What do you think 'the right thing'
> to do is ? To just put new tasks on prev_cpu or something like that ?

I think that EAS, which is about saving power, could be a bit power
friendly when it has to make some assumptions about new task.

>
> That might help some use-cases I suppose, but will probably harm others ...
> I'm just not too keen on making assumptions about the size of new tasks,

But you are already doing some assumptions by letting the default
mode, which use load_avg, selecting the task for you. The comment of
the init function of load_avg states:

void init_entity_runnable_average()
{
...
/*
* Tasks are intialized with full load to be seen as heavy tasks until
* they get a chance to stabilize to their real load level.
* Group entities are intialized with zero load to reflect the fact that
* nothing has been attached to the task group yet.
*/

So it means that EAS makes the assumption that new task are heavy
tasks until they get a chance to stabilize

Regards,
Vincent

> that's all. But I'm definitely open to ideas if there is something
> smarter we can do.
>
> Thanks,
> Quentin
