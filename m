From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Tue, 27 Jun 2006 11:03:05 +0200
Message-ID: <20060627090304.GA29199@elf.ucw.cz>
References: <20060623042452.GA23232@kroah.com>
	<Pine.LNX.4.44L0.0606231028570.5966-100000@iolanthe.rowland.org>
	<20060626235732.GE32008@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <20060626235732.GE32008@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>, linux-pm@osdl.org, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi!

> > > And we also need to be able to handle devices in the device tree that=
 do
> > > not have a suspend/resume function, or ones that are not attached to =
any
> > > bus, without failing the suspend, as obviously they do not care or ne=
ed
> > > to worry about the whole issue.
> > =

> > Ah, there's the rub.  If a driver doesn't have suspend/resume methods, =
is =

> > it because it doesn't need them, or is it because nobody has written th=
em =

> > yet?  In the latter case, failing the suspend or unbinding the driver a=
re =

> > the only safe courses.
> =

> No, if it's not there, just expect that it knows what it is doing, and
> don't fail the thing.  Unless you want to add those methods to _every_
> driver in the kernel, and that's going to be a lot of work...

I believe 90% of drivers need them, anyway... Idea is that if we
refuse the suspend, user has dmesg and did not loose his work. If we
suspend but can't resume due to driver problems, it is slightly more
interesting to debug, and user lost open applications.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
