From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCHv3 0/5] coupled cpuidle state support
Date: Fri, 4 May 2012 11:04:55 +0100
Message-ID: <20120504100455.GA14578@e102568-lin.cambridge.arm.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
	<201204302354.41969.rjw@sisk.pl>
	<CAMbhsRQcDDW5vWbqb1FRtvOmq6UjOjXj9MCfSt2KF9fHrcY59Q@mail.gmail.com>
	<201205032200.01823.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201205032200.01823.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Len Brown <len.brown@intel.com>, Russell King <linux@arm.linux.org.uk>, Kay Sievers <kay.sievers@vrfy.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, Colin Cross <ccross@android.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, Arnd Bergmann <arnd.bergmann@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 03, 2012 at 09:00:01PM +0100, Rafael J. Wysocki wrote:
> On Tuesday, May 01, 2012, Colin Cross wrote:
> > On Mon, Apr 30, 2012 at 2:54 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Monday, April 30, 2012, Colin Cross wrote:
> > >> On Mon, Apr 30, 2012 at 2:25 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

[...]

> Having considered this for a while I think that it may be more straightforward
> to avoid waking up the already idled cores.
> 
> For instance, say we have 4 CPU cores in a cluster (package) such that each
> core has its own idle state (call it C1) and there is a multicore idle state
> entered by turning off the entire cluster (call this state C-multi).  One of
> the possible ways to handle this seems to be to use an identical table of
> C-states for each core containing the C1 entry and a kind of fake entry called
> (for example) C4 with the time characteristics of C-multi and a special
> .enter() callback.  That callback will prepare the core it is called for to
> enter C-multi, but instead of simply turning off the whole package it will
> decrement a counter.  If the counte happens to be 0 at this point, the
> package will be turned off.  Otherwise, the core will be put into the idle
> state corresponding to C1, but it will be ready for entering C-multi at
> any time. The counter will be incremented on exiting the C4 "state".
> 
> It looks like this should work without modifying the cpuidle core, but
> the drawback here is that the cpuidle core doesn't know how much time
> spend in C4 is really in C1 and how much of it is in C-multi, so the
> statistics reported by it won't reflect the real energy usage.

This is exactly what has been done in some ARM platforms with per-CPU power
rails ("C1" means shutdown here) and that are completely symmetric (ie every
CPU can trigger cluster shutdown); a "C4" multi-CPU state with target_residency
equivalent to the cluster shutdown implied power break-even point.

There are two issues with this approach. One you already mentioned it.
Second is that CPUs go idle at different times. Hence, by the time the last
CPU calls C4.enter() other CPUs in the package might already have a timer
that is about to expire. If we start cluster shutdown we are wasting power
(eg caches write-back to DDR) for nothing.

Colin and Santosh mentioned it already, we have to peek at the next event for
all CPUs in the package (or peek the broadcast global timer if CPUs rely
on it) and make a decision accordingly.

Lorenzo
