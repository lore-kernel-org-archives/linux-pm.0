Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53643C433E0
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 21:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A37235DD
	for <linux-pm@archiver.kernel.org>; Thu,  7 Jan 2021 21:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAGVAk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 Jan 2021 16:00:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:36660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbhAGVAj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 7 Jan 2021 16:00:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610053193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8J94mEYDJ9t7cE82ktpH+FoNOTHk/H6HpofiDUP5IZA=;
        b=FwIDkeE5hZIIT2JLvgKIReJ9rJH+7K6iznOQbBIUyvE/is7Dl+20UNHRsOY6u1LQcL8EJJ
        ka231/nxIYZBaAV9JXa4c+Wu7y5D4UrF6BjAY6QPm8fgH+Yzg1UUd6C0kBd324wonXz7lM
        rNTIiXJh7NUJBlpqU10pf/URBff86HA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 006D5ABC4;
        Thu,  7 Jan 2021 20:59:52 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-pm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] cpupower: add Makefile dependencies for install targets
Date:   Thu, 07 Jan 2021 21:59:51 +0100
Message-ID: <3977966.bfq5YHlNPR@c100>
In-Reply-To: <CABWYdi0sne=6reP5oZMFbYk9Nctws=FLoYkjdmnBwXu0bVFozA@mail.gmail.com>
References: <20210104235719.13525-1-ivan@cloudflare.com> <2100533.HVZEckHxcR@c100> <CABWYdi0sne=6reP5oZMFbYk9Nctws=FLoYkjdmnBwXu0bVFozA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Donnerstag, 7. Januar 2021, 18:42:25 CET schrieb Ivan Babrou:
> On Thu, Jan 7, 2021 at 2:07 AM Thomas Renninger <trenn@suse.com> wrote:
> > Am Dienstag, 5. Januar 2021, 00:57:18 CET schrieb Ivan Babrou:
> > > This allows building cpupower in parallel rather than serially.
> > 
> > cpupower is built serially:
> > 
> > [ make clean ]
> > 
> > time make
> > real    0m3,742s
> > user    0m3,330s
> > sys     0m1,105s
> > 
> > [ make clean ]
> > 
> > time make -j10
> > real    0m1,045s
> > user    0m3,153s
> > sys     0m1,037s
> > 
> > Only advantage I see is that you can call
> > make install-xy
> > targets without calling the corresponding build target
> > make xy
> > similar to the general install target:
> > install: all install-lib ...
> > 
> > Not sure anyone needs this and whether all targets
> > successfully work this way.
> > If you'd show a useful usecase example...
> 
> We build a bunch of kernel related tools (perf, cpupower, bpftool,
> etc.) from our own top level Makefile, propagating parallelism
> downwards like one should.
I still do not understand why you do not simply build:
Also if I call this from /tools directory I get a quick build:
make -j20 cpupower

Can you please show the make calls, ideally with a timing to better understand
and also to reproduce the advantages this patch introduces.
From what I can see, it only helps if one calls "sub-install" targets 
directly?
And I still do not understand why things should be more parallel now.

> Without this patch we have to remove parallelism for cpupower,
Why?

> which doesn't seem like a very clean thing
> to do, especially if you consider that it's 3x faster with parallelism
> enabled in wall clock terms.
Sure, you want to build in parallel. I still do not understand how this
patch helps in this regard.

BTW, I recently had a bunch of userspace tools Makefile patches.
I'd like to add you to CC for a review if they are not submitted already.

    Thomas


