From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression (was: Re:
	2.6.14-rc1-mm1: usb breaks suspend)
Date: Wed, 19 Oct 2005 22:18:40 +0200
Message-ID: <200510192218.40857.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0510191204090.5049-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510191204090.5049-100000@iolanthe.rowland.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 19 of October 2005 18:18, Alan Stern wrote:
> [Trimmed the CC: list]
}-- snip --{
> > > > Stopping tasks: ========================|
> > > > Freeing memory... done (14642 pages freed)
> > > > Suspending device card0-0
> > > > Suspending device 2-2:1.0
> > > > Suspending device 2-2
> > > > Suspending device 3-0:1.0
> > > > hub 3-0:1.0: no suspend?
> 
> This line is the puzzle.  It indicates that the driver bound to the
> 3-0:1.0 device (which is a root hub interface for one of your USB
> controllers) doesn't have a suspend or resume method.  But the hub driver
> _does_ have these methods!

Unless someone, like me, has CONFIG_USB_SUSPEND unset,
in which case they are #defined as NULLs (of course if I'm not missing
anything).  Is now CONFIG_USB_SUSPEND mandatory for being able to suspend?

> Unless you somehow screwed up the build.  Take a look inside
> drivers/usb/core/hub.c and make sure that the hub_suspend() and
> hub_resume() routines are listed in the hub_driver table, and that they
> haven't been preprocessed away into NULLs.  You might end up needing to do
> a clean rebuild.

This already is a clean build, on top of 2.6.13 unpacked from scratch (well,
I have some patches applied, but they don't touch USB).

> > > > Suspending device usb3
> > > > Could not suspend device usb3: error -16
> > > > Some devices failed to suspend
> 
> These errors occurred, naturally enough, because the driver for usb3 
> refused to suspend since one of the children -- namely 3-0:1.0 -- wasn't 
> suspended.

I've figured out that too.  However, if something has no _suspend() routine,
verify_suspended() could return 0 for it, I think, instead of -EBUSY.

Greetings,
Rafael
