From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 21:32:58 +0100
Message-ID: <20071226203258.GE8094@elf.ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz>
	<200712261828.04671.oliver@neukum.org>
	<20071226201722.GC8844@elf.ucw.cz>
	<200712262123.37152.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712262123.37152.oliver@neukum.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-12-26 21:23:37, Oliver Neukum wrote:
> Am Mittwoch, 26. Dezember 2007 21:17:22 schrieb Pavel Machek:
> > On Wed 2007-12-26 18:28:04, Oliver Neukum wrote:
> > > Am Mittwoch, 26. Dezember 2007 00:07:31 schrieb Pavel Machek:
> > > > Heute 00:07:31
> > > >   =A0
> > > > This is RFC. It does not even work for me... it sleeps but it wil=
l not
> > > > wake up, because SATA wakeup code is missing. Code attached for i=
llustration.
> > > >=20
> > > > I wonder if this is the right approach? What is right interface t=
o the
> > > > drivers?
> > >=20
> > > IMHO you are making to many special cases. The system can be "sleep=
y"
> > > if all devices can be runtime suspended and all CPUs are idle.
> >=20
> > Is there an easy way to tell if all the devices are runtime suspended=
?
>=20
> Do you really want to know whether they are suspended or whether they
> could be suspended?

If they are suspended.

My plan is: let the drivers autosuspend on their own. If I see all of
them are autosuspended, then it looks like great time to put whole
system into s2ram...

> > I guess I need to know from atomic context :-(.
>=20
> Urgh. suspend() must be able to sleep and can fail.

That's ok.

... I also don't need to call any suspend() routines, because all the
drivers are already suspended, right?

And yes, I want device activity to prevent s2ram. If user is burning
CD, machine should not sleep. If user is actively typing, machine
should not sleep. My vision is: screen saver tells kernel keyboard
need not be very responsive, at that point keyboard driver can
autosuspend the keyboard, and if that was the last device, whole
system sleeps.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
