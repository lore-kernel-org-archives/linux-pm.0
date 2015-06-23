From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 4/6] ARM: dts: Exynos4210: add CPU OPP and regulator supply
 property
Date: Tue, 23 Jun 2015 09:24:40 +0900
Message-ID: <5588A748.2070407@samsung.com>
References: <'@samsung.com>
 <1428079429-4252-1-git-send-email-b.zolnierkie@samsung.com>
 <1428079429-4252-5-git-send-email-b.zolnierkie@samsung.com>
 <CAJKOXPfR5JS546YS3M-8orxO7+SxnzE06h2cyesExyt8Y9fVKw@mail.gmail.com>
 <CAJKOXPfdXV8qxR3AQEzQJTf6MojUN7Z=06ikxF8u5BuMihDfJQ@mail.gmail.com>
 <00f801d0ac8c$344dfeb0$9ce9fc10$@kernel.org> <558767FC.4090405@samsung.com>
 <011f01d0ac8d$40a25110$c1e6f330$@kernel.org>
 <20150622150421.9112.96812@quantum> <55889E59.1070001@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:55701 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbFWAYt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 20:24:49 -0400
In-reply-to: <55889E59.1070001@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 'Lukasz Majewski' <l.majewski@samsung.com>, 'Heiko Stuebner' <heiko@sntech.de>, 'Kevin Hilman' <khilman@linaro.org>, 'Bartlomiej Zolnierkiewicz' <b.zolnierkie@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-kernel@vger.kernel.org, 'Chanwoo Choi' <cw00.choi@samsung.com>, 'Thomas Abraham' <thomas.ab@samsung.com>, 'Sylwester Nawrocki' <s.nawrocki@samsung.com>, 'Andreas Faerber' <afaerber@suse.de>, 'Doug Anderson' <dianders@chromium.org>, 'Javier Martinez Canillas' <javier.martinez@collabora.co.uk>, linux-samsung-soc@vger.kernel.org

On 23.06.2015 08:46, Krzysztof Kozlowski wrote:
> On 23.06.2015 00:04, Michael Turquette wrote:
>> Quoting Kukjin Kim (2015-06-21 18:46:26)
>>> Krzysztof Kozlowski wrote:
>>>>
>>>> On 22.06.2015 10:38, Kukjin Kim wrote:
>>>>> Krzysztof Kozlowski wrote:
>>>>>> 2015-05-08 9:18 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
>>>>>>> 2015-04-04 1:43 GMT+09:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
>>>>>>>> From: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>>>
>>>>>>>> For Exynos4210 platforms, add CPU operating points and CPU
>>>>>>>> regulator supply properties for migrating from Exynos specific
>>>>>>>> cpufreq driver to using generic cpufreq driver.
>>>>>>>>
>>>>>>>> Changes by Bartlomiej:
>>>>>>>> - removed Exynos5250 and Exynos5420 support for now
>>>>>>>>
>>>>>>>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>>>>>>>> Cc: Doug Anderson <dianders@chromium.org>
>>>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>>>>>> Cc: Andreas Faerber <afaerber@suse.de>
>>>>>>>> Cc: Sachin Kamat <sachin.kamat@linaro.org>
>>>>>>>> Cc: Andreas Farber <afaerber@suse.de>
>>>>>>>> Cc: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>>>>>>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>>>>>>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>>>>>
>>>>>>> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>>>>
>>>>>> Rebased and applied to my tree, I'll sent it later to Kukjin unless he
>>>>>> picks it by himself from LKML.
>>>>>>
>>>>> Hi, as far as I know, this is for v4.2 not v4.1 so it will be applied based on
>>>>> v4.2-rc1 after v4.2-rc1 release.
>>>>
>>>> You mean it is for v4.3, not v4.2?
>>>>
>>> Oops, yes v4.3.
>>>
>>> Thanks for the correction.
>>
>> Kukjin & Krzysztof,
>>
>> I'm confused on this point. I was planning to take patches 1, 2, 3, 5
>> and 6 towards 4.2 (e.g. in the pull request that I'll send out this
>> week).
>>
>> Is patch 4 going out for 4.2 or 4.3?
> 
> It is quite late for sending pull request to arm-soc for 4.2.
> For example SoCFPGA pull request from last week was rejected:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/417980

Oh, that was wrong link. Here it is:
http://www.spinics.net/lists/arm-kernel/msg425911.html

> If you want to take it for 4.2 then I am fine with it but this will
> cause some easy but annoying conflicts. There aren't difficult - just
> most of nodes in board DTS changed their place.
> 
> Example of resolution (target file after merge, with cpu nodes reordered
> alphabetically):
> https://github.com/krzk/linux/commit/2cec3cb48abaf44848c62f1c0836b772eb4680dd

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
