From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC 1/3] PM / Domains: Allocate memory outside domain
 locks
Date: Tue, 9 Jun 2015 16:45:09 -0600
Message-ID: <20150609224509.GA3946@linaro.org>
References: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
 <1433456946-53296-2-git-send-email-lina.iyer@linaro.org>
 <5574023E.6060808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:34739 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbFIWpO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2015 18:45:14 -0400
Received: by pdbki1 with SMTP id ki1so23608364pdb.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2015 15:45:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5574023E.6060808@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org, mathieu.poirier@linaro.org, linux-pm@vger.kernel.org, galak@codeaurora.org, msivasub@codeaurora.org, agross@codeaurora.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 07 2015 at 02:35 -0600, Krzysztof Kozlowski wrote:
>W dniu 05.06.2015 o 07:29, Lina Iyer pisze:
>> In order for domains to be powered on/off in irq locked context, the
>> domain locks could either be a spinlock or a mutex, depending on the
>> domain. In preparation for atomic support, allocate domain data outside
>> the domain locks, so the allocation calls dont have to be context
>> sensitive.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 3b3367b..dfd7595 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1367,13 +1367,17 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
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
>> @@ -1383,18 +1387,13 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
>>  		goto out;
>>  	}
>>
>> -	list_for_each_entry(link, &genpd->master_links, master_node) {
>> -		if (link->slave == subdomain && link->master == genpd) {
>> +	list_for_each_entry(itr, &genpd->master_links, master_node) {
>> +		if (itr->slave == subdomain && itr->master == genpd) {
>>  			ret = -EINVAL;
>>  			goto out;
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
>> @@ -1496,17 +1495,17 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
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
>>  		goto out;
>
>I think you must update the error paths. In this case the kfree() is
>missing.
>
Yes, thank you. Will fix.

-- Lina
>
>>  	}
>> -	cpuidle_data = kzalloc(sizeof(*cpuidle_data), GFP_KERNEL);
>> -	if (!cpuidle_data) {
>> -		ret = -ENOMEM;
>> -		goto out;
>> -	}
>> +
>>  	cpuidle_drv = cpuidle_driver_ref();
>>  	if (!cpuidle_drv) {
>>  		ret = -ENODEV;
>>
>
