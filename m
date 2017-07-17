From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] devfreq: tegra: fix error return code in
 tegra_devfreq_probe()
Date: Sun, 16 Jul 2017 23:52:00 -0500
Message-ID: <38a5cf39-26a4-8498-add8-423dc39e3219@embeddedor.com>
References: <20170703124738.GA3947@embeddedgus>
 <5206e248-a3a7-8cb5-5d8f-a0c84bcb9e40@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5206e248-a3a7-8cb5-5d8f-a0c84bcb9e40@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/04/2017 03:35 AM, Jon Hunter wrote:
>
> On 03/07/17 13:47, Gustavo A. R. Silva wrote:
>> platform_get_irq() returns an error code, but the tegra-devfreq
>> driver ignores it and always returns -ENODEV. This is not correct,
>> and prevents -EPROBE_DEFER from being propagated properly.
>>
>> Notice that platform_get_irq() no longer returns 0 on error:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af
>>
>> Print and propagate the return value of platform_get_irq on failure.
>>
>> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>> Changes in v2:
>>  Rewrite commit message.
>>
>>  drivers/devfreq/tegra-devfreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
>> index 214fff9..ae71215 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
>>  	}
>>
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq <= 0) {
>> -		dev_err(&pdev->dev, "Failed to get IRQ\n");
>> -		return -ENODEV;
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
>> +		return irq;
>>  	}
>>
>>  	platform_set_drvdata(pdev, tegra);
>
> Thanks.
>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
>

Thank you, Jon.

-- 
Gustavo A. R. Silva
