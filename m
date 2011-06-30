From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH 3/10 v6] PM / Domains: Support for generic
	I/O PM domains (v7)
Date: Thu, 30 Jun 2011 14:14:40 +0800
Message-ID: <BANLkTi=tipUrzeKJeQirrNWyE0KMS1+DYw__44647.7952682928$1309414551$gmane$org@mail.gmail.com>
References: <201106112223.04972.rjw@sisk.pl> <201106252324.13454.rjw@sisk.pl>
	<201106252326.23837.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106252326.23837.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sun, Jun 26, 2011 at 5:26 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>

> +static void genpd_power_off_work_fn(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct generic_pm_domain *genpd;
> +
> + =A0 =A0 =A0 genpd =3D container_of(work, struct generic_pm_domain, powe=
r_off_work);
> +
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&genpd->parent->lock);
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);

lockdep warning may be triggered if LOCKDEP is enabled, so the
mutex_lock for subdomain should be replaced as mutex_lock_nest.

> + =A0 =A0 =A0 pm_genpd_poweroff(genpd);
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&genpd->parent->lock);
> +}
> +
> +/**
> + * pm_genpd_runtime_suspend - Suspend a device belonging to I/O PM domai=
n.
> + * @dev: Device to suspend.
> + *
> + * Carry out a runtime suspend of a device under the assumption that its
> + * pm_domain field points to the domain member of an object of type
> + * struct generic_pm_domain representing a PM domain consisting of I/O d=
evices.
> + */
> +static int pm_genpd_runtime_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct generic_pm_domain *genpd;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(dev->pm_domain))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 genpd =3D container_of(dev->pm_domain, struct generic_pm_do=
main, domain);
> +
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&genpd->parent->lock);
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);

same with above.

> + =A0 =A0 =A0 if (genpd->stop_device) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D genpd->stop_device(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 genpd->in_progress++;
> + =A0 =A0 =A0 pm_genpd_poweroff(genpd);
> + =A0 =A0 =A0 genpd->in_progress--;
> +
> + out:
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&genpd->parent->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * pm_genpd_poweron - Restore power to a given PM domain and its parents.
> + * @genpd: PM domain to power up.
> + *
> + * Restore power to @genpd and all of its parents so that it is possible=
 to
> + * resume a device belonging to it.
> + */
> +static int pm_genpd_poweron(struct generic_pm_domain *genpd)
> +{
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + start:
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&genpd->parent->lock);
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);

same with above

> + =A0 =A0 =A0 if (!genpd->power_is_off)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> +
> + =A0 =A0 =A0 if (genpd->parent && genpd->parent->power_is_off) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&genpd->parent->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_genpd_poweron(genpd->parent);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto start;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (genpd->power_on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret =3D genpd->power_on(genpd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 genpd->power_is_off =3D false;
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd->parent->sd_count++;
> +
> + out:
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> + =A0 =A0 =A0 if (genpd->parent)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&genpd->parent->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pm_genpd_runtime_resume - Resume a device belonging to I/O PM domain.
> + * @dev: Device to resume.
> + *
> + * Carry out a runtime resume of a device under the assumption that its
> + * pm_domain field points to the domain member of an object of type
> + * struct generic_pm_domain representing a PM domain consisting of I/O d=
evices.
> + */
> +static int pm_genpd_runtime_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct generic_pm_domain *genpd;
> + =A0 =A0 =A0 struct dev_list_entry *dle;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(dev->pm_domain))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 genpd =3D container_of(dev->pm_domain, struct generic_pm_do=
main, domain);
> +
> + =A0 =A0 =A0 ret =3D pm_genpd_poweron(genpd);
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);
> +
> + =A0 =A0 =A0 list_for_each_entry(dle, &genpd->dev_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dle->dev =3D=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __pm_genpd_restore_device(d=
le, genpd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (genpd->start_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd->start_device(dev);
> +
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#else
> +
> +static inline void genpd_power_off_work_fn(struct work_struct *work) {}
> +
> +#define pm_genpd_runtime_suspend =A0 =A0 =A0 NULL
> +#define pm_genpd_runtime_resume =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
> +
> +#endif /* CONFIG_PM_RUNTIME */
> +
> +/**
> + * pm_genpd_add_device - Add a device to an I/O PM domain.
> + * @genpd: PM domain to add the device to.
> + * @dev: Device to be added.
> + */
> +int pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *=
dev)
> +{
> + =A0 =A0 =A0 struct dev_list_entry *dle;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);
> +
> + =A0 =A0 =A0 if (genpd->power_is_off) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_for_each_entry(dle, &genpd->dev_list, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dle->dev =3D=3D dev) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dle =3D kzalloc(sizeof(*dle), GFP_KERNEL);
> + =A0 =A0 =A0 if (!dle) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dle->dev =3D dev;
> + =A0 =A0 =A0 dle->need_restore =3D false;
> + =A0 =A0 =A0 list_add_tail(&dle->node, &genpd->dev_list);
> +
> + =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> + =A0 =A0 =A0 dev->pm_domain =3D &genpd->domain;
> + =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +
> + out:
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pm_genpd_remove_device - Remove a device from an I/O PM domain.
> + * @genpd: PM domain to remove the device from.
> + * @dev: Device to be removed.
> + */
> +int pm_genpd_remove_device(struct generic_pm_domain *genpd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device *dev)
> +{
> + =A0 =A0 =A0 struct dev_list_entry *dle;
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);
> +
> + =A0 =A0 =A0 list_for_each_entry(dle, &genpd->dev_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dle->dev !=3D dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->pm_domain =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&dle->node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dle);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pm_genpd_add_subdomain - Add a subdomain to an I/O PM domain.
> + * @genpd: Master PM domain to add the subdomain to.
> + * @new_subdomain: Subdomain to be added.
> + */
> +int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct generic_pm_do=
main *new_subdomain)
> +{
> + =A0 =A0 =A0 struct generic_pm_domain *subdomain;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(new_subdomain))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);
> +
> + =A0 =A0 =A0 if (genpd->power_is_off && !new_subdomain->power_is_off) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_for_each_entry(subdomain, &genpd->sd_list, sd_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (subdomain =3D=3D new_subdomain) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&new_subdomain->lock);

