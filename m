From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch added
	to -mm	tree
Date: Thu, 22 Mar 2007 18:51:18 +0100
Message-ID: <1174585878.3588.35.camel@johannes.berg>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<20070322142437.GB21954@linux-sh.org>
	<20070322143313.GA7963@elf.ucw.cz>
	<20070322143556.GA22798@linux-sh.org>
	<20070322093604.b3393b32.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0813905647=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070322093604.b3393b32.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============0813905647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NjhnHo7MybcBbNabgZG1"


--=-NjhnHo7MybcBbNabgZG1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 09:36 -0800, Andrew Morton wrote:

> Johannes, this patch series has caused a lot of confusion. =20

Yeah, I didn't intend to cause that much confusion. Sorry about that.

> Perhaps you
> could generate an additional couple of overview paragraphs for the change=
log
> which address the points of confusion, and which prevent the next set of
> reviewers from hitting the same things?

Sure. Most of this is in the pm_ops kerneldoc now. How's this?

This patch series cleans up some misconceptions about pm_ops. Some users
of the pm_ops structure attempt to use it to stop the user from entering
suspend to disk, this, however, is not possible since the user can
always use "shutdown" in /sys/power/disk and then the pm_ops are never
invoked. Also, platforms that don't support suspend to disk simply
should not allow configuring SOFTWARE_SUSPEND (read the help text on it,
it only selects suspend to disk and nothing else, all the other stuff
depends on PM).

The pm_ops structure is actually intended to provide a way to enter
platform-defined sleep states (currently supported states are "standby"
and "mem" (suspend to ram)) and additionally (if SOFTWARE_SUSPEND is
configured) allows a platform to support a platform specific way to
enter low-power mode once everything has been saved to disk. This is
currently only used by ACPI (S4).

johannes

--=-NjhnHo7MybcBbNabgZG1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAsIW/ETPhpq3jKURAtv6AJ9cz6aQ5f7bfhEBhTln1fpelTbv1wCgtllA
z9dn1MAY2kU29f47SBFB5ww=
=qPGB
-----END PGP SIGNATURE-----

--=-NjhnHo7MybcBbNabgZG1--


--===============0813905647==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============0813905647==--
