From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] PM / OPP: fix condition for empty of_init_opp_table()
Date: Thu, 21 Feb 2013 08:59:02 -0600
Message-ID: <20130221145902.GA22712@kahuna>
References: <1361444685-1034-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45833 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753482Ab3BUO7L (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 21 Feb 2013 09:59:11 -0500
Content-Disposition: inline
In-Reply-To: <1361444685-1034-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org

On 19:04-20130221, Shawn Guo wrote:
> randconfig build reports the following error which is caused by that
> CONFIG_PM_OPP is unset.
>=20
Minor: caused by CONFIG_PM_OPP not being set?
>   CC      arch/arm/mach-imx/mach-imx6q.o
> arch/arm/mach-imx/mach-imx6q.c: In function =E2=80=98imx6q_opp_init=E2=
=80=99:
> arch/arm/mach-imx/mach-imx6q.c:248:2: error: implicit declaration of =
function =E2=80=98of_init_opp_table=E2=80=99 [-Werror=3Dimplicit-functi=
on-declaration]
thanks for catching this.
>=20
> Fix the error by giving a more correct condition for empty
> of_init_opp_table() implementation.
>=20
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  include/linux/opp.h |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/include/linux/opp.h b/include/linux/opp.h
> index 214e0eb..3aca2b8 100644
> --- a/include/linux/opp.h
> +++ b/include/linux/opp.h
> @@ -47,15 +47,6 @@ int opp_enable(struct device *dev, unsigned long f=
req);
>  int opp_disable(struct device *dev, unsigned long freq);
> =20
>  struct srcu_notifier_head *opp_get_notifier(struct device *dev);
> -
> -#ifdef CONFIG_OF
> -int of_init_opp_table(struct device *dev);
> -#else
> -static inline int of_init_opp_table(struct device *dev)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_OF */
>  #else
>  static inline unsigned long opp_get_voltage(struct opp *opp)
>  {
> @@ -112,6 +103,15 @@ static inline struct srcu_notifier_head *opp_get=
_notifier(struct device *dev)
>  }
>  #endif		/* CONFIG_PM_OPP */
> =20
> +#if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> +int of_init_opp_table(struct device *dev);
> +#else
> +static inline int of_init_opp_table(struct device *dev)
> +{
> +	return -EINVAL;
> +}
> +#endif
> +
>  #if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
>  int opp_init_cpufreq_table(struct device *dev,
>  			    struct cpufreq_frequency_table **table);

Acked-by: Nishanth Menon <nm@ti.com>
--=20
Regards,
Nishanth Menon
