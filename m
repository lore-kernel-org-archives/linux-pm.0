From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 3 Mar 2016 12:06:42 -0800
Message-ID: <56D89952.1010606@linaro.org>
References: <2495375.dFbdlAZmA6@vostro.rjw.lan>
 <1842158.0Xhak3Uaac@vostro.rjw.lan>
 <CAKfTPtANvYp5ar8UkKyN9R25Ntrfp+bEEFw5M0=MA8q7zscSMw@mail.gmail.com>
 <CAJZ5v0jvStPbhKSJUHTwySkEXa0rKp3zE7YLWeCmGHeQt8xcrw@mail.gmail.com>
 <CAKfTPtAtF4Yax9RrwjqfPqpfhtUxYRb-PDj+B_sZehEfQgsSsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtAtF4Yax9RrwjqfPqpfhtUxYRb-PDj+B_sZehEfQgsSsQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 03/03/2016 05:07 AM, Vincent Guittot wrote:
> I mainly want to prevent any useless and periodic frequency switch
> because of an utilization that changes with the current frequency (if
> frequency invariance is not used) and that can make the formula
> selects another frequency than the current one. That what i can see
> when testing it .
> 
> Sorry for the late reply, i was trying to do some test on my board but
> was facing some crash issue (not link with your patchset). So i have
> done some tests and i can see such instable behavior. I have generated
> a load of 33% at max frequency (3ms runs every 9ms) and i can see the
> frequency that toggles without any good reason. Saying that, i can see
> similar thing with ondemand.

FWIW I ran some performance numbers on my chromebook 2. Initially I
forgot to bring in the frequency invariance support but that yielded an
opportunity to see the impact of it.

The tests below consist of a periodic workload. The OH (overhead)
numbers show how close the workload got to running as slow as fmin (100%
= as slow as powersave gov, 0% = as fast as perf gov). The OR (overrun)
number is the count of instances where the busy work exceeded the period.

First a comparison of schedutil with and without frequency invariance.
Run and period are in milliseconds.

			scu (no inv)	scu (w/inv)	
run	period	busy %	OR	OH	OR	OH
1	100	1.00%	0	79.72%	0	95.86%
10	1000	1.00%	0	24.52%	0	71.61%
1	10	10.00%	0	21.25%	0	41.78%
10	100	10.00%	0	26.06%	0	47.96%
100	1000	10.00%	0	6.36%	0	26.03%
6	33	18.18%	0	15.67%	0	31.61%
66	333	19.82%	0	8.94%	0	29.46%
4	10	40.00%	0	6.26%	0	12.93%
40	100	40.00%	0	6.93%	2	14.08%
400	1000	40.00%	0	1.65%	0	11.58%
5	9	55.56%	0	3.70%	0	7.70%
50	90	55.56%	1	4.19%	6	8.06%
500	900	55.56%	0	1.35%	5	6.94%
9	12	75.00%	0	1.60%	56	3.59%
90	120	75.00%	0	1.88%	21	3.94%
900	1200	75.00%	0	0.73%	4	4.41%

Frequency invariance causes schedutil overhead to increase noticeably. I
haven't dug into traces or anything. Perhaps this is due to the
algorithm overshooting then overcorrecting etc., I do not yet know.

Here is a comparison, with frequency invariance, of ondemand and
interactive with schedfreq and schedutil. The first two columns (run and
period) are omitted so the table will fit.

	ondemand	interactive	schedfreq	schedutil	
busy %	OR	OH	OR	OH	OR	OH	OR	OH
1.00%	0	68.96%	0	100.04%	0	78.49%	0	95.86%
1.00%	0	25.04%	0	22.59%	0	72.56%	0	71.61%
10.00%	0	21.75%	0	63.08%	0	52.40%	0	41.78%
10.00%	0	12.17%	0	14.41%	0	17.33%	0	47.96%
10.00%	0	2.57%	0	2.17%	0	0.29%	0	26.03%
18.18%	0	12.39%	0	9.39%	0	17.34%	0	31.61%
19.82%	0	3.74%	0	3.42%	0	12.26%	0	29.46%
40.00%	2	6.26%	1	12.23%	0	6.15%	0	12.93%
40.00%	0	0.47%	0	0.05%	0	2.68%	2	14.08%
40.00%	0	0.60%	0	0.50%	0	1.22%	0	11.58%
55.56%	2	4.25%	5	5.97%	0	2.51%	0	7.70%
55.56%	0	1.89%	0	0.04%	0	1.71%	6	8.06%
55.56%	0	0.50%	0	0.47%	0	1.82%	5	6.94%
75.00%	2	1.65%	1	0.46%	0	0.26%	56	3.59%
75.00%	0	1.68%	0	0.05%	0	0.49%	21	3.94%
75.00%	0	0.28%	0	0.23%	0	0.62%	4	4.41%

Aside from the 2nd and 3rd tests schedutil is showing decreased
performance across the board. The fifth test is particularly bad.

The catch is that I do not have power numbers to go with this data, as
I'm not currently equipped to gather them. So more analysis is
definitely needed to capture the full story.

thanks,
Steve
