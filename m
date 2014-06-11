From: jonghwa3.lee@samsung.com
Subject: Re: [RFC PATCH] PM: Domain: Add flag to assure that device's runtime
 pm callback is called at once.
Date: Wed, 11 Jun 2014 19:31:19 +0900
Message-ID: <53982FF7.8030606@samsung.com>
References: <1402446800-4043-1-git-send-email-jonghwa3.lee@samsung.com>
 <CAPDyKFr6aoev3vSmxQOJWDGGFLWyE4eZ_0joQ45-GgZNztYdGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:26394 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751050AbaFKKbX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jun 2014 06:31:23 -0400
In-reply-to: <CAPDyKFr6aoev3vSmxQOJWDGGFLWyE4eZ_0joQ45-GgZNztYdGA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, cw00.choi@samsung.com, Myungjoo Ham <myungjoo.ham@samsung.com>, jy0922.shim@samsung.com, inki.dae@samsung.com

Hi Ulf,
On 2014=EB=85=84 06=EC=9B=94 11=EC=9D=BC 17:27, Ulf Hansson wrote:

> On 11 June 2014 02:33, Jonghwa Lee <jonghwa3.lee@samsung.com> wrote:
>> When device uses generic pm domain, its own runtime suspend callback=
 will be
>> executed only when all devices in the same domain are suspended. How=
ever, some
>> device needs sychronized runtime suspend and not to be deffered.
>> For those devices, Generic pm domain adds new API for adding device =
with flag,
>> which shows that it guerantees driver's runtime suspend will be exec=
uted right
>> away not at the time domain is really powered off.
>> Existed API, pm_genpd_add_device(), now adds device with flag repres=
enting this
>> device is not needed sychrnoized callback. It will work as same as b=
efore.
>=20
> Hi Jonghwa,
>=20
> I understand you have an issue of the behaviour of genpd here and I
> agree we need a solution, but I am not sure this is the correct one.
> :-)
>=20
> The current behaviour of how genpd deals with runtime PM suspend
> callbacks has two severe issues:
>=20
> 1 ) It prevents fine grained power management within a domain. Simply
> because those resources that are controlled on levels below the
> pm_domain, can't be put in low power state until the complete domain
> will be dropped.
> 2 ) All devices within a domain will be runtime PM suspended at the
> same time. This causes a thundering herd problem since latencies gets
> accumulated for each device in a domain.
>=20
> Instead I think we should try to change the default behaviour of genp=
d
> and let it invoke the runtime PM callbacks immediately and not wait
> for the domain to be dropped. Do you think that could work?
>=20


Yes, I think it could. I didn't understand why genpd prohibits device t=
o be
suspended separately but puts all devices suspended altogether. But, I'=
m just
afraid to change genpd's behavior totally due to my own inconvenience.

And addition to above problems, there is one more problem due to genpd'=
s current
bust suspending.

3) It would break the device dependency. Even if devices request to be =
suspended
sequentially considering their dependencies, genpd simply ignores it an=
d let
them suspended in order of registration. It means suspending order abso=
lutely
depends on when device is bound to genpd.

Observing 3 definite problems, it looks genpd should be changed. Howeve=
r,
someone might want to keep it work as like before, who knows? I respect=
fully ask
Rafael's opinion.

Best regards
Jonghwa

