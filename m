From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3] PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
Date: Thu, 24 Nov 2016 02:14:10 +0100
Message-ID: <2464704.SUWQ90frYr@vostro.rjw.lan>
References: <1476370734-23168-1-git-send-email-ulf.hansson@linaro.org> <CAPDyKFozunxSTBY_vWbdOFRjSHOjpb+KKTJsdMj+dPpzNCyi-w@mail.gmail.com> <CAJZ5v0gxPzK=YVcG4kR+07VW8_NxfczNSyu+m8PtvE4=5dUxYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46659 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935318AbcKXBGY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Nov 2016 20:06:24 -0500
In-Reply-To: <CAJZ5v0gxPzK=YVcG4kR+07VW8_NxfczNSyu+m8PtvE4=5dUxYA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Walleij <linus.walleij@linaro.org>

On Saturday, November 19, 2016 12:13:03 AM Rafael J. Wysocki wrote:
> On Fri, Nov 18, 2016 at 11:50 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On 17 November 2016 at 22:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >> On Thu, Nov 17, 2016 at 9:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>> On 13 October 2016 at 16:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>>> When the pm_runtime_force_suspend|resume() helpers were invented, we still
> >>>> had CONFIG_PM_RUNTIME and CONFIG_PM_SLEEP as separate Kconfig options.
> >>>>
> >>>> To make sure these helpers worked for all combinations and without
> >>>> introducing too much of complexity, the device was always resumed in
> >>>> pm_runtime_force_resume().
> >>>>
> >>>> More precisely, when CONFIG_PM_SLEEP was set and CONFIG_PM_RUNTIME was
> >>>> unset, we needed to resume the device as the subsystem/driver couldn't
> >>>> rely on using runtime PM to do it.
> >>>>
> >>>> As the CONFIG_PM_RUNTIME option was merged into CONFIG_PM a while ago, it
> >>>> removed this combination, of using CONFIG_PM_SLEEP without the earlier
> >>>> CONFIG_PM_RUNTIME.
> >>>>
> >>>> For this reason we can now rely on the subsystem/driver to use runtime PM
> >>>> to resume the device, instead of forcing that to be done in all cases. In
> >>>> other words, let's defer the runtime resume to a later point when it's
> >>>> actually needed.
> >>>>
> >>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >>>
> >>> Rafael, this one is ready to be queued. Unless there are other objections.
> >>
> >> Not an objection, but I'd like to revisit this when the device
> >> dependencies work gets in, as something similar may need to be done
> >> for suppliers, in principle.
> >
> > I certainly think it would make sense to extend this approach to also
> > respect device-dependencies.
> >
> > However, I suggest we deal with that as a second step, on top of
> > $subject patch. It should not be a problem, as we don't have any users
> > of device-dependencies that also uses
> > pm_runtime_force_suspend|resume(), right?
> >
> > Queuing this now, also allow us to get this more widely tested, before
> > we continue extending it for dependencies.
> 
> Fair enough.

The patch has been queued up for 4.10.

Thanks,
Rafael

