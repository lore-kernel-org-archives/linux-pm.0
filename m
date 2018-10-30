From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v2] cpuidle: New timer events oriented governor for tickless systems
Date: Tue, 30 Oct 2018 08:19:14 +0100
Message-ID: <1649954.HZZfnVZxCN@aspire.rjw.lan>
References: <001201d46dbf$88339510$989abf30$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <001201d46dbf$88339510$989abf30$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, October 27, 2018 8:37:24 AM CET Doug Smythies wrote:
> This is just for anybody else trying to compile:
> 
> On 2018.10.26 02:12 Rafael J. Wysocki wrote:
> 
> > The venerable menu governor does some thigns that are quite
> 
> Typo: thigns -> things
> 
> ...[snip]...
> 
> > The patch should apply on top of 4.19, although I'm running it on
> > top of my linux-next branch.
> 
> No, it uses "poll_time_limit" which was introduced in patch 1 of 6
> [1] in that group of menu changes from October 2nd.
> 
> "[PATCH 1/6] cpuidle: menu: Fix wakeup statistics updates for polling state"

Right, sorry for missing that.

Thanks,
Rafael
