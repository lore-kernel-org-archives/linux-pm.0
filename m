Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D79C433EF
	for <linux-pm@archiver.kernel.org>; Mon, 11 Apr 2022 15:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbiDKPUN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 11 Apr 2022 11:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiDKPUM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Apr 2022 11:20:12 -0400
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FE932076;
        Mon, 11 Apr 2022 08:17:58 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id g34so8146035ybj.1;
        Mon, 11 Apr 2022 08:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+UkpLblW1SxDWq4/v7EPOEjxoIVr/fJ5t6xgCjodwz4=;
        b=YHQzj1X4nZtYMaPyNfztxWY79MUlRIXNCNZdflDw+kn4aQOS1b0gJ4uD0Ucm3JTOJv
         6kc/DgnCO2JrntjLzdWJKDCvsLwlc6A3ofY5GLmC5Dw+c1KsEvh7Zd/AXNNAT8ZXSCZK
         AHfuVs1WvdAMuINDGHuOENN22kUP5fWYEwVodtWwtZ5wyp0s8mayYAJhtBx79co41n40
         zgVuB+gbd51ZjLSKCf1kOKFheXCeHwWv7LoNzOPBsSxfB0YMcqJamMtk3ymfuXNrqt5f
         zt/GpWoXhr+XdHTqgPCJO1SgcjqQTCHf7OANOEkNo7N2YHuqQjSEq311v2t91MINdKwL
         gG8Q==
X-Gm-Message-State: AOAM531vidaL9nHdjTpZhnobBAkiEmKu0oKvm1oP4r+wYuUOdCJmmWET
        NfjyTzYt3kKQThuW8Y4gP7RQLhUdHanhdrPgRO9Q+RE/
X-Google-Smtp-Source: ABdhPJzt77OWrISiDVpat25IqQ429M6dFyJii4JV+hLGXmHdCD31xyct9fXopI95toHyRy/b6gMOoShQ4f6BU+n5vvk=
X-Received: by 2002:a25:3cc3:0:b0:63e:6ee9:4840 with SMTP id
 j186-20020a253cc3000000b0063e6ee94840mr14606614yba.153.1649690277498; Mon, 11
 Apr 2022 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <1836398.tdWV9SEqCh@kreacher> <CAHp75Vc2Lci4ewdosqX4Thm6ME7pKjKw+C+wtUsq2esRM-eXjg@mail.gmail.com>
In-Reply-To: <CAHp75Vc2Lci4ewdosqX4Thm6ME7pKjKw+C+wtUsq2esRM-eXjg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Apr 2022 17:17:46 +0200
Message-ID: <CAJZ5v0hCPG0_4MUW5bt+FLtPmnFZ9NUxsEiFpd-6+wOmYxPm5A@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Avoid device usage count underflows
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 11, 2022 at 5:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 6, 2022 at 11:49 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > A PM-runtime device usage count underflow is potentially critical,
> > because it may cause a device to be suspended when it is expected to
> > be operational.
> >
> > For this reason, (1) make rpm_check_suspend_allowed() return an error
> > when the device usage count is negative to prevent devices from being
> > suspended in that case, (2) introduce rpm_drop_usage_count() that will
> > detect device usage count underflows, warn about them and fix them up,
> > and (3) use it to drop the usage count in a few places instead of
> > atomic_dec_and_test().
>
> ...
>
> > +               retval = rpm_drop_usage_count(dev);
> > +               if (retval > 0) {
> >                         trace_rpm_usage_rcuidle(dev, rpmflags);
> >                         return 0;
> > +               } else if (retval < 0) {
> > +                       return retval;
> >                 }
>
> Can be written in a form
>
>                if (retval < 0)
>                        return retval;
>                if (retval > 0) {
>                        trace_rpm_usage_rcuidle(dev, rpmflags);
>                        return 0;
>                }
>

I know.

And why would it be better?
