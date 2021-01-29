Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8DDC433E0
	for <linux-pm@archiver.kernel.org>; Fri, 29 Jan 2021 18:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AB364E0A
	for <linux-pm@archiver.kernel.org>; Fri, 29 Jan 2021 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhA2SQP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 29 Jan 2021 13:16:15 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42100 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhA2SQP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Jan 2021 13:16:15 -0500
Received: from 89-64-81-181.dynamic.chello.pl (89.64.81.181) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id f3c8eb199e2c59a8; Fri, 29 Jan 2021 19:15:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
Date:   Fri, 29 Jan 2021 19:15:21 +0100
Message-ID: <27811913.MA2oZiD3rT@kreacher>
In-Reply-To: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
References: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com> <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, January 29, 2021 7:13:14 PM CET Linus Torvalds wrote:
> On Fri, Jan 29, 2021 at 10:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > [Resending, because it hasn't made it to the mailing lists, not sure why.]
> 
> I see it, and I see the cc to the list, so it is likely something
> about the list being slow or subtly broken.
> 
> There was another pull request a couple of days ago that apparently
> had the same problem (and didn't get a pr-tracker-bot reply due to
> it). I forget which one.

Thanks for letting me know, much appreciated!

Rafael



