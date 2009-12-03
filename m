From: Oliver Neukum <oliver@neukum.org>
Subject: Re: System sleep vs. runtime PM
Date: Thu, 3 Dec 2009 21:11:30 +0100
Message-ID: <200912032111.30921.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0912031444300.4795-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0912031444300.4795-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Donnerstag, 3. Dezember 2009 20:52:15 schrieb Alan Stern:

> That's not necessarily so.  If remote wakeup is disabled at a device
> between the CPU and the source device, then wakeup events are indeed
> allowed to get lost.  For example, even though a USB hub may be enabled
> for remote wakeup, if its host controller isn't then a wakeup event
> won't generate an IRQ and so won't awaken the system.  And in fact this
> behavior may be desired by the user.  After all, who would want their
> laptop to wake up merely because a USB mouse was unplugged?

That is no problem while the system is asleep. It is no good once the system
wakes up.

> >  But the core doesn't
> > know specifics. Unless you really want to overengineer this and compute
> > the reliability of each path, resuming only those whose drivers have
> > requested that remote wakeup be enabled is the best you can do.
> 
> Isn't that what I agreed drivers should do?

If the algorithm is clear and based only on remote wakeup, why
would you want to involve drivers?

I am afraid we are having a misunderstanding. Could you elaborate?

	Regards
		Oliver
