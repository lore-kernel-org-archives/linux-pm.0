From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date: Wed, 5 Dec 2018 15:07:54 -0800
Message-ID: <006901d48cef$5bb88a00$13299e00$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: TnO3gBgeGpqCWTnO8gldCG
In-Reply-To: TnO3gBgeGpqCWTnO8gldCG
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'LKML' <linux-kernel@vger.kernel.org>, 'Linux Documentation' <linux-doc@vger.kernel.org>, 'Peter Zijlstra' <peterz@infradead.org>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2018.12.03 04:32 Rafael J. Wysocki wrote:

> Add two new metrics for CPU idle states, "high" and "low", to count
> the number of times the given state had been asked for (or entered
> from the kernel's perspective), but the observed idle duration turned
> out to be too high or too low for it (respectively).

I wonder about the "high" "low" terminology here.

> These mertics help to estimat the quality of the CPU idle governor
> in use.

Yes, very useful. Thanks.

Here the terms are mixed with "deep" and "shallow"

> +	unsigned long long	high; /* Number of times it's been too deep */
> +	unsigned long long	low;  /* Number of times it's been too shallow */

> +``high``
> +	Total number of times this idle state had been asked for, but the
> +	observed idle duration was too short to match its target residency.
> +

O.K. To avoid ambiguity, how about naming them "too_short" and "too_long"?

> +``low``
> +	Total number of times this idle state had been asked for, but a deeper
> +	idle state would have been a better match for the observed idle duration.

Even though I read the patch, by the time I actually looked at the numbers I had
forgotten the meaning. I had look at idle state 0 and 4 (the deepest for my computer)
to figure it out:

doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/low
259871
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/high
0
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/low
0
doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/high
5584

Because state 0 can not be too short and state 4 can not be too long.

... Doug
