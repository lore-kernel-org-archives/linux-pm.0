From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 10/10] PM / Domains: Add support for removing nested PM
 domains by provider
Date: Fri, 9 Sep 2016 15:04:15 +0100
Message-ID: <f31e57aa-52aa-d340-ca2b-73dbdf769035@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-11-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFq3h1-64FtZwXa7XWO1UJj8Od-cfjwa8i4bDwN1VVdL7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11576 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750833AbcIIOE2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 10:04:28 -0400
In-Reply-To: <CAPDyKFq3h1-64FtZwXa7XWO1UJj8Od-cfjwa8i4bDwN1VVdL7w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>



On 08/09/16 13:30, Ulf Hansson wrote:
> On 16 August 2016 at 11:49, Jon Hunter <jonathanh@nvidia.com> wrote:
>> If a device supports PM domains that are subdomains of another PM
>> domain, then the PM domains should be removed in reverse order to
>> ensure that the subdomains are removed first. Furthermore, if there is
>> more than one provider, then there needs to be a way to remove the
>> domains in reverse order for a specific provider.
>>
>> Add the function of_genpd_remove_tail() to remove the last PM domain
>> added by a given PM domain provider and return the generic_pm_domain
>> structure for the PM domain that was removed.
>>
>> A PM domain should only be removed once the associated PM domain
>> provider has been removed from the list of providers. Otherwise, it
>> could be possible for a client to be associated with a PM domain that
>> could have been removed. Add a helper function to verify if the PM
>> domain provider is present and only allow a PM domain to be removed if
>> the provider has been removed.
>>
>> The function of_genpd_remove_tail() must hold the gpd_list_lock while
>> finding and removing a PM domain. It is natural for
>> of_genpd_remove_tail() to call pm_genpd_remove() once the appropriate
>> PM domain is found to remove it. However, pm_genpd_remove(), also
>> acquires the gpd_list_lock. Therefore, move the core of the function
>> pm_genpd_remove() to a new function genpd_remove() which does not
>> acquire the gpd_list_lock so this can be used by both pm_genpd_remove()
>> and of_genpd_remove_tail().
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 87 +++++++++++++++++++++++++++++++++++++++++----
>>  include/linux/pm_domain.h   |  7 ++++
>>  2 files changed, 88 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 0bc145e8e902..b6d1d0441a2d 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1357,7 +1357,7 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
>>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>>
>>  /**
>> - * pm_genpd_remove - Remove a generic I/O PM domain
>> + * genpd_remove - Remove a generic I/O PM domain
>>   * @genpd: Pointer to PM domain that is to be removed.
>>   *
>>   * To remove the PM domain, this function:
>> @@ -1366,9 +1366,10 @@ EXPORT_SYMBOL_GPL(pm_genpd_init);
>>   *  - Removes the PM domain from the list of registered PM domains.
>>   *
>>   * The PM domain will only be removed, if it is not a parent to any
>> - * other PM domain and has no devices associated with it.
>> + * other PM domain and has no devices associated with it. Must be called
>> + * with the gpd_list_lock held.
>>   */
>> -int pm_genpd_remove(struct generic_pm_domain *genpd)
>> +static int genpd_remove(struct generic_pm_domain *genpd)
>>  {
>>         struct gpd_link *l, *link;
>>         int ret = 0;
>> @@ -1376,12 +1377,10 @@ int pm_genpd_remove(struct generic_pm_domain *genpd)
>>         if (IS_ERR_OR_NULL(genpd))
>>                 return -EINVAL;
>>
>> -       mutex_lock(&gpd_list_lock);
>>         mutex_lock(&genpd->lock);
>>
>>         if (!list_empty(&genpd->master_links) || genpd->device_count) {
>>                 mutex_unlock(&genpd->lock);
>> -               mutex_unlock(&gpd_list_lock);
>>                 pr_err("%s: unable to remove %s\n", __func__, genpd->name);
>>                 return -EBUSY;
>>         }
>> @@ -1395,11 +1394,25 @@ int pm_genpd_remove(struct generic_pm_domain *genpd)
>>         list_del(&genpd->gpd_list_node);
>>         mutex_unlock(&genpd->lock);
>>         cancel_work_sync(&genpd->power_off_work);
>> -       mutex_unlock(&gpd_list_lock);
>>         pr_debug("%s: removed %s\n", __func__, genpd->name);
>>
>>         return ret;
>>  }
>> +
>> +/**
>> + * pm_genpd_remove - Remove a generic I/O PM domain
>> + * @genpd: Pointer to PM domain that is to be removed.
>> + */
>> +int pm_genpd_remove(struct generic_pm_domain *genpd)
>> +{
>> +       int ret;
>> +
>> +       mutex_lock(&gpd_list_lock);
>> +       ret = genpd_remove(genpd);
>> +       mutex_unlock(&gpd_list_lock);
>> +
>> +       return ret;
>> +}
>>  EXPORT_SYMBOL_GPL(pm_genpd_remove);
> 
> All above changes could have been made already in the patch when
> adding the pm_genpd_remove() API. Could you please fold these changes
> into that patch instead?

