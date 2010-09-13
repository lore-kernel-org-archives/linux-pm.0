From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Mon, 13 Sep 2010 16:02:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009131600230.1315-100000__17096.7724909589$1284408196$gmane$org@iolanthe.rowland.org>
References: <201009132105.38204.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009132105.38204.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: pingc@wacom.com, Dmitry Torokhov <dtor@mail.ru>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Mon, 13 Sep 2010, Oliver Neukum wrote:

> Am Montag, 13. September 2010, 17:17:54 schrieb Alan Stern:
> > On Mon, 13 Sep 2010, Oliver Neukum wrote:
> > 
> > > PM in this driver looks broken. Please try this.
> > > 
> > > In short you want to drop the PM reference and depend on remote
> > > wakeup and busy marking for this driver. Currently it gets a reference
> > > on every open() but never drops it.
> > > 
> > > For locking you depend on the PM core's internal lock. You simply
> > > make sure you have a PM reference during open() and close()
> > 
> > Is there any point in resuming the device during close() just in order
> > to kill the interrupt URB?  It seems counterproductive -- if the device 
> > had been suspended then there wouldn't be any interrupt URB to kill in 
> > the first place.
> 
> Suppose the device does not support remote wakeup. It would never
> be autosuspended while it is open, but simply resetting the flag
> would never reach the PM layer.

Whoops, that's right.  I didn't see the assignment to 
needs_remote_wakeup.

How come wacom_open doesn't check to see if wacom->open is already set?

Alan Stern
