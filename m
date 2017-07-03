From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] devfreq: tegra: fix error code in tegra_devfreq_probe()
Date: Mon, 03 Jul 2017 06:59:05 -0500
Message-ID: <20170703065905.Horde.JGioNMGT4RgQsy5ykZpOZQ1@gator4166.hostgator.com>
References: <20170630072211.GA21867@embeddedgus>
 <89de541e-355e-e79c-0090-cffefd277b4c@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <89de541e-355e-e79c-0090-cffefd277b4c@nvidia.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Jon,

Quoting Jon Hunter <jonathanh@nvidia.com>:

> On 30/06/17 08:22, Gustavo A. R. Silva wrote:
>> Print and propagate the return value of platform_get_irq on failure.
>>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/devfreq/tegra-devfreq.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/devfreq/tegra-devfreq.c  
>> b/drivers/devfreq/tegra-devfreq.c
>> index 214fff9..ae71215 100644
>> --- a/drivers/devfreq/tegra-devfreq.c
>> +++ b/drivers/devfreq/tegra-devfreq.c
>> @@ -688,9 +688,9 @@ static int tegra_devfreq_probe(struct  
>> platform_device *pdev)
>>  	}
>>
>>  	irq = platform_get_irq(pdev, 0);
>> -	if (irq <= 0) {
>> -		dev_err(&pdev->dev, "Failed to get IRQ\n");
>> -		return -ENODEV;
>> +	if (irq < 0) {
>
> The changelog does not describe the above change and if/why this is ok.
> However, the original test looks fine to me and so I don't see a need to
> change this.
>

You are right about the changelog. I think this one is much better:

platform_get_irq() returns an error code, but the tegra-devfreq
driver ignores it and always returns -ENODEV. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print error message and propagate the return value of
platform_get_irq on failure.


What do you think?

Thank you!
--
Gustavo A. R. Silva
