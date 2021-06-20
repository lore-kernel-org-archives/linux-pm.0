Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6940C49361
	for <linux-pm@archiver.kernel.org>; Sun, 20 Jun 2021 17:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DDA6113C
	for <linux-pm@archiver.kernel.org>; Sun, 20 Jun 2021 17:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhFTRkp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 20 Jun 2021 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFTRko (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 20 Jun 2021 13:40:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79373C061574;
        Sun, 20 Jun 2021 10:38:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x24so26103271lfr.10;
        Sun, 20 Jun 2021 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kaK16V+8sfltARKt+U0s+B4owkbBJKvyexhynTlVxdg=;
        b=fh+KE9cHabfnsz6rrWdKT/sUDajbINDvtXsyIMeLQ6bjedszP0Ued7d1VAH8MrCPRx
         4YCoKIZlGA82wAh+7e4w1EzbcTXFXUxsglruKYMZoMx4k01h5eXQ3f84J+Qo6/nvpdXH
         EOUdqzMjBQYSSMn+a/kOa1siHiywjEj8R+YjJf7pIMKJ9b5IoDnr2Y264XYWcixJvkOO
         nKSG6XeSadsDuux0XyHK4PWSwJQUOSCoGCOqF7Rd3kxAO5yvn6Zv6P+wsow/TugA6MYr
         R/HJLTst1xPpWXwiI0HKTQjc8uFjNsP6umG2q7EmeVi3UKy+QzLFBG7kdlVw1mWfWOgT
         faSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kaK16V+8sfltARKt+U0s+B4owkbBJKvyexhynTlVxdg=;
        b=hY7bBC0Afkj9+y21AnY+XbSYjHZCBftgtMGtahhAGR3Jd8zy5e+jEUsU7Z8WYTxFgC
         vLNSGh99JBwPxGDbGK27Ge1rhJwZYzosgRX04pnXV3HmfSo3QzEf48jZLwYRkK5/VeAP
         iQnko9AhnQglpWNnJPVOZ/ntg7V8625+TEeACH+gVp3+5PnELuhcAAUXOwtDGP5OPUqg
         AvVCgxhn/ZBAGXDx6feIhXTKksuqHwwfgLxaWrWlleLs5Yw6v2VSqbCHTqnFHOKQshl9
         +4X+CgzkiFjbL+hE6rWoTYSiNqOQ4lY+Hp9ePmlpx57lEiAPeDEmVxieEkPhKo/6lB1F
         OEnA==
X-Gm-Message-State: AOAM531ZjX0Qi6RvwHavAhgEkZ9yZbsQSakyrPQHXxVaFq2TGUsx0HDE
        IMqZwv+Ys+JrQGFwSfDJajLpAVI8W0k=
X-Google-Smtp-Source: ABdhPJwaM5yDWdPPx/bodV10H9hbDm3GL3pZINV9aC76mIHNOOE6De6CFVoignonzgdUMJgrZyBNHQ==
X-Received: by 2002:a05:6512:1103:: with SMTP id l3mr2286212lfg.526.1624210708714;
        Sun, 20 Jun 2021 10:38:28 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id b15sm970960lff.275.2021.06.20.10.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Jun 2021 10:38:28 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] hwmon: Support set_trips() of thermal device ops
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20210620161223.16844-1-digetx@gmail.com>
 <20210620161223.16844-2-digetx@gmail.com>
 <20210620172329.GA3850372@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1cb97f70-9fdd-e7d5-da73-dc5c42a53104@gmail.com>
Date:   Sun, 20 Jun 2021 20:38:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210620172329.GA3850372@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

20.06.2021 20:23, Guenter Roeck пишет:
> On Sun, Jun 20, 2021 at 07:12:22PM +0300, Dmitry Osipenko wrote:
>> Support set_trips() callback of thermal device ops. This allows HWMON
>> device to operatively notify thermal core about temperature changes, which
>> is very handy to have in a case where HWMON sensor is used by CPU thermal
>> zone that performs passive cooling and emergency shutdown on overheat.
>> Thermal core will be able to react faster to temperature changes.
>>
> 
> Why would this require a driver callback, and why can it not be handled
> in the hwmon core alone ? The hwmon core could register a set_trip function
> if the chip (driver) supports setting low and high limits, and it could
> call the appropriate driver functions when hwmon_thermal_set_trips()
> is called.

I wasn't sure about what other hwmon drivers may need and want to do for
programming of the trips, so decided to start with this variant. I'll
prepare v2 since you're suggesting that the universal callback should
work okay for all drivers, thanks.
