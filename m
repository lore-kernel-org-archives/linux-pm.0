From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Resend][PATCH] cpufreq: conservative: Decrease frequency faster
 when the timer deferred
Date: Tue, 8 Nov 2016 09:34:29 +0530
Message-ID: <20161108040429.GI21030@vireshk-i7>
References: <973ac1ee-ff65-9190-762d-13deefdccba2@semaphore.gr>
 <20161107061234.GD21030@vireshk-i7>
 <8acc17f0-d88f-19f6-f7a3-4c66cd65ab96@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8acc17f0-d88f-19f6-f7a3-4c66cd65ab96@semaphore.gr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07-11-16, 19:27, Stratos Karafotis wrote:
> Yes, it could be done only when we decrease frequency. But I thought that maybe
> this is against conservative governor principle.
> 
> I initially observed this issue on a Snapdragon 808 using conservative on the
> big cluster (A57). The CPU seemed to remain in high frequencies for
> long time (even 10 seconds) before it returns to min.
> 
> So, most probably the load after the deferred period is completely unrelated to
> the previous one. If we apply this heuristic only when the frequency will be
> decreased (and having in mind that we copy the load value from the previous
> period), IMHO I'm afraid that the conservative will be still more aggressive even
> from ondemand governor.

The deferred period here is actually the time for which the CPU was idle and not
doing anything.

And I am not sure why we should be worrying about increasing the frequency steps
for the period for which the CPU was idle.

-- 
viresh
