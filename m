From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] CPUFreq ARM Fixes for 3.11
Date: Mon, 24 Jun 2013 12:46:29 +0200
Message-ID: <1389572.pO2YzmOyGa@vostro.rjw.lan>
References: <CAKohpong-+4vu4Ky7u_7mPanOZr-jxHKSJRur1cRPaZuaFUBUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:48909 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab3FXKhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jun 2013 06:37:03 -0400
In-Reply-To: <CAKohpong-+4vu4Ky7u_7mPanOZr-jxHKSJRur1cRPaZuaFUBUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org

On Monday, June 24, 2013 11:23:52 AM Viresh Kumar wrote:
> Hi Rafael,
>=20
> The following changes since commit 9e895ace5d82df8929b16f58e9f515f6d5=
4ab82d:
>=20
>   Linux 3.10-rc7 (2013-06-22 09:47:31 -1000)
>=20
> are available in the git repository at:
>=20
>   git://git.linaro.org/people/vireshk/linux.git cpufreq-next
>=20
> for you to fetch changes up to 166b9addd83aaf6eb22d9db7dc015f81913c9a=
0e:
>=20
>   cpufreq: s3c2416: fix forgotten driver_data conversions (2013-06-24
> 11:22:33 +0530)

Pulled, thanks Viresh!

Rafael


> ----------------------------------------------------------------
> Heiko St=C3=BCbner (1):
>       cpufreq: s3c2416: fix forgotten driver_data conversions
>=20
>  drivers/cpufreq/s3c2416-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
