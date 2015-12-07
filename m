From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 5/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Mon, 07 Dec 2015 02:28:43 +0100
Message-ID: <1517154.7rUJCu3tN2@vostro.rjw.lan>
References: <cover.1449115453.git.viresh.kumar@linaro.org> <2132445.kEr4nQIvso@vostro.rjw.lan> <20151205041042.GU3430@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56386 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752987AbbLGA6r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 6 Dec 2015 19:58:47 -0500
In-Reply-To: <20151205041042.GU3430@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, open list <linux-kernel@vger.kernel.org>

On Saturday, December 05, 2015 09:40:42 AM Viresh Kumar wrote:
> On 05-12-15, 03:14, Rafael J. Wysocki wrote:
> > Well, almost, but not quite yet, because now the question is what prevents
> > gov_cancel_work() from racing with dbs_work_handler().
> > 
> > If you can guarantee that they'll never run in parallel with each other,
> 
> They can run in parallel and that's how we fix it now:
> - raising skip_work to 2 makes sure that no new timer-handler can
>   queue a new work.

What about if that happens in parallel with the decrementation in
dbs_work_handler()?

Is there anything preventing that from happening?

> - After raising the value of skip_work to 2, we do cancel_work_sync().
>   Which will make sure that the work-handler has finished after
>   cancel_work_sync() has returned.
> - At this point of time we are sure that the works and their handlers
>   are completely killed.
> - All that is left is to kill all timer-handler (which might have
>   gotten queued from the work handler, before it finished).
> - And we do that with gov_cancel_timers().
> - And then we are in safe state, where we are guaranteed that there
>   are no leftovers.

Yes, that part will work.

> > you probably don't need the whole counter dance.  Otherwise, dbs_work_handler()
> > should decrement the counter under the spinlock after all I suppose.
> 
> Its not required because we don't have any race around that decrement
> operation.

As I said, if you can guarantee that the decrementation of the counter in
dbs_work_handler() cannot happen at the same time as the incrementation of
it in gov_cancel_work(), all is fine, but can you actually guarantee that?

That aside, I think you could avoid using the spinlock altogether if the
counter was atomic (and which would make the above irrelevant too).

Say, skip_work is atomic the the relevant code in dbs_timer_handler() is
written as

	atomic_inc(&shared->skip_work);
	smp_mb__after_atomic();
	if (atomic_read(&shared->skip_work) > 1)
		atomic_dec(&shared->skip_work);
	else
		queue_work(system_wq, &shared->work);

and the remaining incrementation and decrementation of skip_work are replaced
with the corresponding atomic operations, it still should work, no?

Thanks,
Rafael

