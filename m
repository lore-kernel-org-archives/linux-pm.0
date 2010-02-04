From: Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [regression] "drm/i915: implement new pm ops"
 disables irq on aborted s2disk
Date: Thu, 4 Feb 2010 09:31:57 +0800
Message-ID: <20100204013157.GA30011__31427.3223201328$1265247186$gmane$org@zhen-devel.sh.intel.com>
References: <4B695BA0.4000007@tuffmail.co.uk> <201002032344.41915.rjw@sisk.pl>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3140207615180455253=="
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002032344.41915.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Eric Anholt <eric@anholt.net>, linux-pm@lists.linux-foundation.org, dri-devel@lists.sourceforge.net, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--===============3140207615180455253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2010.02.03 23:44:41 +0100, Rafael J. Wysocki wrote:
> On Wednesday 03 February 2010, Alan Jenkins wrote:
> > Hi
> >=20
> > I found this regression on my EeePC 701 with modesetting enabled.  When=
=20
> > I hibernate using s2disk, I can abort the hibernation by pressing the=
=20
> > backspace key.  Doing so breaks X on 2.6.32-rc6 (but not 2.6.32).
>=20
> Yeah.
>=20
> To be honest, I knew that's going to happen, but didn't have the time to =
take
> care of it.
>=20
> The problem is that i915 does literally _nothing_ in its .thaw() callback,
> although it should at least reverse whatever .freeze() did to the hardware
> (and memory allocations and so on), so that the adapter is functional
> after creating the image.
>=20
> Fixing this requires some thought, though, because at the moment .freeze()
> thinks it's .suspend(), which is not the case as this report clearly show=
s.
> So, in fact i915_pci_suspend() has to be split into the .freeze() part and
> the poweroff part cleanly and that's not  so simple (at least to me).
>=20

Right, I think that'll be more clean, stuff in i915_save/restore_state() ne=
ed
to be splited too, especially isolate stuff for mode setting and other devi=
ce
state, as what my original purpose for this is to remove extra mode setting=
=20
cycle in old behavior so not waste time for hibernate.

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktqI40ACgkQsQQaM014GCepcwCfU4d/sVAWUPcNxuQenKxxyJy/
UywAnilCQmiBzAA2YS1VVrjk5Ov1pZcm
=knOz
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============3140207615180455253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3140207615180455253==--
