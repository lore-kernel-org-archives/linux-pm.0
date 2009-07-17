From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] sched: fix nr_uninterruptible accounting
 of frozen tasks really
Date: Fri, 17 Jul 2009 17:55:27 +0200
Message-ID: <1247846127.6522.21.camel__11086.8230149665$1247847204$gmane$org@laptop>
References: <20090717121545.489258927@linutronix.de>
	<20090717122103.225652146@linutronix.de>
	<20090717155116.GB5878@count0.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090717155116.GB5878@count0.beaverton.ibm.com>
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

On Fri, 2009-07-17 at 08:51 -0700, Matt Helsley wrote:

> So it's not clear to me how adding PF_FREEZING fixes anything. Am I
> missing something?

Yep, PF_FROZEN is only observed going into schedule(), on the way back
out thaw_process() will already have cleared the flag.

So we don't increment in deactivate_task(), but we do decrement in
activate_task(), yielding for some very unbalanced accounting.
