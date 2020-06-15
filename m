Return-Path: <SRS0=4Bgw=74=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7EC433DF
	for <linux-pm@archiver.kernel.org>; Mon, 15 Jun 2020 12:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCB120739
	for <linux-pm@archiver.kernel.org>; Mon, 15 Jun 2020 12:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKfY5RcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgFOMqv (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOMqu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 08:46:50 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F380DC061A0E;
        Mon, 15 Jun 2020 05:46:49 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id p5so15112220ile.6;
        Mon, 15 Jun 2020 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ex4ahxPfnRJtHhHWkEbgHyzFGza84a5R1pjXHVBwv1k=;
        b=qKfY5RcZwunYOBi349HPaH9pICMNxGTeYVJuxlg2OASzshTxktOUuR2xF4VOxC+gPh
         /m6dq5sc5Zq6O9NEbWCvAuasEFmQUvbH+z36wkqubUp+gJ7qQkatmsqJhbE5j0ETipu6
         oxMEy6xor4+CfJZXMtsT+BIR/6iVSk6EYbBAoq1SVtmUJyj61610y5a1sULkMdxWnKDv
         +mjIRlj519zIpp2eNy3kqE/t/28gLV8iqkjXml8KnpSgTkgGRT/hEy938A8SdKMvDdBN
         DKWdA5hwlb4r2IOpBjsYa80zrdpp4UJ8hBAAUjdryK1VjIj++blPq6733ZB6oNLJFLCa
         yE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ex4ahxPfnRJtHhHWkEbgHyzFGza84a5R1pjXHVBwv1k=;
        b=boSdQhD/R1FMZi91wCOBLb9EJeOzTAHknzWpGP7dMU3Hx7cHdKUZ5Uz2YiF72mu0c7
         cG1kVmpvf6umFtzffGj6h2srFy+mQqI6ejnH75OvGUCdvX4UA9SPAAXYeiRdeKVUUoTo
         C9PhND2nB9eEXwaJ3ehA9nZ1gl7yizbF5VQxT6iCdUi1AfXwmNob0i07HTjTgD+I1Ph4
         9XNYYpYrisNb+xPSLzcg5+V2OF6P4W+6+0PuHX+AOplEj7axS/G1B5ouK3dOyMQZqxrc
         002brSnfi5ICoPs9NKhVwQYhy1HDT4AtaJKMWN4yTDM2qSU1eeK7r1ubVjbwxxdr6juH
         sJQA==
X-Gm-Message-State: AOAM533OeG/Kw/UZbfZwR4+GWLI+bKHO4oVbzSGertI0zpsOqA6sgJ0A
        BmAqAQfSBQYM/1qkAgxzipvUc3qkvYr9i0ZKsKc=
X-Google-Smtp-Source: ABdhPJziLUuk2qoHcHqUNeIaqipAR7Yne8rAu4BGDaYRpWHBs0TR8DrvYEjvYzreMLe1BHbse4edbW5ExC9KB2ifCwA=
X-Received: by 2002:a05:6e02:12b3:: with SMTP id f19mr27719137ilr.13.1592225209461;
 Mon, 15 Jun 2020 05:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590017578.git.syednwaris@gmail.com> <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
In-Reply-To: <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Mon, 15 Jun 2020 18:16:37 +0530
Message-ID: <CACG_h5pP1ffeG4E-Vz_C+cX=2PGaHvNBPe+sUpP7sbfMC-0sdQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce the for_each_set_clump macro
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, May 25, 2020 at 3:06 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> niedz., 24 maj 2020 o 07:00 Syed Nayyar Waris <syednwaris@gmail.com> napi=
sa=C5=82(a):
> >
> > Hello Linus,
> >
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
> >
> > This patchset introduces a new generic version of for_each_set_clump.
> > The previous version of for_each_set_clump8 used a fixed size 8-bit
> > clump, but the new generic version can work with clump of any size but
> > less than or equal to BITS_PER_LONG. The patchset utilizes the new macr=
o
> > in several GPIO drivers.
> >
> > The earlier 8-bit for_each_set_clump8 facilitated a
> > for-loop syntax that iterates over a memory region entire groups of set
> > bits at a time.
> >
>
> The GPIO part looks good to me. Linus: how do we go about merging it
> given the bitops dependency?
>
> Bart

A minor change has been done in patch [2/4] to fix compilation warning.
Kindly refer patchset v8 in future.

Thanks
Syed Nayyar Waris
