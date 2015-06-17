From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] drivers/cpufreq: include <module.h> for modular
 exynos-cpufreq.c code
Date: Wed, 17 Jun 2015 09:36:14 +0900
Message-ID: <5580C0FE.5010502@samsung.com>
References: <1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com>
 <1433366298-30016-1-git-send-email-paul.gortmaker@windriver.com>
 <5110473.q5rJrrjs9a@vostro.rjw.lan> <557F6567.1070901@samsung.com>
 <558040E9.2060008@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <558040E9.2060008@windriver.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 17.06.2015 00:29, Paul Gortmaker wrote:
> On 15-06-15 07:53 PM, Krzysztof Kozlowski wrote:
>> On 16.06.2015 08:47, Rafael J. Wysocki wrote:
>>> On Wednesday, June 03, 2015 05:18:18 PM Paul Gortmaker wrote:
>>>> This file is built off of a tristate Kconfig option ("ARM_EXYNOS_CPUFREQ")
>>>> and also contains modular function calls so it should explicitly include
>>>> module.h to avoid compile breakage during pending header shuffles.
>>>>
>>>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>>>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> Cc: linux-pm@vger.kernel.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-samsung-soc@vger.kernel.org
>>>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>>>
>>> I'm assuming that this will go in via the Samsung tree.
>>>
>>>
>>>> ---
>>>>
>>>> [ patch will be appended to the implicit include fixup series, see:
>>>>   https://lkml.kernel.org/r/1430444867-22342-1-git-send-email-paul.gortmaker@windriver.com
>>>>   for the original series posting.]
>>
>> Paul, will you handle the patch or should it go through Samsung tree?
> 
> 
> I have to keep a copy of the patch in the above series, since if
> I don't then we'll introduce build failures into the bisection
> history, so yes I'll handle it.

Thank you, I'll leave the patch for you to handle.

Best regards,
Krzysztof
