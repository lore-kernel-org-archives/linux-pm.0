From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / QoS: Drop PM_QOS_FLAG_REMOTE_WAKEUP
Date: Fri, 13 Oct 2017 15:04:42 +0200
Message-ID: <1840235.EQbbjP2bUY@aspire.rjw.lan>
References: <1853660.GWc8KbUC1W@aspire.rjw.lan> <CAPDyKFoxooS3QE6vjKr3DNOV6YadV8u0Btw8SWTGdL=EwAxLiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46832 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753290AbdJMNOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 09:14:14 -0400
In-Reply-To: <CAPDyKFoxooS3QE6vjKr3DNOV6YadV8u0Btw8SWTGdL=EwAxLiQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Friday, October 13, 2017 8:32:18 AM CEST Ulf Hansson wrote:
> On 13 October 2017 at 02:35, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The PM QoS flag PM_QOS_FLAG_REMOTE_WAKEUP is not used consistently
> > and the vast majority of code simply assumes that remote wakeup
> > should be enabled for devices in runtime suspend if they can
> > generate wakeup signals, so drop it.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> With a minor nitpick below, please add:
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> > ---
> >  drivers/acpi/device_pm.c    |    6 ++----
> >  drivers/base/power/domain.c |    4 +---
> >  drivers/base/power/sysfs.c  |   28 ----------------------------
> >  include/linux/pm_qos.h      |    1 -
> >  4 files changed, 3 insertions(+), 36 deletions(-)
> 
> I found the flag to also be mentioned in the
> Documentation/power/pm_qos_interface.txt, could please remove that
> part as well.

Right, and not only there.

That's how it goes when you try to document everything dutifully. :-)

I'll send an update shortly.

Thanks,
Rafael
