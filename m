Return-Path: <SRS0=oqst=5M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6976C2D0EC
	for <linux-pm@archiver.kernel.org>; Fri, 27 Mar 2020 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 926DB20658
	for <linux-pm@archiver.kernel.org>; Fri, 27 Mar 2020 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VgTMqvN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0Pjv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:39:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgC0Pjv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Mar 2020 11:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Glkd4Poyiz/H8tXZD3WNk7OjbV0plFdAnFSLYOWflAc=; b=VgTMqvN2GhS2F+72hyoHVuZIfX
        mhBVu6xa3IcAdST9Cl0/hifX2ny7hpNRkDFP8nXFXLJThYqqs7C+01rfd9ExVqdAxLZZxw5pTkWcA
        137UWX2ptUugqk3vk01Ftkd0r3JSRbor9iRK7rfMNvytND51qtx8uGRiLLxPmbBL3rfwGEfif8yDA
        cBOb20gEAU3/Iido5GZpPkMocn/q6Zz4jx9AZj/hEHoFKzSnLcEP2odZqjMdTGnjVEFoq1Regkck6
        7KYY3sJsBK9M8GdIcrKLr4nb1hma+xy1NHoKIi8EoRzUkDWfLHmVvbAN+g9p5xNPoWeQ/Pa9dx3kc
        mjp2goMQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHr5I-0006ZA-AP; Fri, 27 Mar 2020 15:39:48 +0000
Subject: Re: [PATCH] PM / sleep: Add pm_debug_messages boot command control
To:     Chen Yu <yu.c.chen@intel.com>, linux-pm@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200327111141.14324-1-yu.c.chen@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a9843786-e7da-2c3c-30e2-c4887e9af4c6@infradead.org>
Date:   Fri, 27 Mar 2020 08:39:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200327111141.14324-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 3/27/20 4:11 AM, Chen Yu wrote:
> Debug messages from the system suspend/hibernation infrastructure
> is disabled by default, and can only be enabled after the system
> has boot up via /sys/power/pm_debug_messages. This makes the hibernation
> resume hard to track as it involves system boot up across hibernation.
> There's no chance for software_resume() to track the resume process,
> eg.
> 
> Turning on the pm_debug_messages during boot up by appending
> 'pm_debug_message'.

Please add that command line option to
Documentation/admin-guide/kernel-parameters.txt.
Thanks.

> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/power/main.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 69b7a8aeca3b..1da3d7c15e03 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -535,6 +535,13 @@ static ssize_t pm_debug_messages_store(struct kobject *kobj,
>  
>  power_attr(pm_debug_messages);
>  
> +static int __init pm_debug_message_setup(char *str)
> +{
> +	pm_debug_messages_on = true;
> +	return 1;
> +}
> +__setup("pm_debug_message", pm_debug_message_setup);
> +
>  /**
>   * __pm_pr_dbg - Print a suspend debug message to the kernel log.
>   * @defer: Whether or not to use printk_deferred() to print the message.
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
