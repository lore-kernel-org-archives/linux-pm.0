From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC/RFT][PATCH v8] cpuidle: New timer events oriented governor
 for tickless systems
Date: Mon, 17 Dec 2018 12:59:48 +0100
Message-ID: <CAJZ5v0hg3pGoptF4oC4+=1n5y8cGsqOSoJeSaRzC-6tmvqEnjA@mail.gmail.com>
References: <000001d495ab$5c16eea0$1444cbe0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <000001d495ab$5c16eea0$1444cbe0$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Giovanni Gherdovich <ggherdovich@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Mel Gorman <mgorman@suse.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, hu1.chen@intel.com, Quentin Perret <quentin.perret@arm.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 17, 2018 at 2:53 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> On 2018.12.11 03:50 Rafael J. Wysocki wrote:
>
> ...[snip]...
>
> > With this version of the TEO governor I'm observing slight, but consistent
> > performance improvements in some different benchmarks on a few different
> > systems with respect to menu
>
> Same here.
>
> > and the corresponding power draw differences
> > appear to be in the noise.  The idle power doesn't seem to change either.
>
> Same here.
>
> > Also the "above" and "below" metrics (introduced by a separate patch under
> > discussion) indicate changes in the "good" direction.
>
> My graphs now include the "above" and "below" metrics.
> In particular see Idle State 1 "above" (was too deep) graphs in the links below.
> However, performance is up and power about the same, so O.K.

Thanks a lot for the comprehensive results, much appreciated as always!

This basically confirms my own observations, so my overall conclusion
is that what we have here is as good as it can get without changing
the approach entirely or adding complications that would be difficult
to justify in general.

> > Overall, I like this one, so I may consider dropping the RFC/RFT tag from the
> > next submission. :-)

And so that's what I'm going to do.

Cheers,
Rafael
