From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 10030] Suspend doesn't work when SD card is
	inserted
Date: Mon, 25 Feb 2008 12:41:25 +0100
Message-ID: <200802251241.26216.rjw__12461.3376720392$1203939896$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0802242119500.31164-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0802242119500.31164-100000@netrider.rowland.org>
Content-Disposition: inline
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, Kernel development list <linux-kernel@vger.kernel.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Monday, 25 of February 2008, Alan Stern wrote:
> On Sun, 24 Feb 2008, Rafael J. Wysocki wrote:
> 
> > > Very subtly wrong ;-).
> > > 
> > > imagine suspending_task == 0xabcdef01. Now task "R" with current ==
> > > 0xabcd0000 reads suspending_task while the other cpu is writing to it,
> > > and sees 0xabcd0000 (0xef01 was not yet written) -- and mistakenly
> > > believes that  "R" == suspending_task.
> > > 
> > > I agree it is very unlikely, and it will not happen on i386. But what
> > > about just using atomic_t suspending_task, and store current->pid into
> > > it?
> > 
> > I'd rather use a lock, frankly.  For example, we can require the readers to
> > take pm_sleep_rwsem for reading in order to access that.
> 
> That certainly won't work.  Imagine what would happen when the reader 
> _was_ the suspending task.

Yeah, I've already realized it was a stupid idea. :-)

> But if you really twist my arm, I'll go along with Pavel's suggestion.

So can you do that, pretty please?

Thanks,
Rafael
