From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH] thermal: samsung: Only update available threshold limits
Date: Thu, 24 Apr 2014 17:00:28 +0530
Message-ID: <5358F5D4.1010506@linaro.org>
References: <1397453895-6688-1-git-send-email-tushar.behera@linaro.org> <1705902.4858U1S3Zd@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1705902.4858U1S3Zd@amdc1032>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com
List-Id: linux-pm@vger.kernel.org

On 04/24/2014 04:18 PM, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Monday, April 14, 2014 11:08:15 AM Tushar Behera wrote:
>> Currently the threshold limits are updated in 2 stages, once for all
>> software trigger levels and again for hardware trip point.
>>
>> While updating the software trigger levels, it overwrites the threshold
>> limit for hardware trip point thereby forcing the Exynos core to issue
>> an emergency shutdown.
> 
> On what SoC type have you encountered this problem?  It doesn't seem to
> happen on older SoCs (at least Exynos4210 and Exynos4x12 ones).
> 

I found this issue while testing on Exynos5420 with these patches [1].

[1] https://lkml.org/lkml/2013/8/1/38

>> Updating only the required fields in threshold register fixes this issue.
> 
> With the current code there is indeed a time window during which threshold
> limit for hardware trip point is set to zero so the fix is correct.
> 


-- 
Tushar Behera
