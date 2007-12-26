From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 20:02:52 +0100
Message-ID: <20071226190252.GC8094@elf.ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz> <200712261828.04671.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752592AbXLZTDS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200712261828.04671.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-12-26 18:28:04, Oliver Neukum wrote:
> Am Mittwoch, 26. Dezember 2007 00:07:31 schrieb Pavel Machek:
> > Heute 00:07:31
> >   =A0
> > This is RFC. It does not even work for me... it sleeps but it will =
not
> > wake up, because SATA wakeup code is missing. Code attached for ill=
ustration.
> >=20
> > I wonder if this is the right approach? What is right interface to =
the
> > drivers?
>=20
> IMHO you are making to many special cases. The system can be "sleepy"
> if all devices can be runtime suspended and all CPUs are idle.

Pretty much, except that "timer device" needs to be runtime suspended,
too... We probably should not sleep if wakeup is scheduled 1 second in
future.

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
