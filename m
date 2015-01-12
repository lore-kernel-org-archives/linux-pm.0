From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv7 04/10] devfreq: event: Add exynos-ppmu devfreq-event
 driver
Date: Mon, 12 Jan 2015 17:39:28 +0900
Message-ID: <54B38840.9080308@samsung.com>
References: <603055177.891931421049871049.JavaMail.weblogic@epmlwas09a>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <603055177.891931421049871049.JavaMail.weblogic@epmlwas09a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "kgene@kernel.org" <kgene@kernel.org>, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, ABHILASH KESAVAN <a.kesavan@samsung.com>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Dear Myungjoo,

On 01/12/2015 05:04 PM, MyungJoo Ham wrote:
>>   
>>  This patch adds exynos-ppmu devfreq-event driver to get performance data
>> of each IP for Samsung Exynos SoC. These event from Exynos PPMU provide
>> useful information about the behavior of the SoC that you can use when
>> analyzing system performance, and made visible and can be counted using
>> logic in each IP.
>>
>> This patch is based on existing drivers/devfreq/exynos/exynos-ppmu.c
>>
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/event/Kconfig       |   9 +
>>  drivers/devfreq/event/Makefile      |   1 +
>>  drivers/devfreq/event/exynos-ppmu.c | 399 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 409 insertions(+)
>>  create mode 100644 drivers/devfreq/event/exynos-ppmu.c
>>
> 
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> 

Thanks for your reviw.

Best Regards,
Chanwoo Choi
