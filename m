From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 8/8] PM / Domains: Add support for removing PM domains
Date: Tue, 21 Jun 2016 15:08:50 +0100
Message-ID: <57694A72.6090202@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-9-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFrKCB00hHhpSaJZ57wThPFRjnp+3xMz_YW9k+zqafppHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFrKCB00hHhpSaJZ57wThPFRjnp+3xMz_YW9k+zqafppHg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexander Aring <alex.aring@gmail.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


On 15/06/16 15:33, Ulf Hansson wrote:
> On 4 March 2016 at 12:23, Jon Hunter <jonathanh@nvidia.com> wrote:
>> The genpd framework allows users to add PM domains via the pm_genpd_init()
>> function, however, there is no corresponding function to remove a PM
>> domain. For most devices this may be fine as the PM domains are never
>> removed, however, for devices that wish to populate the PM domains from
>> within a driver, having the ability to remove a PM domain if the probing
>> of the device fails or the driver is unloaded is necessary.
>>
>> Add the function pm_genpd_remove() to remove a PM domain by referencing
>> it's generic_pm_domain structure.
>>
>> If a device supports nested or subdomains, then the PM domains
>> should be removed in reverse order to ensure that the subdomains are
>> removed first. Hence, add the function pm_genpd_remove_tail() to remove
>> the last PM domain added by a given provider and return the
>> generic_pm_domain structure for the PM domain that was removed.
> 
> Perhaps split this up, so the pm_genpd_remove_tail() gets added in a
> separate patch on top.

OK.

>>
>> PM domains can only be removed if they are not a parent domain to
>> another PM domain and have no devices associated with them.
>>
>> When removing PM domains, the PM domain will also be removed from the
>> list of providers, if it was registered.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/pm_domain.h   | 12 ++++++
>>  2 files changed, 108 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 9b33377bf01b..17090e1c91d6 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1556,6 +1556,102 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
>>  }
>>  EXPORT_SYMBOL_GPL(pm_genpd_init);
>>
>> +/**
>> + * __pm_genpd_remove - Remove a generic I/O PM domain
>> + * @genpd: Pointer to PM domain that is to be removed.
>> + *
>> + * To remove the PM domain, this function:
>> + *  - Removes the PM domain from the list of providers, if registered.
>> + *  - Removes the PM domain as a subdomain to any parent domains,
>> + *    if it was added.
>> + *  - Removes the PM domain from the list of registered PM domains.
>> + *
>> + * The PM domain will only be removed, if it is not a parent to any
>> + * other PM domain and has no devices associated with it. Must be called
>> + * with the gpd_list_lock held.
>> + */
>> +static int __pm_genpd_remove(struct generic_pm_domain *genpd)
> 
> Please rename to genpd_remove() as it's a static function.

OK.

>> +{
>> +       struct gpd_link *l, *link;
>> +       int ret = 0;
>> +
>> +       if (IS_ERR_OR_NULL(genpd))
>> +               return -EINVAL;
>> +
>> +       if (genpd->provider_data)
>> +               of_genpd_del_provider_by_data(genpd->provider_data);
>> +
>> +       mutex_lock(&genpd->lock);
>> +
>> +       if (!list_empty(&genpd->master_links) || genpd->device_count) {
>> +               mutex_unlock(&genpd->lock);
>> +               pr_err("%s: unable to remove %s\n", __func__, genpd->name);
>> +               return -EBUSY;
>> +       }
>> +
>> +       list_for_each_entry_safe(link, l, &genpd->slave_links, slave_node) {
>> +               list_del(&link->master_node);
>> +               list_del(&link->slave_node);
>> +               kfree(link);
>> +       }
>> +
>> +       list_del(&genpd->gpd_list_node);
>> +       mutex_unlock(&genpd->lock);
>> +       cancel_work_sync(&genpd->power_off_work);
>> +       pr_debug("%s: removed %s\n", __func__, genpd->name);
>> +
>> +       return ret;
>> +}
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
>> +       ret = __pm_genpd_remove(genpd);
>> +       mutex_unlock(&gpd_list_lock);
>> +
>> +       return ret;
>> +}
>> +
>> +/**
>> + * pm_genpd_remove_tail - Remove the last PM domain registered for a provider
>> + * @provider: Pointer to device structure associated with provider
>> + *
>> + * Find the last PM domain that was added by the provider whose 'provider'
>> + * device structure matches the device structure given. The 'provider'
>> + * device structure for a given PM domain should be initialised by the
>> + * device that is creating the PM domains and hence, calling
>> + * pm_genpd_init().
> 
> Maybe make this a bigger "Important note" as what is needed to
> actually benefit from using this function.

Yes, good point. Will update.

Cheers
Jon

-- 
nvpublic
