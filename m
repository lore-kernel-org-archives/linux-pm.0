Return-Path: <SRS0=+XkI=CE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60CC433E1
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 14:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E07422BEA
	for <linux-pm@archiver.kernel.org>; Wed, 26 Aug 2020 14:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgHZOp3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:45:29 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:49674 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726700AbgHZOp2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 10:45:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 325391822326E;
        Wed, 26 Aug 2020 14:45:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: owl38_5e0175327065
X-Filterd-Recvd-Size: 2293
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 14:45:25 +0000 (UTC)
Message-ID: <7b78e43a01865ec0c296ad9acad0616a6c2c3b86.camel@perches.com>
Subject: Re: [PATCH 29/29] tools: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Thomas Renninger <trenn@suse.com>,
        Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Wed, 26 Aug 2020 07:45:24 -0700
In-Reply-To: <6011591.XMClsHuqKX@c100>
References: <cover.1598331148.git.joe@perches.com>
         <52b68acfeb441b483de188f7e100600291f8c3ec.1598331149.git.joe@perches.com>
         <6011591.XMClsHuqKX@c100>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 2020-08-26 at 11:30 +0200, Thomas Renninger wrote:
> Hi,
> 
> getting rid of lines with multiple instructions, separated by comma is
> certainly a good idea.
> One nit pick, though:
> 
> Am Dienstag, 25. August 2020, 06:56:26 CEST schrieb Joe Perches:
> > Use semicolons and braces.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
[]
> I can remember patches being rejected with one line statements in a condition,
> surounded by braces.
> I just read up Documentation/process/coding-style.rst, to be sure this still is up-to-date.
> It's not a must, but line 180 says:
> "Do not unnecessarily use braces where a single statement will do."

Read the block immediately below that too:

"This does not apply if only one branch of a conditional statement is a
single statement; in the latter case use braces in both branches:"

> I haven't reviewed every line, but I expect you only split up comma separated instructions
> into separate lines and added braces?

I do not.

While there was a defect using this style though in another patch,
this is a style only change.

> Afaik there isn't a specific tag, but having:
> cleanup only: No functional change
> 
> in the changelog would be nice for people looking for fixes to backport.

This is not a fix, so it's not for backporting.


