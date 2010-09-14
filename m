From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: wacom + runtime PM = AA deadlock
Date: Tue, 14 Sep 2010 12:05:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009141203460.1648-100000__21210.9512686313$1284480466$gmane$org@iolanthe.rowland.org>
References: <201009141730.38215.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201009141730.38215.oneukum@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oneukum@suse.de>
Cc: pingc@wacom.com, Dmitry Torokhov <dtor@mail.ru>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, linux-pm <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Tue, 14 Sep 2010, Oliver Neukum wrote:

> Am Dienstag, 14. September 2010, 17:23:15 schrieb Alan Stern:
> > On Tue, 14 Sep 2010, Oliver Neukum wrote:
> > 
> > > > > Should I have used usb_autopm_get_interface_no_resume()?
> > > > 
> > > > That actually would work.  It's a good idea.  The only drawback (not a
> > > > big one) is that if the device _was_ suspended with remote wakeup
> > > > enabled, doing this wouldn't turn off remote wakeup.  I think that
> > > > doesn't matter.
> > > 
> > > I am afraid it does matter as devices whose remote wakeup is enabled
> > > may draw more power.
> > 
> > I doubt it, or at least, not very much more.  They are still limited by 
> > the USB spec as to the total amount of current they can draw while 
> > suspended.
> 
> 7.2.3 Sources of remote wakeup may draw 2.5mA when suspended
> as opposed to 0.5 mA

Okay, then we may as well wake it up in order to turn off remote 
wakeup.  For drivers that don't need remote wakeup, it's better to use 
the _no_resume form.

Alan Stern
