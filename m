From: Mike Galbraith <efault@gmx.de>
Subject: Re: Help needed: Resume problems in 2.6.32-rc,
 perhaps related to preempt_count leakage in keventd
Date: Mon, 09 Nov 2009 17:19:13 +0100
Message-ID: <1257783553.6408.6.camel__23257.5731272393$1257783685$gmane$org@marge.simson.net>
References: <200911091250.31626.rjw@sisk.pl> <200911091527.12249.rjw@sisk.pl>
	<1257777040.6365.15.camel@marge.simson.net>
	<200911091647.54171.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200911091647.54171.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2009-11-09 at 16:47 +0100, Rafael J. Wysocki wrote:
> On Monday 09 November 2009, Mike Galbraith wrote:

> > > Very likely.  What did you do to fix it?
> > 
> > You don't really wanna know.  In 31 with newidle enabled, the below
> > fixed it.  It won't fix 32, though it might cure the resume problem.
> 
> OK, I'll give it a try.

I just tried to trigger badness via high speed online/offline combined
with taskset with CONFIG_PREEMPT enabled, and couldn't make it explode.

(damn, wish i could s2ram this box)

	-Mike
