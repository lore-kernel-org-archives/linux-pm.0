From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 17:44:55 +0200
Message-ID: <201006101744.55754.rjw__10135.3607060902$1276184894$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1006101043510.1702-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006101043510.1702-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Felipe Contreras <felipe.contreras@gmail.com>, Arve@smtp1.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, david@lang.hm, tytso@mit.edu, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 10, 2010, Alan Stern wrote:
> On Thu, 10 Jun 2010, Rafael J. Wysocki wrote:
> 
> > Moreover, having thought a bit more about the "power manager in user space"
> > concept I'm not sure if it really is that better than the original wakelocks
> > idea.  Namely, it only repaces a kernel-based mechanism with a user space
> > task doing basically the same thing, but the communication between that task
> > and the other cooperating user space tasks is arguably more complicated (it
> > also uses the kernel resources, although indirectly).
> 
> That is all true.  The "power manager in userspace" was meant to prove
> a point: that this _could_ be done without invasive changes to the
> kernel.  It wasn't necessarily meant to be a _better_ solution.
> 
> > So, for a phone-like system, where you'd generally want to simplify user space,
> > having a "power manager" in the kernel seems to make sense to me.
> 
> This is a judgment call.  Obviously different people have different 
> opinions.

Agreed.

Rafael
