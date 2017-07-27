From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Eas-dev] [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq
 callbacks
Date: Thu, 27 Jul 2017 11:20:26 +0530
Message-ID: <20170727055026.GK352@vireshk-i7>
References: <cover.1501060871.git.viresh.kumar@linaro.org>
 <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
 <CAEi0qN=ipk9SR+3DYcLk-5SoKnsfK=PQV62VH9KAoXz2PDRkjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEi0qN=ipk9SR+3DYcLk-5SoKnsfK=PQV62VH9KAoXz2PDRkjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

On 26-07-17, 22:34, Joel Fernandes (Google) wrote:
> On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > @@ -221,7 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
> >         sugov_set_iowait_boost(sg_cpu, time, flags);
> >         sg_cpu->last_update = time;
> >
> > -       if (!sugov_should_update_freq(sg_policy, time))
> > +       if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
> >                 return;
> 
> Since with the remote callbacks now possible, isn't it unsafe to
> modify sg_cpu and sg_policy structures without a lock in
> sugov_update_single?
> 
> Unlike sugov_update_shared, we don't acquire any lock in
> sugov_update_single before updating these structures. Did I miss
> something?

As Peter already mentioned it earlier, the callbacks are called with
rq locks held and so sugov_update_single() wouldn't get called in
parallel for a target CPU.

That's the only race you were worried about ?

-- 
viresh
