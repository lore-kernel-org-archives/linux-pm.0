From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC v2 01/16] PM / Domains: Allocate memory outside
 domain locks
Date: Mon, 29 Jun 2015 10:36:45 -0600
Message-ID: <20150629163645.GB1524@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-2-git-send-email-lina.iyer@linaro.org>
 <559090B3.4040502@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32850 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849AbbF2Qgs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2015 12:36:48 -0400
Received: by pdjn11 with SMTP id n11so119959216pdj.0
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2015 09:36:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <559090B3.4040502@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, geert@linux-m68k.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org

On Mon, Jun 29 2015 at 18:26 -0600, Krzysztof Kozlowski wrote:
>On 27.06.2015 12:02, Lina Iyer wrote:
>> In preparation for supporting IRQ-safe domains, allocate domain data
>> outside the domain locks. These functions are not called in an atomic
>> context, so we can always allocate memory using GFP_KERNEL. By
>> allocating memory before the locks, we can safely lock the domain using
>> spinlocks instead of mutexes.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>> Changes in v2:
>> 	- Modify commit text
>> ---
>>  drivers/base/power/domain.c | 27 +++++++++++++--------------
>>  1 file changed, 13 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 87d405a..44af889 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1379,13 +1379,17 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>>  int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>  			   struct generic_pm_domain *subdomain)
>>  {
>> -	struct gpd_link *link;
>> +	struct gpd_link *link, *itr;
>>  	int ret = 0;
>>
>>  	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain)
>>  	    || genpd == subdomain)
>>  		return -EINVAL;
>>
>> +	link = kzalloc(sizeof(*link), GFP_KERNEL);
>> +	if (!link)
>> +		return -ENOMEM;
>> +
>>  	mutex_lock(&genpd->lock);
>>  	mutex_lock_nested(&subdomain->lock, SINGLE_DEPTH_NESTING);
>>
>> @@ -1395,18 +1399,13 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>  		goto out;
>>  	}
>>
>> -	list_for_each_entry(link, &genpd->master_links, master_node) {
>> -		if (link->slave == subdomain && link->master == genpd) {
>> +	list_for_each_entry(itr, &genpd->master_links, master_node) {
>> +		if (itr->slave == subdomain && itr->master == genpd) {
>>  			ret = -EINVAL;
>>  			goto out;
>
>The same comment as in previous version - where is the kfree()? You
>moved the allocation so all error paths have to be checked and adjusted.
>Not just one that I pointed in previous review.
>
Sorry, didnt notice that, will fix this. I seem to have addressed the
other fone.
>>  		}
>>  	}
>>
>> -	link = kzalloc(sizeof(*link), GFP_KERNEL);
>> -	if (!link) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>>  	link->master = genpd;
>>  	list_add_tail(&link->master_node, &genpd->master_links);
>>  	link->slave = subdomain;
>> @@ -1508,17 +1507,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
>>  	if (IS_ERR_OR_NULL(genpd) || state < 0)
>>  		return -EINVAL;
>>
>> +	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
>> +	if (!cpuidle_data)
>> +		return -ENOMEM;
>> +
>>  	mutex_lock(&genpd->lock);
>>
>>  	if (genpd->cpuidle_data) {
>>  		ret = -EEXIST;
>> -		goto out;
>> -	}
>> -	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
>> -	if (!cpuidle_data) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> +		goto err_drv;
>
>Is the mutex freed in this exit path?
>
Yes, err_drv jumps to out, which frees the mutex.

Thank you so much for the review.

-- Lina

>>  	}
>> +
>>  	cpuidle_drv = cpuidle_driver_ref();
>>  	if (!cpuidle_drv) {
>>  		ret = -ENODEV;
>>
>
