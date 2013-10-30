From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PULL REQUEST for Rafael] PM / devfreq: pull request bugfixes (resend)
Date: Wed, 30 Oct 2013 01:54:56 +0100
Message-ID: <30768194.yuLq4dZVZ8@vostro.rjw.lan>
References: <23142243.105481383031030053.JavaMail.weblogic@epv6ml10>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:55791 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab3J3Amu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2013 20:42:50 -0400
In-Reply-To: <23142243.105481383031030053.JavaMail.weblogic@epv6ml10>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, =?utf-8?B?7Jqw7IOB7KCV?= <sangjung.woo@samsung.com>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>

On Tuesday, October 29, 2013 07:17:10 AM MyungJoo Ham wrote:
> Dear Rafael,
>=20
> Here goes some bugfixes of devfreq.
> If it is not too late, please merge into 3.12-rcX.

Pulled, but in my opinion these fixes don't qualify as 3.12 material at=
 this
point.

Thanks!

>
> The following changes since commit 959f58544b7f20c92d5eb43d1232c96c15=
c01bfb:
>=20
>   Linux 3.12-rc7 (2013-10-27 16:12:03 -0700)
>=20
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-r=
afael
>=20
> Dan Carpenter (1):
>       PM / devfreq: create_freezable_workqueue() doesn't return an ER=
R_PTR
>=20
> Sachin Kamat (4):
>       PM / devfreq: Fix incorrect usage of IS_ERR_OR_NULL in exynos5_=
bus.c
>       PM / devfreq: Remove redundant platform_set_drvdata() in exynos=
5_bus.c
>       PM / devfreq: Use devm_* APIs in exynos5_bus.c
>       PM / devfreq: Remove duplicate header file inclusion in exynos5=
_bus.c
>=20
>  drivers/devfreq/devfreq.c            |    4 ++--
>  drivers/devfreq/exynos/exynos5_bus.c |   31 +++++++++---------------=
-------
>  2 files changed, 11 insertions(+), 24 deletions(-)
> N=EF=BF=BD=E3=8E=A0=EF=A6=9Er=EF=BF=BDy=E9=89=89=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=D0=A4=ED=91=A4v=EF=BF=BD=EF=BF=BD)=E9=A0=BB{.n=EF=BF=BD=EF=BF=BD=
=EB=9E=A8=EF=BF=BD{=EA=B4=9Ch=E3=8E=8D=17=EF=BF=BD=E2=97=8F=EF=BF=BD=EF=
=BF=BD=EA=BC=BF=EF=BF=BDz=EF=BF=BDj:+v=EF=BF=BD=E3=89=AD=07=EF=BF=BD=E5=
=96=A9zZ+=EF=BF=BD=EF=BF=BDzf=EF=BC=82=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=E9=8E=ACz=EF=BF=BD=EF=BF=BD=E2=85=
=B1=EF=BF=BD=EF=BF=BD=E2=91=A1=EF=BF=BD&=EF=BF=BD=E5=88=AA=1Bf
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
