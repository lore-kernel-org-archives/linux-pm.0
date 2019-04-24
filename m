Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF2C10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9451B218FD
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 08:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfDXI6D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:58:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:61509 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfDXI6C (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 04:58:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 01:58:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="153293323"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2019 01:58:01 -0700
Message-ID: <1556096275.2744.28.camel@intel.com>
Subject: Re: [PATCH] PM: wakup: export wakeup irq when system aborts suspend
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Date:   Wed, 24 Apr 2019 16:57:55 +0800
In-Reply-To: <CAJZ5v0iJp1x+WReTTwQvx6GX+=U-imLkASkJVt9o4FhS74NJhQ@mail.gmail.com>
References: <1556089181-4246-1-git-send-email-rui.zhang@intel.com>
         <CAJZ5v0gfAzgzDuTZgghsm7h48_DK+zTmT9pEGrsqdsQE4xU-WA@mail.gmail.com>
         <1556092001.2744.11.camel@intel.com>
         <CAJZ5v0iJp1x+WReTTwQvx6GX+=U-imLkASkJVt9o4FhS74NJhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 三, 2019-04-24 at 10:32 +0200, Rafael J. Wysocki wrote:
> On Wed, Apr 24, 2019 at 9:46 AM Zhang Rui <rui.zhang@intel.com>
> wrote:
> > 
> > 
> > On 三, 2019-04-24 at 09:29 +0200, Rafael J. Wysocki wrote:
> > > 
> > > On Wed, Apr 24, 2019 at 8:59 AM Zhang Rui <rui.zhang@intel.com>
> > > wrote:
> > > > 
> > > > 
> > > > 
> > > > When suspend is aborted because of an ARMED irq, we can not get
> > > > any
> > > > useful information about which irq is triggered.
> > > That should be provided via the /sys/power/pm_wakeup_irq
> > > attribute.
> > > 
> > another case is that,
> > say we got spurious wakeup interrupts in the idle loop, and then
> > waked
> > by a real wakeup interrupt, say, rtc.
> > /sys/power/pm_wakeup_irq only shows the latest one,
> No it doesn't, it shows the *first* one.
> 
> Please look at the code: pm_wakeup_irq is only set when it is zero
> which is unless it has been set before.
> 

hmmm, by reading the code, pm_wakeup_clear() clears pm_wakeup_irq, and it is invoked inside the s2idle loop. So I think pm_wakeup_irq is cleared and set again if there is a second spurious interrupt.

> > and we can not find out the spurious wakeup interrupts.
> The wakeup interrupts that have occurred after the first one are not
> recorded, but your patch doesn't change that.
> 
> Your patch causes pm_wakeup_irq to be added to the trace only when it
> is set, but that is the /sys/power/pm_wakeup_irq which is my point.

yes, the first case (suspend aborted) can be covered
by /sys/power/pm_wakeup_irq.
For the spurious wakeup case, I think I observed the behavior before,
e.g, pm_wakeup_irq keeps on showing 9 because of spurious GPE, and then
 returns 8 because of RTC wakeup event. Anyway, let me do some
experimental to confirm and get back to you then.

thanks,
rui


