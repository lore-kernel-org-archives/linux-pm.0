Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ABCC2B9F4
	for <linux-pm@archiver.kernel.org>; Sat, 19 Jun 2021 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108A46117A
	for <linux-pm@archiver.kernel.org>; Sat, 19 Jun 2021 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFSJy5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 19 Jun 2021 05:54:57 -0400
Received: from mail.manjaro.org ([176.9.38.148]:33016 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229477AbhFSJy4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 19 Jun 2021 05:54:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id 0BF153FA0488;
        Sat, 19 Jun 2021 11:52:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SbkbecczGtEy; Sat, 19 Jun 2021 11:52:37 +0200 (CEST)
Subject: Re: [PATCH] power: supply: cw2015: Add CHARGE_NOW support
To:     Paul Fertser <fercerpav@gmail.com>,
        Martin Ashby <martin@ashbysoft.com>
Cc:     t.schramm@manjaro.org, linux-pm@vger.kernel.org
References: <20210218124250.128008-1-martin@ashbysoft.com>
 <20210618123017.GA10695@home.paul.comp>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <8390c743-e4a4-bf1d-457e-2bfdcf9143d2@manjaro.org>
Date:   Sat, 19 Jun 2021 11:52:34 +0200
MIME-Version: 1.0
In-Reply-To: <20210618123017.GA10695@home.paul.comp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

Am 18.06.21 um 14:30 schrieb Paul Fertser:
...
> 
> Are you sure the chip reports current state of charge relative to the
> full design capacity rather than to the latest auto-calibrated full
> capacity? That would mean that over time as the cells wear out
> cw_bat->soc (PROP_CAPACITY) is never going to be reaching 100; does
> this match your experience?
> 
As far as I'm aware the gauge reports SoC relative to what it believes 
to be the the current, auto-calibrated full battery capacity.
However, since I don't know how to extract that value from the gauge we 
just always assume it to be the design capacity [1].
Since we inquire the gauge about current SoC directly [2] there is no 
way for any miscalculation on our end preventing it from reaching 100%.

Cheers,
Tobias

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/cw2015_battery.c#n507

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/power/supply/cw2015_battery.c#n368
