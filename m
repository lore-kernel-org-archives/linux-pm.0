Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFE4C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A72148D
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556094763;
	bh=MZ7NzPNhNQln1iBSTWj9+qRgdxAkF3sUlwhC1xILT9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U1SVIXs/QHfHpEKkuyOtP/QN3woUV2VCGmkjLk6di22jduWJwkZzX003HE4MksYB2
	 nbTvBKpztOnu4cVqFkxAgtU/8bqrKvfTotyAeeJzh+wAm8YIt7bc03VyB7mx5afXi/
	 aKAyGpi6a/guKQ3DU6X55Gv7gaQLswUG/y87+iIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfDXIcm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:32:42 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38562 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfDXIcm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Apr 2019 04:32:42 -0400
Received: by mail-ot1-f67.google.com with SMTP id t20so5953423otl.5
        for <linux-pm@vger.kernel.org>; Wed, 24 Apr 2019 01:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j3n0GATtcoxOIbUOiv1mESDY3mnujS8TeGnodOnMJAs=;
        b=OLvD05JXH5carN04uxNFvpb+vaIU3OcZw1mp5yZA5yeaCAJk8mtU9GFcf8h6PI4GcR
         WY+gnRnI2NQsayw2X55JjtJoZCQlMeb0mBwoPsgkeRJgMxDiUmplli6rhLvxu9RX6FXQ
         3NeKAn+GwWGIDIj7UYf+6jyTDifoyhKpNeuYRyjlxbUldF9etoIhBPNVDSkEmkXd9k0y
         wJ2cDQQH2BYSHhovYplT0Tr36JTPvNAjkOBvZqFksjub+kV7/of5hYA6In7Qkjbbwwt0
         gd5i8nW5E1Uc4N1vz8L1EhwJNUk5BDhVZs/CO0r+R4/PcCnEP30SP9mMbJsmZmXw3mn3
         lWyg==
X-Gm-Message-State: APjAAAUOmjd3IuFOjOtlEJNRLoulenSean8kJwj10InYrMhtkcxmUV6+
        aztqrH+S54XPQwUT0KQ9AYv6eYwsuB08r1XXPBw=
X-Google-Smtp-Source: APXvYqwgP+lIAH02lHepUaIXGvZSEGxp/pcHkGSrm9+F1MHQD9Jrn7jcBNoT8SdWZEf/Q0GhoR6FDMRqw6L8VfOwnbg=
X-Received: by 2002:a05:6830:20cd:: with SMTP id z13mr19383917otq.168.1556094761632;
 Wed, 24 Apr 2019 01:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
 <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com> <1556092001.2744.11.camel@intel.com>
In-Reply-To: <1556092001.2744.11.camel@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Apr 2019 10:32:30 +0200
Message-ID: <CAJZ5v0iJp1x+WReTTwQvx6GX+=U-imLkASkJVt9o4FhS74NJhQ@mail.gmail.com>
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

On Wed, Apr 24, 2019 at 9:46 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On 三, 2019-04-24 at 09:29 +0200, Rafael J. Wysocki wrote:
> > On Wed, Apr 24, 2019 at 8:59 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > >
> > > When suspend is aborted because of an ARMED irq, we can not get any
> > > useful information about which irq is triggered.
> > That should be provided via the /sys/power/pm_wakeup_irq attribute.
> >
> another case is that,
> say we got spurious wakeup interrupts in the idle loop, and then waked
> by a real wakeup interrupt, say, rtc.
> /sys/power/pm_wakeup_irq only shows the latest one,

No it doesn't, it shows the *first* one.

Please look at the code: pm_wakeup_irq is only set when it is zero
which is unless it has been set before.

> and we can not find out the spurious wakeup interrupts.

The wakeup interrupts that have occurred after the first one are not
recorded, but your patch doesn't change that.

Your patch causes pm_wakeup_irq to be added to the trace only when it
is set, but that is the /sys/power/pm_wakeup_irq which is my point.
