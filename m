From: Ingo Molnar <mingo@elte.hu>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 02:39:34 +0200
Message-ID: <20100604003934.GA5221__46568.2602175095$1275612101$gmane$org@elte.hu>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100603232302.GA16184@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

>  - Create a 'deep idle' mode that suspends. This, if all constraints
>    are met, is triggered by the scheduler automatically: just like the other
>    idle modes are triggered currently. This approach fixes the wakeup
>    races because an incoming wakeup event will set need_resched() and
>    abort the suspend.
> 
>    ( This mode can even use the existing suspend code to bring stuff down,
>      therefore it also solves the pending timer problem and works even on
>      PC style x86. )

Note that this does not necessarily have to be implemented as 'execute suspend 
from the idle task' code: scheduling from the idle task, while can certainly 
be made to work, is a somewhat recursive concept that we might want to avoid 
for robustness reasons.

Instead, the 'deepest idle' (suspend) method could consist of a wakeup of a 
kernel thread (or of any of the existing kernel threads such as the migration 
thread) - which kernel thread then does a race-free suspend: it offlines all 
but one CPU [on platforms that need that] and then initiates the suspend - but 
aborts the attempt if there's any sign of wakeup activity.

Thanks,

	Ingo
