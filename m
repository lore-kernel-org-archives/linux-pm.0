From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
Date: Thu, 08 Feb 2007 14:14:54 +0100
Message-ID: <1170940494.4385.51.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0536663159=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070207124610.392302000@sipsolutions.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--===============0536663159==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-j8baZh/sR370sU53uJcs"


--=-j8baZh/sR370sU53uJcs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-02-07 at 13:45 +0100, Johannes Berg wrote:

> Except for the in-irq count hack I'm happy with this. I still haven't fou=
nd
> where the in-hard-irq count is set to 1 in the down path during suspend o=
r
> resume and other platforms do similar things so I'm inclined to leave thi=
s.

Um, ok, so the hack breaks platforms that don't have paca, e.g. chrp32.

Also, I finally figured out how the in-hard-irq count happens. The thing
is that when I try to turn off the CPU it actually doesn't really turn
off of course, so it ends up doing NAP and taking timer interrupts...
which goes irq_enter() and we happen to kill it afterwards.

I have two ways of fixing this:
 - just ignore it as we do now
 - insert a "if (cpu_dead) return" into the timer interrupt function

I prefer the latter because then we're guaranteed that whatever the
timer interrupt does we don't modify any state for/by the CPU that isn't
supposed to exist.

johannes

--=-j8baZh/sR370sU53uJcs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFyyJO/ETPhpq3jKURAtIvAKC3peiqx1+DS509RvNWdyMpsl3+CwCeIRfe
HEyGnG+EZDfamXCylK881mQ=
=EICJ
-----END PGP SIGNATURE-----

--=-j8baZh/sR370sU53uJcs--


--===============0536663159==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0536663159==--
