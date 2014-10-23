From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] thermal-soc changes
Date: Thu, 23 Oct 2014 13:15:45 +0800
Message-ID: <1414041345.2380.3.camel@rzhang1-toshiba>
References: <20141021134941.GA4937@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:43022 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102AbaJWFPo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 23 Oct 2014 01:15:44 -0400
In-Reply-To: <20141021134941.GA4937@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On =E4=BA=8C, 2014-10-21 at 09:49 -0400, Eduardo Valentin wrote:
> Hello Rui,
>=20
> Here are a couple of changes that are in my tree. They include:
> - a few code refactoring improving the Exynos code base;
> - new feature on the Exynos code base (TRIMINFO and TRIMRELOAD);
> - a documentation of RCAR thermal; and
> - a fix in the of-thermal, regarding the proper usage of of APIs.
>=20
what's their target?
please send me separate pull requests for different targets.

thanks,
rui
> They are based on your next branch.
>=20
> BR,
>=20
> Eduardo Valentin
>=20
> The following changes since commit 6ceaf58abe25e86292152005c51169796b=
ad3407:
>=20
>   Merge branch 'int340x-thermal' of .git into next (2014-10-17 14:30:=
58 +0800)
>=20
> are available in the git repository at:
>=20
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-th=
ermal.git next
>=20
> for you to fetch changes up to df67e40f51398fef8dd705dfe4e287ad9b10ba=
4b:
>=20
>   thermal: fix multiple disbalanced device node counters (2014-10-21 =
08:05:50 -0400)
>=20
> ----------------------------------------------------------------
> Bartlomiej Zolnierkiewicz (9):
>       thermal: exynos: remove unused struct exynos_tmu_registers entr=
ies
>       thermal: exynos: remove dead code for HW_MODE calibration
>       thermal: exynos: remove redundant pdata checks from exynos_tmu_=
initialize()
>       thermal: exynos: remove redundant threshold_code checks from ex=
ynos_tmu_initialize()
>       thermal: exynos: simplify temp_to_code() and code_to_temp()
>       thermal: exynos: cache non_hw_trigger_levels in pdata
>       thermal: exynos: remove redundant pdata checks from exynos_tmu_=
control()
>       thermal: exynos: remove identical values from exynos*_tmu_regis=
ters structures
>       thermal: samsung: Exynos5260 and Exynos5420 should not use TRIM=
_RELOAD flag
>=20
> Chanwoo Choi (2):
>       thermal: exynos: Add support for many TRIMINFO_CTRL registers
>       thermal: exynos: Add support for TRIM_RELOAD feature at Exynos3=
250
>=20
> Geert Uytterhoeven (1):
>       thermal: rcar: Add binding docs for new R-Car Gen2 SoCs
>=20
> Vladimir Zapolskiy (1):
>       thermal: fix multiple disbalanced device node counters
>=20
>  .../devicetree/bindings/thermal/rcar-thermal.txt   |   5 +-
>  drivers/thermal/of-thermal.c                       |  40 ++++--
>  drivers/thermal/samsung/exynos_thermal_common.h    |   2 +-
>  drivers/thermal/samsung/exynos_tmu.c               | 141 ++++++-----=
----------
>  drivers/thermal/samsung/exynos_tmu.h               |  81 ++---------=
-
>  drivers/thermal/samsung/exynos_tmu_data.c          |  83 ++++-------=
-
>  drivers/thermal/samsung/exynos_tmu_data.h          |  39 +-----
>  7 files changed, 111 insertions(+), 280 deletions(-)


