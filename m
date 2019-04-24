Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBFC282CE
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A32E218D3
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 07:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729878AbfDXHqt (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 03:46:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:8971 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726707AbfDXHqs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 03:46:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 00:46:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="138345395"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2019 00:46:47 -0700
Message-ID: <1556092001.2744.11.camel@intel.com>
Subject: Re: [PATCH] PM: wakup: export wakeup irq when system aborts suspend
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 24 Apr 2019 15:46:41 +0800
In-Reply-To: <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com>
References: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 三, 2019-04-24 at 09:29 +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 8:59 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > When suspend is aborted because of an ARMED irq, we can not get any
> > useful information about which irq is triggered.
> That should be provided via the /sys/power/pm_wakeup_irq attribute.
> 
another case is that,
say we got spurious wakeup interrupts in the idle loop, and then waked
by a real wakeup interrupt, say, rtc.
/sys/power/pm_wakeup_irq only shows the latest one, and we can not find
out the spurious wakeup interrupts.

I should add this in the changelog as well.

thanks,
rui

> > 
> > Export the wakeup irq via suspend_resume trace event in this case.
> > 
> > Signed-off-by: Brandt, Todd E <todd.e.brandt@intel.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/base/power/wakeup.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/base/power/wakeup.c
> > b/drivers/base/power/wakeup.c
> > index bb1ae17..d32bd91 100644
> > --- a/drivers/base/power/wakeup.c
> > +++ b/drivers/base/power/wakeup.c
> > @@ -875,6 +875,7 @@ void pm_system_irq_wakeup(unsigned int
> > irq_number)
> >  {
> >         if (pm_wakeup_irq == 0) {
> >                 pm_wakeup_irq = irq_number;
> > +               trace_suspend_resume(TPS("irq_wakeup"), irq_number,
> > true);
> pm_wakeup_irq can be read from /sys/power/pm_wakeup_irq, so why is it
> necessary to trace it additionally?
> 
> > 
> >                 pm_system_wakeup();
> >         }
> >  }
> > --
