From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
 of frozen tasks really
Date: Fri, 17 Jul 2009 18:47:34 +0200
Message-ID: <1247849254.6522.75.camel__23657.7540789314$1247849444$gmane$org@laptop>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
	<1247833910.15751.61.camel@twins>
	<20090717152235.GA5878@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090717152235.GA5878@count0.beaverton.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Nathan Lynch <ntl@pobox.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, 2009-07-17 at 08:22 -0700, Matt Helsley wrote:

> The job scheduler in question does not use FROZEN as a transient state and
> does not use checkpoint/restart at all since c/r is still a work in progress.
> Even when used for power management it seems wrong to count frozen tasks
> towards the loadavg since they aren't using CPU time or waiting for IO.

You're abusing it for _WHAT_?
