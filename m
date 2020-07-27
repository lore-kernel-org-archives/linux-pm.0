Return-Path: <SRS0=nOYf=BG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E1DC433E3
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E72072E
	for <linux-pm@archiver.kernel.org>; Mon, 27 Jul 2020 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595849103;
	bh=FF+iPrS7fANlcs2X2qeJQ8tIK7QrX3yOID0NhuZywUQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i43aJpHkaSJzR0hbOyuY7GfwJGB5GASTsHaFHS2/GyYl1+16I/8UrGzTjUwV9EBo1
	 uTYZCA0uD0abrli2dwdKUF7OTlof0t3vRQjy5iRqWBl20bPBz/HW/8E8KhnUR5xrTu
	 VlSqqmFWXeTNmH0hH0iSMzDUOoyazIvwAxnEAIP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgG0LZC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:25:02 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41740 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgG0LZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2020 07:25:01 -0400
Received: by mail-ot1-f66.google.com with SMTP id a65so2867347otc.8
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2020 04:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWUtaK+v67ZxkbnIhhuXC9E5DWT7VRvJLk/O+hH7irU=;
        b=S/2jnNsJRltCLC9RJgg7roU2FOd84ln4X1aWNwXuACqH2c/IHY3O1r/422+afynDl9
         2jVu7LNIyI9UdmQLe/C/W72w3VaoJIrvC3udNbC5ZG9MtT7eTulPgDUJq1dEU4QSvk2Y
         M3gADjYZDbXAK+t2L+BVAd1YCTN4J8ML3u63nFPmyom69sMKY2HQzIV5NL94eyUYmUOo
         g/cHD8ne0P1kozRKE/ZCvnJxqIngm+4cDs8sNQGvzdSS/3uNZ84ga+NMNYgwzArLxYEA
         Do+svGomMXACVAcDY+tFaFsf8U4X1COskFA6W868m4MWsnW80KkMfZaSSpYpT16unJXQ
         yHfw==
X-Gm-Message-State: AOAM532m11LOXamUr6KkVP58/FMhZd8AmgcE8xbUu2GqG90hkGOfez2t
        epqaTsL48P4NYW3Ygc6+RA01ASNk9QbnvRtcQGE=
X-Google-Smtp-Source: ABdhPJzLdgVRJBdcqCaXSf0pM5I80BDxolo3/Zs/1dyeNmxwT28o3E1/SqyQJG8hudzstcm9Emg2FXd/ue/DLdB7cIg=
X-Received: by 2002:a9d:590a:: with SMTP id t10mr19968047oth.262.1595849099630;
 Mon, 27 Jul 2020 04:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200707125804.13030-1-ulf.hansson@linaro.org>
 <CAPDyKFp6+kSHsgvjQQwyQtot2KqdhikbCJW0JUSQJZyfa9cRyw@mail.gmail.com>
 <CAPDyKFpi0jy1OQu7X4KEQVvTCDAHK=A5WueD1XPGj9dxDeNS3A@mail.gmail.com> <CAJZ5v0ihsDGZ7_JXSq12tF+pWdfoVBDz+HJrrRtusKftUSY9-w@mail.gmail.com>
In-Reply-To: <CAJZ5v0ihsDGZ7_JXSq12tF+pWdfoVBDz+HJrrRtusKftUSY9-w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jul 2020 13:24:30 +0200
Message-ID: <CAJZ5v0iG9RUPSW=OphHgnbDm=nB6dAhDnLGbHHjQteUhBqpokg@mail.gmail.com>
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

On Fri, Jul 24, 2020 at 1:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Jul 24, 2020 at 1:15 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 15 Jul 2020 at 11:53, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 7 Jul 2020 at 14:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > Changes in v2:
> > > >         - Put patch 3 as patch 1 and rebased accordingly. No other changes have
> > > >         been made.
> > > >         - Added reviewed-by and acked-by tags.
> > >
> > > Rafael, I think this is ready to be picked up. In particular, the code
> > > that Sudeep/Lorenzo cares most about has been reviewed by
> > > Sudeep/Lukaz.
> >
> > Rafael, apologies for nagging. Any reasons you see why this can't be
> > queued up by now?
>
> I'm mostly offline this week.  I'll queue it up when I'm back early next week.

And so now applied as 5.9 material, thanks!
