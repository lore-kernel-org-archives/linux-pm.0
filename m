From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/4] rk3399_dmc: Fix line continuation format
Date: Thu, 23 Nov 2017 10:45:25 +0900
Message-ID: <5A162835.5050806@samsung.com>
References: <1511347280.6989.81.camel@perches.com>
        <cover.1510845910.git.joe@perches.com>
        <7d659960e45f66894126fba9e2d54cf25ae1185b.1510845910.git.joe@perches.com>
        <5A150792.6050104@samsung.com>
        <CGME20171116152742epcas2p22b17887a4d7f2adcd3beb414988dbce3@epcms1p1>
        <20171123012100epcms1p13f78950557de06dbbd65996c8b0645ee@epcms1p1>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20171123012100epcms1p13f78950557de06dbbd65996c8b0645ee@epcms1p1>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, Joe Perches <joe@perches.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2017년 11월 23일 10:21, MyungJoo Ham wrote:
>> On Wed, 2017-11-22 at 14:13 +0900, Chanwoo Choi wrote:
>>> On 2017년 11월 17일 00:27, Joe Perches wrote:
>>>> Line continuations with excess spacing causes unexpected output.
>>>>
>>>> Signed-off-by: Joe Perches <joe@perches.com>
>>>> ---
>>>>  drivers/devfreq/rk3399_dmc.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
>>>> index 5dfbfa3cc878..0938c97d46f0 100644
>>>> --- a/drivers/devfreq/rk3399_dmc.c
>>>> +++ b/drivers/devfreq/rk3399_dmc.c
>>>> @@ -146,8 +146,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
>>>>  
>>>>  	/* If get the incorrect rate, set voltage to old value. */
>>>>  	if (dmcfreq->rate != target_rate) {
>>>> -		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,\
>>>> -			Current frequency %lu\n", target_rate, dmcfreq->rate);
>>>> +		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu, Current frequency %lu\n",
>>>> +			target_rate, dmcfreq->rate);
>>>
>>> IMO, I don't like over 80 char in the one line.
>>
>> Fix it as you chose, but the code I proposed
>> is what is preferred by CodingStyle.
>>
>> The current code is unintentional.
>>
>> Right now there are 3 tabs between "Request frequency"
>> and "Current frequency" in the output.
> 
> Chanwoo, this is not a simple coding style issue.
> I'm seeing these unintentional tabs as well.
> 
> If you want to keep it 80 cols with strings (which is not mandatory for strings in double quotes),
> We'd better do:
> 
> -		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,\
> -			Current frequency %lu\n", target_rate, dmcfreq->rate);
> +		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,"
> +			" Current frequency %lu\n", target_rate, dmcfreq->rate);

I agree with Myungjoo's opinion.
I think the readability is important. So, I prefer to keep one line within 80 char.

> 
> Cheers,
> MyungJoo
> 
>>
>>>>  		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
>>>>  				      dmcfreq->volt);
>>>>  		goto out;
>>>>
>>>
>>>
>>
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
