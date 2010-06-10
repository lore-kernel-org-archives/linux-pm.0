From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 10:39:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006101037470.1702-100000__32518.8748458915$1276180937$gmane$org@iolanthe.rowland.org>
References: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.01.1006092117100.17462@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 9 Jun 2010 david@lang.hm wrote:

> why could the suspend blocker process see all events, but the power 
> manager process not see the events?
> 
> have the userspace talk to the power manager the way it does to the 
> suspend blocker now and what's the difference?
> 
> effectivly think s/suspend blocker/power manager/ (with the power manager 
> doing all the other things that are proposed instead of grabbing the 
> wakelock), the difference should be hidden to the rest of userspace.
> 
> what am I missing here?

The main difference is that with a userspace power manager, programs
have to tell the power manager whenever they open or close a
wakeup-capable device file (and send it a copy of the file descriptor).  
With an in-kernel implementation these extra steps aren't needed,
because of course kernel drivers already know when their device files
are opened or closed.

Alan Stern
