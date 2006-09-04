From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re : [HELP] Power management for embedded system
Date: Mon, 4 Sep 2006 23:56:47 +0200
Message-ID: <20060904215647.GA1975@elf.ucw.cz>
References: <20060824093739.5085.qmail@web25802.mail.ukl.yahoo.com>
	<1156414325.5555.11.camel@localhost.localdomain>
	<20060824162034.GB19753@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060824162034.GB19753@srcf.ucam.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: moreau francis <francis_moreau2000@yahoo.fr>, Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > It would be nice to move that to some arch independent generic
> > implementation of these things and to leave the APM emulation behind.
> > The battery information should be a sysfs class (see the backlight/led
> > classes as examples of sysfs classes). The suspend/resume event handling
> > would be something new as far as I know and ideally should support
> > suspending/resuming individual sections of device hardware as well as
> > the whole system.
> =

> Triggering suspend/resume is already generic in the form of the =

> /sys/power/state interface. There's been discussion of producing a =

> generic battery class lately. There's some trend towards tying suspend =

> requests into the input layer, but how appropriate that is may
> > depend on =


suspend requests into input layer.. No, I do not think Dmitry will
allow us to do that.

Yes, we definitely want some kind of "generic battery" layer.

									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
