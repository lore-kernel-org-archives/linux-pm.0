From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 21:17:22 +0100
Message-ID: <20071226201722.GC8844@elf.ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz>
	<200712261828.04671.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200712261828.04671.oliver@neukum.org>
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

On Wed 2007-12-26 18:28:04, Oliver Neukum wrote:
> Am Mittwoch, 26. Dezember 2007 00:07:31 schrieb Pavel Machek:
> > Heute 00:07:31
> >   =A0
> > This is RFC. It does not even work for me... it sleeps but it will no=
t
> > wake up, because SATA wakeup code is missing. Code attached for illus=
tration.
> >=20
> > I wonder if this is the right approach? What is right interface to th=
e
> > drivers?
>=20
> IMHO you are making to many special cases. The system can be "sleepy"
> if all devices can be runtime suspended and all CPUs are idle.

Is there an easy way to tell if all the devices are runtime suspended?

I guess I need to know from atomic context :-(.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
