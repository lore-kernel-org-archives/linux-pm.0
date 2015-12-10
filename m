From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V3 2/2] PM / OPP: Parse 'opp-<prop>-<name>' bindings
Date: Thu, 10 Dec 2015 09:54:45 +0000
Message-ID: <CAF2Aj3h6u5W+H0shc+MwPpfb8spwXBZYr1+m4w62PpiHk=50UA@mail.gmail.com>
References: <cover.1449627691.git.viresh.kumar@linaro.org>
	<e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35374 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbbLJJyq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 04:54:46 -0500
Received: by vkha189 with SMTP id a189so76263756vkh.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Dec 2015 01:54:45 -0800 (PST)
In-Reply-To: <e3744c43a5ad26e9e49cf938b3ecd846cc500fce.1449627691.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <vireshk@kernel.org>

On 9 December 2015 at 02:31, Viresh Kumar <viresh.kumar@linaro.org> wro=
te:
> OPP bindings (for few properties) allow a platform to choose a
> value/range among a set of available options. The options are present=
 as
> opp-<prop>-<name>, where the platform needs to supply the <name> stri=
ng.
>
> The OPP properties which allow such an option are: opp-microvolt and
> opp-microamp.
>
> Add support to the OPP-core to parse these bindings, by introducing
> dev_pm_opp_{set|put}_prop_name() APIs.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/base/power/opp/core.c | 165 ++++++++++++++++++++++++++++++++=
++++++----
>  drivers/base/power/opp/opp.h  |   2 +
>  include/linux/pm_opp.h        |   9 +++
>  3 files changed, 161 insertions(+), 15 deletions(-)

