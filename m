From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/3] thermal: exynos: Defer probe if vtmu is present but
 not registered
Date: Fri, 19 Feb 2016 13:25:05 +0900
Message-ID: <56C69921.4050201@samsung.com>
References: <1455819551-4666-1-git-send-email-javier@osg.samsung.com>
 <1455819551-4666-4-git-send-email-javier@osg.samsung.com>
 <20160219042014.GB27936@samsunx.samsung>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20160219042014.GB27936@samsunx.samsung>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Shyti <andi.shyti@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 19.02.2016 13:20, Andi Shyti wrote:
> Hi Javier,
> 
> Just a question...
> 
>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>> index f4f36bba7be9..f3ce94ec73b5 100644
>> --- a/drivers/thermal/samsung/exynos_tmu.c
>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>> @@ -1318,6 +1318,8 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>>  			return ret;
>>  		}
>>  	} else {
>> +		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
>> +			return -EPROBE_DEFER;
> 
> shouldn't we return also in case of -ENOMEM? -ENOMEM is a Kernel
> failure, not depending on the regulator itself.

Usually not because that would make this error path quite complicated
and difficult to keep consistent. If you choose this way then you will
have to probably extend the black list (e.g. EINVAL, some other)... or
use a white list.

Additionally the error codes can come from deeper layers. These layer
now can return ESOMETHING but later it might change to EDIFFERENT... you
cannot predict that.

Whatever the reason was (except defer), just ignore the regulator.

Best regards,
Krzysztof
