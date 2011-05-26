From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 3/3] show energy consumption info in perf tool
Date: Thu, 26 May 2011 12:49:37 +0200
Message-ID: <20110526104937.GE1763__12277.8153083802$1306407056$gmane$org@elte.hu>
References: <1306398855.2207.156.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1306398855.2207.156.camel@rui>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: a.p.zijlstra@chello.nl, ming.m.lin@intel.com, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>, acme@redhat.com, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> Introduce four new perf software events
>
> PERF_COUNT_SW_PKG_ENERGY
> PERF_COUNT_SW_CORE_ENERGY
> PERF_COUNT_SW_UNCORE_ENERGY
> and
> PERF_COUNT_SW_DRAM_ENERGY
> 
> To use it, users can run
> perf stat -e pkg-energy foo
> to get the package energy consumption when running foo.

That's very interesting - being able to profile workloads by 
power/energy use looks like a *very* powerful feature.

Are you allowed to show us some sample output of the data? What's the 
granularity of this info? Say what is the output of:

  perf stat -e pkg-energy -e core-energy -e uncore-energy -e dram-energy -a sleep 10

?

Also, have you tried something like:

	perf record -a -e pkg-energy sleep 60

	perf report

To see where most of the energy is used within a 1 minute interval?

Also, conceptually these are really hardware events, right?

Thanks,

	Ingo
