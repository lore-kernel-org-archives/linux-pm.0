From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / AVS: SmartReflex: remove unused function
Date: Tue, 16 Oct 2018 11:09:11 +0200
Message-ID: <10339961.29dihbgRqp@aspire.rjw.lan>
References: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181006164059.16106-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <uwe@kleine-koenig.org>, linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>, LinAdmin <linadmin@quickline.ch>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Saturday, October 6, 2018 6:40:59 PM CEST Uwe Kleine-K=F6nig wrote:
> From: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> =

> omap_sr_register_pmic() was introduced in 2010 in commit
> =

> 	984aa6dbf4ca ("OMAP3: PM: Adding smartreflex driver support.")
> =

> . There was never any caller of this function in mainline resulting in a
> warning
> =

> 	sr_init: No PMIC hook to init smartreflex
> =

> for each machine where this driver is enabled. So remove the unused
> function and the pr_warn.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <uwe@kleine-koenig.org>
> ---
> Hello,
> =

> I didn't test this change, didn't even try to compile it. Just read a
> report[1] that this warning is annoying on an Marvell Armada based
> machine running a Debian kernel.
> =

> Best regards
> Uwe
> =

> [1] https://lists.debian.org/d6abf9d1-14bf-86fc-58a0-0f11ff1ac345@quickli=
ne.ch
> =

>  drivers/power/avs/smartreflex.c   | 31 -------------------------------
>  include/linux/power/smartreflex.h |  5 -----
>  2 files changed, 36 deletions(-)
> =

> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartref=
lex.c
> index cb0237143dbe..d29b6313cafc 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -36,7 +36,6 @@
>  static LIST_HEAD(sr_list);
>  =

>  static struct omap_sr_class_data *sr_class;
> -static struct omap_sr_pmic_data *sr_pmic_data;
>  static struct dentry		*sr_dbg_dir;
>  =

>  static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32=
 value)
> @@ -779,25 +778,6 @@ void omap_sr_disable_reset_volt(struct voltagedomain=
 *voltdm)
>  	sr_class->disable(sr, 1);
>  }
>  =

> -/**
> - * omap_sr_register_pmic() - API to register pmic specific info.
> - * @pmic_data:	The structure containing pmic specific data.
> - *
> - * This API is to be called from the PMIC specific code to register with
> - * smartreflex driver pmic specific info. Currently the only info requir=
ed
> - * is the smartreflex init on the PMIC side.
> - */
> -void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data)
> -{
> -	if (!pmic_data) {
> -		pr_warn("%s: Trying to register NULL PMIC data structure with smartref=
lex\n",
> -			__func__);
> -		return;
> -	}
> -
> -	sr_pmic_data =3D pmic_data;
> -}
> -
>  /* PM Debug FS entries to enable and disable smartreflex. */
>  static int omap_sr_autocomp_show(void *data, u64 *val)
>  {
> @@ -1064,17 +1044,6 @@ static int __init sr_init(void)
>  {
>  	int ret =3D 0;
>  =

> -	/*
> -	 * sr_init is a late init. If by then a pmic specific API is not
> -	 * registered either there is no need for anything to be done on
> -	 * the PMIC side or somebody has forgotten to register a PMIC
> -	 * handler. Warn for the second condition.
> -	 */
> -	if (sr_pmic_data && sr_pmic_data->sr_pmic_init)
> -		sr_pmic_data->sr_pmic_init();
> -	else
> -		pr_warn("%s: No PMIC hook to init smartreflex\n", __func__);
> -
>  	ret =3D platform_driver_register(&smartreflex_driver);
>  	if (ret) {
>  		pr_err("%s: platform driver register failed for SR\n",
> diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smar=
treflex.h
> index 7b81dad712de..a586976f4784 100644
> --- a/include/linux/power/smartreflex.h
> +++ b/include/linux/power/smartreflex.h
> @@ -303,9 +303,6 @@ void omap_sr_enable(struct voltagedomain *voltdm);
>  void omap_sr_disable(struct voltagedomain *voltdm);
>  void omap_sr_disable_reset_volt(struct voltagedomain *voltdm);
>  =

> -/* API to register the pmic specific data with the smartreflex driver. */
> -void omap_sr_register_pmic(struct omap_sr_pmic_data *pmic_data);
> -
>  /* Smartreflex driver hooks to be called from Smartreflex class driver */
>  int sr_enable(struct omap_sr *sr, unsigned long volt);
>  void sr_disable(struct omap_sr *sr);
> @@ -320,7 +317,5 @@ static inline void omap_sr_enable(struct voltagedomai=
n *voltdm) {}
>  static inline void omap_sr_disable(struct voltagedomain *voltdm) {}
>  static inline void omap_sr_disable_reset_volt(
>  		struct voltagedomain *voltdm) {}
> -static inline void omap_sr_register_pmic(
> -		struct omap_sr_pmic_data *pmic_data) {}
>  #endif
>  #endif
> =


Applied, thanks!
