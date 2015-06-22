From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator supply
 property
Date: Mon, 22 Jun 2015 10:42:20 +0900
Message-ID: <558767FC.4090405@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-5-git-send-email-b.zolnierkie@samsung.com>
 <CAJKOXPfR5JS546YS3M-8orxO7+SxnzE06h2cyesExyt8Y9fVKw@mail.gmail.com>
 <CAJKOXPfdXV8qxR3AQEzQJTf6MojUN7Z=06ikxF8u5BuMihDfJQ@mail.gmail.com>
 <00f801d0ac8c$344dfeb0$9ce9fc10$@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <00f801d0ac8c$344dfeb0$9ce9fc10$@kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Kevin Hilman' <khilman@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, mturquette@baylibre.com, linux-pm@vger.kernel.org, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Andreas Faerber' <afaerber@suse.de>, 'Doug Anderson' <dianders@chromium.org>, 'Javier Martinez Canillas' <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22.06.2015 10:38, Kukjin Kim wrote:
> Krzysztof Kozlowski wrote:
>> 2015-05-08 9:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>>> 2015-04-04 1:43 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>
>>>> For Exynos4210 platforms, add CPU operating points and CPU
>>>> regulator supply properties for migrating from Exynos specific
>>>> cpufreq driver to using generic cpufreq driver.
>>>>
>>>> Changes by Bartlomiej:
>>>> - removed Exynos5250 and Exynos5420 support for now
>>>>
>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>>> Cc: Doug Anderson <dianders@chromium.org>
>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>> Cc: Andreas Faerber <afaerber@suse.de>
>>>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
>>>> Cc: Andreas Farber <afaerber@suse.de>
>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>
>>> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>
>> Rebased and applied to my tree, I'll sent it later to Kukjin unless he
>> picks it by himself from LKML.
>>
> Hi, as far as I know, this is for v4.2 not v4.1 so it will be applied based on
> v4.2-rc1 after v4.2-rc1 release.

You mean it is for v4.3, not v4.2?

Best regards,
Krzysztof
