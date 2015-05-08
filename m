From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v7 1/5] PM / Domains: prepare for multiple states
Date: Fri, 8 May 2015 09:36:43 +0900
Message-ID: <CAJKOXPdi3qjgEERM8PmN6Rb-9xGa6V5RW_3zKpnnCECzwmmUbQ@mail.gmail.com>
References: <1430391335-7588-1-git-send-email-ahaslam@baylibre.com>
	<1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vn0-f52.google.com ([209.85.216.52]:37982 "EHLO
	mail-vn0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbbEHAgo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 20:36:44 -0400
Received: by vnbf1 with SMTP id f1so4393586vnb.5
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2015 17:36:43 -0700 (PDT)
In-Reply-To: <1430391335-7588-2-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ahaslam@baylibre.com
Cc: ulf.hansson@linaro.org, khilman@linaro.org, geert@linux-m68k.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>

2015-04-30 19:55 GMT+09:00  <ahaslam@baylibre.com>:
> From: Axel Haslam <ahaslam+renesas@baylibre.com>
>
> prepare generic power domain init function parameters
> to accept a pointer to the states structure that describes
> the possible states that a power domain can enter.
>
> There is no functional change, as support for multiple
> domains will be added in subsequent patches.
>
> Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
> ---
>  arch/arm/mach-exynos/pm_domains.c   |  2 +-

For Exynos:
Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

However could you fix up your GIT or email app? It is wrapping lines
in commit message around ~55 character making the message unreadable.
Just use default value of 75 characters (gui.commitmsgwidth?).

Best regards,
Krzysztof
