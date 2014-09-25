From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] PM / AVS changes for v3.18 - v2
Date: Thu, 25 Sep 2014 22:42:37 +0200
Message-ID: <38173516.KG4f94aNi3@vostro.rjw.lan>
References: <7ha95nikqh.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64626 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751307AbaIYUWr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 16:22:47 -0400
In-Reply-To: <7ha95nikqh.fsf@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, dianders@chromium.org, heiko@sntech.de, broonie@kernel.org

On Thursday, September 25, 2014 12:05:42 PM Kevin Hilman wrote:
> Hi Rafael,
>=20
> The first pull request was missing a dependency on a feature that wen=
t
> in through Mark Brown's regulator tree, so it wouldn't actually compi=
le
> properly by itself.  This version pulls in that topic branch from Mar=
ks
> tree (topic/voltage-ev branch, already part of -next), and now compil=
es fine.

Pulled, thanks!

I'll push it to Linus after the Mark's material has been merged to avoi=
d
git log confusion.

Rafael


> The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe9=
88a2b9:
>=20
>   Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux.git tag=
s/avs-for-3.18
>=20
> for you to fetch changes up to cd8caa18deff6d2d87a4e3161b4dd8c6da3c4f=
38:
>=20
>   Merge branch 'topic/voltage-ev' of git://git.kernel.org/pub/scm/lin=
ux/kernel/git/broonie/regulator into avs-next (2014-09-25 09:57:57 -070=
0)
>=20
> ----------------------------------------------------------------
> PM / AVS changes for v3.18
>=20
> - Add new driver for Rockchip IO voltage domains
> - update MAINTAINERS to reflect maintenance of drivers/power/avs/*
>=20
> ----------------------------------------------------------------
> Heiko St=C3=BCbner (2):
>       regulator: core: Add REGULATOR_EVENT_PRE_VOLTAGE_CHANGE (and AB=
ORT)
>       PM / AVS: rockchip-io: add driver handling Rockchip io domains
>=20
> Kevin Hilman (2):
>       MAINTAINERS: update entry for drivers/power/avs
>       Merge branch 'topic/voltage-ev' of git://git.kernel.org/.../bro=
onie/regulator into avs-next
>=20
>  Documentation/devicetree/bindings/power/rockchip-io-domain.txt |  83=
 +++++++++++++++++++
>  MAINTAINERS                                                    |   4=
 +-
>  drivers/power/avs/Kconfig                                      |   8=
 ++
>  drivers/power/avs/Makefile                                     |   1=
 +
>  drivers/power/avs/rockchip-io-domain.c                         | 351=
 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>  drivers/regulator/core.c                                       |  63=
 +++++++++++++--
>  include/linux/regulator/consumer.h                             |  20=
 +++++
>  7 files changed, 521 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip-=
io-domain.txt
>  create mode 100644 drivers/power/avs/rockchip-io-domain.c
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
