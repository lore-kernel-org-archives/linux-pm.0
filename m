From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: Problems with remote-wakeup settings
Date: Sat, 6 Mar 2010 07:36:18 +0300
Message-ID: <201003060736.18555.arvidjaar__39719.3619319752$1267850240$gmane$org@mail.ru>
References: <Pine.LNX.4.44L0.1003052314130.10381-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5646629746789173658=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1003052314130.10381-100000@netrider.rowland.org>
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
To: linux-hotplug@vger.kernel.org
Cc: USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

--===============5646629746789173658==
Content-Type: multipart/signed;
  boundary="nextPart2181245.yYC95H6HeF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2181245.yYC95H6HeF
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 06 of March 2010 07:16:20 Alan Stern wrote:
> On Fri, 5 Mar 2010, Rafael J. Wysocki wrote:
> > On Friday 05 March 2010, Oliver Neukum wrote:
> > > Am Freitag, 5. M=E4rz 2010 21:59:31 schrieben Sie:
> > > > > I guess it's better if drivers don't set should_wakeup if
> > > > > unsure, but of course that's impossible to enforce.
> > > >=20
> > > > That's the real question.  Ideally, drivers won't touch
> > > > should_wakeup. How do we get there from here?
> > >=20
> > > Enable it only for devices specifically designed for wakeup, that
> > > is keyboards, power buttons and WoL, perhaps also mice and
> > > modems. Are we far away from that?
> >=20
> > I don't think we're very far from that.
> >=20
> > Mice are known dangerous, especially the USB ones, though.
>=20
> I agree, especially for desktop systems.  You don't want the system
> to wake up merely because you happened to jostle the mouse.  That
> happened to me just a few days ago (and it was a PS/2 mouse, not
> USB).

I remember, my old desktop had BIOS option to wake up on mouse click=20
(and it had PS/2 mouse either) ignoring mouse move. I actually found it=20
useful.

--nextPart2181245.yYC95H6HeF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuR28IACgkQR6LMutpd94yuegCgpfFtMVCw09Qh0dPDNcFu3wil
RL8AnRB0i5bEosIeWXKgcs3/5IthH0io
=uiuN
-----END PGP SIGNATURE-----

--nextPart2181245.yYC95H6HeF--

--===============5646629746789173658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5646629746789173658==--
