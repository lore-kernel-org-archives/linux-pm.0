Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C5741854;
	Wed, 20 Dec 2023 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 968951FB;
	Wed, 20 Dec 2023 08:22:00 -0800 (PST)
Received: from [10.57.82.217] (unknown [10.57.82.217])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBD4B3F64C;
	Wed, 20 Dec 2023 08:21:14 -0800 (PST)
Message-ID: <3f83b7a7-b674-486f-889a-033f550f3654@arm.com>
Date: Wed, 20 Dec 2023 16:22:22 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] thermal: gov_power_allocator: Simplify checks for
 valid power actor
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
 linux-pm@vger.kernel.org, rui.zhang@intel.com
References: <20231212134844.1213381-1-lukasz.luba@arm.com>
 <20231212134844.1213381-5-lukasz.luba@arm.com>
 <CAJZ5v0g_+D5WV0kiC_guS4OQP4wb1qgw1xmzFQBhvF9fz4zxJQ@mail.gmail.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0g_+D5WV0kiC_guS4OQP4wb1qgw1xmzFQBhvF9fz4zxJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/20/23 14:40, Rafael J. Wysocki wrote:
> On Tue, Dec 12, 2023 at 2:48 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> There is a need to check if the cooling device in the thermal zone
>> supports IPA callback and is set for control trip point.
>> Refactor the code which validates the power actor capabilities and
>> make it more consistent in all places.
> 
> This really is about reducing code duplication which is worth
> mentioning, so I would say
> 
> "Add a helper to check if a given cooling device in a thermal zone
> supports the IPA callback and is bound to the control trip point and
> use it wherever that check is needed to reduce code duplication."
> 

Thanks, I'll use it.

>>
>> No intentional functional impact.
>>
>> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
>> ---
>>   drivers/thermal/gov_power_allocator.c | 41 +++++++++++----------------
>>   1 file changed, 17 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/thermal/gov_power_allocator.c b/drivers/thermal/gov_power_allocator.c
>> index 3328c3ec71f2..1a605fd9c8c6 100644
>> --- a/drivers/thermal/gov_power_allocator.c
>> +++ b/drivers/thermal/gov_power_allocator.c
>> @@ -85,6 +85,13 @@ struct power_allocator_params {
>>          u32 *weighted_req_power;
>>   };
>>
>> +static bool power_actor_is_valid(struct power_allocator_params *params,
>> +                                struct thermal_instance *instance)
>> +{
>> +       return ((instance->trip == params->trip_max) &&
> 
> The inner parens are redundant.

OK

> 
>> +                cdev_is_power_actor(instance->cdev));
>> +}
> 
> The part below LGTM.
