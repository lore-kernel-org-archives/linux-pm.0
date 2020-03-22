Return-Path: <SRS0=sUMx=5H=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2646BC4332D
	for <linux-pm@archiver.kernel.org>; Sun, 22 Mar 2020 00:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0B620782
	for <linux-pm@archiver.kernel.org>; Sun, 22 Mar 2020 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQWBdTR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgCVAdu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:33:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42311 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCVAdt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 Mar 2020 20:33:49 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so4217759plz.9;
        Sat, 21 Mar 2020 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7vtokbDa+jk1IkonfP+8mmd2hW8UtwtfycemouqpA58=;
        b=oQWBdTR+X3bLAxH7mWuUmReG4nhWYPsCJk2Z1KIJm8pHRtvh5jWm8LCHAns4W69yk3
         qlDuhUFe3djichyEuX9Ap/QLBV5CVQRsLqUu+r85O55n+4zAX0S1jBw7IsdEOkdtMr4F
         kp9bsXMnc96iuLEWbEvLltzdHxqS/076V7mHJ9xJvlNyX3aWK0x7J78P25xCuPWtRYxM
         kGDJt+EHiU2gafP0Ig+PBTjbXLA6pa8KH0e44VjPBbwv4VGtvLHe5MgJ2RcpIqHeod84
         uiHS5dbbANbeSkyVUs9t1zVZCkWZb+x4q3iJrhWWAiCGFV1CJoPgiqFMLG5Hg3gTqtz1
         BVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7vtokbDa+jk1IkonfP+8mmd2hW8UtwtfycemouqpA58=;
        b=mffB+HxHew0JD5W+DdztyLL2xSKTqTAxwaVMBqgC1n5i78NYeDMdPMbAkazpZFT17A
         K3nnU/ZgC5nM6tNx9jlnypz4+EXudSQWB60nlMetty9qdQd+5zZo7HOUQgVlJwsU6OJc
         Myk/zXAMHlBs6bz3DiQ2nisgtD086QtmEjiGrlf2G3EdhYRfOmemP9cta9O0vjvr77dy
         vBgerx0hIMjGF/B5edeRXofi86V/UJ8ne24gCfWlqePfFK3ASFhPETsK1h6FGuxVJIhU
         UaEsTJWcAV0aIWVpEV2xMMTywR7dc4W1wuZwcVjKxQvCcIHzkN7e+mqxCLG+GPpfvvef
         tdwQ==
X-Gm-Message-State: ANhLgQ37M/iCo0C/r8c+9ans7fu+5bSpcljLgTyfg2yJpMZza0vtV2fy
        uzdZPC3xIDmITfLy3XZlMwDO7exqHRdTBKla8Cs=
X-Google-Smtp-Source: ADFU+vvlcJsq0qZwh0rRxotLSFhizYNl6shFx+yGRqYpgQ8SRvchb+bxeEDw1Oq6Rs+N8EMqUfFLnYu3LLSHHpRN/nc=
X-Received: by 2002:a17:902:8d92:: with SMTP id v18mr15819898plo.18.1584837228226;
 Sat, 21 Mar 2020 17:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200318153434.62833-1-michael.auchter@ni.com> <20200318153434.62833-2-michael.auchter@ni.com>
In-Reply-To: <20200318153434.62833-2-michael.auchter@ni.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 22 Mar 2020 02:33:37 +0200
Message-ID: <CAHp75VdJ-rUGsuMi=ufLrFs9Tj5fsbqPcqJSypHBx6SuPZWD7g@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: dac: ad5686: add of_match_table
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 18, 2020 at 5:56 PM Michael Auchter <michael.auchter@ni.com> wrote:
>
> Add of_match_table to this driver, so devices can be probed based on
> device tree contents.

> +               .of_match_table = of_match_ptr(ad5686_of_match),

There is no need to use of_match_ptr().
Didn't you get a compiler warning for !OF case?

-- 
With Best Regards,
Andy Shevchenko
