From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 05/19] PM / devfreq: tegra: Replace write memory
 barrier with the read barrier
Date: Tue, 16 Apr 2019 16:57:31 +0300
Message-ID: <1ef32d1f-895a-5006-5760-bf2c070bc6e2@gmail.com>
References: <20190415145505.18397-1-digetx@gmail.com>
 <CGME20190415145805epcas1p209d0e2a8ba052ad11e91155c4585b1bd@epcas1p2.samsung.com>
 <20190415145505.18397-6-digetx@gmail.com>
 <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e0a9def6-e3ed-f134-e612-aa257aa3fa12@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

16.04.2019 11:00, Chanwoo Choi пишет:
> Hi,
> 
> On 19. 4. 15. 오후 11:54, Dmitry Osipenko wrote:
>> The write memory barrier isn't needed because the BUS buffer is flushed
>> by read after write that happens after the removed wmb(), we will also
>> use readl() instead of the relaxed version to ensure that read is indeed
>> completed.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index d62fb1b0d9bb..f0f0d78f6cbf 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -243,8 +243,7 @@ static void tegra_devfreq_update_wmark(struct tegra_devfreq *tegra,
>>  static void actmon_write_barrier(struct tegra_devfreq *tegra)
>>  {
>>  	/* ensure the update has reached the ACTMON */
>> -	wmb();
>> -	actmon_readl(tegra, ACTMON_GLB_STATUS);
>> +	readl(tegra->regs + ACTMON_GLB_STATUS);
> 
> I think that this meaning of actmon_write_barrier() keeps
> the order of 'store' assembly command without the execution change
> from compiler optimization by using the wmb().

The IO mapped memory is strongly-ordered on ARM, hence all readl/writel accesses are guaranteed to be ordered by default. I think wmb() here is just a cut-n-pasted relic from old downstream driver.

> But, this patch edits it as following:
> The result of the following two cases are same?
> 
> [original code]
> 	wmb()
> 	read_relaxed()
> 
> [new code by this patch]
> 	readl_relaxed()
> 	rmb()

Yes, the result is the same. The wmb() is not just about IO accesses, but about all kind of memory accesses and at least on Tegra30 it is quite expensive operation because it translates into L2XO cache syncing (arm_heavy_mb) + dsb(). It should be more efficient to flush out writes with a read-back and then wait for that read operation to be completed.
