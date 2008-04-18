From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.25-mm1: suspend-to-disk warning, resume failure
Date: Sat, 19 Apr 2008 01:19:10 +0200
Message-ID: <20080418231910.GE13847@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0804181116590.6252-100000@iolanthe.rowland.org>
	<200804182047.40724.rjw@sisk.pl> <200804182214.14376.rjw@sisk.pl>
	<200804182238.45512.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200804182238.45512.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, USB list <linux-usb@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> > > > > ipw2200: Radio Frequency Kill Switch is On:
> > > > > Kill switch must be turned off for wireless networking to work.
> > > > > PM: Device usb1 failed to (unknown PM event): error -113
> > > > > PM: Device usb2 failed to (unknown PM event): error -113
> > > > > PM: Device usb3 failed to (unknown PM event): error -113
> > > > > PM: Device usb4 failed to (unknown PM event): error -113
> > > > 
> > > > These -113 errors can be ignored.  They are fallout from the recent 
> > > > conversion of the driver core's suspend/resume API.  Matching changes 
> > > > have not yet been added to the USB core.
> > > > 
> > > > The "(unknown PM event)" strings look like a bug, though.
> > > 
> > > Yes, it does.
> > > 
> > > I'm trying to figure this out.
> > 
> > This particular problem should be fixed by the appended patch.
> 
> The following patch is also necessary to make hibernation work as documented
> in pm.h.

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
