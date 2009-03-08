From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH][1/8] PM: Rework handling of interrupts
 during suspend-resume (rev. 5)
Date: Sun, 8 Mar 2009 08:37:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0903080834150.32373-100000__24875.0124047094$1236515998$gmane$org@netrider.rowland.org>
References: <200903081100.43757.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903081100.43757.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Sun, 8 Mar 2009, Rafael J. Wysocki wrote:

> > > > So perhaps you're worried about drivers that aren't sufficiently
> > > > clever.  Or is something deeper going on?

> > In other words, why not simply abort the suspend if IRQ_PENDING is set
> > for _any_ interrupt during sysdev_suspend()?
> 
> The "wake-up" ones are _intentionally_ left enabled, while the other ones may
> be left enabled by mistake.  The check is intended to prevent the current
> behavior from changing (ie. suspend is aborted if any "wake-up" interrupts
> are pending) and since the platforms only check for the "wake-up" interrupts,
> it doesn't go any further.  Moreover, I think it might introduce a regression
> if it did.

So it _is_ because you are worried about drivers that aren't
sufficiently clever.  If the drivers did their job correctly then there
wouldn't be any pending non-"wake-up" interrupts to confuse matters.

Alan Stern
