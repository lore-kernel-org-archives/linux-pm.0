From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 18:18:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006211814370.1687-100000__20148.4383120716$1277158733$gmane$org@iolanthe.rowland.org>
References: <20100621223841.1cf1942d@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621223841.1cf1942d@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jun 2010, Florian Mickler wrote:

> > In the end you would want to have communication in both directions:  
> > suspend blockers _and_ callbacks.  Polling is bad if done too often.  
> > But I think the idea is a good one.
> 
> Actually, I'm not so shure. 
> 
> 1. you have to roundtrip whereas in the suspend_blocker scheme you have
> active annotations (i.e. no further action needed) 

That's why it's best to use both.  The normal case is that programs
activate and deactivate blockers by sending one-way messages to the PM
process.  The exceptional case is when the PM process is about to
initiate a suspend; that's when it does the round-trip polling.  Since
the only purpose of the polling is to avoid a race, 90% of the time it
will succeed.

> 2. it may not be possible for a user to determine if a wake-event is
> in-flight. you would have to somehow pass the wake-event-number with
> it, so that the userspace process could ack it properly without
> confusion. Or... I don't know of anything else... 
> 
> 	1. userspace-manager (UM) reads a number (42). 
> 
> 	2. it questions userspace program X: is it ok to suspend?
> 
> 	[please fill in how userspace program X determines to block
> 	suspend]
> 
> 	3a. UM's roundtrip ends and it proceeds to write "42" to the
> 	kernel [suspending]
> 	3b. UM's roundtrip ends and it aborts suspend, because a
> 	(userspace-)suspend-blocker got activated
> 
> I'm not shure how the userspace program could determine that there is a
> wake-event in flight. Perhaps by storing the number of last wake-event.
> But then you need per-wake-event-counters... :|

Rafael seems to think timeouts will fix this.  I'm not so sure.

> Do you have some thoughts about the wake-event-in-flight detection?

Not really, except for something like the original wakelock scheme in
which the kernel tells the PM core when an event is over.

Alan Stern
