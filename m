From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH v2 4/8] PM / devfreq: exynos-ppmu: Show the registred
 device for ppmu device
Date: Fri, 30 Dec 2016 21:00:48 +0900
Message-ID: <CAGTfZH29XCyBrzyB7mCZ5Bwyn02rjj+jr3TevTe6+HYvSdSngQ@mail.gmail.com>
References: <CGME20161228115654epcas1p1fcd9be231f97e6782e06d75ace95a9ba@epcas1p1.samsung.com>
 <1482926212-19223-1-git-send-email-cw00.choi@samsung.com> <1482926212-19223-5-git-send-email-cw00.choi@samsung.com>
 <CAJ0PZbRKPpbHG_dMFowd7nXbxUGJRmY=jsscKBLDY27GTFjO7g@mail.gmail.com>
Reply-To: cwchoi00@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJ0PZbRKPpbHG_dMFowd7nXbxUGJRmY=jsscKBLDY27GTFjO7g@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2016-12-30 19:35 GMT+09:00 MyungJoo Ham <myungjoo.ham@samsung.com>:
> On Wed, Dec 28, 2016 at 8:56 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch just adds the simple log to show the PPMU device's registration
>> during the kernel booting.
>>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
>> Cc: linux-samsung-soc@vger.kernel.org
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/devfreq/event/exynos-ppmu.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
>> index fb3706faf5bd..9b5294d0bff4 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -591,7 +591,7 @@ static int exynos_ppmu_parse_dt(struct platform_device *pdev,
>>         info->ppmu.clk = devm_clk_get(dev, "ppmu");
>>         if (IS_ERR(info->ppmu.clk)) {
>>                 info->ppmu.clk = NULL;
>> -               dev_warn(dev, "cannot get PPMU clock\n");
>> +               dev_dbg(dev, "cannot get PPMU clock\n");
>
> Do you really want not to emit warning with a clock not found?

The clock is now optional on the exynos-bus.c driver. But we better to
keep the warning message. Instead, I'll try to add the clock to PPMU
which is missing the clock.

I'll send the next version.

[snip]

-- 
Best Regards,
Chanwoo Choi
