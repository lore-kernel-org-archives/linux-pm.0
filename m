Return-Path: <SRS0=HpL5=3C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E89CC33CA9
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BB22075B
	for <linux-pm@archiver.kernel.org>; Mon, 13 Jan 2020 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMRQJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 13 Jan 2020 12:16:09 -0500
Received: from mail.sig21.net ([80.244.240.74]:47663 "EHLO mail.sig21.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727222AbgAMRQJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 12:16:09 -0500
Received: from localhorst ([127.0.0.1])
         by mail.sig21.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
         (Exim 4.84_2)
        (envelope-from <js@sig21.net>)
         id 1ir3Jr-0000RI-4D ; Mon, 13 Jan 2020 18:16:04 +0100
Received: from js by abc.local with local (Exim 4.93)
        (envelope-from <js@sig21.net>)
        id 1ir3Jl-0002EN-NE; Mon, 13 Jan 2020 18:15:57 +0100
Date:   Mon, 13 Jan 2020 18:15:57 +0100
From:   Johannes Stezenbach <js@sig21.net>
To:     Alexander Potapenko <glider@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.cz>, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: init_on_free breaks hibernate
Message-ID: <20200113171557.GA8544@sig21.net>
References: <20191223211309.GA4609@sig21.net>
 <20200113092604.GA26365@sig21.net>
 <CAG_fn=WSUGq_UZZOCQRbaKDE01yA6dLLqToOBWZ=0s5uxMwatw@mail.gmail.com>
 <CAG_fn=V0nTqsFxYAuH0K3cJxx3nWitG50VkYOQ8MHNO+H8hfKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=V0nTqsFxYAuH0K3cJxx3nWitG50VkYOQ8MHNO+H8hfKQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 04:41:27PM +0100, Alexander Potapenko wrote:
> > Resuming doesn't work for me in your setup with upstream kernel and
> > init_on_alloc/init_on_free disabled.
> > To hibernate, I did:
> 
> Ok, I've managed to resume by running QEMU with -append "... resume=/dev/vda".

Strange about the resume=/dev/vda, it worked for me the way I described it.
Maybe device numbers are dynamic, 254:0 is what I got from ls -l /dev/vda.

> The memory corruption is also reproducible for me, taking a look.

Great!

Johannes
