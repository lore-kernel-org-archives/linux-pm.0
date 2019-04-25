Return-Path: <SRS0=5pBW=S3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA3C10F03
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C63214AE
	for <linux-pm@archiver.kernel.org>; Thu, 25 Apr 2019 10:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556187150;
	bh=887GDVs21/D2CuWStZBqULeqz7Xdm2SoJ+BlyHwmbw0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eIYw+4ALJXlMwoTg0IOoYturaFFpIZiZi5y1hGz5irvMdDUfO/P2YvwcHCQFyEFFt
	 /kcHZWE6L0OukM2MohIE+ZbDNIZJ4LIuT8rtdEz0LpHZli9WgVPE2KN4zBqIwefPZ4
	 JUUvnQluxp2cvQU+mz8OgO0fVq0HkawdkXePM49c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfDYKM3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 25 Apr 2019 06:12:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40153 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfDYKM3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2019 06:12:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so18896433otp.7
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2019 03:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1+X1ZFwCfqouoR3g0gbNys9U/xE1ytLatGAbiu8VZVA=;
        b=haEVi5pDz78/t9VDXqjtv85WsoQr98STlQpmpgdH3apLt45zTcZOmlojWRxDnphdKl
         hsk+/JN/qz/6A2+ubBkROycnG+S5/5iCptsrCU/p9Yj0jq+g7qLDIhhEnptrPsLqpirW
         F9xPrriyoJsNCD56rMwrGtKUhwzH3DChg6BqFhPVgs7+AOBepM2dEvti1aTsdahUckm8
         eO48EkWDAA6OeeXhZnESkiM0eHeYwxgoinFL2s3OwM/wRJpYfXTi+PvTpZzvqml6RH/g
         tv8Engd47D3rT//zgvQHjXDCz14RBix60XjRP4WkLjCoEMhJWPi6F/2Pp+0vTMXioNLQ
         N51g==
X-Gm-Message-State: APjAAAV3q/my0u6IEoLBA1xCws65tXhM87heo+lT1GGcnsM/Uw46F3Cu
        f1L2svrpxO6CJja8JY4zCuNDe1HsJBdUe0iFVEE=
X-Google-Smtp-Source: APXvYqz46ZlIu8U4MvE0DweeR1HrABtASD6+bRR6XxQn+6fACJSiJpInlW6Wh2zJlEYQjdpMyGbdp4hbdAFsElniJXc=
X-Received: by 2002:a9d:648f:: with SMTP id g15mr22166646otl.220.1556187148411;
 Thu, 25 Apr 2019 03:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
 <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com>
 <1556092001.2744.11.camel@intel.com> <CAJZ5v0iJp1x+WReTTwQvx6GX+=U-imLkASkJVt9o4FhS74NJhQ@mail.gmail.com>
 <1556096275.2744.28.camel@intel.com>
In-Reply-To: <1556096275.2744.28.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Apr 2019 12:12:17 +0200
Message-ID: <CAJZ5v0h62sqKBHmJgS_f+LxrR9MEb8cFMNOBFx9+UAr4VHjc+g@mail.gmail.com>
Subject: Re: [PATCH] PM: wakup: export wakeup irq when system aborts suspend
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Apr 24, 2019 at 10:58 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 三, 2019-04-24 at 10:32 +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 24, 2019 at 9:46 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > >
> > > On 三, 2019-04-24 at 09:29 +0200, Rafael J. Wysocki wrote:
> > > >
> > > > On Wed, Apr 24, 2019 at 8:59 AM Zhang Rui <rui.zhang@intel.com>
> > > > wrote:
> > > > >
> > > > >
> > > > >
> > > > > When suspend is aborted because of an ARMED irq, we can not get
> > > > > any
> > > > > useful information about which irq is triggered.
> > > > That should be provided via the /sys/power/pm_wakeup_irq
> > > > attribute.
> > > >
> > > another case is that,
> > > say we got spurious wakeup interrupts in the idle loop, and then
> > > waked
> > > by a real wakeup interrupt, say, rtc.
> > > /sys/power/pm_wakeup_irq only shows the latest one,
> > No it doesn't, it shows the *first* one.
> >
> > Please look at the code: pm_wakeup_irq is only set when it is zero
> > which is unless it has been set before.
> >
>
> hmmm, by reading the code, pm_wakeup_clear() clears pm_wakeup_irq, and it is invoked inside the s2idle loop. So I think pm_wakeup_irq is cleared and set again if there is a second spurious interrupt.

If that is a concern, I would suggest adding a debug printout to
pm_wakeup_clear() to print the current value of pm_wakeup_irq before
clearing it (if not zero already).
