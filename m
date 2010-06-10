From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 10:47:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006101043510.1702-100000__342.904780018394$1276181392$gmane$org@iolanthe.rowland.org>
References: <201006101059.44411.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006101059.44411.rjw@sisk.pl>
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
Cc: david@lang.hm, Peter Zijlstra <peterz@infradead.org>, tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 10 Jun 2010, Rafael J. Wysocki wrote:

> Moreover, having thought a bit more about the "power manager in user space"
> concept I'm not sure if it really is that better than the original wakelocks
> idea.  Namely, it only repaces a kernel-based mechanism with a user space
> task doing basically the same thing, but the communication between that task
> and the other cooperating user space tasks is arguably more complicated (it
> also uses the kernel resources, although indirectly).

That is all true.  The "power manager in userspace" was meant to prove
a point: that this _could_ be done without invasive changes to the
kernel.  It wasn't necessarily meant to be a _better_ solution.

> So, for a phone-like system, where you'd generally want to simplify user space,
> having a "power manager" in the kernel seems to make sense to me.

This is a judgment call.  Obviously different people have different 
opinions.

Alan Stern
