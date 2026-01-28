Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A729B78F;
	Wed, 28 Jan 2026 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769596971; cv=none; b=kGgj1biVOLnAnEndWcIvSiOIDEjK5utn5luk3jbUjspCvwP1wYjKG4BhjxvofP8SEJJqhTwnTCxnAKkSkBAh3LMbuLvMRcjEBWtyL2NFl/WyzR99CwzaXy7XttApIQNf36Pb9H267CYwIviDe1erv8Ip507JZktEYBRZxCwa2Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769596971; c=relaxed/simple;
	bh=XuLhm7lxuNCOLV9QyUWF4q0xm+qYs+xetGXCyt3L55w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOUXhchyxFVeFTkA+wSjoUOVF+bUBDUGCMZFTmd3YRr7+ea6KFaVHqcU+iFuklJ/PVjvxZuDDHubfHiWVMtOHkbCFQPcHVLh+VU9sT2uL5ACwSXo5gAbWUU03G+kRm5blyGXRmGdWWckSEMU/qs3pNVZse1+y4UYG9GgSX40xww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 464B61515;
	Wed, 28 Jan 2026 02:42:42 -0800 (PST)
Received: from [10.57.17.95] (unknown [10.57.17.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20B9C3F5CA;
	Wed, 28 Jan 2026 02:42:46 -0800 (PST)
Message-ID: <67d1584c-a474-4873-8cc2-9899296ea7ea@arm.com>
Date: Wed, 28 Jan 2026 10:42:48 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/of: Fix reference leak in thermal_of_cm_lookup()
To: "Rafael J. Wysocki" <rafael@kernel.org>, Felix Gu <ustc.gu@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Yu-Che Cheng <giver@chromium.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260124-thermal_of-v1-1-54d3416948cf@gmail.com>
 <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0gL92f3g4oj47jaYQKG_V6vd_oBawbwQVWjUP7u9QKS7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/27/26 16:22, Rafael J. Wysocki wrote:
> On Fri, Jan 23, 2026 at 8:06 PM Felix Gu <ustc.gu@gmail.com> wrote:
>>
>> In thermal_of_cm_lookup(), tr_np is obtained via of_parse_phandle(). But
>> it never be released.
>> Use the __free(device_node) cleanup attribute to automatically release
>> the node and fix the leak.
>>
>> Fixes: 423de5b5bc5b ("thermal/of: Fix cdev lookup in thermal_of_should_bind()")
>>
>> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
>> ---
>>   drivers/thermal/thermal_of.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
>> index 1a51a4d240ff..b6d0c92f5522 100644
>> --- a/drivers/thermal/thermal_of.c
>> +++ b/drivers/thermal/thermal_of.c
>> @@ -280,10 +280,10 @@ static bool thermal_of_cm_lookup(struct device_node *cm_np,
>>                                   struct cooling_spec *c)
>>   {
>>          for_each_child_of_node_scoped(cm_np, child) {
>> -               struct device_node *tr_np;
>>                  int count, i;
>>
>> -               tr_np = of_parse_phandle(child, "trip", 0);
>> +               struct device_node *tr_np __free(device_node) =
>> +                       of_parse_phandle(child, "trip", 0);
>>                  if (tr_np != trip->priv)
>>                          continue;
>>
>>
>> ---
> 
> This looks good to me.
> 
> Lukasz, Daniel?


Good catch thanks! That looks good. This scoped device node
handling approach simplifies a lot the error paths (and is less
error-prone).

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
