From: Pavel Machek <pavel@suse.cz>
Subject: Re: [Regression] USB wakeup problem on Toshiba Portege
	R500
Date: Fri, 9 Jan 2009 11:18:41 +0100
Message-ID: <20090109101840.GD3396__10914.7913557992$1231496405$gmane$org@elf.ucw.cz>
References: <200901080835.39639.rjw@sisk.pl>
	<200901080949.34339.oliver@neukum.org>
	<200901081736.12926.rjw@sisk.pl>
	<200901081748.58962.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200901081748.58962.oliver@neukum.org>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2009-01-08 17:48:57, Oliver Neukum wrote:
> Am Thursday 08 January 2009 17:36:12 schrieb Rafael J. Wysocki:
> > > We do support remote wakeup from PS2 keyboards. So you might argue we
> > > should do the same for USB HID devices.
> > =

> > Well, _I_ can live with a few 'echo disabled > /sys/devices/.../power/w=
akeup'
> > lines in my init scripts, but I'm afraid we're going to get many problem
> > reports related to this. =A0This means people will likely lose time on =
trying to
> > debug this problem and someone will have to handle the reports. =A0Are =
you
> > volunteering to do that?
> =

> You are making a very persuasive argument for reverting it.
> But what about laptops that only have a USB keyboard?

laptops normally wake up lid open... (and you still have a
powerbutton; plus I'm not aware of any laptops with usb keyboard --
are apples crazy enough to do that?)
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
