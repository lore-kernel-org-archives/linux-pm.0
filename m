From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 3/3] cpufreq: schedutil: map raw required frequency to
 driver frequency
Date: Mon, 30 May 2016 15:48:30 +0530
Message-ID: <20160530101830.GE30066@vireshk-i7>
References: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
 <1464231181-30741-4-git-send-email-smuckle@linaro.org>
 <20160526071629.GW17585@vireshk-i7>
 <CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gxfRBeQTyHACVtRpon50N_t3qytrFPT4ga2zwPhVYYdw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 29-05-16, 02:40, Rafael J. Wysocki wrote:
> I can't really parse the above question, so I'm not going to try to
> answer it. :-)

Sorry about that :(

IOW, I think that we should make this change into the sched-governor (I will
send a patch separately if you agree to this):

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14c4aa25cc45..5934b14aa21c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -66,11 +66,6 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 
        if (unlikely(sg_policy->need_freq_update)) {
                sg_policy->need_freq_update = false;
-               /*
-                * This happens when limits change, so forget the previous
-                * next_freq value and force an update.
-                */
-               sg_policy->next_freq = UINT_MAX;
                return true;
        }

And here is my reasoning behind this.

Can you show me any case, where the above code (as present in mainline
today) leads to a freq-change? I couldn't find any.

Let me demonstrate.

Following only talks about the fast-switch path, the other path is
same as well.

Suppose this is the current range of frequencies supported by a
driver: 200, 400, 600, 800, 1000 (in MHz).

And policy->cur = next_freq = 400 MHz.

A.) Suppose that we change policy->min to 400 MHz from userspace.
    -> sugov_limits()
       This will find everything in order and simply set
       need_freq_update, without updating the frequency.

    On next util-callback, we will forcefully return true from
    sugov_should_update_freq() and reach sugov_update_commit().

    We calculate next_freq and that comes to 400 MHz again (that's the
    case we are trying to target with the above code).

    With the current code, we will forcefully end up calling
    cpufreq_driver_fast_switch().

    Because the new and current frequencies are same,
    cpufreq_driver->fast_switch() will simply return.

    NOTE: I also think that cpufreq_driver_fast_switch() should have a
    check like (policy->cur == target_freq). I will add that too, in
    case you agree.

    So, forcefully updating next_freq to UINT_MAX will end up wasting
    some cycles, but wouldn't do any useful stuff.

B.) Suppose that we change policy->min to 600 MHz from userspace.
    -> sugov_limits()
       This will find that policy->cur is less than 600 and will set
       that to 600 MHz by calling __cpufreq_driver_target(). We will
       also set need_freq_update.

       Note that next_freq and policy->cur are not in sync anymore and
       perhaps this is the most important case for the above code.

    On next util-callback, we will forcefully return true from
    sugov_should_update_freq() and reach sugov_update_commit().

    We calculate next_freq and lets say that comes to 400 MHz again
    (as that's the case we are trying to target with the above code).

    With the current code, we will forcefully end up calling
    cpufreq_driver_fast_switch().

    Because next_freq() is not part of the new range, we will clamp it
    and set it to 600 MHz eventually. Again, next and current
    frequencies are same, cpufreq_driver->fast_switch() will simply
    return.

    So, forcefully updating next_freq to UINT_MAX will end up wasting
    some cycles here as well, but would do any useful stuff.


What am I missing ?

-- 
viresh
