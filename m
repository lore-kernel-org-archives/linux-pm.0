Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB82C43334
	for <linux-pm@archiver.kernel.org>; Thu, 23 Jun 2022 10:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiFWKjl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 23 Jun 2022 06:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiFWKjh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2022 06:39:37 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A83153F
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2022 03:39:36 -0700 (PDT)
Received: from fsav113.sakura.ne.jp (fsav113.sakura.ne.jp [27.133.134.240])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 25NAdSvb065733;
        Thu, 23 Jun 2022 19:39:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav113.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp);
 Thu, 23 Jun 2022 19:39:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav113.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 25NAdRIL065728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Jun 2022 19:39:28 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e2eb6f36-3660-26fc-4aca-b1412affbf7c@I-love.SAKURA.ne.jp>
Date:   Thu, 23 Jun 2022 19:39:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] power: ab8500: Remove flush_scheduled_work() call.
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>
References: <50d84193-a933-1301-b9d9-bf6cc01ee126@I-love.SAKURA.ne.jp>
 <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20220609194329.bkvnxmxovnbqxuxg@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Linus, is this patch OK?

On 2022/06/10 4:43, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Jun 09, 2022 at 01:58:04PM +0900, Tetsuo Handa wrote:
>> It seems to me that ab8500 driver is using dedicated workqueues and
>> is not calling schedule{,_delayed}_work{,_on}(). Then, there will be
>> no work to flush using flush_scheduled_work().
>>
>> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
>> ---
>> Please see commit c4f135d643823a86 ("workqueue: Wrap flush_workqueue()
>> using a macro") for background.
> 
> Looks sensible to me. Adding Linus to Cc and waiting a bit so that
> he has time to review/test.
> 
> @Linus I think it makes sense to add something like this to
> MAINTAINERS or add the files to the "ARM/NOMADIK/Ux500 ARCHITECTURES"
> entry, so that you will be CC'd.
> 
> AB8500 BATTERY AND CHARGER DRIVERS
> M:	Linus Walleij <linus.walleij@linaro.org>
> S:	Maintained
> F:	Documentation/devicetree/bindings/power/supply/*ab8500*
> F:	Documentation/devicetree/bindings/power/supply/*ab8500*
> 
> -- Sebastian
> 
>>  drivers/power/supply/ab8500_btemp.c    | 1 -
>>  drivers/power/supply/ab8500_chargalg.c | 1 -
>>  drivers/power/supply/ab8500_charger.c  | 2 --
>>  drivers/power/supply/ab8500_fg.c       | 1 -
>>  4 files changed, 5 deletions(-)
>>
