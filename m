From: Pierre Ossman <drzeus@drzeus.cx>
Subject: Re: PNP: do not stop/start devices in suspend/resume path
Date: Thu, 13 Dec 2007 09:26:21 +0100
Message-ID: <20071213092621.7cf6ee87__8492.38419109515$1197534468$gmane$org@poseidon.drzeus.cx>
References: <4745F77C.7040402@gmail.com> <47514CE2.3000600@gmail.com>
	<200712051124.18852.bjorn.helgaas@hp.com>
	<200712061625.57660.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1166729872494865318=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712061625.57660.bjorn.helgaas@hp.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jiri Slaby <jirislaby@gmail.com>, matthew@wil.cx, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Matthieu Castet <castet.matthieu@free.fr>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Kristen Carlson Accardi <kristen.c.accardi@intel.com>
List-Id: linux-pm@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============1166729872494865318==
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1;
	boundary="=_hera.drzeus.cx-25559-1197534386-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-25559-1197534386-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Dec 2007 16:25:57 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> PNP: do not stop/start devices in suspend/resume path
>=20
> Do not disable PNP devices in the suspend path.  We still call
> the driver's suspend method, which should prevent further use of
> the device, and the protocol suspend method, which may put the
> device in a low-power state.
>=20
> I'm told that Windows puts devices in a low-power state (Linux
> does this in the protocol suspend method), but does not use _DIS
> in the suspend path.  Other relevant references:
>=20
>   - In the ACPI 3.0b spec, I can't find any mention of _DIS in
>     connection with sleep.  And Device Object Notifications,
>     Section 5.6.3, Table 5-43, says we should get a bus check
>     after awakening if hardware was removed while we slept.
>=20
>   - This: http://msdn2.microsoft.com/en-us/library/ms810079.aspx
>     makes a similar point about how the OS re-enumerates devices
>     as a result of a power state change (3rd last paragraph of
>     text).
>=20
>   - This: http://msdn2.microsoft.com/en-us/library/aa489874.aspx
>     suggests that Windows only stops a device to rebalance hardware
>     resources.
>=20
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>=20

Tested-by: Pierre Ossman <drzeus@drzeus.cx>

No noticeable issues with suspend or hibernate using this patch.

Rgds
Pierre

--=_hera.drzeus.cx-25559-1197534386-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHYOyt7b8eESbyJLgRAkFQAJ9DDfb9L2gXYVF32hxFgu9hpHPNfwCguypF
kLYBUDCTxW9Rm445Ts7Iiq4=
=9Wkm
-----END PGP SIGNATURE-----

--=_hera.drzeus.cx-25559-1197534386-0001-2--

--===============1166729872494865318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1166729872494865318==--
