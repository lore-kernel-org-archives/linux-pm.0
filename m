From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power/reset: zx: Register restart handler
Date: Tue, 14 Jul 2015 08:27:26 +0200
Message-ID: <20150714062725.GA3915@earth>
References: <1436171730-21175-1-git-send-email-jun.nie@linaro.org>
 <20150713120019.GB9128@earth>
 <CABymUCPmXH2VhU-rtpuq2eavbb1oAzAk_6gXqSPBJCvPcF5ZrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36586 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbGNG1b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 02:27:31 -0400
Content-Disposition: inline
In-Reply-To: <CABymUCPmXH2VhU-rtpuq2eavbb1oAzAk_6gXqSPBJCvPcF5ZrA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jun Nie <jun.nie@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, "wan.zhijun" <wan.zhijun@zte.com.cn>, Jason Liu <jason.liu@linaro.org>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 14, 2015 at 09:42:39AM +0800, Jun Nie wrote:
> 2015-07-13 20:00 GMT+08:00 Sebastian Reichel <sre@kernel.org>:
> > On Mon, Jul 06, 2015 at 04:35:30PM +0800, Jun Nie wrote:
> >> Register with kernel restart handler instead of setting arm_pm_restart
> >> directly.
> >>
> >> [...]
> >>
> >> +static int zx_restart_handler(struct notifier_block *this,
> >> +                           unsigned long mode, void *cmd)
> >> +{
> >> +     writel_relaxed(1, base + 0xb0);
> >> +     writel_relaxed(1, pcu_base + 0x34);
> >> +
> >> +     while (1)
> >> +             cpu_do_idle();
> >
> > mdelay(some_time);
> > pr_emerg("Unable to restart system\n");
>=20
> I do not think these code can be executed as reset will happen after
> register writing and while loop will stop any further code execution.
> Please point out issue if any.

Please remove the while loop. Instead wait for a reasonable amount
of time. If something goes wrong print an error message and return
NOTIFY_DONE. You can see an example in syscon-reboot.c

-- Sebastian

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVpKvKAAoJENju1/PIO/qayqUP/3zul1qtm0F/SrhNsHi0OosA
YnitmVn3DklkqGmHxX5Pcu1wFDFzvxCUp0WuUImvO93WF1rPk6bkExWkJzF+qXoE
Rw/hzTHe5RJG5g5QCoiN8yAaTszIQfm+Hsob8hbK2PkFeBlySeb27KHCdMlsjpZc
NfOG4HdQis4L8mOEc4OGlKdG9pXx89YJORTKdJeEbp6+Nq9mEn+q7Q4YuWAJJ8/O
+yyJQvxHKPvX94NsP5l6v9MNYLdlJPo3hRN5gDwrPvs0ZVbQTkgt9TazRwlIDET5
CRaYtMxBoHGteLMqV6G4e7hJiULmkb/jgt7yiNQ7PAJWwy6zyoXtN5gaHqWuN5Hy
baEL1fuCyvTF6e/ulWTnuc6E+CJeYjkGeP7HVJR39+WwNHjq2+VJGXCV2Sliuid2
ZGZrTDtGZU7zGrXEofeDnivwTdjkKXmY2TjWiLvMTifypqwFAYT6FNeTNFazrd0P
gP+bJkw1fFxijKit7EjfhWIlHAIJQjO2ihMZOW9zE6pePrPivnoOyLrkSST284X4
gdCuyN5XO+nJQYlJI8rc3OKAH692vjgRCPpBe6aRqL2y2wlewZfLkXVGW3yXfuYk
n8RtubyGI41Wu1GKDYSj/HgKNc2G8Q18NNJLr/LBuG5XFCRF1DLC4/hsKYW6M2rV
T3PY7d09P9+NjULgu9Z9
=KNjD
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
