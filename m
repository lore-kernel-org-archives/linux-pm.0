Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58723C433E0
	for <linux-pm@archiver.kernel.org>; Sun, 17 Jan 2021 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D35229EF
	for <linux-pm@archiver.kernel.org>; Sun, 17 Jan 2021 09:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbhAQJuj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 17 Jan 2021 04:50:39 -0500
Received: from fold.natur.cuni.cz ([195.113.57.32]:58736 "EHLO
        fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbhAQJuf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Jan 2021 04:50:35 -0500
Received: from [192.168.251.4] (unknown [192.168.251.4])
        by fold.natur.cuni.cz (Postfix) with ESMTP id 7C1C710FC07A;
        Sun, 17 Jan 2021 10:49:50 +0100 (MET)
Subject: Re: 5.4.89: sbs-charger.c:undefined reference to
 __devm_regmap_init_i2c
To:     Randy Dunlap <rdunlap@infradead.org>, nicolassaenzj@gmail.com,
        linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210116153911.GA22392@fold.natur.cuni.cz>
 <a7c5bf4c-4bab-07ea-b76b-3b0f54a44620@infradead.org>
From:   Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Message-ID: <cb0bbc04-9f92-abce-be9c-c7c6e3047e1b@fold.natur.cuni.cz>
Date:   Sun, 17 Jan 2021 10:49:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a7c5bf4c-4bab-07ea-b76b-3b0f54a44620@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/01/2021 22:16, Randy Dunlap wrote:
> On 1/16/21 7:39 AM, Martin Mokrejs wrote:
>> Hi Julien,
>>   probably not your business these days but it seems building your 
>> driver fails now in linux-5.4.89 release. Would you mind checking this 
>> and contacting the right people?
>>
>> ld -m elf_x86_64 -z max-page-size=0x200000 --build-id --strip-debug -o 
>> .tmp_vmlinux.kallsyms1 -T ./arch/x86/kernel/vmlinux.lds --whole-archive 
>> arch/x86/kernel/head_64.o arch/x86/kernel/head64.o 
>> arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o init/built-in.a 
>> usr/built-in.a arch/x86/built-in.a kernel/built-in.a certs/built-in.a 
>> mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a 
>> crypto/built-in.a block/built-in.a lib/built-in.a 
>> arch/x86/lib/built-in.a drivers/built-in.a sound/built-in.a 
>> arch/x86/pci/built-in.a arch/x86/power/built-in.a 
>> arch/x86/video/built-in.a net/built-in.a virt/built-in.a 
>> --no-whole-archive --start-group lib/lib.a arch/x86/lib/lib.a 
>> --end-group
>> ld: drivers/power/supply/sbs-charger.o: in function `sbs_probe':
>> sbs-charger.c:(.text+0x1db): undefined reference to 
>> `__devm_regmap_init_i2c'
> 
> I just sent a patch for this:
> 
> https://lore.kernel.org/linux-pm/20210116211310.19232-1-rdunlap@infradead.org/

Excellent, works for me now.
