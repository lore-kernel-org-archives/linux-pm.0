From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 8/8] PM / devfreq: exynos-bus: Register cooling
 device
Date: Wed, 18 Oct 2017 11:08:28 +0900
Message-ID: <59E6B79C.2040000@samsung.com>
References: <CGME20171013074837epcas1p49957bd030fc1a27cc845d63c50ad0aba@epcas1p4.samsung.com>
        <1507880904-31956-1-git-send-email-cw00.choi@samsung.com>
        <1507880904-31956-9-git-send-email-cw00.choi@samsung.com>
        <CAJ0PZbRkfNt5eQK5qzunAnFiGmwEF1Dj-TKuqXNhxhN=BxzVEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAJ0PZbRkfNt5eQK5qzunAnFiGmwEF1Dj-TKuqXNhxhN=BxzVEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: Kyungmin Park <kyungmin.park@samsung.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, chanwoo@kernel.org, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2017년 10월 18일 00:11, MyungJoo Ham wrote:
> On Fri, Oct 13, 2017 at 4:48 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>> This patch registers the Exynos Bus-Frequency scaling device
>> as a cooling device of thermal management.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk@kernel.org>
>> Cc: linux-samsung-soc@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
> 
> I've got a question below.
> 
>> ---
>>  drivers/devfreq/exynos-bus.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
>> index c25658b26598..1c7521b65c2f 100644
> []> @@ -468,6 +471,19 @@ static int exynos_bus_probe(struct
> platform_device *pdev)
>>                 goto err;
>>         }
>>
>> +       /*
>> +        * Register devfreq cooling device if thermal DT code
>> +        * takes care of matching them.
>> +        */
>> +       if (of_find_property(np, "#cooling-cells", NULL)) {
>> +               bus->cdev = of_devfreq_cooling_register(np, bus->devfreq);
>> +               if (IS_ERR(bus->cdev)) {
>> +                       dev_err(dev, "running exynos-bus without cooling device\n");
>> +                       bus->cdev = NULL;
>> +               }
>> +       }
>> +       of_node_put(np);
> 
> Is this of_node_put() is a pair of of_find_property? or for something else?
> (do you need to call put for of_find_property? or for something else?
> I'm not seeing a function with "get")

You're right. The of_node_put(np) call is unneeded.
Actually, the extcon-bus.c have to use the of_node_get instead of accessing
the 'dev->of_node' directly.

And, when I test this patch, I got a bug related to passive governor.
I need more time for debugging and redevelopment.
So, I'll drop this patch on next patchset (v5).

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
