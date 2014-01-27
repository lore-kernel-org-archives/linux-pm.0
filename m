From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] setting the table for integration of cpuidle with
 the scheduler
Date: Mon, 27 Jan 2014 13:47:31 +0100
Message-ID: <20140127124731.GA4941@twins.programming.kicks-ass.net>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 27, 2014 at 01:08:15AM -0500, Nicolas Pitre wrote:
> As everyone should know by now, we want to integrate the cpuidle
> governor with the scheduler for a more efficient idling of CPUs.
> In order to help the transition, this small patch series moves the
> existing interaction with cpuidle from architecture code to generic
> core code.  No functional change should have occurred yet.
> 
> The ARM, PPC, SH and X86 architectures are concerned.  Small cleanups
> to ARM and ARM64 are also included. I don't know yet the best path for
> those patches to get into mainline, but it is probably best if they
> stay together. So ACKs from architecture maintainers would be greatly
> appreciated.
> 
> 
>  arch/arm/kernel/process.c                       | 21 +++---------
>  arch/arm/kernel/setup.c                         |  7 ++++
>  arch/arm64/kernel/process.c                     |  5 ---
>  arch/arm64/kernel/setup.c                       |  7 ++++
>  arch/powerpc/platforms/pseries/processor_idle.c |  5 +++
>  arch/powerpc/platforms/pseries/setup.c          | 34 ++++++++-----------
>  arch/sh/kernel/idle.c                           |  4 +--
>  arch/x86/kernel/process.c                       |  5 +--
>  include/linux/cpu.h                             |  1 -
>  kernel/Makefile                                 |  1 -
>  kernel/cpu/Makefile                             |  1 -
>  kernel/sched/Makefile                           |  2 +-
>  kernel/{cpu => sched}/idle.c                    |  6 ++--
>  13 files changed, 44 insertions(+), 55 deletions(-)

Thomas, any objections to this? It looks like a sensible thing to do.
