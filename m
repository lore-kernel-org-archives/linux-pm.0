From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 12/19] PM / devfreq: tegra: Avoid inconsistency of
 current frequency value
Date: Tue, 16 Apr 2019 18:40:16 +0300
Message-ID: <2d2f7c42-2cad-3b49-eaf3-810f94b3dc77@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145721epcas1p4936edf8cf61a7d373a6e3f6aba76a029@epcas1p4.samsung.com>
 <20190415145505.18397-13-digetx@gmail.com>
 <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <375ebaba-1762-2675-3ae3-2ea9ec4cbcb2@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

16.04.2019 10:15, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The frequency value potentially could change in-between. It doesn't
>> cause any real problem at all right now, but that could change in the
>> future. Hence let's avoid the inconsistency.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index a668e4fbc874..f1a6f951813a 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -496,13 +496,15 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  {
>>  	struct tegra_devfreq *tegra = dev_get_drvdata(dev);
>>  	struct tegra_devfreq_device *actmon_dev;
>> +	unsigned long cur_freq;
>>  
>> -	stat->current_frequency = tegra->cur_freq * KHZ;
>> +	cur_freq = READ_ONCE(tegra->cur_freq);
>>  
>>  	/* To be used by the tegra governor */
>>  	stat->private_data = tegra;
>>  
>>  	/* The below are to be used by the other governors */
>> +	stat->current_frequency = cur_freq * KHZ;
>>  
>>  	actmon_dev = &tegra->devices[MCALL];
>>  
>> @@ -513,7 +515,7 @@ static int tegra_devfreq_get_dev_status(struct device *dev,
>>  	stat->busy_time *= 100 / BUS_SATURATION_RATIO;
>>  
>>  	/* Number of cycles in a sampling period */
>> -	stat->total_time = ACTMON_SAMPLING_PERIOD * tegra->cur_freq;
>> +	stat->total_time = ACTMON_SAMPLING_PERIOD * cur_freq;
>>  
>>  	stat->busy_time = min(stat->busy_time, stat->total_time);
>>  
>>
> 
> The read/write access of tegra->cur_freq is in the single routine
> of update_devfreq() as following. I think that there are no any
> potential problem about the inconsistency of tegra->cur_freq.

No, that's wrong assumption. The tegra->cur_freq is changed by the clock notifier that runs asynchronously with the devfreq driver when EMC clock rate is changed by something else in the kernel. 

> IMHO, if there are no any problem now, I'm not sure that we need
> to apply this patch.
> 
> update_devfreq()
> {
> 	devfreq->governor->get_target_freq()
> 		devfreq_update_stats(devfreq)
> 			tegra_devfreq_get_dev_status()
> 				stat->current_frequency = tegra->cur_freq * KHZ;
> 
> 	devfreq_set_target()
> 		tegra_devfreq_target()
> 			clk_set_min_rate(emc_rate, )
> 				tegra_actmon_rate_notify_cb()
> 					tegra->cur_freq = data->new_rate / KHZ;
> 		
> 			clk_set_rate(emc_rate, )
> 				tegra_actmon_rate_notify_cb()
> 					tegra->cur_freq = data->new_rate / KHZ;
> }
> 
> 

The cur_freq value is changed by the clock notifier that runs asynchronously with the rest of the devfreq driver. Hence potentially compiler may generate two separate fetches of the cur_freq value, then the clock rate could be changed by other CPU core simultaneously with tegra_devfreq_get_dev_status() or kernel may re-schedule preemptively, changing the clock rate in-between of the two fetches.