> Kind regards
> Ulf Hansson
>=20
>>
>> Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
>> ---
>>  drivers/base/power/domain.c |   17 ++++++++++++++---
>>  include/linux/pm_domain.h   |   19 ++++++++++++++++---
>>  2 files changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain=
=2Ec
>> index ae098a2..6c7a786 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -503,6 +503,9 @@ static int pm_genpd_poweroff(struct generic_pm_d=
omain *genpd)
>>         genpd->poweroff_task =3D current;
>>
>>         list_for_each_entry_reverse(pdd, &genpd->dev_list, list_node=
) {
>> +               if (dev_gpd_data(pdd->dev)->rpmflags & GENPD_RPM_SYN=
C)
>> +                       continue;
>> +
>>                 ret =3D atomic_read(&genpd->sd_count) =3D=3D 0 ?
>>                         __pm_genpd_save_device(pdd, genpd) : -EBUSY;
>>
>> @@ -625,6 +628,9 @@ static int pm_genpd_runtime_suspend(struct devic=
e *dev)
>>         if (stop_ok && !stop_ok(dev))
>>                 return -EBUSY;
>>
>> +       if (dev_gpd_data(dev)->rpmflags & GENPD_RPM_SYNC)
>> +               genpd_save_dev(genpd, dev);
>> +
>>         ret =3D genpd_stop_dev(genpd, dev);
>>         if (ret)
>>                 return ret;
>> @@ -1416,7 +1422,7 @@ static void __pm_genpd_free_dev_data(struct de=
vice *dev,
>>   * @td: Set of PM QoS timing parameters to attach to the device.
>>   */
>>  int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct d=
evice *dev,
>> -                         struct gpd_timing_data *td)
>> +                         struct gpd_timing_data *td, enum genpd_rpm=
flags flags)
>>  {
>>         struct generic_pm_domain_data *gpd_data_new, *gpd_data =3D N=
ULL;
>>         struct pm_domain_data *pdd;
>> @@ -1472,6 +1478,7 @@ int __pm_genpd_add_device(struct generic_pm_do=
main *genpd, struct device *dev,
>>         gpd_data->need_restore =3D genpd->status =3D=3D GPD_STATE_PO=
WER_OFF;
>>         gpd_data->td.constraint_changed =3D true;
>>         gpd_data->td.effective_constraint_ns =3D -1;
>> +       gpd_data->rpmflags =3D flags;
>>         mutex_unlock(&gpd_data->lock);
>>
>>   out:
>> @@ -1494,6 +1501,7 @@ int __pm_genpd_of_add_device(struct device_nod=
e *genpd_node, struct device *dev,
>>                              struct gpd_timing_data *td)
>>  {
>>         struct generic_pm_domain *genpd =3D NULL, *gpd;
>> +       enum genpd_rpmflags rpmflags;
>>
>>         dev_dbg(dev, "%s()\n", __func__);
>>
>> @@ -1512,7 +1520,9 @@ int __pm_genpd_of_add_device(struct device_nod=
e *genpd_node, struct device *dev,
>>         if (!genpd)
>>                 return -EINVAL;
>>
>> -       return __pm_genpd_add_device(genpd, dev, td);
>> +       rpmflags =3D of_property_read_bool(dev->of_node, "pm-genpd-r=
pmsync");
>> +
>> +       return __pm_genpd_add_device(genpd, dev, td, rpmflags);
>>  }
>>
>>
>> @@ -1525,7 +1535,8 @@ int __pm_genpd_of_add_device(struct device_nod=
e *genpd_node, struct device *dev,
>>  int __pm_genpd_name_add_device(const char *domain_name, struct devi=
ce *dev,
>>                                struct gpd_timing_data *td)
>>  {
>> -       return __pm_genpd_add_device(pm_genpd_lookup_name(domain_nam=
e), dev, td);
>> +       struct generic_pm_domain *genpd =3D pm_genpd_lookup_name(dom=
ain_name);
>> +       return __pm_genpd_add_device(genpd, dev, td, GENPD_RPM_ASYNC=
);
>>  }
>>
>>  /**
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index 7c1d252..d36e5cf 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -106,6 +106,11 @@ struct gpd_timing_data {
>>         bool cached_stop_ok;
>>  };
>>
>> +enum genpd_rpmflags {
>> +       GENPD_RPM_ASYNC =3D 0,
>> +       GENPD_RPM_SYNC,
>> +};
>> +
>>  struct generic_pm_domain_data {
>>         struct pm_domain_data base;
>>         struct gpd_dev_ops ops;
>> @@ -114,6 +119,7 @@ struct generic_pm_domain_data {
>>         struct mutex lock;
>>         unsigned int refcount;
>>         bool need_restore;
>> +       enum genpd_rpmflags rpmflags;
>>  };
>>
>>  #ifdef CONFIG_PM_GENERIC_DOMAINS
>> @@ -132,7 +138,8 @@ extern struct dev_power_governor simple_qos_gove=
rnor;
>>  extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
>>  extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
>>                                  struct device *dev,
>> -                                struct gpd_timing_data *td);
>> +                                struct gpd_timing_data *td,
>> +                                enum genpd_rpmflags flags);
>>
>>  extern int __pm_genpd_of_add_device(struct device_node *genpd_node,
>>                                     struct device *dev,
>> @@ -180,7 +187,8 @@ static inline struct generic_pm_domain *dev_to_g=
enpd(struct device *dev)
>>  }
>>  static inline int __pm_genpd_add_device(struct generic_pm_domain *g=
enpd,
>>                                         struct device *dev,
>> -                                       struct gpd_timing_data *td)
>> +                                       struct gpd_timing_data *td,
>> +                                       enum genpd_rpmflags flags);
>>  {
>>         return -ENOSYS;
>>  }
>> @@ -263,10 +271,15 @@ static inline bool default_stop_ok(struct devi=
ce *dev)
>>  #define pm_domain_always_on_gov NULL
>>  #endif
>>
>> +static inline int pm_genpd_add_device_rpmsync(struct generic_pm_dom=
ain *genpd,
>> +                                     struct device *dev)
>> +{
>> +       return __pm_genpd_add_device(genpd, dev, NULL, GENPD_RPM_SYN=
C);
>> +}
>>  static inline int pm_genpd_add_device(struct generic_pm_domain *gen=
pd,
>>                                       struct device *dev)
>>  {
>> -       return __pm_genpd_add_device(genpd, dev, NULL);
>> +       return __pm_genpd_add_device(genpd, dev, NULL, GENPD_RPM_ASY=
NC);
>>  }
>>
>>  static inline int pm_genpd_of_add_device(struct device_node *genpd_=
node,
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>=20