Tested-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/c=
ore.c
> index 55cf1a99b532..5c01fec1ed14 100644
> --- a/drivers/base/power/opp/core.c
> +++ b/drivers/base/power/opp/core.c
> @@ -562,6 +562,9 @@ static void _remove_device_opp(struct device_opp =
*dev_opp)
>         if (dev_opp->supported_hw)
>                 return;
>
> +       if (dev_opp->prop_name)
> +               return;
> +
>         list_dev =3D list_first_entry(&dev_opp->dev_list, struct devi=
ce_list_opp,
>                                     node);
>
> @@ -794,35 +797,48 @@ static int _opp_add_v1(struct device *dev, unsi=
gned long freq, long u_volt,
>  }
>
>  /* TODO: Support multiple regulators */
> -static int opp_parse_supplies(struct dev_pm_opp *opp, struct device =
*dev)
> +static int opp_parse_supplies(struct dev_pm_opp *opp, struct device =
*dev,
> +                             struct device_opp *dev_opp)
>  {
>         u32 microvolt[3] =3D {0};
>         u32 val;
>         int count, ret;
> +       struct property *prop =3D NULL;
> +       char name[NAME_MAX];
> +
> +       /* Search for "opp-microvolt-<name>" */
> +       if (dev_opp->prop_name) {
> +               sprintf(name, "opp-microvolt-%s", dev_opp->prop_name)=
;
> +               prop =3D of_find_property(opp->np, name, NULL);
> +       }
> +
> +       if (!prop) {
> +               /* Search for "opp-microvolt" */
> +               name[13] =3D '\0';
> +               prop =3D of_find_property(opp->np, name, NULL);
>
> -       /* Missing property isn't a problem, but an invalid entry is =
*/
> -       if (!of_find_property(opp->np, "opp-microvolt", NULL))
> -               return 0;
> +               /* Missing property isn't a problem, but an invalid e=
ntry is */
> +               if (!prop)
> +                       return 0;
> +       }
>
> -       count =3D of_property_count_u32_elems(opp->np, "opp-microvolt=
");
> +       count =3D of_property_count_u32_elems(opp->np, name);
>         if (count < 0) {
> -               dev_err(dev, "%s: Invalid opp-microvolt property (%d)=
\n",
> -                       __func__, count);
> +               dev_err(dev, "%s: Invalid %s property (%d)\n",
> +                       __func__, name, count);
>                 return count;
>         }
>
>         /* There can be one or three elements here */
>         if (count !=3D 1 && count !=3D 3) {
> -               dev_err(dev, "%s: Invalid number of elements in opp-m=
icrovolt property (%d)\n",
> -                       __func__, count);
> +               dev_err(dev, "%s: Invalid number of elements in %s pr=
operty (%d)\n",
> +                       __func__, name, count);
>                 return -EINVAL;
>         }
>
> -       ret =3D of_property_read_u32_array(opp->np, "opp-microvolt", =
microvolt,
> -                                        count);
> +       ret =3D of_property_read_u32_array(opp->np, name, microvolt, =
count);
>         if (ret) {
> -               dev_err(dev, "%s: error parsing opp-microvolt: %d\n",=
 __func__,
> -                       ret);
> +               dev_err(dev, "%s: error parsing %s: %d\n", __func__, =
name, ret);
>                 return -EINVAL;
>         }
>
> @@ -830,7 +846,20 @@ static int opp_parse_supplies(struct dev_pm_opp =
*opp, struct device *dev)
>         opp->u_volt_min =3D microvolt[1];
>         opp->u_volt_max =3D microvolt[2];
>
> -       if (!of_property_read_u32(opp->np, "opp-microamp", &val))
> +       /* Search for "opp-microamp-<name>" */
> +       prop =3D NULL;
> +       if (dev_opp->prop_name) {
> +               sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
> +               prop =3D of_find_property(opp->np, name, NULL);
> +       }
> +
> +       if (!prop) {
> +               /* Search for "opp-microamp" */
> +               name[12] =3D '\0';
> +               prop =3D of_find_property(opp->np, name, NULL);
> +       }
> +
> +       if (prop && !of_property_read_u32(opp->np, name, &val))
>                 opp->u_amp =3D val;
>
>         return 0;
> @@ -948,6 +977,112 @@ void dev_pm_opp_put_supported_hw(struct device =
*dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_put_supported_hw);
>
> +/**
> + * dev_pm_opp_set_prop_name() - Set prop-extn name
> + * @dev: Device for which the regulator has to be set.
> + * @name: name to postfix to properties.
> + *
> + * This is required only for the V2 bindings, and it enables a platf=
orm to
> + * specify the extn to be used for certain property names. The prope=
rties to
> + * which the extension will apply are opp-microvolt and opp-microamp=
=2E OPP core
> + * should postfix the property name with -<name> while looking for t=
hem.
> + *
> + * Locking: The internal device_opp and opp structures are RCU prote=
cted.
> + * Hence this function internally uses RCU updater strategy with mut=
ex locks
> + * to keep the integrity of the internal data structures. Callers sh=
ould ensure
> + * that this function is *NOT* called under RCU protection or in con=
texts where
> + * mutex cannot be locked.
> + */
> +int dev_pm_opp_set_prop_name(struct device *dev, const char *name)
> +{
> +       struct device_opp *dev_opp;
> +       int ret =3D 0;
> +
> +       /* Hold our list modification lock here */
> +       mutex_lock(&dev_opp_list_lock);
> +
> +       dev_opp =3D _add_device_opp(dev);
> +       if (!dev_opp) {
> +               ret =3D -ENOMEM;
> +               goto unlock;
> +       }
> +
> +       /* Make sure there are no concurrent readers while updating d=
ev_opp */
> +       WARN_ON(!list_empty(&dev_opp->opp_list));
> +
> +       /* Do we already have a prop-name associated with dev_opp? */
> +       if (dev_opp->prop_name) {
> +               dev_err(dev, "%s: Already have prop-name %s\n", __fun=
c__,
> +                       dev_opp->prop_name);
> +               ret =3D -EBUSY;
> +               goto err;
> +       }
> +
> +       dev_opp->prop_name =3D kstrdup(name, GFP_KERNEL);
> +       if (!dev_opp->prop_name) {
> +               ret =3D -ENOMEM;
> +               goto err;
> +       }
> +
> +       mutex_unlock(&dev_opp_list_lock);
> +       return 0;
> +
> +err:
> +       _remove_device_opp(dev_opp);
> +unlock:
> +       mutex_unlock(&dev_opp_list_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_set_prop_name);
> +
> +/**
> + * dev_pm_opp_put_prop_name() - Releases resources blocked for prop-=
name
> + * @dev: Device for which the regulator has to be set.
> + *
> + * This is required only for the V2 bindings, and is called for a ma=
tching
> + * dev_pm_opp_set_prop_name(). Until this is called, the device_opp =
structure
> + * will not be freed.
> + *
> + * Locking: The internal device_opp and opp structures are RCU prote=
cted.
> + * Hence this function internally uses RCU updater strategy with mut=
ex locks
> + * to keep the integrity of the internal data structures. Callers sh=
ould ensure
> + * that this function is *NOT* called under RCU protection or in con=
texts where
> + * mutex cannot be locked.
> + */
> +void dev_pm_opp_put_prop_name(struct device *dev)
> +{
> +       struct device_opp *dev_opp;
> +
> +       /* Hold our list modification lock here */
> +       mutex_lock(&dev_opp_list_lock);
> +
> +       /* Check for existing list for 'dev' first */
> +       dev_opp =3D _find_device_opp(dev);
> +       if (IS_ERR(dev_opp)) {
> +               dev_err(dev, "Failed to find dev_opp: %ld\n", PTR_ERR=
(dev_opp));
> +               goto unlock;
> +       }
> +
> +       /* Make sure there are no concurrent readers while updating d=
ev_opp */
> +       WARN_ON(!list_empty(&dev_opp->opp_list));
> +
> +       if (!dev_opp->prop_name) {
> +               dev_err(dev, "%s: Doesn't have a prop-name\n", __func=
__);
> +               goto unlock;
> +       }
> +
> +       kfree(dev_opp->prop_name);
> +       dev_opp->prop_name =3D NULL;
> +
> +       /* Try freeing device_opp if this was the last blocking resou=
rce */
> +       _remove_device_opp(dev_opp);
> +
> +unlock:
> +       mutex_unlock(&dev_opp_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_put_prop_name);
> +
>  static bool _opp_is_supported(struct device *dev, struct device_opp =
*dev_opp,
>                               struct device_node *np)
>  {
> @@ -1042,7 +1177,7 @@ static int _opp_add_static_v2(struct device *de=
v, struct device_node *np)
>         if (!of_property_read_u32(np, "clock-latency-ns", &val))
>                 new_opp->clock_latency_ns =3D val;
>
> -       ret =3D opp_parse_supplies(new_opp, dev);
> +       ret =3D opp_parse_supplies(new_opp, dev, dev_opp);
>         if (ret)
>                 goto free_opp;
>
> diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/op=
p.h
> index 70f4564a6ab9..690638ef36ee 100644
> --- a/drivers/base/power/opp/opp.h
> +++ b/drivers/base/power/opp/opp.h
> @@ -131,6 +131,7 @@ struct device_list_opp {
>   * @suspend_opp: Pointer to OPP to be used during device suspend.
>   * @supported_hw: Array of version number to support.
>   * @supported_hw_count: Number of elements in supported_hw array.
> + * @prop_name: A name to postfix to many DT properties, while parsin=
g them.
>   * @dentry:    debugfs dentry pointer of the real device directory (=
not links).
>   * @dentry_name: Name of the real dentry.
>   *
> @@ -157,6 +158,7 @@ struct device_opp {
>
>         unsigned int *supported_hw;
>         unsigned int supported_hw_count;
> +       const char *prop_name;
>
>  #ifdef CONFIG_DEBUG_FS
>         struct dentry *dentry;
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index 3a85110242f0..95403d2ccaf5 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -58,6 +58,8 @@ struct srcu_notifier_head *dev_pm_opp_get_notifier(=
struct device *dev);
>  int dev_pm_opp_set_supported_hw(struct device *dev, const u32 *versi=
ons,
>                                 unsigned int count);
>  void dev_pm_opp_put_supported_hw(struct device *dev);
> +int dev_pm_opp_set_prop_name(struct device *dev, const char *name);
> +void dev_pm_opp_put_prop_name(struct device *dev);
>  #else
>  static inline unsigned long dev_pm_opp_get_voltage(struct dev_pm_opp=
 *opp)
>  {
> @@ -142,6 +144,13 @@ static inline int dev_pm_opp_set_supported_hw(st=
ruct device *dev,
>
>  static inline void dev_pm_opp_put_supported_hw(struct device *dev) {=
}
>
> +static inline int dev_pm_opp_set_prop_name(struct device *dev, const=
 char *name)
> +{
> +       return -EINVAL;
> +}
> +
> +static inline void dev_pm_opp_put_prop_name(struct device *dev) {}
> +
>  #endif         /* CONFIG_PM_OPP */
>
>  #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
> --
> 2.6.2.198.g614a2ac
>
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-kernel



--=20
Lee Jones
Linaro ST Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
