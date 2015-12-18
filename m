From: "pankaj.dubey" <pankaj.dubey@samsung.com>
Subject: Re: [PATCH v7 0/6] samsung: pmu: split up SoC specific PMU data
Date: Fri, 18 Dec 2015 13:49:42 +0530
Message-ID: <5673C19E.9000907@samsung.com>
References: <1450409536-30463-1-git-send-email-pankaj.dubey@samsung.com>
 <56738B39.10201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <56738B39.10201@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: kgene.kim@samsung.com, thomas.ab@samsung.com, amitdanielk@gmail.com, olof@lixom.net, khilman@linaro.org, arnd@arndb.de
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On Friday 18 December 2015 09:57 AM, Krzysztof Kozlowski wrote:
> On 18.12.2015 12:32, Pankaj Dubey wrote:
>> In this series I am splitting up SoC specific PMU configuration data into
>> mach-exynos folder itself, before moving all of them under
>> drivers/soc/samsung/. Also instead of making all changes in single patch it
>> has been broken into SoC specific patches to avoid large size of patch.
>> With this approach there will not be unwanted big churns just after
>> adding exynos-pmu under drivers/soc/samsung.
>>
>> All these patches are just refactoring to keep minimal changes while moving
>> exynos-pmu driver under drivers/soc/samsung/. Support for exynos7 PMU can
>> be added on top of it, in such a manner that for ARM64 build, ARM related
>> SoC's PMU will not get compiled and thus unnecessary increasing kernel image size.
>>
>> This series have been prepared on top of Krzysztof Kozlowski's 
>> next/stuff-late-not-split-per-branch branch, and it's just a rebase compared to
>> V6 posted and reviewed here [1]. 
>>
>> [1]: https://lkml.org/lkml/2015/11/17/15
>>
>> For testing entire patchset on Peach-Pi (Exynos5880) based chromebook for boot
>> and S2R functionality.
>>
>> Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>
>> For testing entire patchset on on Trats2 (Exynos4412, S2R, reboot, poweroff)
>> and Odroid XU3 (Exynos5422, reboot, poweroff).
>>
>> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> Changes since v6:
>>  - Rebasing on top of branch provided by Krzysztof, after resolving conflicts 
>>    caused due to Alim's patches for adoptation of generic syscon for poweroff, reboot.
>>  - Included Tested-by tags on individual patches as per applicability.
>>  - Dropped patches v6 [1/9], v6 [2/9] as these are already present in above mentioned branch.
>>  - Dropped patch v6 [8/9] as after Alim's patch this patch no more required.
>>
> 
> Patchset applied cleanly with:
> 1. Removal of blank lines at end of two files (they appeared in v7).
> 2. Removal of your tested-by. The author does not provide such tag
> because it is assumed that he tested it before sending. However I left
> the information about testing platform near your signed-off-by.
> 

Thanks for taking care of minor nitpicks. I will be more careful, next
time.

> You can find the patches on the same branch:
> https://git.kernel.org/cgit/linux/kernel/git/krzk/linux.git/log/?h=next/stuff-late-not-split-per-branch
> 
> I hope I will be able to push it out to arm-soc soon...
> 

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
> 
> 
