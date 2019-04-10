Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D1C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4446E2133D
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFBdFeP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbfDJI0T (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:26:19 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37008 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfDJI0T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:26:19 -0400
Received: by mail-vk1-f194.google.com with SMTP id o187so374104vkg.4
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C60e8J/901M0yAJl8d+mDMJW2gbbK7ZM+gdIk/nTZk8=;
        b=rFBdFeP7iFyWVDev+Fph9wEpmdEXlxySfCesz/Lj8qBriP8UZJIqvklEPjVyRsSr1k
         UX7hFiedRRtNNl5mr72ZcKbwqdJjarttOElJtO/JclvYTDlvHx1T1TjmAyHGeFdDcLkM
         BfcwX7lDtaD9WG4j4Qfi33hDDoIMJGOx1ow22q6ZB4hU4V30n/QJ/D6tbAxmsL4KPupI
         V1cLkQEVtOLjIFdUQeiaDvdTQwSzPP6VeQwdsUPsEp2u0+7lBB+dHwGK1/AMw9uM4+Sr
         pdtKSWWpymLO+m9kFsOgV0foioOREKpOtt6DUhiiz4Kx+g5Acl+trPgew6T5BhWtpjyi
         BTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C60e8J/901M0yAJl8d+mDMJW2gbbK7ZM+gdIk/nTZk8=;
        b=kMUXg7pdegMyprgxLkHdsXk9BLh/GfiihBi1F9/SpcCacY9NRBVlE/FB7sVOKzHX0D
         BT43TTArJtKDycVqvJYp4/oxO1AQD/Sz7HWRnAVbXJpEMvIPRgRkt8IcByrnOv1LLZX0
         y/WwlAeHz9Q8eQ3x1LGfZ8W4x1GS2AsFrmovS0Mdp+ROrgjqbhMvywy9BZclEJ/bf+mG
         avJJ5BBXh4S9ys0Bd9tno5fnX/CQQtn2rjSy36habJbOvi9o8PnlM6MDFeKiHvkdkeTR
         19l7sgMoF26hxY3DJ3xBqeDyW0nleakWw5ZTMWWrXKdxeL86D1ZMaABN7x+VREUbDdVB
         rl2w==
X-Gm-Message-State: APjAAAUllNam6CZsdFmv/897MZJ9yD30hmMEhO9W1g6vo5BAXehmHU3M
        FaVoA1jYE/i3bISqMiW0d88RPitHDWoLh1+Jm2uJ3w==
X-Google-Smtp-Source: APXvYqw3GyPpLGur74ddJXaEQwH5ZGzmVJzLKOqImGKXSFKdkKbRx7sVo5nxvisvHRi2BT/e7f7HfTCatBvLckAPcfs=
X-Received: by 2002:a1f:2c8:: with SMTP id 191mr22851733vkc.29.1554884778538;
 Wed, 10 Apr 2019 01:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
 <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com> <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 10 Apr 2019 10:25:42 +0200
Message-ID:
 <CAPDyKFpjpLaYSqj23YV_HdNG9Tp485Omn4pVQQH_Cj8_k_E8WQ@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Message-ID: <20190410082542.XWg21r2brYzWfwGQbPerKUrnaA1xL67f5sBVhiCp09g@z>

On Tue, 9 Apr 2019 at 17:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Apr 9, 2019 at 1:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 27 Mar 2019 at 15:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v13:
> > >  - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
> > > struct cpuidle_device. Also reset the same variable after resumed from idle to
> > > avoid it from containing a stale value.
> > >  - Added acks from Daniel Lezcano.
> > >  - The entire v13 series, including the PSCI/ARM changes are available in a
> > > git branch [3].
> >
> > Rafael, I have address the received comments on this version $subject
> > series, is there anything that is holding you back from queuing it?
> >
> > If you like I can send a pull-request, to simplify for you.
>
> I will get to this one shortly.  I've been waiting for possible
> comments on patch [3/4], but since no one has commented so far, it
> seems to be non-controversial. :-)
>
> I'm going to add this material to the cpuidle branch rather than genpd.

Sound good to me, thanks!

>
> > Moreover, there is another series which I have pinged you about
> > earlier, which I would appreciate to queue via your tree. It's acked
> > by PSCI maintainers and is ready to go. "[PATCH v2 0/5] drivers:
> > firmware: psci: Some cleanup and refactoring".
>
> If you want me to merge the PSCI series, please resent it with a
> request to that end in the cover letter.  Also please let me know
> whether or not it depends on the $subject series.

No dependency, but I am using it as a base for a future series that I
will post as soon as you have queued it.

So, I have just resent the series, as per your request. If there is
anything else, just let me know.

Kind regards
Uffe
