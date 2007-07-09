From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Mon, 9 Jul 2007 12:02:04 +0200
Message-ID: <20070709100204.GN5401@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707081517540.11049-100000@netrider.rowland.org>
	<1183929611.3388.303.camel@localhost.localdomain>
	<200707090847.43378.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707090847.43378.oliver@neukum.org>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > But I'm not sure it's a good idea in the long run. =A0Think of a pr=
inter=20
> > > daemon, for example. =A0It shouldn't have to experience unexpected =
I/O=20
> > > problems merely because someone has decided to put the system to sl=
eep.
> >=20
> > Why not ? Printer is offline when machine is asleep... trying to prin=
t

...filesystems are offline, too, when the machine is asleep. Yet,
unmounting everything on suspend would not result in useful suspend
support.

Yes, I believe we should be transparent.
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
