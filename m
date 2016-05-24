From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] power_suply: isp1704_charger: Fix isp1704_write()
 definition
Date: Tue, 24 May 2016 17:32:06 +0200
Message-ID: <20160524153206.GU29844@pali>
References: <1451646209-11618-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201601011226.21552@pali>
 <201601092342.30608@pali>
 <20160519091304.GK29844@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35128 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbcEXPcJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 11:32:09 -0400
Content-Disposition: inline
In-Reply-To: <20160519091304.GK29844@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, sre@kernel.org
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Thursday 19 May 2016 11:13:04 Pali Roh=C3=A1r wrote:
> On Saturday 09 January 2016 23:42:30 Pali Roh=C3=A1r wrote:
> > On Friday 01 January 2016 12:26:21 Pali Roh=C3=A1r wrote:
> > > On Friday 01 January 2016 12:03:29 Ivaylo Dimitrov wrote:
> > > > All calls to isp1704_write() are using parameter sequence of
> > > > isp1704_write(isp, reg, val) but the function is defined as
> > > > isp1704_write(isp, val, reg). Fix isp1704_write function defini=
tion
> > > > so that the driver to be functional.
> > > >=20
> > > > Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
> > >=20
> > > Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > >=20
> > > This problem is there since inclusion of driver itself. No idea w=
hy
> > > that driver could work... I remember that it detected correctly t=
ype
> > > of charger.
> > >=20
> > > I will test this patch on real N900 HW in one or two weeks to che=
ck
> > > how it behave after patching...
> >=20
> > Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >=20
> > Please send this patch to all stable kernels.
>=20
> Hi! I still think that this patch should go to stable kernels. Becaus=
e
> without it driver does not work... Will somebody send it to stable?

So no objections, I sent it to stable@vger.kernel.org.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
