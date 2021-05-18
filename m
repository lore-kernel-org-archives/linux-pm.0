Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0467FC433B4
	for <linux-pm@archiver.kernel.org>; Tue, 18 May 2021 22:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E576135F
	for <linux-pm@archiver.kernel.org>; Tue, 18 May 2021 22:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352705AbhERWUl (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 18 May 2021 18:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236372AbhERWUj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 18:20:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF94C061573
        for <linux-pm@vger.kernel.org>; Tue, 18 May 2021 15:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=kKpVrcH8m/qcb7y9jFL3p1+FSHqYM3RzVk7yiT1GOXo=; b=3RmMNVyOqlbLKcUTM507gf6/UJ
        +GcAbYsm8vfUJvqdfwDgxQE0xUaLJ2+K8holQQXI4QTcQQFeACiOF28wn/mVD+5rIUvQqELNn1Tp4
        i62BBcA+W5r49kiTvOGSY0clZ7zicq/EFqJst9NmvwD45xydNVjzyrPiGfq7jdzcHkivMLvuqx2gv
        D5Y7VIjNmWx1CCWJURKrWf+JSfb4fsJWMLeoGRM1gvx6PcB2rqcVI1lDPXQRNrx5dWfHcxtVAuMRS
        pDdfUjv9jKd/t0pb5Ltt4J9b5pPCbLMRvD2onDV1+MkVozAHyaowKzABVsVZ7E7lXyKsk228Se9P9
        yaZIfqBQ==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lj83b-00EzwH-1E; Tue, 18 May 2021 22:19:19 +0000
Subject: Re: [PATCH] cpufreq: sc520_freq: add 'fallthrough' to one case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
References: <20210503161840.26771-1-rdunlap@infradead.org>
 <20210504062245.hfn7n7ghm27oxehx@vireshk-i7>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <23673b12-6e46-f511-e326-d6f5342b0013@infradead.org>
Date:   Tue, 18 May 2021 15:19:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504062245.hfn7n7ghm27oxehx@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 5/3/21 11:22 PM, Viresh Kumar wrote:
> On 03-05-21, 09:18, Randy Dunlap wrote:
>> Quieten an implicit-fallthrough warning in sc520_freq.c:
>>
>> ../drivers/cpufreq/sc520_freq.c: In function 'sc520_freq_get_cpu_frequency':
>> ../include/linux/printk.h:343:2: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>> ../drivers/cpufreq/sc520_freq.c:43:3: note: in expansion of macro 'pr_err'
>>    pr_err("error: cpuctl register has unexpected value %02x\n",
>> ../drivers/cpufreq/sc520_freq.c:45:2: note: here
>>   case 0x01:
>>
>> Fixes: bf6fc9fd2d848 ("[CPUFREQ] AMD Elan SC520 cpufreq driver.")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> ---
>> Found in linux-next but applies to mainline.
>>
>>  drivers/cpufreq/sc520_freq.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20210503.orig/drivers/cpufreq/sc520_freq.c
>> +++ linux-next-20210503/drivers/cpufreq/sc520_freq.c
>> @@ -42,6 +42,7 @@ static unsigned int sc520_freq_get_cpu_f
>>  	default:
>>  		pr_err("error: cpuctl register has unexpected value %02x\n",
>>  		       clockspeed_reg);
>> +		fallthrough;
>>  	case 0x01:
>>  		return 100000;
>>  	case 0x02:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Rafael, ping?

thanks.
-- 
~Randy

