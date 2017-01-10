From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 1/4] dmaengine: pl330: remove pdata based initialization
Date: Tue, 10 Jan 2017 07:55:27 +0100
Message-ID: <c12cb9e0-ce2f-662a-2b3b-12b4a2209b74@samsung.com>
References: <1483970598-6191-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170109140325eucas1p2674704b2505517ee532284c58c8a64d1@eucas1p2.samsung.com>
 <1483970598-6191-2-git-send-email-m.szyprowski@samsung.com>
 <20170109181511.37da3mslzdiq4uhr@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:44578 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbdAJGzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 01:55:35 -0500
In-reply-to: <20170109181511.37da3mslzdiq4uhr@kozik-lap>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Vinod Koul <vinod.koul@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Inki Dae <inki.dae@samsung.com>

Hi Krzysztof,


On 2017-01-09 19:15, Krzysztof Kozlowski wrote:
> On Mon, Jan 09, 2017 at 03:03:15PM +0100, Marek Szyprowski wrote:
>> This driver is now used only on platforms which support device tree, so
>> it is safe to remove legacy platform data based initialization code.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/dma/pl330.c        | 30 ++++++++----------------------
>>   include/linux/amba/pl330.h | 35 -----------------------------------
> Nope:
> $ git grep pl330.h
> arch/arm/plat-samsung/devs.c:#include <linux/amba/pl330.h>

Huh... This seems to be a leftover from a really old code, because pl330
devices have been removed from devs.c quite a long time ago. I will fix
this in v3.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

