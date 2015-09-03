From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH] PM / Domains: Ensure subdomain is not in use before
 removing
Date: Thu, 3 Sep 2015 09:08:38 +0100
Message-ID: <55E80006.4090603@nvidia.com>
References: <1440667276-8986-1-git-send-email-jonathanh@nvidia.com>
 <7hbndr48lg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5767 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbbICIIo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 04:08:44 -0400
In-Reply-To: <7hbndr48lg.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, geert@linux-m68k.org, linux-pm@vger.kernel.org


On 28/08/15 18:38, Kevin Hilman wrote:
> Jon Hunter <jonathanh@nvidia.com> writes:
> 
>> The function pm_genpd_remove_subdomain() removes a subdomain from a
>> generic PM domain, however, it does not check if the subdomain has any
>> slave domains or device attached before doing so. Therefore, add a test
>> to verify that the subdomain does not have any slave domains associated
>> or any device attached before removing.
>>
>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>  drivers/base/power/domain.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 27888a90ca98..a3ed71d8129a 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1469,6 +1469,11 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
>>  
>>  	mutex_lock(&genpd->lock);
>>  
>> +	if (!list_empty(&subdomain->slave_links) || subdomain->device_count) {
> 
> maybe a pr_warn() or similar is appropriate here?

Thanks, good suggestion. Will add.

>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +
> 
> ... otherwise looks like a good check to add.
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>

Cheers
Jon


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
