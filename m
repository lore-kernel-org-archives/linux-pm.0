From: Oliver Neukum <oneukum@suse.de>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 10:13:19 +0200
Message-ID: <201009141013.19704.oneukum__42418.7805074782$1284452015$gmane$org@suse.de>
References: <Pine.LNX.4.44L0.1009131600230.1315-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1009131600230.1315-100000@iolanthe.rowland.org>
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

Am Montag, 13. September 2010, 22:02:16 schrieb Alan Stern:
> > > Is there any point in resuming the device during close() just in order
> > > to kill the interrupt URB?  It seems counterproductive -- if the device 
> > > had been suspended then there wouldn't be any interrupt URB to kill in 
> > > the first place.
> > 
> > Suppose the device does not support remote wakeup. It would never
> > be autosuspended while it is open, but simply resetting the flag
> > would never reach the PM layer.
> 
> Whoops, that's right.  I didn't see the assignment to 
> needs_remote_wakeup.

Should I have used usb_autopm_get_interface_no_resume()?

	Regards
		Oliver
