Return-Path: <SRS0=8MB0=AT=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78678C433DF
	for <linux-pm@archiver.kernel.org>; Wed,  8 Jul 2020 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FA9E206E9
	for <linux-pm@archiver.kernel.org>; Wed,  8 Jul 2020 13:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgGHNmV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:42:21 -0400
Received: from foss.arm.com ([217.140.110.172]:41246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729450AbgGHNmR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Jul 2020 09:42:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564B01FB;
        Wed,  8 Jul 2020 06:42:16 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65CF03F237;
        Wed,  8 Jul 2020 06:42:14 -0700 (PDT)
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megous@megous.com>,
        Frank Lee <tiny.windzz@gmail.com>,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200708105527.868987-1-megous@megous.com>
 <CAEExFWvR4QnAQsXBnxk3V776P+YVJzs4PU-HWJ7dfo4B6cdtkg@mail.gmail.com>
 <20200708132124.3b3iaavms43o622g@core.my.home>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7f7843aa-def2-2bca-fbd4-ae20e4ebb020@arm.com>
Date:   Wed, 8 Jul 2020 14:42:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708132124.3b3iaavms43o622g@core.my.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-07-08 14:21, Ondřej Jirman wrote:
[...]
>>> @@ -523,10 +547,17 @@ static int sun8i_ths_probe(struct platform_device *pdev)
>>>          ret = devm_request_threaded_irq(dev, irq, NULL,
>>>                                          sun8i_irq_thread,
>>>                                          IRQF_ONESHOT, "ths", tmdev);
>>> -       if (ret)
>>> -               return ret;
>>> +       if (ret) {
>>> +               dev_err(dev, "Failed to request irq (%d)\n", ret);
>>> +               goto err_out;
>>> +       }
>>>
>>> +       dev_info(dev, "Thermal sensor ready!\n");
>>>          return 0;
>>> +
>>> +err_out:
>>> +       dev_err(dev, "Failed to probe thermal sensor (%d)\n", ret);
>>
>> When the driver fails, there will be this print. Isn't it superfluous
>> for you to add these？
>>
>> sun8i-thermal: probe of 5070400.thermal-sensor failed with error
> 
> There's no such failure message in the case I investigated, which is
> EPROBE_DEFER failure waiting for nvmem driver that never loads,
> because it's not configured by the user to build.

Ah, in that case this was a bit misleading, since "probe failure" isn't 
really the problem at all. As it happens, there's a whole other 
discussion ongoing around making probe deferral issues easier to debug:

https://lore.kernel.org/linux-arm-kernel/20200626100103.18879-1-a.hajda@samsung.com/

Robin.
