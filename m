From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic code
Date: Thu, 21 Apr 2016 00:31:25 +0200
Message-ID: <CAJZ5v0h0T=XyC2bd3RByAC7mSYqRRcTe9XDVULHRz0Owr3a9Kg@mail.gmail.com>
References: <cover.1459325515.git.viresh.kumar@linaro.org>
	<20160420095557.GF12019@vireshk-i7>
	<5717F43D.1060504@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:32938 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcDTWb1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 18:31:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id p64so6603242lfg.0
        for <linux-pm@vger.kernel.org>; Wed, 20 Apr 2016 15:31:26 -0700 (PDT)
In-Reply-To: <5717F43D.1060504@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, mmcclint@codeaurora.org, Rafael Wysocki <rjw@rjwysocki.net>, Arnd Bergmann <arnd.bergmann@linaro.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kukjin Kim <kgene.kim@samsung.com>, xf@rock-chips.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>

On Wed, Apr 20, 2016 at 11:27 PM, Mason <slash.tmp@free.fr> wrote:
> On 20/04/2016 11:55, Viresh Kumar wrote:
>> On 30-03-16, 13:45, Viresh Kumar wrote:
>>> Multiple platforms are using the generic cpufreq-dt driver now, and all
>>> of them are required to create a platform device with name "cpufreq-dt",
>>> in order to get the cpufreq-dt probed.
>>>
>>> Many of them do it from platform code, others have special drivers just
>>> to do that.
>>>
>>> It would be more sensible to do this at a generic place, where all such
>>> platform can mark their entries.
>>>
>>> The first patch fixes an issue that came up with an earlier version of
>>> patch 2/4, but its still worth fixing it.  The second one creates a new
>>> driver to create platform-device based on current platform and the last
>>> two converts exynos platform to use this common infrastructure.
>>>
>>> I will migrate rest of the platforms after this is accepted as the right
>>> way ahead.
>>
>> @Matthew and @Mason,
>>
>> Now that this is present in linux-next, you guys can send patches for
>> your platforms cpufreq support.
>
> Present in linux-next means it will show up in 4.6-rc5?

No, it doesn't, in general.

Bug fixes may show up in -rcX, X > 1, but the majority of new material
in linux-next will show up in the next -rc1 (4.7-rc1 in this
particular case).
