Return-Path: <SRS0=4hIB=D4=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52493C4363D
	for <linux-pm@archiver.kernel.org>; Wed, 21 Oct 2020 03:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C489720727
	for <linux-pm@archiver.kernel.org>; Wed, 21 Oct 2020 03:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jelfM9Yy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411742AbgJUD1k (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Oct 2020 23:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411737AbgJUD1k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 23:27:40 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D9FC0613CE
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 20:27:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id p25so441620vsq.4
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 20:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okDKMzXzCtX+DL70PlkyYgGodwergNlDE9kGKTPNIKg=;
        b=jelfM9YyqCKcnDtniLjUFPu6VhMOAsfQOqqWSfu0zlFEjfKhE7JnIz/kRKKRoK2VJv
         Xw8SL0BTy6z2ymLtcBHN8Gl8opJuePohe1HySszT+qFcfjdRZHkNizRExSD9rKGs++br
         pFjvyn6iF/NQ2MrM4Ps9lF31Hb3CHtu2q5iGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okDKMzXzCtX+DL70PlkyYgGodwergNlDE9kGKTPNIKg=;
        b=IR4DE9uzmo4gZrNKx+p09NvJr0wLh+YNSUKhgp90zkrsIl39VP53Yux40/Qb2CUOqf
         7gaNuLGOcEjG0a2QVi4XFG4nAmUEOBa37Lhza+yVefXaPmYTWR2bpGS4OaVbUs6fwbHT
         fRN6kiosfSGnFnio9WB3gXovP1uSGEqB557b8tnS/7yL9wL4JCwU4QQJXKl+XK8RLXze
         zMfYXBgMQSLgOoqSAdM4EZxQQdsyMOOrahk4x7ucRwkCt5VAKlksZp3kGlnBc93IG15D
         gP+9BM7ieaHboltLiphVkKv349VpmyDGv23NI06UxfKas4uXR2HlFgxaRkWj2PcjQ++w
         /x+A==
X-Gm-Message-State: AOAM532MA1wH17du3klTt8KEvxIWOV/9Xv/GlZqoioC5Y6VPRFvNWND/
        s0NjJeX5QfSv0PAFG2bCu7jVa6FKb8W+OS0OypDhCQ==
X-Google-Smtp-Source: ABdhPJyHqwzVn8t+z+oInKgq5Xr4Q5Fhgb86BH/r8Q454Y6wqjeLrz2gjPJeUiRzPK+mZ8tcCv03sbCwCtelDtxopN4=
X-Received: by 2002:a67:2c4c:: with SMTP id s73mr448412vss.53.1603250858758;
 Tue, 20 Oct 2020 20:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201019223257.261223-1-abhishekpandit@chromium.org>
 <20201019153232.1.I797f9874972a07fc381fe586b6748ce71c7b1fda@changeid> <20201020055738.GD3437534@kroah.com>
In-Reply-To: <20201020055738.GD3437534@kroah.com>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Tue, 20 Oct 2020 20:27:27 -0700
Message-ID: <CANFp7mXd=spL6PAL1cGrdZYBHu4A5uqJhFnu3Fmg9FmmFu6JJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] kobject: Don't emit change events if not in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Greg,

I was debugging without a live repro and I was told this patch
improved behavior but it's only by chance (someone bisected a Dell
D6000 dock's displayport issue to this commit and this change seemed
to help; udev logs later shows that's not the case). I took another
look at device_init_wakeup and I can see that
device_set_wakeup_capable does indeed check for device_is_registered
before adding the wakeup attributes so the ordering of events I
suspected cannot occur.

Thanks for pushing back Greg. It made me take a deeper look at an
assumption I hadn't challenged. Please consider this patch abandoned.

Abhishek

On Mon, Oct 19, 2020 at 10:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Oct 19, 2020 at 03:32:57PM -0700, Abhishek Pandit-Subedi wrote:
> > Add a check to make sure the kobj is created and in sysfs before sending
> > a change event notification. Otherwise, udev rules that depend on the
> > change notification may find that the path that changed doesn't actually
> > exist.
>
> Why is the user of the kobject trying to emit a uevent before it is
> registered?  Shouldn't we fix the root problem here instead?  Otherwise
> the event is still "gone", the caller will not know what to do about it.
>
> Please fix the root problem here.
>
> thanks,
>
> greg k-h
