Return-Path: <SRS0=fkE9=AG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E1CC433E0
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 13:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113CE20781
	for <linux-pm@archiver.kernel.org>; Thu, 25 Jun 2020 13:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593091979;
	bh=4K+iccIgXViq702B9y5IsAD6WZsT1HLp79mj+NPrJDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H9X1Ye4K1mOQ8yapVR82Vh1UicfSTGVopPRcYot/t4KI5EUiklGp8q6YHGB15sUpq
	 4P2DX6xNdzIXaB4R5ghXAGAoAnsraJ4xCVDFOAxTzpivMvFkpus/OlsK3vJG1Rgx/i
	 4VsBJHInjdvrpbBoelLZ5uXnggAYOnMf1mS8Bet8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405097AbgFYNc6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Jun 2020 09:32:58 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34411 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405083AbgFYNcz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jun 2020 09:32:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id p82so4967865oif.1;
        Thu, 25 Jun 2020 06:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K+iccIgXViq702B9y5IsAD6WZsT1HLp79mj+NPrJDE=;
        b=QA3v1KQqdtOg0hP7MV8RIRTVHe3ay46TbvxEXMG1++LholAunFqCoNF3U1sOHBeVwQ
         76XDSKGeANpKHPCS/iABi3YkwqrKZF0ksHP3GQHPBHe4y9O/MpySaVxqNZ00FM0ARjpb
         lVfIvPPwYobQHr/pDk2uZj0dmfQileY64u9NUk6t/XVVH10O/4zUlNQfRfC3F1sRd9hh
         rUwRLyJk4e3Y+6548FV6Zu0O64WjTZLJgJlnujitEuFJUPeEYCnrB0Bc97nIDH5ov4dp
         +JtAyVrDEuyWjtuwtYuy6YwCwrlFx91Ml85GISx1tKCYNRrX2PvXQt8u3ytYIy8xJs2O
         PsEQ==
X-Gm-Message-State: AOAM532DzP4BRBW+tZ8UGm/H6bgYy6Fba9xzHiQSmdSjohXPLsCWtZIz
        MXhonL9czP4JhtSDi0R1X24bpwTyLk+1inD8lBFmxdj3
X-Google-Smtp-Source: ABdhPJyI63FNSZeXa2r3yRmCTtP2tBaCGxrj8JXqh7aES7YFYozxizFeWRYdvMmAqDF9kDMRSK5te8NFAj5ORBRtm3w=
X-Received: by 2002:a54:4585:: with SMTP id z5mr2232235oib.110.1593091974481;
 Thu, 25 Jun 2020 06:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <49c7d64460cdb39b006991e5251260eb0eea9f2a.1593082448.git.viresh.kumar@linaro.org>
 <20200625111452.GA200288@google.com>
In-Reply-To: <20200625111452.GA200288@google.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Jun 2020 15:32:43 +0200
Message-ID: <CAJZ5v0gdJ2gtxjpzHCZ6C0LCZ0SYeR1LZcb=CwjrS2aa86fmdA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Fix locking issues with governors
To:     Quentin Perret <qperret@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Jun 25, 2020 at 1:14 PM Quentin Perret <qperret@google.com> wrote:
>
> Hey Viresh
>
> On Thursday 25 Jun 2020 at 16:24:16 (+0530), Viresh Kumar wrote:
> > The locking around governors handling isn't adequate currently. The list
> > of governors should never be traversed without locking in place. Also we
> > must make sure the governor isn't removed while it is still referenced
> > by code.
>
> Thanks for having a look at this!
>
> This solves the issue for the reference to policy->last_governor, but
> given that your patch is based on top of
> 20200623142138.209513-3-qperret@google.com, 'default_governor' needs a
> similar treatment I think.

So I would prefer to rebase the $subject patch from Viresh on top of
the current mainline, apply it first and rebase the "default governor"
series on top of it - and include the changes needed for the default
governor handling in there.

Thanks!
