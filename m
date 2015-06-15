From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
Date: Tue, 16 Jun 2015 08:53:11 +0900
Message-ID: <557F6567.1070901@samsung.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
 <5110473.q5rJrrjs9a@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <5110473.q5rJrrjs9a@vostro.rjw.lan>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16.06.2015 08:47, Rafael J. Wysocki wrote:
> On Wednesday, June 03, 2015 05:18:18 PM Paul Gortmaker wrote:
>> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
>> and also contains modular function calls so it should explicitly include
>> module.h to avoid compile breakage during pending header shuffles.
>>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: Kukjin Kim <kgene@kernel.org>
>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-samsung-soc@vger.kernel.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> I'm assuming that this will go in via the Samsung tree.
> 
> 
>> ---
>>
>> [ patch will be appended to the implicit include fixup series, see:
>>   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com
>>   for the original series posting.]

Paul, will you handle the patch or should it go through Samsung tree?

Best regards,
Krzysztof
