From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression (was: Re:
 2.6.14-rc1-mm1: usb breaks suspend)
Date: Wed, 19 Oct 2005 16:46:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510191638250.4439-100000@iolanthe.rowland.org>
References: <200510192218.40857.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============67667423880524447=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200510192218.40857.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, USB development list <linux-usb-devel@lists.sourceforge.net>
List-Id: linux-pm@vger.kernel.org

--===============67667423880524447==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 19 Oct 2005, Rafael J. Wysocki wrote:

> > This line is the puzzle.  It indicates that the driver bound to the
> > 3-0:1.0 device (which is a root hub interface for one of your USB
> > controllers) doesn't have a suspend or resume method.  But the hub driver
> > _does_ have these methods!
> 
> Unless someone, like me, has CONFIG_USB_SUSPEND unset,
> in which case they are #defined as NULLs (of course if I'm not missing
> anything).  Is now CONFIG_USB_SUSPEND mandatory for being able to suspend?

No.  It's mandatory only for runtime PM; system PM will work as long as 
CONFIG_PM is set.

> > Unless you somehow screwed up the build.  Take a look inside
> > drivers/usb/core/hub.c and make sure that the hub_suspend() and
> > hub_resume() routines are listed in the hub_driver table, and that they
> > haven't been preprocessed away into NULLs.  You might end up needing to do
> > a clean rebuild.
> 
> This already is a clean build, on top of 2.6.13 unpacked from scratch (well,
> I have some patches applied, but they don't touch USB).

Then that's your problem.  There has been a lot of development on USB 
suspend/resume in 2.6.14, and you don't have all the patches applied.  In 
particular, you are missing usb-pm-05.patch (probably a bunch of others as 
well).

Take my advice: Start from 2.6.14-rc4, apply gregkh-all-2.6.14-rc4.patch 
(it gets updated fairly often, so retrieve a fresh copy), and also apply 
the PF_NOFREEZE patch (as585) I posted on lkml and linux-pm.

> > These errors occurred, naturally enough, because the driver for usb3 
> > refused to suspend since one of the children -- namely 3-0:1.0 -- wasn't 
> > suspended.
> 
> I've figured out that too.  However, if something has no _suspend() routine,
> verify_suspended() could return 0 for it, I think, instead of -EBUSY.

Dave Brownell would probably give you an argument, but I tend to agree.  
Alternatively, if something has no ->suspend then we could just set its 
->power.power_state value directly so it would _appear_ to be suspended.

Alan Stern


--===============67667423880524447==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============67667423880524447==--
