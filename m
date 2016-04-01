From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Fri, 01 Apr 2016 08:43:10 +0300
Message-ID: <87d1q9anpt.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org> <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org> <87h9foqnur.fsf@intel.com> <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com> <87poubgnbh.fsf@intel.com> <20160331170635.GH2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:26712 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbcDAFpH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Apr 2016 01:45:07 -0400
In-Reply-To: <20160331170635.GH2350@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Mark Brown <broonie@kernel.org> writes:
> On Thu, Mar 31, 2016 at 09:42:58AM +0300, Felipe Balbi wrote:
>> Baolin Wang <baolin.wang@linaro.org> writes:
>
>> > I want to use bus structure to manage the charger device. Maybe choose
>> > class to manage them?
>
>> I guess a class would fit better in this case.
>
> IIRC Greg didn't want new classes?

good point. Still, this doesn't seem to fit a but_type IMO.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW/gpvAAoJEIaOsuA1yqREBk8P/2NV9jhN/RhaWtWOXJEErByO
mAtaalHpNr5skD4twUY+vFN+TGwZ/Y8Xm4Nh4QBFpqi0iEzYUy3aeH3D49CMLvQf
QVQ0XMsL0mOeYQxDLuZAGlWKzxHXVKjSYttKhSrjlOuLBdy03IZiWDtehNJfMlob
Hh5lQP6kNqZdOJIP3Al38D0PCw+b2vPFAs+mNLY+2pamYfm5+sakQlmF74vcABgz
CJdDUO+WZSM8Xw1j53vyQa6J2dcRsjkqZmu3W4VYVl4RWE7I9nq9xTltUuVIiPt6
F3pKVwAE70/Fl7mj4Wxll2JEsAO+Z6sLjuYqd9biQBjhsZJaxeM4a7PA8LSvyv3r
0BQDmLutAAoWop3aOeBslOhZPxyGoi03NBhem4OycAkzWGXuLGGF3qgDjX2cq7vI
X+iHiPJb6xEyl3XIvM/cjFdcxUq17gEnnpXz0aaL1rpBK5grj0CfKmJn5y6Smm9W
0/BvmtQtL3/aE72Q4tiC9tzMASpga2l+s56suST+d0PfcdDjKiUBmv5m74YOe6ve
bpcJ/GjncoSFaABp6o2WNDGUjfaSpTcpBdoRc98QL6+ANrCHerBHPDlx/uSePjZi
kfYtq1t8uNgAuOG22sN86K0wYUM2juqk1POZLrdcXu4jjM1F84Er+nOLL+nvJuLi
4ao0i6WKQ/oUosE1yx5f
=+wFv
-----END PGP SIGNATURE-----
--=-=-=--
