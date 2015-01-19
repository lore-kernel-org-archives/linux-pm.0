From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 1/9] devfreq: exynos: Add generic exynos memory bus
 frequency driver
Date: Mon, 19 Jan 2015 18:35:27 +0900
Message-ID: <54BCCFDF.5040305@samsung.com>
References: <27342443.1253691421659213933.JavaMail.weblogic@epmlwas05d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <27342443.1253691421659213933.JavaMail.weblogic@epmlwas05d>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

On 01/19/2015 06:20 PM, MyungJoo Ham wrote:
>>   
>>  This patch adds the generic exynos bus frequency driver for memory bus
>> with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
>> for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
>> support the memory bus frequency driver for Exynos SoCs.
>>
>> Each memory bus block has a clock for memory bus speed and frequency
>> table which is changed according to the utilization of memory bus on runtime.
>> And then each memory bus group has the one more memory bus blocks and
>> OPP table (including frequency and voltage), regulator, devfreq-event
>> devices.
>>
>> There are a little difference about the number of memory bus because each Exynos
>> SoC have the different sub-IP and different memory bus speed. In spite of this
>> difference among Exynos SoCs, we can support almost Exynos SoC by adding
>> unique data of memory bus to devicetree file.
>>
>> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/Kconfig             |  15 +
>>  drivers/devfreq/Makefile            |   1 +
>>  drivers/devfreq/exynos/Makefile     |   1 +
>>  drivers/devfreq/exynos/exynos-bus.c | 598 ++++++++++++++++++++++++++++++++++++
>>  4 files changed, 615 insertions(+)
>>  create mode 100644 drivers/devfreq/exynos/exynos-bus.c
>>
> 
> []
> 
>> +static void exynos_bus_exit(struct device *dev)
>> +{
>> +	struct exynos_memory_bus *bus = dev_get_drvdata(dev);
>> +	int i, ret;
>> +
>> +	ret = exynos_bus_disable_edev(bus);
>> +	if (ret < 0)
>> +		dev_warn(dev, "failed to disable the devfreq-event devices\n");
>> +
>> +	for (i = 0; i < bus->block_count; i++)
>> +		clk_disable_unprepare(bus->block[i].clk);
>> +
>> +	if (regulator_is_enabled(bus->regulator))
>> +		regulator_disable(bus->regulator);
> 
> This is_enabled check is itchy.
> 
> Why do you need this here?
> Please let me know what kind of errors here.
> (note that this may simply hide errors made by other drivers)
> 
> Adding this condition does not introduce additional error, but
> could you please let me know why it is here? This is supposed to be
> paired with probe.

The regulator_is_enabled() is not necessary according to your comment.
I'll remove it.

> 
> 
> Except this point (valid if addressed or {explained and understood}),
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks for your review.

Best Regards,
Chanwoo Choi
