From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 0/3] Move pm_runtime accounted time to raw nsec
Date: Thu, 31 Jan 2019 08:43:36 +0100
Message-ID: <CAPDyKFpNqANViRhmZXLTbwvP-Gn7Xt1JxKS4noyBH08h7Y0CcA@mail.gmail.com>
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org> <2577730.BvIW2u5g9k@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2577730.BvIW2u5g9k@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thara Gopinath <thara.gopinath@linaro.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Jan 2019 at 00:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Wednesday, January 23, 2019 8:50:12 AM CET Vincent Guittot wrote:
> > Move pm_runtime accounted time to raw nsec. The subject of the patchset
> > has changed as 1st patch o the previous versions has been queued by
> > Rafael.
> >
> > Patch 1 set accounting_timestamp to 0 in pm_runtime_init and update it when enable.
> > So we remove ordering constraint between timekeeping_init and pm_runtime_init
> >
> > Patch 2 moves time accounting on raw ns. This patch initially used
> > ktime instead of raw ns but it was easier to move i915 driver on raw ns
> > than on ktime.
> >
> > Change since v6:
> > - move code that set accounting_timestamp in pm_runtime_enable
> >
> > Changes since v5:
> > - removed patches already queued.
> > - set accounting_timestamp to 0 in pm_runtime_init and update it when enable
> >
> > Changes since v4:
> > -Update commit message
> >
> > Changes since v3:
> > - Rebase on v4.20-rc7 without patch that has been queued by Rafael
> > - Simplify the new interface pm_runtime_suspended_time()
> >
> > Changes since v2:
> > - remove patch1 that has been queued by rafael
> > - add new interface in pm_runtime to get accounted time
> > - reorder patchset to prevent compilation error
> >
> > Changes since v1:
> > - updated commit message of patch 1
> > - Added patches 2 & 3 to move runtime_pm accounting on raw ns
> >
> > Thara Gopinath (1):
> >   PM-runtime: Replace jiffies based accounting with ktime-based
> >     accounting
> >
> > Vincent Guittot (1):
> >   PM-runtime: update accounting_timestamp only when enable
> >
> >  drivers/base/power/runtime.c | 26 ++++++++++++++++----------
> >  drivers/base/power/sysfs.c   | 11 ++++++++---
> >  include/linux/pm.h           |  6 +++---
> >  3 files changed, 27 insertions(+), 16 deletions(-)
>
> Both patches applied, thanks!
>

I had some comment on v6, none that needs to prevent this from being
applied and that can't be addressed as improvements on top.

Feel free to add (if not too late) my:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
