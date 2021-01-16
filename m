Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4FFC433DB
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 18:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B7222510
	for <linux-pm@archiver.kernel.org>; Sat, 16 Jan 2021 18:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbhAPSGE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Jan 2021 13:06:04 -0500
Received: from fold.natur.cuni.cz ([195.113.57.32]:55528 "EHLO
        fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbhAPSGE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 16 Jan 2021 13:06:04 -0500
X-Greylist: delayed 3740 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2021 13:06:03 EST
Received: by fold.natur.cuni.cz (Postfix, from userid 1000)
        id 8578A10FC07B; Sat, 16 Jan 2021 16:39:11 +0100 (MET)
Date:   Sat, 16 Jan 2021 16:39:11 +0100
From:   Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
To:     nicolassaenzj@gmail.com, linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: 5.4.89: sbs-charger.c:undefined reference to __devm_regmap_init_i2c
Message-ID: <20210116153911.GA22392@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Julien,
  probably not your business these days but it seems building your 
driver fails now in linux-5.4.89 release. Would you mind checking this 
and contacting the right people?

ld -m elf_x86_64 -z max-page-size=0x200000 --build-id --strip-debug -o 
.tmp_vmlinux.kallsyms1 -T ./arch/x86/kernel/vmlinux.lds --whole-archive 
arch/x86/kernel/head_64.o arch/x86/kernel/head64.o 
arch/x86/kernel/ebda.o arch/x86/kernel/platform-quirks.o init/built-in.a 
usr/built-in.a arch/x86/built-in.a kernel/built-in.a certs/built-in.a 
mm/built-in.a fs/built-in.a ipc/built-in.a security/built-in.a 
crypto/built-in.a block/built-in.a lib/built-in.a 
arch/x86/lib/built-in.a drivers/built-in.a sound/built-in.a 
arch/x86/pci/built-in.a arch/x86/power/built-in.a 
arch/x86/video/built-in.a net/built-in.a virt/built-in.a 
--no-whole-archive --start-group lib/lib.a arch/x86/lib/lib.a 
--end-group
ld: drivers/power/supply/sbs-charger.o: in function `sbs_probe':
sbs-charger.c:(.text+0x1db): undefined reference to 
`__devm_regmap_init_i2c'


