From: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
	of frozen	tasks really
Date: Fri, 17 Jul 2009 09:20:01 -0700
Message-ID: <20090717162001.GC5878__36972.9321603247$1247847664$gmane$org@count0.beaverton.ibm.com>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
	<20090717155116.GB5878@count0.beaverton.ibm.com>
	<1247846127.6522.21.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247846127.6522.21.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org, Nathan Lynch <ntl@pobox.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 17, 2009 at 05:55:27PM +0200, Peter Zijlstra wrote:
> On Fri, 2009-07-17 at 08:51 -0700, Matt Helsley wrote:
> 
> > So it's not clear to me how adding PF_FREEZING fixes anything. Am I
> > missing something?
> 
> Yep, PF_FROZEN is only observed going into schedule(), on the way back
> out thaw_process() will already have cleared the flag.
> 
> So we don't increment in deactivate_task(), but we do decrement in
> activate_task(), yielding for some very unbalanced accounting.

Ahhh, right!

OK, so the fix looks good then.

Cheers,
	-Matt Helsley
