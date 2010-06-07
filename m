From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: suspend blockers & Android integrationy
Date: Mon, 7 Jun 2010 17:49:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1006071748270.2933__39837.9066646614$1275925986$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.1006071010001.1398-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006071010001.1398-100000@iolanthe.rowland.org>
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
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Florian Mickler <florian@mickler.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Alan,

On Mon, 7 Jun 2010, Alan Stern wrote:
> On Mon, 7 Jun 2010, Thomas Gleixner wrote:
> > #2 is a tad harder, as it requires to fix the trusted apps not to fire
> >    timers when there is nothing to do.
> 
> No; all you have to do is handle the trusted apps as though they were 
> untrusted -- just as in the original wakelock approach.
> 
> >    Though you can solve it with cgroups as well. The unfreeze problem
> >    for real wakeups can be solved as mhelsley pointed out somewhere
> >    else in this thread.
> > 
> > But that depends on user space changes ....
> 
> If you handle all the apps uniformly, very few userspace changes are
> needed.

Oh, I see. I misunderstood you. -ENOTENOUGHSLEEP
 
Thanks,

	Thomas
