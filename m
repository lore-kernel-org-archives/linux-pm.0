From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Thu, 27 Jul 2017 12:49:51 +0530
Message-ID: <20170727071951.GM352@vireshk-i7>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
 <20170727054635.GJ352@vireshk-i7>
 <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 26-07-17, 23:23, Joel Fernandes (Google) wrote:
> Ok, but the "heavy" in init_entity_runnable_average means for load,
> not the util_avg. The util_avg is what's used for frequency scaling
> IIUC and is set to 0 in that function no?

That's because the task isn't enqueued yet and so don't have any
utilization. The last line of that routine is a comment which says:

/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */

But once the task is enqueued, this load_avg will get considered for
sure :)

> > The application was written by Steve (all credit goes to him) before
> > he left Linaro, but I did test it with ftrace. What I saw with ftrace
> > was that the freq isn't reevaluated for almost an entire tick many
> > times because we enqueued the task remotely. And that changes with
> > this series.
> >
> >> > The reason being that this patchset only targets a corner case, where
> >> > following are required to be true to improve performance and that
> >> > doesn't happen too often with these tests:
> >> >
> >> > - Task is migrated to another CPU.
> >> > - The task has maximum demand initially, and should take the CPU to
> >>
> >> Just to make the cover-letter more clear and also confirming with you
> >> I understand the above usecase, maybe in the future this can reworded
> >> from "initially" to "before the migration" and "take the CPU" to "take
> >> the target CPU of the migration" ?
> >
> > I can reword it a bit, but the test case wasn't really migrating
> > anything and was looking only at the initial loads.
> 
> Ok, I wasn't talking about the synthetic test in the second part of my
> email above but about the explanation you gave about Galleryfling
> improvement (that the migration of a task with high utilization
> doesn't update the target frequency) which makes sense to me so we are
> on the same page about that.

Okay, great.

-- 
viresh
