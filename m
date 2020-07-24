Return-Path: <SRS0=KrQF=BD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8CF1C433ED
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68462074F
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jul 2020 11:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595589747;
	bh=ZMxi7wy+NUaz2HrzDOYJUy6MyS4rb0Ea2cG1bH5ie2A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QPbW6tRw4NyByRwVI13bY2yJdhl0l8dRk6KHd/qtEkiOrUCdjF8wnoij/pW7/bZ19
	 s5GYtWcPo5KvzGOWwJPArnbdbf6dGGqlG5/I61xyjJtWpo8FJJxkrE1nLQ0AJDu6Sg
	 j9vwtK8a19WyLBQIVLdBXOuAcxI/ehctVTO+csnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgGXLW1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:22:27 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33148 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGXLW1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 07:22:27 -0400
Received: by mail-oi1-f194.google.com with SMTP id k22so7750802oib.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2020 04:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhbuFXh8HOgHtCXDlwhmKtQ/8YW0bgLh9wkb84i37pg=;
        b=ggV48G7U8AyN+6cww793t0NCoO7lw5OWXWFKThtm4sLhR22dgGMqZeqcFE6QF2qgQv
         wQeE/3sIi6hnIQUx6S3nN87TsZc+GxYSLWL6rTv3fGlmE1mHNA44oqCgZ/aqQdlPi0s1
         g6+/9k79cFl2JztxuWn5SzPMWzMHba5uUra5zw0Fswtp7HtxNYsU512CZKPt4UinYe+d
         RiEnhXRtclTvquKGrnBx/1lKacM0vuMNeiQQAXRQ5YsrdmXgPQOCf7XpF+q03XP8Q4Yr
         jISIC2UoFUbRqoZmkHKkXFH+9Y/1Xpwo+pjS2K031yTotc1ILUI/nJwASq+hFIA96yld
         rdRw==
X-Gm-Message-State: AOAM533AbXEigOOVozZ/yvGq9fen+rRABlIBIYY1H2NfpMFy8UACumGm
        4Q0AYLzcowEw9bG0z8QHgz9FX9tI4pq9dHtLJ9U=
X-Google-Smtp-Source: ABdhPJxiyVzsgoHC34xJNnxr5YvUi69SY6txEbx6yRtvpYsgiOgHj9wyrktjas8HnTcuGau2u43st7Soy0WyWFzbIQs=
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr7834637oie.110.1595589746154;
 Fri, 24 Jul 2020 04:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
 <CAPDyKFp6+kSHsgvjQQwyQtot2KqdhikbCJW0JUSQJZyfa9cRyw@mail.gmail.com> <CAPDyKFpi0jy1OQu7X4KEQVvTCDAHK=A5WueD1XPGj9dxDeNS3A@mail.gmail.com>
In-Reply-To: <CAPDyKFpi0jy1OQu7X4KEQVvTCDAHK=A5WueD1XPGj9dxDeNS3A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Jul 2020 13:22:15 +0200
Message-ID: <CAJZ5v0ihsDGZ7_JXSq12tF+pWdfoVBDz+HJrrRtusKftUSY9-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] cpuidle: psci: Various improvements for PSCI PM domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Lina Iyer <ilina@codeaurora.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Saravana Kannan <saravanak@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Jul 24, 2020 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 15 Jul 2020 at 11:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 7 Jul 2020 at 14:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v2:
> > >         - Put patch 3 as patch 1 and rebased accordingly. No other changes have
> > >         been made.
> > >         - Added reviewed-by and acked-by tags.
> >
> > Rafael, I think this is ready to be picked up. In particular, the code
> > that Sudeep/Lorenzo cares most about has been reviewed by
> > Sudeep/Lukaz.
>
> Rafael, apologies for nagging. Any reasons you see why this can't be
> queued up by now?

I'm mostly offline this week.  I'll queue it up when I'm back early next week.

Cheers!
