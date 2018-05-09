From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] sched/schedutil: Don't set next_freq to UINT_MAX
Date: Wed, 9 May 2018 14:45:19 +0530
Message-ID: <20180509091519.czq5zu5l7xfhqph4@vireshk-i7>
References: <872c3f8690d9362820639d91a807e535f10a9a36.1525761635.git.viresh.kumar@linaro.org>
 <CAJZ5v0gVpOT81WPFc8shkPa0vzteb6s2r9dBYW9VGz+wcuffGw@mail.gmail.com>
 <20180509084128.s3nu57njyep4tw2w@vireshk-i7>
 <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gAuhUsEg_yLw1kZYE_MnaLFR+X1c9OZCROF2u17RaKOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Claudio Scordino <claudio@evidence.eu.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, "4 . 12+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09-05-18, 10:56, Rafael J. Wysocki wrote:
> I'm kind of concerned about updating the limits via sysfs in which
> case the cached next frequency may be out of range, so it's better to
> invalidate it right away then.

That should not be a problem as __cpufreq_driver_target() will anyway
clamp the target frequency to be within limits, whatever the cached
value of next_freq is.

And we aren't invalidating the cached next freq immediately currently
as well, as we are waiting until the next time the util update handler
is called to set sg_policy->next_freq to UINT_MAX.

> > What else do you have in mind to solve this problem ?
> 
> Something like the below?
> 
> ---
>  kernel/sched/cpufreq_schedutil.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -305,7 +305,8 @@ static void sugov_update_single(struct u
>       * Do not reduce the frequency if the CPU has not been idle
>       * recently, as the reduction is likely to be premature then.
>       */
> -    if (busy && next_f < sg_policy->next_freq) {
> +    if (busy && next_f < sg_policy->next_freq &&
> +        sg_policy->next_freq != UINT_MAX) {
>          next_f = sg_policy->next_freq;
> 
>          /* Reset cached freq as next_freq has changed */

This will fix the problem we have identified currently, but adding a
special meaning to next_freq == UINT_MAX invites more hidden corner
cases like the one we just found. IMHO, using next_freq only for the
*real* frequency values makes its usage more transparent and readable.
And we already have the need_freq_update flag which we can use for
this special purpose, as is done in my patch.

-- 
viresh
