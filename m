From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/3] cpufreq: exynos: Use generic platdev driver
Date: Tue, 29 Mar 2016 13:39:46 +0900
Message-ID: <56FA0712.6020802@samsung.com>
References: <cover.1458801338.git.viresh.kumar@linaro.org>
 <6cb29053bce7026dd9429326236a67c45e901c7b.1458801338.git.viresh.kumar@linaro.org>
 <56FA0039.6030007@samsung.com> <20160329041827.GA25424@vireshk-i7>
 <20160329041923.GB25424@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:25602 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755829AbcC2Ej4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 00:39:56 -0400
In-reply-to: <20160329041923.GB25424@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org, Kukjin Kim <kgene@kernel.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

On 29.03.2016 13:19, Viresh Kumar wrote:
> On 29-03-16, 09:48, Viresh Kumar wrote:
>> On 29-03-16, 13:10, Krzysztof Kozlowski wrote:
>>> On 24.03.2016 15:40, Viresh Kumar wrote:
>>>> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
>>>> device now, reuse that and remove similar code from platform code.
>>>>
>>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> ---
>>>>  arch/arm/mach-exynos/exynos.c        | 25 -------------------------
>>>>  drivers/cpufreq/cpufreq-dt-platdev.c |  5 +++++
>>>>  2 files changed, 5 insertions(+), 25 deletions(-)
>>>
>>> Looks fine to me... except that it is a little bit outdated. Please
>>> rebase on v4.6-rc1 because Bartlomiej added support for cpufreq @Exynos542x.
>>
>> Yeah, I know. I already have the updated version.
> 
> Here it is:
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Thu, 24 Mar 2016 12:04:10 +0530
> Subject: [PATCH] cpufreq: exynos: Use generic platdev driver
> 
> The cpufreq-dt-platdev driver supports creation of cpufreq-dt platform
> device now, reuse that and remove similar code from platform code.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/exynos.c        | 29 -----------------------------
>  drivers/cpufreq/cpufreq-dt-platdev.c |  9 +++++++++
>  2 files changed, 9 insertions(+), 29 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>



Best regards,

Krzysztof