Ok. I was not sure if it would seem odd to add pm_genpd_remove() and
genpd_remove() in the same patch because pm_genpd_remove() is the only
user of genpd_remove(). However, it would simplify the diff and so I am
fine with that.

>>
>>  #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
>> @@ -1610,6 +1623,26 @@ void of_genpd_del_provider(struct device_node *np)
>>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>
>>  /**
>> + * genpd_provider_present() - Verify if a PM domain provider is present
>> + * @np: Device node pointer associated with the PM domain provider
>> + */
>> +static bool genpd_provider_present(struct device_node *np)
>> +{
>> +       struct of_genpd_provider *cp;
>> +
>> +       mutex_lock(&of_genpd_mutex);
>> +       list_for_each_entry(cp, &of_genpd_providers, link) {
>> +               if (cp->node == np) {
>> +                       mutex_unlock(&of_genpd_mutex);
>> +                       return true;
>> +               }
>> +       }
>> +       mutex_unlock(&of_genpd_mutex);
>> +
>> +       return false;
>> +}
>> +
>> +/**
>>   * genpd_get_from_provider() - Look-up PM domain
>>   * @genpdspec: OF phandle args to use for look-up
>>   *
>> @@ -1713,6 +1746,48 @@ out:
>>  EXPORT_SYMBOL_GPL(of_genpd_add_subdomain);
>>
>>  /**
>> + * of_genpd_remove_tail - Remove the last PM domain registered for a provider
>> + * @provider: Pointer to device structure associated with provider
> 
> The naming of this function would be okay, if we only have added
> genpds in the gpd_list by using list_add_tail(), although we don't.
> Instead we use list_add() and put them first in the list.
> 
> So, unless we change to use list_add_tail() when adding genpds (I
> assume we can do that!), I would rather change the name of this
> function to of_genpd_remove_first().
> 
> What option do you prefer?

I think that I would prefer either of_genpd_remove_last() or
of_genpd_remove_one(). Although _first is accurate from the list
perspective it seems odd from the user perspective. I think that _last
is more meaningful as we are removing the last that was added regardless
or how things appear on the list. Alternatively, _one could be a good
compromise.


>> + *
>> + * Find the last PM domain that was added by a particular provider and
>> + * remove this PM domain from the list of PM domains. The provider is
>> + * identified by the 'provider' device structure that is passed. The PM
>> + * domain will only be removed, if the provider associated with domain
>> + * has been removed.
>> + *
>> + * Returns a valid pointer to struct generic_pm_domain on success or
>> + * ERR_PTR() on failure.
>> + */
>> +struct generic_pm_domain *of_genpd_remove_tail(struct device_node *np)
>> +{
>> +       struct generic_pm_domain *gpd, *genpd = ERR_PTR(-ENOENT);
>> +       int ret;
>> +
>> +       if (IS_ERR_OR_NULL(np))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       mutex_lock(&gpd_list_lock);
>> +       list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
>> +               if (gpd->provider == &np->fwnode) {
>> +                       if (!genpd_provider_present(np)) {
>> +                               ret = genpd_remove(gpd);
>> +                               genpd = ret ? ERR_PTR(ret) : gpd;
>> +                               break;
>> +                       }
> 
> Maybe use an "else" here instead to avoid the double "break;".

Ok.

Cheers
Jon

-- 
nvpublic
