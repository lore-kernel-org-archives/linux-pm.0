From: Oliver Neukum <oneukum@suse.de>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 16:03:59 +0200
Message-ID: <201009141603.59338.oneukum__43599.6221415282$1284473123$gmane$org@suse.de>
References: <Pine.LNX.4.44L0.1009140954180.1648-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009140954180.1648-100000@iolanthe.rowland.org>
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
Cc: pingc@wacom.com, Dmitry Torokhov <dtor@mail.ru>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 14. September 2010, 16:01:14 schrieb Alan Stern:
> On Tue, 14 Sep 2010, Oliver Neukum wrote:
> 
> > Am Montag, 13. September 2010, 22:02:16 schrieb Alan Stern:
> > > > > Is there any point in resuming the device during close() just in order
> > > > > to kill the interrupt URB?  It seems counterproductive -- if the device 
> > > > > had been suspended then there wouldn't be any interrupt URB to kill in 
> > > > > the first place.
> > > > 
> > > > Suppose the device does not support remote wakeup. It would never
> > > > be autosuspended while it is open, but simply resetting the flag
> > > > would never reach the PM layer.
> > > 
> > > Whoops, that's right.  I didn't see the assignment to 
> > > needs_remote_wakeup.
> > 
> > Should I have used usb_autopm_get_interface_no_resume()?
> 
> That actually would work.  It's a good idea.  The only drawback (not a
> big one) is that if the device _was_ suspended with remote wakeup
> enabled, doing this wouldn't turn off remote wakeup.  I think that
> doesn't matter.

I am afraid it does matter as devices whose remote wakeup is enabled
may draw more power.

	Regards
		Oliver
