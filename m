From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 16:00:26 +1000
Message-ID: <200606151600.30410.ncunningham@linuxmail.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<20060614235713.GA24859@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1824364002=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200606141846.55839.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: David Brownell <david-b@pacbell.net>, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============1824364002==
Content-Type: multipart/signed; boundary="nextPart3270774.mDLuyWsnuq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3270774.mDLuyWsnuq
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 15 June 2006 11:46, David Brownell wrote:
> On Wednesday 14 June 2006 4:57 pm, Pavel Machek wrote:
> > My point is that you really want the console enabled in writing phase
> > of suspend-to-disk.
>
> Notice how nicely this generalizes a point that's been made before:
> Linux should have the ability to exclude certain devices (and their
> parents) from that first "prepare to suspend" phase.  Originally the
> canonical example was the swap device (and its disk, controller, bus
> tree, etc).  Now we recognize consoles (and their parents, network
> controllers, etc) have the same issue ...

Wouldn't it be simpler to say "We send the prepare_to_suspend/freeze/suspen=
d=20
messages to all devices, but some have the nous to know to ignore them"?

To put flesh on what I'm saying, I would imagine that the right behaviour o=
f=20
the device to which we're writing the image would be:

prepare_to_suspend: Allocate any memory needed for freezing and/or suspendi=
ng,=20
ensure any firmware images needed are in memory and so on.
freeze: Quiesce the queue, flush writes but don't power down.
suspend: Freeze + power down.

Another device, say the console might treat freeze as a noop.

Is there something I'm missing that makes this impractical?

Regards,

Nigel
=2D-=20
Nigel, Michelle and Alisdair Cunningham
5 Mitchell Street
Cobden 3266
Victoria, Australia

--nextPart3270774.mDLuyWsnuq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEkPd+N0y+n1M3mo0RAm+oAJ4t4qIo2kIkhVZROyvxCnRrXLo8oACfa6OE
rbNApNhNS2EVMII5qC8uXpk=
=oelU
-----END PGP SIGNATURE-----

--nextPart3270774.mDLuyWsnuq--

--===============1824364002==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============1824364002==--
