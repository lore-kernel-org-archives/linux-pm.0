From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 09/10] PM / Domains: Store the provider in the PM domain
 structure
Date: Fri, 9 Sep 2016 14:57:45 +0100
Message-ID: <73870e28-3600-8a84-7659-55d4a8320a1d@nvidia.com>
References: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
 <1471340976-5379-10-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFp+93=CrmgLNx1ritm1Dm=eWFJn=vbuzAUb9VmWc4j1fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFp+93=CrmgLNx1ritm1Dm=eWFJn=vbuzAUb9VmWc4j1fg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 08/09/16 12:56, Ulf Hansson wrote:
> On 16 August 2016 at 11:49, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>> It is possible that a device has more than one provider of PM domains
>> and to support the removal of a PM domain by provider, it is necessary
>> to store a reference to the provider in the PM domain structure.
>> Therefore, store a reference to the firmware node handle in the PM
>> domain structure and populate it when providers (only device-tree based
>> providers are currently supported by PM domains) are registered.
>>
>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/base/power/domain.c | 18 ++++++++++++++----
>>  include/linux/pm_domain.h   |  1 +
>>  2 files changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 72b973539205..0bc145e8e902 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1539,6 +1539,8 @@ int of_genpd_add_provider_simple(struct device_node *np,
>>                 return -EINVAL;
>>         }
>>
>> +       genpd->provider = &np->fwnode;
>> +
>>         ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
> 
> I guess you want to reset genpd->provider = NULL, when
> genpd_add_provider() fails!?

Yes, will fix.

> Perhaps better to assign genpd->provider when you know
> genpd_add_provider() has succeeded.

Yes seems sane!

>>
>>         mutex_unlock(&gpd_list_lock);
>> @@ -1564,10 +1566,10 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>>         mutex_lock(&gpd_list_lock);
>>
>>         for (i = 0; i < data->num_domains; i++) {
>> -               if (!pm_genpd_present(data->domains[i])) {
>> -                       mutex_unlock(&gpd_list_lock);
>> -                       return -EINVAL;
>> -               }
>> +               if (!pm_genpd_present(data->domains[i]))
>> +                       goto error;
>> +
>> +               data->domains[i]->provider = &np->fwnode;
>>         }
>>
>>         ret = genpd_add_provider(np, genpd_xlate_onecell, data);
>> @@ -1575,6 +1577,14 @@ int of_genpd_add_provider_onecell(struct device_node *np,
>>         mutex_unlock(&gpd_list_lock);
>>
>>         return ret;
>> +
>> +error:
>> +       while (i--)
>> +               data->domains[i]->provider = NULL;
>> +
>> +       mutex_unlock(&gpd_list_lock);
>> +
>> +       return -EINVAL;
>>  }
>>  EXPORT_SYMBOL_GPL(of_genpd_add_provider_onecell);
>>
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index fbdc5c4588ef..4aa285e44eb0 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -51,6 +51,7 @@ struct generic_pm_domain {
>>         struct mutex lock;
>>         struct dev_power_governor *gov;
>>         struct work_struct power_off_work;
>> +       struct fwnode_handle *provider; /* Identity of the domain provider */
>>         const char *name;
>>         atomic_t sd_count;      /* Number of subdomains with power "on" */
>>         enum gpd_status status; /* Current state of the domain */
>> --
>> 2.1.4
>>
> 
> I also think you should extend this change, to also make the
> of_genpd_del_provider() API to reset the genpd->provider = NULL.
> Otherwise you can't track when a provider is removed.

Unfortunately that is not going to work. The function
of_genpd_remove_tail() (patch #10) uses the ->provider member to remove
the last domain for the given provider and of_genpd_del_provider() must
be called before hand.

Cheers
Jon

-- 
nvpublic
