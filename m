From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH - resend 1/3] thermal/drivers/cpu_cooling: Fixup the
 header and copyright
Date: Mon, 29 Apr 2019 10:37:08 +0200
Message-ID: <a7b26683-0514-fd58-f5b1-d9128e490b84@linaro.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
 <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429054350.kaup4w2b5yx3mdqb@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>
List-Id: linux-pm@vger.kernel.org

On 29/04/2019 07:43, Viresh Kumar wrote:
> On 28-04-19, 11:51, Daniel Lezcano wrote:
>> The copyright format does not conform to the format requested by
>> Linaro: https://wiki.linaro.org/Copyright
>>
>> Fix it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Viresh Kumar <viresh.kumar@linaro.org>
> 
> What exactly have I done here ? :)

Argh!

Thanks for spotting it.


>> ---
>>  drivers/thermal/cpu_cooling.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
>> index ee8419a6390c..42aeb9087cab 100644
>> --- a/drivers/thermal/cpu_cooling.c
>> +++ b/drivers/thermal/cpu_cooling.c
>> @@ -2,9 +2,11 @@
>>   *  linux/drivers/thermal/cpu_cooling.c
>>   *
>>   *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
>> - *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
>>   *
>> - *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
>> + *  Copyright (C) 2012-2018 Linaro Limited.
>> + *
>> + *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
>> + *		Viresh Kumar <viresh.kumar@linaro.org>
>>   *
>>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>   *  This program is free software; you can redistribute it and/or modify
>> -- 
>> 2.17.1
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
