Return-Path: <SRS0=SyNq=5O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BAC43331
	for <linux-pm@archiver.kernel.org>; Sun, 29 Mar 2020 10:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54402073B
	for <linux-pm@archiver.kernel.org>; Sun, 29 Mar 2020 10:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC2KYL (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 29 Mar 2020 06:24:11 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48772 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KYK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Mar 2020 06:24:10 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: rcn)
        with ESMTPSA id 1BE112612F5
Message-ID: <e69c39e6d86fb4e9fe560a20485158e7aa7d80cf.camel@collabora.com>
Subject: Re: [PATCH] i2c: enable async suspend/resume on i2c devices
From:   Ricardo =?ISO-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>
To:     "dbasehore ." <dbasehore@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>
Date:   Sun, 29 Mar 2020 12:24:05 +0200
In-Reply-To: <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
References: <20200327151951.18111-1-ricardo.canuelo@collabora.com>
         <20200327154345.GA3971@ninjato>
         <CAGAzgsqJznZi83ijxCgQg463Q4AnwiNX-a0Q9+Og9MW5OJ4Vew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2020-03-27 at 13:26 -0700, dbasehore . wrote:
> 
> Enabling async is a confirmation that all dependencies to other
> devices are properly tracked, whether through the parent/child
> relationship or otherwise.

Thanks for the info, Derek.

Wouldn't it be risky then to enable async for all i2c client devices
indiscriminately? Or is it safe to assume that all i2c devices will be
idependent from each other?

Cheers,
Ricardo

