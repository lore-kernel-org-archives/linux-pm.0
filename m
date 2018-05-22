From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] schedutil: Allow cpufreq requests to be made even
 when kthread kicked
Date: Tue, 22 May 2018 16:26:24 +0530
Message-ID: <20180522105624.ttd6isx7c2ylgzqy@vireshk-i7>
References: <20180518185501.173552-1-joel@joelfernandes.org>
 <20180522103415.cuutobi5kbhj4gcw@vireshk-i7>
 <20180522105157.GX30654@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180522105157.GX30654@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: "Joel Fernandes (Google.)" <joelaf@google.com>, linux-kernel@vger.kernel.org, "Joel Fernandes (Google)" <joel@joelfernandes.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Luca Abeni <luca.abeni@santannapisa.it>, Todd Kjos <tkjos@google.com>, claudio@evidence.eu.com, kernel-team@android.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22-05-18, 11:51, Patrick Bellasi wrote:
> It could happen, but using:
> 
>    raw_spin_lock_irqsave(&sg_policy->update_lock, flags);
>    freq = READ_ONCE(sg_policy->next_freq)
>    WRITE_ONCE(sg_policy->work_in_progress, false);
>    raw_spin_unlock_irqrestore(&sg_policy->update_lock, flags);
> 
>                        if (!READ_ONCE(sg_policy->work_in_progress)) {
>                            WRITE_ONCE(sg_policy->work_in_progress, true);
>                            irq_work_queue(&sg_policy->irq_work);
>                        }

I think its better to get locking in place for non-fast switching case in
single-policy systems right now.

> should fix it by enforcing the ordering as well as documenting the
> concurrent access.
> 
> However, in the "sched update" side, where do we have the sequence:
> 
>    sg_policy->next_freq = 0;
>    sg_policy->next_freq = real-next-freq;

Ah, that was just an example of what a compiler may do (though it shouldn't do).

-- 
viresh
