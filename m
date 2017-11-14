From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / runtime: Drop children check from __pm_runtime_set_status()
Date: Tue, 14 Nov 2017 22:44:39 +0100
Message-ID: <5072995.lhOZmqyh0S@aspire.rjw.lan>
References: <1713438.irjm9MTSvo@aspire.rjw.lan> <CAPDyKFrzJuWVr9hmcU-S6LMMGTh2pyQcjMJc2+ky5AmctatOLQ@mail.gmail.com> <CAPDyKFo0pufKdZ=5Dn84UewE7qN3ztVKjRV1_TyM_DcxX2B7Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58965 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754627AbdKNVow (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 16:44:52 -0500
In-Reply-To: <CAPDyKFo0pufKdZ=5Dn84UewE7qN3ztVKjRV1_TyM_DcxX2B7Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

On Tuesday, November 14, 2017 10:56:39 AM CET Ulf Hansson wrote:
> On 14 November 2017 at 10:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 13 November 2017 at 22:50, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> On Monday, November 13, 2017 2:26:28 PM CET Ulf Hansson wrote:
> >>> On 12 November 2017 at 01:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >>> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> >
> >>> > The check for "active" children in __pm_runtime_set_status(), when
> >>> > trying to set the parent device status to "suspended", doesn't
> >>> > really make sense, because in fact it is not invalid to set the
> >>> > status of a device with runtime PM disabled to "suspended" in any
> >>> > case.  It is invalid to enable runtime PM for a device with its
> >>> > status set to "suspended" while its child_count reference counter
> >>> > is nonzero, but the check in __pm_runtime_set_status() doesn't
> >>> > really cover that situation.
> >>>
> >>> The reason to why I changed this in commit a8636c89648a ("PM /
> >>> Runtime: Don't allow to suspend a device with an active child") was
> >>> because to get a consistent behavior.
> >>
> >> Well, it causes the function to return an error in a non-error situation,
> >> which IMnsHO is a bug.
> >>
> >>> Because, setting the device's status to active (RPM_ACTIVE) via
> >>> __pm_runtime_set_status(), requires its parent to also be active (in
> >>> case the parent has runtime PM enabled).
> >>
> >> No!!!
> >>
> >> The check is in there, because the parent's usage_count is affected by that
> >> code and incrementing it in case the parent has runtime PM enabled and is
> >> RPM_SUSPENDED leads to an inconsistent runtime PM state of the parent.  IOW,
> >> it would confuse the framework.
> >
> > Right, I do understand the reasons *why* it is like this.
> >
> >>
> >> There's no such issue if the runtime PM status of a child is set to RPM_SUSPENDED.
> >>
> >> It is all consistent without the check I'm removing and is made inconsistent
> >> by that very check.
> >>
> >>> I would prefer to try maintain this consistency, but I also I realize
> >>> that commit a8636c89648a, should also have been checking if the parent
> >>> has runtime PM enabled (again for consistency), which it doesn't.
> >>>
> >>> What about fixing that instead?
> >>
> >> Runtime PM is *disabled* for the parent at this point, guaranteed, so there's
> >> nothing to check, I'm afraid ...
> >
> > Where and how is that guarantee made?
> 
> Oh, just realize that it should be "child" instead of "parent", in the
> above reasoning. Apologize for giving the wrong argument.
> 
> So, let's me take this once again, to make it clear.
> 
> When pm_runtime_set_suspended(dev) is called, dev's child device may
> still be runtime PM enabled and active.
> I was suggesting to add a check for this scenario, to see if dev's
> child device is runtime PM is enabled, as and additional constraint
> before deciding to return an error code.

Well, that's sort of difficult to do, however, because the code would need to
walk all of the children of the device and the child power lock cannot be
acquired under the one of the parent, so it would be fragile and ugly.

> The idea was to get a consistent behavior, from the
> pm_runtime_set_active|suspended() APIs point of view, and not from the
> runtime PM core point of view.

Yes, but the cost is high and the benefit is shallow.

The enable-time WARN() should cover the really broken cases without that
much complexity.

Thanks,
Rafael
