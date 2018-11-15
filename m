From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v5] cpuidle: New timer events oriented governor for tickless systems
Date: Thu, 15 Nov 2018 03:56:33 +0100
Message-ID: <9662418.c5ysHFetnm@aspire.rjw.lan>
References: <102783770.7hZjAahU8c@aspire.rjw.lan> <1541877001.17878.5.camel@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541877001.17878.5.camel@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Giovanni Gherdovich <ggherdovich@suse.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, November 10, 2018 8:10:01 PM CET Giovanni Gherdovich wrote:
> On Thu, 2018-11-08 at 18:25 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] cpuidle: New timer events oriented governor for tickless systems
> > 

[cut]

> [NOTE: the tables in this message are quite wide, ~130 columns. If this
> doesn't get to you properly formatted you can read a copy of this message at
> the URL https://beta.suse.com/private/ggherdovich/teo-eval/teo-eval.html ]
> 
> 
> Hello Rafael,
> 
> I have results for v3 and v5. Regarding v4, I made a mistake and didn't get
> valid data; as I saw v5 coming shortly after, I didn't rerun v4.
> 
> I'm replying to the v5 thread because that's where these results belong, but
> I'm quoting your text from the v2 email at
> https://lore.kernel.org/lkml/4168371.zz0pVZtGOY@aspire.rjw.lan so that's
> easier to follow along.

Thanks for the results, much appreciated!

> The quick summary is:
> 
> ---> sockperf on loopback over UDP, mode "throughput":
>      this had a 12% regression in v2 on 48x-HASWELL-NUMA, which is completely
>      recovered in v3 and v5. Good stuff.

That's good news, thanks!

> ---> dbench on xfs:
>      this was down 16% in v2 on 48x-HASWELL-NUMA. On v5 we're at a 10%
>      regression. Slight improvement. What's really hurting here is the single
>      client scenario.
> 
> ---> netperf-udp on loopback:
>      had 6% regression on v2 on 8x-SKYLAKE-UMA, which is the same as what
>      happens in v5.
> 
> ---> tbench on loopback:
>      was down 10% in v2 on 8x-SKYLAKE-UMA, now slightly worse in v5 with a 12%
>      regression. As in dbench, it's at low number of clients that the results
>      are worst. Note that this machine is different from the one that has the
>      dbench regression.

Clearly, playing with the pattern detection part of the governor alone is not
sufficient to make all of the workloads happy at the same time.

> A more detailed report follows below.
> 
> I maintain my original opinion from v2 that this governor is largely
> performance-neutral and I'm not overly worried about the numbers above:

OK, fair enough.

Cheers,
Rafael
