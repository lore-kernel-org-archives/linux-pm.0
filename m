From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Mon, 11 May 2015 10:23:14 +0200
Message-ID: <CAKXjFTNaUYV9KGSz-gnsKkG=6oLOQo8i=dyvs5NYh=-pPuJdWw@mail.gmail.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
	<1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
	<CAJKOXPdi3qjgEERM8PmN6Rb-9xGa6V5RW_3zKpnnCECzwmmUbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34265 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbEKIXP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 04:23:15 -0400
Received: by oiko83 with SMTP id o83so98815306oik.1
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2015 01:23:14 -0700 (PDT)
In-Reply-To: <CAJKOXPdi3qjgEERM8PmN6Rb-9xGa6V5RW_3zKpnnCECzwmmUbQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Benoit Cousson <bcousson@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Axel Haslam <ahaslam+renesas@baylibre.com>

Hi Krzysztof,

On Fri, May 8, 2015 at 2:36 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-04-30 19:55 GMT+09:00  <ahaslam@baylibre.com>:
>> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>>
>> prepare generic power domain init function parameters
>> to accept a pointer to the states structure that describes
>> the possible states that a power domain can enter.
>>
>> There is no functional change, as support for multiple
>> domains will be added in subsequent patches.
>>
>> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
>> ---
>>  arch/arm/mach-exynos/pm_domains.c   |  2 +-
>
> For Exynos:
> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> However could you fix up your GIT or email app? It is wrapping lines
> in commit message around ~55 character making the message unreadable.
> Just use default value of 75 characters (gui.commitmsgwidth?).

Ok, ill change the message width in the next series,
ill wait for acks or comments to the rest of the patches
before sending it.

Regards,
Axel.

>
> Best regards,
> Krzysztof
