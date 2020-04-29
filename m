Return-Path: <SRS0=WlAP=6N=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A148C83003
	for <linux-pm@archiver.kernel.org>; Wed, 29 Apr 2020 11:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F09D206C0
	for <linux-pm@archiver.kernel.org>; Wed, 29 Apr 2020 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588158396;
	bh=vJS/kGIzLag3qQZ2CjCIW+mf5tVkZuiOU/sKYbzFgtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A1R0fRAOn830NijyDtI2HvRJDwJnN/c61rSY3/nEE+S+6vmeTEPvFOTntLRLxTOHf
	 g5Era1Q+JcxfT/+V5/0BnAHW0PaHr1Y0EeBdRIZwutE5rGxn+mgP3bFnCKMf+B4l22
	 adFxcD5kI9/3JsKm4b8EihZEpnovGhdPbCNIdLdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgD2LGg (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:06:36 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42952 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2LGf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Apr 2020 07:06:35 -0400
Received: by mail-ot1-f66.google.com with SMTP id m18so1297276otq.9
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2020 04:06:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4B76i/2oqBCCwZ3yp2S+jNtg7m3AdRnJIeFiVqFmRU=;
        b=EPOpOYNSxHdOKMJ2bitF8SzCOeI0Q2XeCFX972jj8GR/WzwfhnYsXi3Aq9GZu2Wplc
         GyZAuKSthFCDOu6gBbZCwpr/yXkTsfM/ulSqhqZvUXu/Db/3hKcqvkpqqJRFzTYU/lwR
         050Hv5jd6sEubF+kLClrUUV3av/g1YQP14f7/UtRZvRCS5Rf6LF3PSOGSjVqWCk3l0b5
         lLxeJu6VoR7JHuoi+T24SBLgHuXjhojSF11zbczMUos+M2OioRZxtn8H3ln6QzSAOmKU
         /aopWKPnx6sI+PXuYh+gcQgSsxCyFdMvxIgeIGoMz4g0fF/bRD1phJLW9q9GDHZqeNli
         ScAg==
X-Gm-Message-State: AGi0PuZyVAHh7D6r7OONsbpBEwmO+kBB+fL+uqoaM+whDThLvDjI9ZyM
        kJFY+bqtp4b4DS80djiO4q+dKZ27U4dcU4gCxgY2DRXJ
X-Google-Smtp-Source: APiQypJz9V8511uwXQJsp/R4xRxuHv/0my2Nq32m0rXJviwIMT3YvOOeHpoX+kcPx56MyXeXDM+blvQVn2i7ZZSrrII=
X-Received: by 2002:a9d:6ac8:: with SMTP id m8mr26101438otq.262.1588158395019;
 Wed, 29 Apr 2020 04:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200413190843.044112674@gmail.com> <1636190.8qWULXYmPk@kreacher> <20200427095306.GB29259@dumbo>
In-Reply-To: <20200427095306.GB29259@dumbo>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 29 Apr 2020 13:06:01 +0200
Message-ID: <CAJZ5v0g4GyaxtKvbdS7u0rWtMbd075hPzFO-+Cz0q+zM1WbE-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Preparing to phase out uswsusp
To:     Domenico Andreoli <domenico.andreoli@linux.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>, 954061@bugs.debian.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Apr 27, 2020 at 11:53 AM Domenico Andreoli
<domenico.andreoli@linux.com> wrote:
>
> On Sun, Apr 26, 2020 at 05:46:37PM +0200, Rafael J. Wysocki wrote:
> > On Monday, April 13, 2020 9:08:43 PM CEST Domenico Andreoli wrote:
> > > Dear maintainers,
> > >
> > >   it is my understanding that the usermode software suspend is not any
> > > more the first choice for suspend/hibernate needs (uswsusp tool did
> > > not receive any update in years).
> >
> > While the last part is true, the user space utilities are still usable.
> >
>
> Indeed I've been using them until now and work perfectly.
>
> > Moreover, the kernel-based hibernation is still missing one important
> > piece with respect to the user space variant, which is image encryption.
> >
>
> Interesting, is it advertised anywhere?

I'm not sure what you mean by "advertised".

There is a way to combine hibernation with dm-crypt which is kind of
described by Documentation/power/swsusp-dmcrypt.rst, but the lack of
encryption support in the built-in hibernation code is not documented
otherwise AFAICS.
