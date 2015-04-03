From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 1/2] power: max17042_battery: Use reg type instead of
 chip type
Date: Fri, 3 Apr 2015 11:01:05 +0200
Message-ID: <CAJKOXPe9wRK-TYXkMbN0h6B6zWSTYJRvLy8Ji6vWLULxaRbreQ@mail.gmail.com>
References: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
	<1428049570-3295-2-git-send-email-beomho.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33764 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbbDCJBG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 05:01:06 -0400
In-Reply-To: <1428049570-3295-2-git-send-email-beomho.seo@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Beomho Seo <beomho.seo@samsung.com>
Cc: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com, Krzysztof Kozlowski <k.kozlowski@samsung.com>

2015-04-03 10:26 GMT+02:00 Beomho Seo <beomho.seo@samsung.com>:
> Currently, max17042 battery driver choose register map by MAX17042_DevName
> register. But it is return IC specific firmware version. So other maxim chip
> hard to use this drvier. This patch choose chip type from driver_data.
>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
> ---
>  drivers/power/max17042_battery.c       |   33 ++++++++++----------------------
>  include/linux/power/max17042_battery.h |    9 ++++++++-
>  2 files changed, 18 insertions(+), 24 deletions(-)

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
