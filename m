From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 27 Jul 2017 11:16:35 +0530
Message-ID: <20170727054635.GJ352@vireshk-i7>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 26-07-17, 22:14, Joel Fernandes (Google) wrote:
> I think you dropped [1] in your cover-letter. May be you meant to add
> it at the end of the cover letter?
> 
> I noticed from your v2 that its:
> https://pastebin.com/7LkMSRxE

Yeah, I missed it. Thanks :)

> Also one more comment about this usecase:
> 
> You mentioned in our discussion at [2] sometime back, about the
> question of initial utilization,
> 
> "We don't have any such configurable way possible right
> now, but there were discussions on how much utilization should a new
> task be assigned when it first comes up."

We still initialize it to a value, just that it isn't configurable.
See below..

> But, then in your cover letter above, you mentioned "This is verified
> using ftrace". So my question is how has this been verified with
> ftrace if the new initial utilization as you said in [2] is currently
> still under discussion? Basically how could you verify with ftrace
> that the target CPU frequency isn't increasing immediately on spawning
> of a new task remotely, if the initial utilization of a new task isn't
> something we set/configure with current code? Am I missing something?
> 
> [2] https://lists.linaro.org/pipermail/eas-dev/2017-January/000785.html

The statement "new tasks should receive maximum demand initially" is
used to represent tasks which have high demand every time they run.
For example scrolling of a web page or gallery on our phones. Yes,
maybe I can use the work "migrated" (as you suggested later) as the
history of its utilization will move with it then to the new CPU.

But even without that, if you see the routine
init_entity_runnable_average() in fair.c, the new tasks are
initialized in a way that they are seen as heavy tasks. And so even
for the first time they run, freq should normally increase on the
target CPU (at least with above application).

The application was written by Steve (all credit goes to him) before
he left Linaro, but I did test it with ftrace. What I saw with ftrace
was that the freq isn't reevaluated for almost an entire tick many
times because we enqueued the task remotely. And that changes with
this series.

> > The reason being that this patchset only targets a corner case, where
> > following are required to be true to improve performance and that
> > doesn't happen too often with these tests:
> >
> > - Task is migrated to another CPU.
> > - The task has maximum demand initially, and should take the CPU to
> 
> Just to make the cover-letter more clear and also confirming with you
> I understand the above usecase, maybe in the future this can reworded
> from "initially" to "before the migration" and "take the CPU" to "take
> the target CPU of the migration" ?

I can reword it a bit, but the test case wasn't really migrating
anything and was looking only at the initial loads.

> >   higher OPPs.
> > - And the target CPU doesn't call into schedutil until the next tick.
> 
> I found this usecase to be more plausible and can see this patch
> series being useful there.
> 
> Could you also keep me in CC on these patches (at joelaf@google.com)?
> I'm interested in this series.

Sure.

-- 
viresh
