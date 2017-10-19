From: "Wangtao (Kevin, Kirin)" <kevin.wangtao@hisilicon.com>
Subject: Re: [PATCH] thermal/drivers/hisi: disable multi alarm support for
 hi3660 SoC
Date: Thu, 19 Oct 2017 09:31:24 +0800
Message-ID: <6f39a5ed-0db6-4600-19d0-f9e9c5c43b1f@hisilicon.com>
References: <20171017043941.GE7954@localhost.localdomain>
 <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
 <9685721b-4593-029b-b8e8-d721526b7119@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8947 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdJSBeN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 21:34:13 -0400
In-Reply-To: <9685721b-4593-029b-b8e8-d721526b7119@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, Kevin Wangtao <kevin.wangtao@linaro.org>



在 2017/10/18 23:54, Daniel Lezcano 写道:
> On 18/10/2017 11:15, Tao Wang wrote:
>> From: Kevin Wangtao <kevin.wangtao@linaro.org>
>>
>> multi alarm interrupt forced a re-trigger of power_allocator_throttle
>> which changes the PID's actual sampling rate, this isn't optimal for
>> IPA, it is best to disable multi alarm support now and sort out this
>> issue later.
>>
>> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> Did you test the series with this change?
Yes
> 
>> ---
>>   drivers/thermal/hisi_thermal.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
>> index 133238a..3b74c12 100644
>> --- a/drivers/thermal/hisi_thermal.c
>> +++ b/drivers/thermal/hisi_thermal.c
>> @@ -360,7 +360,6 @@ static int hi3660_thermal_enable_sensor(struct hisi_thermal_data *data)
>>   
>>   	/* set interrupt threshold */
>>   	value = hi3660_thermal_temp_to_step(sensor->thres_temp[0]);
>> -	value |= hi3660_thermal_temp_to_step(sensor->thres_temp[1]) << 10;
>>   	hi3660_thermal_alarm_set(data->regs, sensor->id, value);
>>   
>>   	/* enable interrupt */
>>
> 
> 
