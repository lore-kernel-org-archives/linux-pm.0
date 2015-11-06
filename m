From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] bq2415x_charger: Delete unnecessary checks before the
 function call "of_node_put"
Date: Fri, 6 Nov 2015 17:13:35 +0100
Message-ID: <20151106161335.GG16108@pali>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <563CCDB1.1040703@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <563CCDB1.1040703@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On Friday 06 November 2015 16:56:33 SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 6 Nov 2015 16:48:46 +0100
>=20
> The of_node_put() function tests whether its argument is NULL and the=
n
> returns immediately. Thus the test around the calls is not needed.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
