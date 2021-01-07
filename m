Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD58C433E0
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 21:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87A523441
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 21:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAGVaR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:30:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:56360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbhAGVaR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 16:30:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610054970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GQxhxEiTLYYGbnvSxxPcn+/4ZW3cUduLnF1gwGVD97k=;
        b=iYV2+oM6WGQZbwexMFiOR1I6V9bVHK/MPkf6RgMWkCpftdemE8/6BPFSC6gG2DBjDPL0nq
        cqrHn646iwKocPCO6Po5gczGAS2wzg1YqsDU2NhJvzZyZ/9qb9/QLfDfJfTMIGhfxphGPG
        +Uk0ORrU7JyDaJmPLHDyVfF91XlSOSk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53691ABC4;
        Thu,  7 Jan 2021 21:29:30 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Shuah Khan <shuah@kernel.org>, rafael@kernel.org
Subject: Re: [PATCH] cpupower: add Makefile dependencies for install targets
Date:   Thu, 07 Jan 2021 22:29:29 +0100
Message-ID: <2142020.VHZ5RWNYVy@c100>
In-Reply-To: <CABWYdi3yOYrLq_Zo2qrvFVZtwhbS85zWbt2+by0Fm6D3S17ZQw@mail.gmail.com>
References: <20210104235719.13525-1-ivan@cloudflare.com> <3977966.bfq5YHlNPR@c100> <CABWYdi3yOYrLq_Zo2qrvFVZtwhbS85zWbt2+by0Fm6D3S17ZQw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Donnerstag, 7. Januar 2021, 22:15:16 CET schrieb Ivan Babrou:
> On Thu, Jan 7, 2021 at 12:59 PM Thomas Renninger <trenn@suse.com> wrote:
> > Am Donnerstag, 7. Januar 2021, 18:42:25 CET schrieb Ivan Babrou:
> > > On Thu, Jan 7, 2021 at 2:07 AM Thomas Renninger <trenn@suse.com> wrote:
> > > > Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
> > > > > This allows building cpupower in parallel rather than serially.
...
> > Can you please show the make calls, ideally with a timing to better
> > understand and also to reproduce the advantages this patch introduces.
> > From what I can see, it only helps if one calls "sub-install" targets
> > directly?
> 
> That's exactly what we do: make install directly:
> 
> /linux-5.10.5$ make -C ./tools/power/cpupower DESTDIR=/tmp/cpupower
> install -j $(nproc)

This makes sense then.
@Shuah @Rafael: Can this patch be queued up, please.

Thanks for the patch and the details,

   Thomas


