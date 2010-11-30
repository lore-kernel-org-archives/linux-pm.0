From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: Prevent dpm_prepare() from returning
	errors unnecessarily
Date: Tue, 30 Nov 2010 23:23:50 +0100
Message-ID: <201011302323.50475.rjw__6109.03776619143$1291156066$gmane$org@sisk.pl>
References: <201011281312.49949.rjw@sisk.pl>
	<AANLkTi=tgEug5EUpqV1-GLFh9rsD5obAyExe+V=CjsbO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=tgEug5EUpqV1-GLFh9rsD5obAyExe+V=CjsbO@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 30, 2010, Ming Lei wrote:
> 2010/11/28 Rafael J. Wysocki <rjw@sisk.pl>:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Currently dpm_prepare() returns error code if it finds that a device
> > being suspended has a pending runtime resume request.  However, it
> > should not do that if the checking for wakeup events is not enabled.
> > On the other hand, if the checking for wakeup events is enabled, it
> > can return error when a wakeup event is detected, regardless of its
> > source.
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/base/power/main.c |   11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > Index: linux-2.6/drivers/base/power/main.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/power/main.c
> > +++ linux-2.6/drivers/base/power/main.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/sched.h>
> >  #include <linux/async.h>
> > +#include <linux/suspend.h>
> >
> >  #include "../base.h"
> >  #include "power.h"
> > @@ -1052,8 +1053,10 @@ static int dpm_prepare(pm_message_t stat
> >                mutex_unlock(&dpm_list_mtx);
> >
> >                pm_runtime_get_noresume(dev);
> > -               if (pm_runtime_barrier(dev) && device_may_wakeup(dev)) {
> > -                       /* Wake-up requested during system sleep transition. */
> > +               if (pm_runtime_barrier(dev) && device_may_wakeup(dev))
> > +                       pm_wakeup_event(dev, 0);
> > +
> > +               if (pm_check_wakeup_events()) {
> 
> If pm_check_wakeup_events returns true, it means there is no wakeup event
> coming, so seems should handle normal suspend prepare, but why
> abort the suspend here?

That's a bug, it should be !pm_check_wakeup_events() instead.

Thanks,
Rafael
