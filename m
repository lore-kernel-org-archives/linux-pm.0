From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3 1/8] devfreq: exynos: Add generic exynos memory bus
 frequency driver
Date: Tue, 13 Jan 2015 19:29:42 +0900
Message-ID: <54B4F396.3090105@samsung.com>
References: <2009992739.970611421140038667.JavaMail.weblogic@epmlwas05d>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <2009992739.970611421140038667.JavaMail.weblogic@epmlwas05d>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 01/13/2015 06:07 PM, MyungJoo Ham wrote:
>>  
>> Dear Myungjoo,
>>
>> On 01/13/2015 05:42 PM, MyungJoo Ham wrote:
>>>>   
>>>>  This patch adds the generic exynos bus frequency driver for memory bus
>>>> with DEVFREQ framework. The Samsung Exynos SoCs have the common architecture
>>>> for memory bus between DRAM memory and MMC/sub IP in SoC. This driver can
>>>> support the memory bus frequency driver for Exynos SoCs.
>>>>
>>>> Each memory bus block has a clock for memory bus speed and frequency
>>>> table which is changed according to the utilization of memory bus on runtime.
>>>> And then each memory bus group has the one more memory bus blocks and
>>>> OPP table (including frequency and voltage), regulator, devfreq-event
>>>> devices.
>>>>
>>>> There are a little difference about the number of memory bus because each Exynos
>>>> SoC have the different sub-IP and different memory bus speed. In spite of this
>>>> difference among Exynos SoCs, we can support almost Exynos SoC by adding
>>>> unique data of memory bus to devicetree file.
>>>>
>>>> Cc: Myungjoo Ham <myungjoo.ham@samsung.com>
>>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>>> ---
>>>>  drivers/devfreq/Kconfig          |  15 +
>>>>  drivers/devfreq/Makefile         |   1 +
>>>>  drivers/devfreq/exynos-busfreq.c | 589 +++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 605 insertions(+)
>>>>  create mode 100644 drivers/devfreq/exynos-busfreq.c
>>>
>>> Exynos drivers are located at drivers/devfreq/exynos/
>>> Please relocate/rename exynos-busfreq.c
>>
>> OK. I'll move it at drivers/devfreq/exynos directory.
>> Do you prefer 'exynos-bus.c' instead of 'exynos-busfreq.c'?
>> If you reply, I'll change it.
> 
> exynos-bus looks more pretty :)

OK, I'll change the driver name according to your comment.

Best Regards,
Chanwoo Choi

> 
>>
>>>
>>> []
>>>
>>>> diff --git a/drivers/devfreq/exynos-busfreq.c b/drivers/devfreq/exynos-busfreq.c
>>>> new file mode 100644
>>>> index 0000000..b180f43
>>>> --- /dev/null
>>>> +++ b/drivers/devfreq/exynos-busfreq.c
>>>
>>> []
>>>
>>>> +
>>>> +#define BUS_SATURATION_RATIO	40
>>>
>>> In order to be a common driver, this should be tunable.
>>>
>>> Because .dts is supposed to have hardware configuration only,
>>> you may keep a table of { chip-name, saturation ratio} in this
>>> driver and look up the saturation ratio based on the chip-name.
>>
>> OK, I'll add new property for saturation_ratio.
>>
>> I'll implement to use default saturation_ratio value ,
>> if dt node don't include saturation_ratio property.
> 
> Yes. I didn't talk with DT maintainers and I do not have much
> experience with DT; however, it appears that such values are not
> recommended to be in DTS files and this value is determined by
> the SoC model number without complications in the driver file.
> 
