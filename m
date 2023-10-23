Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C00C25B46
	for <linux-pm@archiver.kernel.org>; Mon, 23 Oct 2023 18:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjJWSWr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Oct 2023 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJWSWq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Oct 2023 14:22:46 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D69D8E
        for <linux-pm@vger.kernel.org>; Mon, 23 Oct 2023 11:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qaNUIV4EzPxTLqyfcMSiKwuDAGc/JwcBeOpWcvN4F/Q=; b=Q89omwMMhLPqRQyGpoMPAAJr4G
        AkEjvkyTvYkABv+XOz5TF6wHVQ5Du1gk2Ut2chg4jelgEz4CVXd5c5g9u1QJBQHX4dpj1kD3L6vIk
        Mw0v+caaenQt4f80fiKvXsUrUoRyzersCxThLHpYi4P2RKUPk8hE7T3R0vr9yYfPdjTnMZNwW+u1L
        fIlaeh0vT231SidUZ6ZtWKqGGiV8lx1H2usNXLruHrX9JWsDa0bD8TmijTqr8aUFBg2I4RNjt240Z
        HohqV5nweZBIXi8bNYZs2hvdopdtGP8d/oxu8MHW4IL8a4XxVR75HQ3qJwnXt8wAGgVthsKzpzOsu
        rgNjuBBw==;
Received: from [177.34.168.16] (helo=[192.168.0.8])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1quzZJ-005pgC-2t; Mon, 23 Oct 2023 20:22:25 +0200
Message-ID: <70993124-7bf3-33b4-c54e-912c7ddd6c3a@igalia.com>
Date:   Mon, 23 Oct 2023 15:22:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] pmdomain: bcm: bcm2835-power: check if the ASB register
 is equal to enable
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nick Alcock <nick.alcock@oracle.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Lee Jones <lee@kernel.org>, Melissa Wen <mwen@igalia.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel-dev@igalia.com
References: <20231023145004.284826-2-mcanal@igalia.com>
 <78770d2a-85c2-4347-a637-6781a5c44638@i2se.com>
From:   Maira Canal <mcanal@igalia.com>
In-Reply-To: <78770d2a-85c2-4347-a637-6781a5c44638@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Stefan,

On 10/23/23 15:14, Stefan Wahren wrote:
> Hi Maíra,
> 
> Am 23.10.23 um 16:49 schrieb Maíra Canal:
>> The commit c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
>> refactored the ASB control by using a general function to handle both
>> the enable and disable. But this patch introduced a subtle regression:
>> we need to check if (readl(base + reg) & ASB_ACK) == enable, not just
>> check if (readl(base + reg) & ASB_ACK) == true.
> 
> thanks for finding this regression
> 
>>
>> Currently, this is causing an invalid register state in V3D when
>> unloading and loading the driver, because `bcm2835_asb_disable()` will
>> return -ETIMEDOUT and `bcm2835_asb_power_off()` will fail to disable the
>> ASB slave for V3D.
>>
>> Fixes: c494a447c14e ("soc: bcm: bcm2835-power: Refactor ASB control")
>> Signed-off-by: Maíra Canal <mcanal@igalia.com>
>> ---
>>   drivers/pmdomain/bcm/bcm2835-power.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/bcm/bcm2835-power.c 
>> b/drivers/pmdomain/bcm/bcm2835-power.c
>> index 1a179d4e011c..2d3636bc277e 100644
>> --- a/drivers/pmdomain/bcm/bcm2835-power.c
>> +++ b/drivers/pmdomain/bcm/bcm2835-power.c
>> @@ -175,7 +175,7 @@ static int bcm2835_asb_control(struct 
>> bcm2835_power *power, u32 reg, bool enable
>>       }
>>       writel(PM_PASSWORD | val, base + reg);
>>
>> -    while (readl(base + reg) & ASB_ACK) {
>> +    while ((readl(base + reg) & ASB_ACK) == enable) {
> 
> but shouldn't it be:
> 
> while (!!(readl(base + reg) & ASB_ACK) == enable) ?

You're correct. Thanks for the correction! I'll send a v2.

Best Regards,
- Maíra

> 
>>           cpu_relax();
>>           if (ktime_get_ns() - start >= 1000)
>>               return -ETIMEDOUT;
>> -- 
>> 2.41.0
>>
