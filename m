From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] power: bq27xxx_battery: Fix bq27541 AveragePower register address
Date: Wed, 6 Jan 2016 15:49:09 +0900
Message-ID: <CAJKOXPdUrRzuUUc1AaV6cSX3WbVCqUaA+oGn2REG_pYnraVEZg@mail.gmail.com>
References: <OF8219B649.7DD7FCA2-ON48257F32.0023C1E9-48257F32.00245EFF@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:32915 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbcAFGtJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2016 01:49:09 -0500
Received: by mail-ig0-f173.google.com with SMTP id z14so22877453igp.0
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2016 22:49:09 -0800 (PST)
In-Reply-To: <OF8219B649.7DD7FCA2-ON48257F32.0023C1E9-48257F32.00245EFF@zte.com.cn>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: liu.xiang6@zte.com.cn
Cc: linux-pm@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org

2016-01-06 15:37 GMT+09:00 <liu.xiang6@zte.com.cn>:
>
> From 410671019563323b8947a25e4cf429c41e982683 Mon Sep 17 00:00:00 2001
> Message-Id:
> <410671019563323b8947a25e4cf429c41e982683.1452047614.git.liu.xiang6@zte.com.cn>
> From: Liu Xiang <liu.xiang6@zte.com.cn>
> Date: Wed, 6 Jan 2016 10:28:27 +0800
> Subject: [PATCH] power: bq27xxx_battery: Fix bq27541 AveragePower register
>  address
>
> Currently in bq27541 driver, the average power register address is
> incorrectly set to 0x76, which would result in an error:
> bq27xxx-battery 2-0055: error reading average power register  10: -11
> According to the bq27541 datasheet, fix this problem by setting
> the average power register address to 0x24.
>
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>

Hi,

Thanks for sharing the patch!

You are sending this patch for 3rd time I think. Please version it -
both in subject and with a changelog describing changes put after
separator '---'.

I see that you removed the confidential disclaimer and reviewed-by tag
which was not given out in a public way - good!
However the patch still has some unusual stuff added - the headers.
Usually they are not needed. Just use git and:
$ git format-patch -1 -v3
$ scripts/get_maintainers.pl v3-0001*
$ git send-email --to/cc ... v3-0001*

Best regards,
Krzysztof
