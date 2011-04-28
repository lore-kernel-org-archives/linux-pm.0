From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Generic clock
	manipulation rountines for runtime PM (v3)
Date: Thu, 28 Apr 2011 02:58:34 +0200
Message-ID: <201104280258.34694.rjw__2785.35317997939$1303952380$gmane$org@sisk.pl>
References: <201104130205.26988.rjw@sisk.pl> <201104272348.24084.rjw@sisk.pl>
	<BANLkTimHkKq9+0z-4CZs=34GNO6Ab0wZPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimHkKq9+0z-4CZs=34GNO6Ab0wZPQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Colin Cross <ccross@google.com>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, April 28, 2011, Colin Cross wrote:
> On Wed, Apr 27, 2011 at 2:48 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Many different platforms and subsystems may want to disable device
> > clocks during suspend and enable them during resume which is going to
> > be done in a very similar way in all those cases.  For this reason,
> > provide generic routines for the manipulation of device clocks during
> > suspend and resume.
> >
> > Convert the ARM shmobile platform to using the new routines.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >
> > Hi,
> >
> > This (hopefully final) version of the patch has a couple of bugs fixed in
> > clock_ops.c.
> >
> > Thanks,
> > Rafael
> >
> > ---
> >  arch/arm/mach-shmobile/pm_runtime.c |  140 -----------
> >  drivers/base/power/Makefile         |    1
> >  drivers/base/power/clock_ops.c      |  423 ++++++++++++++++++++++++++++++++++++
> >  include/linux/pm_runtime.h          |   42 +++
> >  kernel/power/Kconfig                |    4
> >  5 files changed, 479 insertions(+), 131 deletions(-)
> >
> <snip>
> > +void pm_runtime_clk_remove(struct device *dev, const char *con_id)
> > +{
> > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > +       struct pm_clock_entry *ce;
> > +
> > +       if (!prd)
> > +               return;
> > +
> > +       mutex_lock(&prd->lock);
> > +
> > +       list_for_each_entry(ce, &prd->clock_list, node)
> Braces

No, this is correct as is.

> > +               if (!con_id && !ce->con_id) {
> > +                       __pm_runtime_clk_remove(ce);
> > +                       break;
> > +               } else if (!con_id || !ce->con_id) {
> > +                       continue;
> > +               } else if (!strcmp(con_id, ce->con_id)) {
> > +                       __pm_runtime_clk_remove(ce);
> > +                       break;
> > +               }
> > +
> > +       mutex_unlock(&prd->lock);
> > +}
> >
> > +/**
> > + * pm_runtime_clk_acquire - Acquire a device clock.
> > + * @dev: Device whose clock is to be acquired.
> > + * @con_id: Connection ID of the clock.
> > + */
> > +static void pm_runtime_clk_acquire(struct device *dev,
> > +                                   struct pm_clock_entry *ce)
> > +{
> > +       ce->clk = clk_get(dev, ce->con_id);
> > +       if (!IS_ERR(ce->clk)) {
> > +               ce->clock_active = true;
> > +               dev_dbg(dev, "Clock %s managed by runtime PM.\n", ce->con_id);
> > +       }
> > +}
> > +
> > +/**
> > + * pm_runtime_clk_suspend - Disable clocks in a device's runtime PM clock list.
> > + * @dev: Device to disable the clocks for.
> > + */
> > +int pm_runtime_clk_suspend(struct device *dev)
> > +{
> > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > +       struct pm_clock_entry *ce;
> > +
> > +       dev_dbg(dev, "%s()\n", __func__);
> > +
> > +       if (!prd)
> > +               return 0;
> > +
> > +       mutex_lock(&prd->lock);
> > +
> > +       list_for_each_entry_reverse(ce, &prd->clock_list, node) {
> > +               if (!ce->clk) {
> > +                       dev_err(dev, "Clock is not ready for runtime PM\n");
> > +                       pm_runtime_clk_acquire(dev, ce);
> Why delay the call to clk_get until the first suspend?

Because the clock framework need not be ready at the _add time.

> Also, this will always print an error during the first call to suspend.

That actually depends on the initial state of the device and the
assumption is that will be RPM_SUSPENDED, so _resume will be called
first.

I can remove the message, but it's there for backwards compatibility with
the code this is intended to replace.

> > +               }
> > +
> > +               if (ce->clock_active) {
> I don't think clock_active is necessary, and the name is misleading.

It's not strictly necessary and "active" means "being used for runtime PM".

> Why not use if (ce->clk)?

Because _that_ would be confusing?

> > +                       clk_disable(ce->clk);
> > +                       ce->clock_enabled = false;
> Clock enables are already refcounted, do you really need a flag as
> well?  In what situations would pm_runtime_clk_remove get called,
> which currently needs to know when the clock is enabled?

When the device object is removed, for whatever reason.

> > +               }
> > +       }
> > +
> > +       mutex_unlock(&prd->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * pm_runtime_clk_resume - Enable clocks in a device's runtime PM clock list.
> > + * @dev: Device to enable the clocks for.
> > + */
> > +int pm_runtime_clk_resume(struct device *dev)
> > +{
> > +       struct pm_runtime_clk_data *prd = __to_prd(dev);
> > +       struct pm_clock_entry *ce;
> > +
> > +       dev_dbg(dev, "%s()\n", __func__);
> > +
> > +       if (!prd)
> > +               return 0;
> > +
> > +       mutex_lock(&prd->lock);
> > +
> > +       list_for_each_entry(ce, &prd->clock_list, node) {
> > +               if (!ce->clk)
> > +                       pm_runtime_clk_acquire(dev, ce);
> If the clock was not present during suspend, should you be enabling it
> during resume?

Because resume is called first as the initial state of the device
is assumed to be RPM_SUSPENDED.

> > +
> > +               if (ce->clock_active) {
> > +                       clk_enable(ce->clk);
> > +                       ce->clock_enabled = true;
> > +               }
> > +       }
> > +
> > +       mutex_unlock(&prd->lock);
> > +
> > +       return 0;
> > +}

HTH,
Rafael
