Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC550C10F12
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA812073F
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555489020;
	bh=kuBFyWMZfEjsAHrWudB2EIXpFIjBspt+Kjij2kGkq9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Mul+EgKqjEScrAf6aHaxv40jyvdzCsG867LWL0oXXhkASOQcbtFsm00ETqYIP3TpB
	 2t+ZVPObyoqz49Udt8Oa2h/5x9b5CM3fjEE22VueNL0BAyQoZ0JDUWR7GKJCuV4dkp
	 8pYnxW6ELt1esfNe3a5LqUg33QzgqHmGM3YrLpd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDQIRA (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:17:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44144 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQIQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Apr 2019 04:16:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so19940451otl.11
        for <linux-pm@vger.kernel.org>; Wed, 17 Apr 2019 01:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ybI6sgwS6hZ8vlBEWsPe3hjiF7ThxNXb2rHDg0BYhZk=;
        b=HwVyLsMcQ1YonxX2HQHrbX3U+y6NBRtovvqGH8yyjLM05wmjb6BVRyWMJYdvvH2GXH
         QOOZ8YeHsjWdABImfp8PMkmcVizKQbJe4WNCBYXrh67uPt19X0uKMRGsBTTXVBDJ0SOk
         sCcL3ctmgZYJSvsjqIoYEuM8loeAgbaOlz7RNNjeLT2Vijsb//jFSiKXUn2LJwPFo1xj
         5JYBNz3S4XEDRGQ8m4lawzfcRoDLnk0Ee/6I2wHVujDQqQ0uUoW3NdIZAXFwAy3d2WmF
         8VwByQTx4hmstfREjnZYTTQqMprEk9e6jWdKueKtBAoCfwsmdYMxPiU3xVrPvxTw3dZw
         g9uw==
X-Gm-Message-State: APjAAAX2HCqDrxFEssLyd4hynsQGyIDHYgf3lcRuc3QaXOyffgMcrkNv
        xeUvD9k9stFb6pW33M6IDL2sfe38u6VkyLPPxQo=
X-Google-Smtp-Source: APXvYqzxtsk0owLzC6bh2sg7ke438fN/mZwh5glvB3gWEZCRFIyANWW73cfgb1RIu6HPGoav9iZwz8QXVMkb+vsu7oc=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr52454757oth.83.1555489018932;
 Wed, 17 Apr 2019 01:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p6>
 <CGME20190417022610epcms1p620ea173956cd58582ab4ceb47c55e4db@epcms1p5>
 <CAJZ5v0h+P0PNDma4NH6SnLy17U1qb9opOm5ZwJVAXNWWOfs5Vw@mail.gmail.com> <20190417081306epcms1p56acc17942dcb11828995ebbf2b8a7fc0@epcms1p5>
In-Reply-To: <20190417081306epcms1p56acc17942dcb11828995ebbf2b8a7fc0@epcms1p5>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 17 Apr 2019 10:16:47 +0200
Message-ID: <CAJZ5v0iVnhovN5-6N89qkZm0zX0Ec=9=b9tggZKr1x4JK2PQNQ@mail.gmail.com>
Subject: Re: Re: [Pull Request] for Rafael, Linux-PM, from devfreq.
To:     Myungjoo Ham <myungjoo.ham@samsung.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "skannan@codeaurora.org" <skannan@codeaurora.org>,
        "tiny.windzz@gmail.com" <tiny.windzz@gmail.com>,
        "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 17, 2019 at 10:13 AM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
>
> >On Wed, Apr 17, 2019 at 4:26 AM MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> >>
> >> Dear Rafael,
> >>
> >> Here goes a pull-request for next / Linux-PM.
> >>
> >>
> >> Cheers,
> >> MyungJoo
> >>
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> The following changes since commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:
> >>
> >>   Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)
> >>
> >> are available in the git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-next
> >>
> >> for you to fetch changes up to cf451adfa392bd9ba36f31659dbe6a5010b46ef9:
> >>
> >>   PM / devfreq: add tracing for scheduling work (2019-04-16 09:29:18 +0900)
> >
> >Pulled, thanks!
> >
> >That said, next time can you please provide a high-level brief
> >description of what's being changed, so I can add it to my merge?
> >
> >Cheers,
> >Rafael
>
> Sorry for missing that part in the mail message; I forgot to add it
> from the tag message.
>
> It's
>
> This includes:
> - Number of bugfixes (mainly on exception handling or styles)
> - Exynos-bus: fix issues related with shutdown/reboot
> - Rockchip-dfi: code refactoring
> - RK3399: support trusted firmware
> - Added trace support for devfreq-event

Thanks!
