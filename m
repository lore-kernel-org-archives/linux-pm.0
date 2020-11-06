Return-Path: <SRS0=UEvt=EM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C71C2D0A3
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 09:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAD522210
	for <linux-pm@archiver.kernel.org>; Fri,  6 Nov 2020 09:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mCza6PKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKFJrh (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Nov 2020 04:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgKFJrg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Nov 2020 04:47:36 -0500
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63034C0613D2
        for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2020 01:47:36 -0800 (PST)
Received: by mail-vk1-xa44.google.com with SMTP id p201so109661vke.11
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2020 01:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23W4y+M6abuLudmZYHb5EuUWkPwY6lV1mseRyEhWEi8=;
        b=mCza6PKGULKR3KSLVi71jaHeGa6jbvf6eXzzXIBvNZeyIvCsGCa0s69whdIqeCnP5h
         mBXASZSIMWro685Lrr3eqyNcGTqYWXcWrkmSjeghCw/RZcqBPaXJs2pxzzmkC37gHMRK
         3JrHTfZywnCyf11o6Inei30zBTKv+nQNQGq04ubzXiaWxwoQfGdqG00g1CqlJGsB/BCy
         SF+PPXvk4D69igY9N+Jk/R+pI2iIYDoA5XrYnZBYwQnr9ejxhUSjMb4vvY7rT7KHcnbY
         27llEWNDyIS8qOTbGquBtsENdCDqQCx6NlIdaaRmBu5bYBGDhw2TSMH51pVRSps4IBkw
         RIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23W4y+M6abuLudmZYHb5EuUWkPwY6lV1mseRyEhWEi8=;
        b=TEll9jmbA/MpDjcm4Fvi9ddijsdDlWUGNClYX1rNRmtM3ra4sDVwv7xAnrbdvLDztl
         mUvqJM3CrVtOXvVzghFf9FWIcZda0TqzM0pm51ruf2utjQhDloDmdHFEwcy1XkSoyECE
         lWnCv4ZVnab2BpgKWpoFhLYl2gHOrahoAeOS7w0qU6cgM5bldzpjbpnDPEXCGAQPNQVw
         QeWnOm3FUxxdekbi1KB+0/8nM5HN77X7Wh9FPJh7nGkPC4aIxOlAuI9jROlla3TVv4h7
         7evabTypMtVqwFtjfPI06hHOdxPYL4reidP/WXNSe0MbLDMC30YzqjVvTERf2+sJP0zY
         FP3g==
X-Gm-Message-State: AOAM531JXSSLgli8lYZxwAGjrMYX/mfGPdRcPQjFbN/CoEIoRo315UrS
        6vw56SDwsRpghXZGRG9IJXD0wRo6hnamIUXnQt9+ddOnJGw=
X-Google-Smtp-Source: ABdhPJyXTD4HNdZV3wzzfqQ8t69K2mMISGmdEjWNlqIkWraZz4pfH1N3k25yw1yNuJKt+bmqGH3xyqLHf33qIXEIte0=
X-Received: by 2002:a1f:9682:: with SMTP id y124mr465715vkd.6.1604656055569;
 Fri, 06 Nov 2020 01:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20201106073358.8379-1-patrice.chotard@st.com>
In-Reply-To: <20201106073358.8379-1-patrice.chotard@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Nov 2020 10:46:58 +0100
Message-ID: <CAPDyKFq94tpotN9P=pgBx+=deYQWzAYfFQWO3ejPOqAMN3PN=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] PM: Add dev_wakeup_path() helper
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Erwan Le Ray <erwan.leray@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Pierre-Yves MORDRET <pierre-yves.mordret@st.com>,
        amelie.delaunay@st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 6 Nov 2020 at 08:34, <patrice.chotard@st.com> wrote:
>
> From: Patrice Chotard <patrice.chotard@st.com>
>
> Add dev_wakeup_path() helper to avoid to spread
> dev->power.wakeup_path test in drivers.
>
> Cc: amelie.delaunay@st.com,
>     erwan_leray@st.com,
>     fabrice.gasnier@st.com,
>     alexandre.torgue@st.com,
>     alain.volmat@st.com,
>     pierre-yves.mordret@st.com
>
> *** BLURB HERE ***

:-)

>
> Patrice Chotard (4):
>   PM / wakeup: Add dev_wakeup_path() helper
>   PM: domains: Make usage of device_wakeup_path() helper
>   PM: core: Make usage of device_wakeup_path() helper
>   i2c: stm32f7: Make usage of dev_wakeup_path() helper
>
>  drivers/base/power/domain.c      |  4 ++--
>  drivers/base/power/main.c        |  4 ++--
>  drivers/i2c/busses/i2c-stm32f7.c |  4 ++--
>  include/linux/pm_wakeup.h        | 10 ++++++++++
>  4 files changed, 16 insertions(+), 6 deletions(-)
>
> --
> 2.17.1
>

For the series:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
