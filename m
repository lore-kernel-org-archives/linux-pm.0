From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 0/3] sched: cpufreq: Allow remote callbacks
Date: Wed, 26 Jul 2017 23:23:21 -0700
Message-ID: <CAEi0qN=e9sL+ndTerAwcJTwCsmzJiwgtWkSk3Coa0Qzvyzdb2Q@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <CAEi0qNmuPLG68o0XZy5BTZO7=MwAkUdobOs=m4Fa6NYJ2q6B6w@mail.gmail.com>
 <20170727054635.GJ352@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34623 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdG0GXX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 02:23:23 -0400
In-Reply-To: <20170727054635.GJ352@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>

Hi Viresh,

On Wed, Jul 26, 2017 at 10:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 26-07-17, 22:14, Joel Fernandes (Google) wrote:
<snip>
>> Also one more comment about this usecase:
>>
>> You mentioned in our discussion at [2] sometime back, about the
>> question of initial utilization,
>>
>> "We don't have any such configurable way possible right
>> now, but there were discussions on how much utilization should a new
>> task be assigned when it first comes up."
>
> We still initialize it to a value, just that it isn't configurable.
> See below..
>
>> But, then in your cover letter above, you mentioned "This is verified
>> using ftrace". So my question is how has this been verified with
>> ftrace if the new initial utilization as you said in [2] is currently
>> still under discussion? Basically how could you verify with ftrace
>> that the target CPU frequency isn't increasing immediately on spawning
>> of a new task remotely, if the initial utilization of a new task isn't
>> something we set/configure with current code? Am I missing something?
>>
>> [2] https://lists.linaro.org/pipermail/eas-dev/2017-January/000785.html
>
> The statement "new tasks should receive maximum demand initially" is
> used to represent tasks which have high demand every time they run.
> For example scrolling of a web page or gallery on our phones. Yes,
> maybe I can use the work "migrated" (as you suggested later) as the
> history of its utilization will move with it then to the new CPU.
>
> But even without that, if you see the routine
> init_entity_runnable_average() in fair.c, the new tasks are
> initialized in a way that they are seen as heavy tasks. And so even
> for the first time they run, freq should normally increase on the
> target CPU (at least with above application).i

Ok, but the "heavy" in init_entity_runnable_average means for load,
not the util_avg. The util_avg is what's used for frequency scaling
IIUC and is set to 0 in that function no?

>
> The application was written by Steve (all credit goes to him) before
> he left Linaro, but I did test it with ftrace. What I saw with ftrace
> was that the freq isn't reevaluated for almost an entire tick many
> times because we enqueued the task remotely. And that changes with
> this series.
>
>> > The reason being that this patchset only targets a corner case, where
>> > following are required to be true to improve performance and that
>> > doesn't happen too often with these tests:
>> >
>> > - Task is migrated to another CPU.
>> > - The task has maximum demand initially, and should take the CPU to
>>
>> Just to make the cover-letter more clear and also confirming with you
>> I understand the above usecase, maybe in the future this can reworded
>> from "initially" to "before the migration" and "take the CPU" to "take
>> the target CPU of the migration" ?
>
> I can reword it a bit, but the test case wasn't really migrating
> anything and was looking only at the initial loads.

Ok, I wasn't talking about the synthetic test in the second part of my
email above but about the explanation you gave about Galleryfling
improvement (that the migration of a task with high utilization
doesn't update the target frequency) which makes sense to me so we are
on the same page about that.

thanks,

-Joel
