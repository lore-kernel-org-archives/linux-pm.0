From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/3] thermal: exynos: Fix typos in Kconfig
Date: Fri, 30 Aug 2013 16:35:01 +0800
Message-ID: <1377851701.2652.1.camel@rzhang-lenovo>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
	 <521F3BEE.5020608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64850 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752529Ab3H3Idh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 Aug 2013 04:33:37 -0400
In-Reply-To: <521F3BEE.5020608@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-pm@vger.kernel.org, jonghwa3.lee@samsung.com, amit.daniel@samsung.com, patches@linaro.org

On =E5=9B=9B, 2013-08-29 at 08:17 -0400, Eduardo Valentin wrote:
> On 19-08-2013 02:28, Sachin Kamat wrote:
> > Fixes some trivial typos.
> >=20
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>=20
>=20
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
>=20
so are you going to take this patch series?

thanks,
rui
> > ---
> > This series is based on next branch of below tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
> >=20
> > This is tested on Exynos4210 and 5250 based boards.
> > ---
> >  drivers/thermal/samsung/Kconfig |   10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/sams=
ung/Kconfig
> > index b653f15..92492e4 100644
> > --- a/drivers/thermal/samsung/Kconfig
> > +++ b/drivers/thermal/samsung/Kconfig
> > @@ -3,16 +3,16 @@ config EXYNOS_THERMAL
> >  	depends on ARCH_HAS_BANDGAP
> >  	help
> >  	  If you say yes here you get support for the TMU (Thermal Manage=
ment
> > -	  Unit) driver for SAMSUNG EXYNOS series of soc. This driver init=
ialises
> > +	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver ini=
tialises
> >  	  the TMU, reports temperature and handles cooling action if defi=
ned.
> > -	  This driver uses the exynos core thermal API's and TMU configur=
ation
> > -	  data from the supported soc's.
> > +	  This driver uses the Exynos core thermal APIs and TMU configura=
tion
> > +	  data from the supported SoCs.
> > =20
> >  config EXYNOS_THERMAL_CORE
> > -	bool "Core thermal framework support for EXYNOS SOC's"
> > +	bool "Core thermal framework support for EXYNOS SOCs"
> >  	depends on EXYNOS_THERMAL
> >  	help
> >  	  If you say yes here you get support for EXYNOS TMU
> >  	  (Thermal Management Unit) common registration/unregistration
> >  	  functions to the core thermal layer and also to use the generic
> > -	  cpu cooling API's.
> > +	  CPU cooling APIs.
> >=20
>=20
>=20


