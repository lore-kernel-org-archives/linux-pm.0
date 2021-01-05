Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03D8C433E0
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jan 2021 14:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E47D22AAD
	for <linux-pm@archiver.kernel.org>; Tue,  5 Jan 2021 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhAEOUG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbhAEOUF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2021 09:20:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47828C061796
        for <linux-pm@vger.kernel.org>; Tue,  5 Jan 2021 06:19:25 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm17so31277841edb.4
        for <linux-pm@vger.kernel.org>; Tue, 05 Jan 2021 06:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/9ZfcA2tM6SOnOAgqAyi8khL28Ou4AoCcOsnTQ0YF4=;
        b=vhALD3rc06dWqruq6fITSXawb6N3JgrPn0LBfVwyZbbwJm5bBWyMOCOlUMvbv2VViR
         prUteizV9nRdwPsbqApNu4/pBGJE8vvwY8JQVMDlr/GWZMtJXHOZQ9HeKDAE0O2x8XTD
         /elYM+BXpm3o4x/99VIMUPGurHP7P3m90NGIVXDkw5smPnRf3+VjYkg0fPpMMrcX9BQ0
         POXaCioLFFiORsGmqDBShuO358XnDCqYFtnEcxqszHu/z2YhKVKnugoDjTbmh7aUXQEm
         EWdkyWosd6Wp6J6wwC/1wlVMSlHAg6ULQwxX4RRySD9oShYJ+JB4cuKBkyKIt76Q33x1
         9+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/9ZfcA2tM6SOnOAgqAyi8khL28Ou4AoCcOsnTQ0YF4=;
        b=NDK9tNUrd3KszQgiJFBTuLhIdvZKZrDp8/ht85uIFu0U4/kxlS3uJoG333RW7uvSea
         a00OEj+eSJ/7ZUjMkekWvwnuqKirCaJzWQZn8bpMyapTCTfCKFoEG3cg8Cb4F7zoPxPb
         psRxRgvA6Q75EEb6IqWh16ous/pdrACekmV/DtTM9IdMxtFGH/sg155UWv8Hho6vjiE/
         7cpvcA2e3hewhl+4UI2ENLLzjUlzQwxcsIXh7MNX6CBKb1rbdytMPumM9P51wawscd4p
         DhjazAXdPKOq7vE5mjP740iypyDj2MwcrSYSJHKD/AnTBXKA2zSCUarPynsKvmQkMSID
         CnUQ==
X-Gm-Message-State: AOAM530FBjymMbxVBmwy5fQgeT/n5DDmnMhzTWeRU/qb5txzLQLj0ijV
        gmLZEjP0ZCFNs4Oh9nCI+bHGM6z170ku/uuUfPn+kQ==
X-Google-Smtp-Source: ABdhPJxIVgZDRUr17uvcAnR7t5T6eFIgYR7KHHCcIaA2rzCzP103uhOV4yPjCluFvme/MqfKZGXVVTWgEWl+bjNiUj8=
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr76783235edb.186.1609856363835;
 Tue, 05 Jan 2021 06:19:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1608963094.git.syednwaris@gmail.com> <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
In-Reply-To: <CACRpkdYZwMy5faNhUyiNnvdnMOf4ac7XWqjnf3f4jCJeE=p2Lw@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 5 Jan 2021 15:19:13 +0100
Message-ID: <CAMpxmJW46Oh2h7RrBNo5vACfYnWy63rZOO=Va=ppUDeaj5GpBg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Syed Nayyar Waris <syednwaris@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 27, 2020 at 10:27 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sat, Dec 26, 2020 at 7:41 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
>
> Actually Bartosz is handling the GPIO patches for v5.12.
> I tried to merge the patch series before but failed for
> various reasons.
>
> Yours,
> Linus Walleij

My info on this is a bit outdated - didn't Linus Torvalds reject these
patches from Andrew Morton's PR? Or am I confusing this series with
something else?

Bart
