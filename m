From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 6/8] PM / Domains: Remove a provider by referencing
 the data pointer
Date: Mon, 11 Jul 2016 14:14:39 +0100
Message-ID: <57839BBF.30102@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-7-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpLcnLvQmpQgzhOExq67XrbaW9Nf1Gk2Y+CND8dn_cmyA@mail.gmail.com>
 <5769455C.9010809@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5769455C.9010809-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Ulf,

On 21/06/16 14:47, Jon Hunter wrote:
> 
> On 15/06/16 15:38, Ulf Hansson wrote:
>> On 4 March 2016 at 12:23, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>> To remove a PM domain from the system, it is necessary to ensure
>>> that any PM domain providers associated with the PM domain have
>>> been removed. Otherwise it could be possible to obtain a pointer
>>> to a PM domain structure that has been removed.
>>>
>>> PM domains now have a reference to the pointer for the PM domain
>>> provider's data variable. Add a function so that a PM domain can
>>> remove a PM domain provider by referencing the data pointer.
>>>
>>> Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>> ---
>>>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>>>  include/linux/pm_domain.h   |  2 ++
>>>  2 files changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>>> index 72055fef6256..438885f2455f 100644
>>> --- a/drivers/base/power/domain.c
>>> +++ b/drivers/base/power/domain.c
>>> @@ -1738,6 +1738,30 @@ void of_genpd_del_provider(struct device_node *np)
>>>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>>
>>>  /**
>>> + * of_genpd_del_provider_by_data() - Remove a registered PM domain provider
>>> + * @data: Pointer to the data associated with the PM domain provider
>>> + *
>>> + * Look up a PM domain provider based upon a pointer to it's data and
>>> + * remove the PM domain provider from the list of providers.
>>> + */
>>> +void of_genpd_del_provider_by_data(void *data)
>>> +{
>>> +       struct of_genpd_provider *c, *cp;
>>> +
>>> +       mutex_lock(&of_genpd_mutex);
>>> +       list_for_each_entry_safe(cp, c, &of_genpd_providers, link) {
>>> +               if (cp->data == data) {
>>> +                       list_del(&cp->link);
>>> +                       of_node_put(cp->node);
>>> +                       kfree(cp);
>>> +                       break;
>>> +               }
>>> +       }
>>> +       mutex_unlock(&of_genpd_mutex);
>>> +}
>>> +EXPORT_SYMBOL_GPL(of_genpd_del_provider_by_data);
>>> +
>>> +/**
>>>   * of_genpd_get_from_provider() - Look-up PM domain
>>>   * @genpdspec: OF phandle args to use for look-up
>>>   *
>>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>>> index bed84413546f..7b7921a65cb0 100644
>>> --- a/include/linux/pm_domain.h
>>> +++ b/include/linux/pm_domain.h
>>> @@ -199,6 +199,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
>>>  int of_genpd_add_provider_onecell(struct device_node *np,
>>>                                   struct genpd_onecell_data *data);
>>>  void of_genpd_del_provider(struct device_node *np);
>>
>> There's currently only one user of of_genpd_del_provider().
>>
>> Could this patch just convert that user to the new API, so we don't
>> need to keep both the legacy and new one?
>>
>> I guess we could then just stick to the name "of_genpd_del_provider()".
> 
> I had a look at this and to do that we would end up with
> of_genpd_del_provider(struct device_node *np, void *data) where the user
> should only pass one of the arguments. It seems a bit odd. However,
> unless I have forgotten something, I wonder if we should just make
> of_genpd_del_provider_by_name() a local function and not export this at
> all? It seems more natural for users to delete a provider by the
> device_node than by name rather than the data argument.
> 
> The only problem I see with making of_genpd_del_provider_by_name() local
> is that I need to add a prototype for the function at the top of the
> domain.c source file so that it builds because __pm_genpd_remove() is
> defined above it. Yes I could move __pm_genpd_remove() to the bottom of
> the file but then it is not located next to pm_genpd_init() which seems odd.
> 
> Let me know what you think.

Any response on this? This is the last item that we need to sort out?

Cheers
Jon

-- 
nvpublic
