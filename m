From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH 6/8] PM / Domains: Remove a provider by referencing
 the data pointer
Date: Tue, 21 Jun 2016 14:47:08 +0100
Message-ID: <5769455C.9010809@nvidia.com>
References: <1457090634-14785-1-git-send-email-jonathanh@nvidia.com>
 <1457090634-14785-7-git-send-email-jonathanh@nvidia.com>
 <CAPDyKFpLcnLvQmpQgzhOExq67XrbaW9Nf1Gk2Y+CND8dn_cmyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFpLcnLvQmpQgzhOExq67XrbaW9Nf1Gk2Y+CND8dn_cmyA@mail.gmail.com>
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


On 15/06/16 15:38, Ulf Hansson wrote:
> On 4 March 2016 at 12:23, Jon Hunter <jonathanh@nvidia.com> wrote:
>> To remove a PM domain from the system, it is necessary to ensure
>> that any PM domain providers associated with the PM domain have
>> been removed. Otherwise it could be possible to obtain a pointer
>> to a PM domain structure that has been removed.
>>
>> PM domains now have a reference to the pointer for the PM domain
>> provider's data variable. Add a function so that a PM domain can
>> remove a PM domain provider by referencing the data pointer.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 24 ++++++++++++++++++++++++
>>  include/linux/pm_domain.h   |  2 ++
>>  2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 72055fef6256..438885f2455f 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1738,6 +1738,30 @@ void of_genpd_del_provider(struct device_node *np)
>>  EXPORT_SYMBOL_GPL(of_genpd_del_provider);
>>
>>  /**
>> + * of_genpd_del_provider_by_data() - Remove a registered PM domain provider
>> + * @data: Pointer to the data associated with the PM domain provider
>> + *
>> + * Look up a PM domain provider based upon a pointer to it's data and
>> + * remove the PM domain provider from the list of providers.
>> + */
>> +void of_genpd_del_provider_by_data(void *data)
>> +{
>> +       struct of_genpd_provider *c, *cp;
>> +
>> +       mutex_lock(&of_genpd_mutex);
>> +       list_for_each_entry_safe(cp, c, &of_genpd_providers, link) {
>> +               if (cp->data == data) {
>> +                       list_del(&cp->link);
>> +                       of_node_put(cp->node);
>> +                       kfree(cp);
>> +                       break;
>> +               }
>> +       }
>> +       mutex_unlock(&of_genpd_mutex);
>> +}
>> +EXPORT_SYMBOL_GPL(of_genpd_del_provider_by_data);
>> +
>> +/**
>>   * of_genpd_get_from_provider() - Look-up PM domain
>>   * @genpdspec: OF phandle args to use for look-up
>>   *
>> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
>> index bed84413546f..7b7921a65cb0 100644
>> --- a/include/linux/pm_domain.h
>> +++ b/include/linux/pm_domain.h
>> @@ -199,6 +199,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
>>  int of_genpd_add_provider_onecell(struct device_node *np,
>>                                   struct genpd_onecell_data *data);
>>  void of_genpd_del_provider(struct device_node *np);
> 
> There's currently only one user of of_genpd_del_provider().
> 
> Could this patch just convert that user to the new API, so we don't
> need to keep both the legacy and new one?
> 
> I guess we could then just stick to the name "of_genpd_del_provider()".

I had a look at this and to do that we would end up with
of_genpd_del_provider(struct device_node *np, void *data) where the user
should only pass one of the arguments. It seems a bit odd. However,
unless I have forgotten something, I wonder if we should just make
of_genpd_del_provider_by_name() a local function and not export this at
all? It seems more natural for users to delete a provider by the
device_node than by name rather than the data argument.

The only problem I see with making of_genpd_del_provider_by_name() local
is that I need to add a prototype for the function at the top of the
domain.c source file so that it builds because __pm_genpd_remove() is
defined above it. Yes I could move __pm_genpd_remove() to the bottom of
the file but then it is not located next to pm_genpd_init() which seems odd.

Let me know what you think.

Cheers
Jon

-- 
nvpublic
