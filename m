From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Sat, 5 Dec 2015 09:40:42 +0530
Message-ID: <20151205041042.GU3430@ubuntu>
References: <cover.1449115453.git.viresh.kumar@linaro.org>
 <10439879.00aCyM9quW@vostro.rjw.lan>
 <20151204061101.GA3430@ubuntu>
 <2132445.kEr4nQIvso@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2132445.kEr4nQIvso@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05-12-15, 03:14, Rafael J. Wysocki wrote:
> Well, almost, but not quite yet, because now the question is what prevents
> gov_cancel_work() from racing with dbs_work_handler().
> 
> If you can guarantee that they'll never run in parallel with each other,

They can run in parallel and that's how we fix it now:
- raising skip_work to 2 makes sure that no new timer-handler can
  queue a new work.
- After raising the value of skip_work to 2, we do cancel_work_sync().
  Which will make sure that the work-handler has finished after
  cancel_work_sync() has returned.
- At this point of time we are sure that the works and their handlers
  are completely killed.
- All that is left is to kill all timer-handler (which might have
  gotten queued from the work handler, before it finished).
- And we do that with gov_cancel_timers().
- And then we are in safe state, where we are guaranteed that there
  are no leftovers.

> you probably don't need the whole counter dance.  Otherwise, dbs_work_handler()
> should decrement the counter under the spinlock after all I suppose.

Its not required because we don't have any race around that decrement
operation.

-- 
viresh
