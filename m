From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Document new pm_runtime_set_suspended constraint
Date: Fri, 28 Jul 2017 01:55:33 +0200
Message-ID: <1947994.JPBmfa77ej@aspire.rjw.lan>
References: <20170724095356.21667-1-johan@kernel.org> <CAPDyKFrp4wNJs_pc+hM6zv7ZRBjWjJ9Cf3GdtjPPMECQgNChaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:42347 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751565AbdG1ADf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 20:03:35 -0400
In-Reply-To: <CAPDyKFrp4wNJs_pc+hM6zv7ZRBjWjJ9Cf3GdtjPPMECQgNChaA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Lindgren <tony@atomide.com>

On Thursday, July 27, 2017 03:20:16 PM Ulf Hansson wrote:
> On 24 July 2017 at 11:53, Johan Hovold <johan@kernel.org> wrote:
> > Since commit a8636c89648a ("PM / Runtime: Don't allow to suspend a
> > device with an active child") it is no longer permitted to set
> > RPM_SUSPENDED state for a device with active children unless
> > power.ignore_children is set.
> >
> > Update the documentation to reflect this.
> >
> > Cc: Alan Stern <stern@rowland.harvard.edu>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied, thanks!
