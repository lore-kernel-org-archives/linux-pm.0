From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH] thermal: armada: Update Armada 380 thermal sensor coefficients
Date: Wed, 06 May 2015 14:45:45 +0200
Message-ID: <554A0CF9.7080608@free-electrons.com>
References: <1429117688-27100-1-git-send-email-gregory.clement@free-electrons.com> <553DE806.4030905@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <553DE806.4030905@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Zhang, Eduardo,

On 27/04/2015 09:40, Gregory CLEMENT wrote:
> Hi Zhang, Eduardo,
> 
> On 15/04/2015 19:08, Gregory CLEMENT wrote:
>> From: Nadav Haklai <nadavh@marvell.com>
>>
>> Improve the Armada 380 thermal sensor accuracy by using updated formula.
>> The updated formula is:
>> Temperature[C degrees] = 0.4761 * tsen_vsen_out - 279.1
>>
>> Signed-off-by: Nadav Haklai <nadavh@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> Cc: <stable@vger.kernel.org> #v3.16
> 
> Any chance that this fix was merged in 4.1-rc ?

I saw that you missed the merge window. However I think this patch is really
a fix and is a good candidate to be merged in 4.1.


Thanks,

Gregory


> 
> Thanks,
> 
> Gregory
> 
> 
>> ---
>>  drivers/thermal/armada_thermal.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
>> index c2556cf5186b..01255fd65135 100644
>> --- a/drivers/thermal/armada_thermal.c
>> +++ b/drivers/thermal/armada_thermal.c
>> @@ -224,9 +224,9 @@ static const struct armada_thermal_data armada380_data = {
>>  	.is_valid_shift = 10,
>>  	.temp_shift = 0,
>>  	.temp_mask = 0x3ff,
>> -	.coef_b = 1169498786UL,
>> -	.coef_m = 2000000UL,
>> -	.coef_div = 4289,
>> +	.coef_b = 2931108200UL,
>> +	.coef_m = 5000000UL,
>> +	.coef_div = 10502,
>>  	.inverted = true,
>>  };
>>  
>>
> 
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
