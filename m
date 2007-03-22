From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: + rework-pm_ops-pm_disk_mode-kill-misuse.patch	added
	to -mm tree
Date: Thu, 22 Mar 2007 16:28:24 +0100
Message-ID: <1174577304.3588.17.camel@johannes.berg>
References: <200703212334.l2LNYDjj007030@shell0.pdx.osdl.net>
	<20070322094825.GA29627@flint.arm.linux.org.uk>
	<20070322015614.dafa1ed7.akpm@linux-foundation.org>
	<20070322100355.GA6834@elf.ucw.cz>
	<1174558128.3944.78.camel@johannes.berg>
	<20070322132622.GD29627@flint.arm.linux.org.uk>
	<20070322133117.GC6050@elf.ucw.cz>
	<20070322142437.GB21954@linux-sh.org>
	<1174575945.3588.7.camel@johannes.berg>
	<acd2a5930703220823m3697cd98i47c3ead8e9fd19bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2139314256=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <acd2a5930703220823m3697cd98i47c3ead8e9fd19bb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


--===============2139314256==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VLxKFaGXbdFTJcptTvNx"


--=-VLxKFaGXbdFTJcptTvNx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-03-22 at 18:23 +0300, Vitaly Wool wrote:
> On 3/22/07, Johannes Berg <johannes@sipsolutions.net> wrote:
> > If you have a platform that doesn't allow CONFIG_SOFTWARE_SUSPEND (whic=
h
> > is only suspend to disk) and doesn't have pm_ops either, then you end u=
p
> > with an empty /sys/power/state file.
>=20
> CONFIG_SOFTWARE_SUSPEND is a misleading name then.

Oh, I don't disagree, but the help text for it makes it amply clear:

config SOFTWARE_SUSPEND
[...]
          Enable the suspend to disk (STD) functionality.

          You can suspend your machine with 'echo disk > /sys/power/state'.
          Alternatively, you can use the additional userland tools availabl=
e
          from <http://suspend.sf.net>.
[...]

johannes

--=-VLxKFaGXbdFTJcptTvNx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGAqCY/ETPhpq3jKURAoMPAKC3i8OQIbWJg0QOll7UjmenpwbSlACgmDDS
jKZI9Top1ddBwYqcbtx1JBc=
=j5jH
-----END PGP SIGNATURE-----

--=-VLxKFaGXbdFTJcptTvNx--


--===============2139314256==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============2139314256==--
