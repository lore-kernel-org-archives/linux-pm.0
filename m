From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: Re: [PATCH v2 00/10] Exynos IOMMU: proper runtime PM support (use
 device dependencies)
Date: Mon, 18 Jul 2016 13:00:43 +0200
Message-ID: <578CB6DB.90608@math.uni-bielefeld.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <5787B2B0.9020809@math.uni-bielefeld.de>
 <5788E352.3040801@math.uni-bielefeld.de>
 <a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <a15e438a-7fa0-3a4d-e6e2-13425512dddd@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Marek,


Marek Szyprowski wrote:
> Hi Tobias,
> 
> 
> On 2016-07-15 15:21, Tobias Jakobi wrote:
>> Tobias Jakobi wrote:
>>> Hello Marek,
>>>
>>> I've tested the patchset on 4.7-rc7 and noticed that it breaks reboot on
>>> my ODROID-X2.
>>>
>>> Going to check where exactly things break.
>> Sadly it's the last patch where everything comes together:
>> "iommu/exynos: Add proper runtime pm support"
>>
>> I still have to check if forcing runpm status to 'on' makes a
>> difference. I suspect that the aggressive clock gating might be the
>> reason?
> 
> Thanks for testing. I will check this issue. Could you send me your
> .config?
This is the config I'm currently using:
https://github.com/tobiasjakobi/odroid-environment/blob/master/sourcecode/system/vanilla-4.7-debug.conf

Do you think checking this with no_console_suspend makes sense?

- Tobias


> 
> Best regards
