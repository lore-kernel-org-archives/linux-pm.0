From: Beomho Seo <beomho.seo@samsung.com>
Subject: Re: [PATCH v2 1/2] power: max17042_battery: Use reg type instead of
 chip type
Date: Mon, 06 Apr 2015 22:34:15 +0900
Message-ID: <55228B57.7@samsung.com>
References: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
 <1428049570-3295-2-git-send-email-beomho.seo@samsung.com>
 <CAJKOXPe9wRK-TYXkMbN0h6B6zWSTYJRvLy8Ji6vWLULxaRbreQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54184 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbbDFNeR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 09:34:17 -0400
In-reply-to: <CAJKOXPe9wRK-TYXkMbN0h6B6zWSTYJRvLy8Ji6vWLULxaRbreQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com

On 04/03/2015 06:01 PM, Krzysztof Kozlowski wrote:
> 2015-04-03 10:26 GMT+02:00 Beomho Seo <beomho.seo@samsung.com>:
>> Currently, max17042 battery driver choose register map by MAX17042_DevName
>> register. But it is return IC specific firmware version. So other maxim chip
>> hard to use this drvier. This patch choose chip type from driver_data.
>>
>> Cc: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
>> ---
>>  drivers/power/max17042_battery.c       |   33 ++++++++++----------------------
>>  include/linux/power/max17042_battery.h |    9 ++++++++-
>>  2 files changed, 18 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> 
> Best regards,
> Krzysztof
> 

Thanks Krzysztof for your reviews.

Sebastian, Could you please merge that your git tree?

Best regards
Beomho