same with above

> +
> + =A0 =A0 =A0 list_add_tail(&new_subdomain->sd_node, &genpd->sd_list);
> + =A0 =A0 =A0 new_subdomain->parent =3D genpd;
> + =A0 =A0 =A0 if (!subdomain->power_is_off)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd->sd_count++;
> +
> + =A0 =A0 =A0 mutex_unlock(&new_subdomain->lock);
> +
> + out:
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
> + * @genpd: Master PM domain to remove the subdomain from.
> + * @target: Subdomain to be removed.
> + */
> +int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct generic_=
pm_domain *target)
> +{
> + =A0 =A0 =A0 struct generic_pm_domain *subdomain;
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(target))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&genpd->lock);
> +
> + =A0 =A0 =A0 list_for_each_entry(subdomain, &genpd->sd_list, sd_node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (subdomain !=3D target)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&subdomain->lock);

same with above

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&subdomain->sd_node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 subdomain->parent =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!subdomain->power_is_off)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 genpd_sd_counter_dec(genpd);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&subdomain->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&genpd->lock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * pm_genpd_init - Initialize a generic I/O PM domain object.
> + * @genpd: PM domain object to initialize.
> + * @gov: PM domain governor to associate with the domain (may be NULL).
> + * @is_off: Initial value of the domain's power_is_off field.
> + */
> +void pm_genpd_init(struct generic_pm_domain *genpd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct dev_power_governor *gov, bool=
 is_off)
> +{
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(genpd))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 INIT_LIST_HEAD(&genpd->sd_node);
> + =A0 =A0 =A0 genpd->parent =3D NULL;
> + =A0 =A0 =A0 INIT_LIST_HEAD(&genpd->dev_list);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&genpd->sd_list);
> + =A0 =A0 =A0 mutex_init(&genpd->lock);
> + =A0 =A0 =A0 genpd->gov =3D gov;
> + =A0 =A0 =A0 INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
> + =A0 =A0 =A0 genpd->in_progress =3D 0;
> + =A0 =A0 =A0 genpd->sd_count =3D 0;
> + =A0 =A0 =A0 genpd->power_is_off =3D is_off;
> + =A0 =A0 =A0 genpd->domain.ops.runtime_suspend =3D pm_genpd_runtime_susp=
end;
> + =A0 =A0 =A0 genpd->domain.ops.runtime_resume =3D pm_genpd_runtime_resum=
e;
> + =A0 =A0 =A0 genpd->domain.ops.runtime_idle =3D pm_generic_runtime_idle;
> +}
> Index: linux-2.6/kernel/power/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/kernel/power/Kconfig
> +++ linux-2.6/kernel/power/Kconfig
> @@ -227,3 +227,7 @@ config PM_OPP
> =A0config PM_RUNTIME_CLK
> =A0 =A0 =A0 =A0def_bool y
> =A0 =A0 =A0 =A0depends on PM_RUNTIME && HAVE_CLK
> +
> +config PM_GENERIC_DOMAINS
> + =A0 =A0 =A0 bool
> + =A0 =A0 =A0 depends on PM
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>


thanks,
-- =

Ming Lei
