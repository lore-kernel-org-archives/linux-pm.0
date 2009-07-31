From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH update] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 11)
Date: Fri, 31 Jul 2009 20:53:17 +0200
Message-ID: <200907312053.17914.rjw@sisk.pl>
References: <200907221701.50449.rjw@sisk.pl> <200907222110.47701.rjw@sisk.pl>
	<aec7e5c30907310732u35faa15fpab070025f596463e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30907310732u35faa15fpab070025f596463e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday 31 July 2009, Magnus Damm wrote:
> Hi Rafail

Hi,

> [Runtime PM v11]
> 
> Thanks for your work on this. The code is getting better and better.
> I've just finished posting a bunch of patches related to v11 of your
> Runtime PM patch. Basically everything seems fine except a few minor
> details and the code below: =)

Thanks a lot for your feedback.

> On Thu, Jul 23, 2009 at 4:10 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > On Wednesday 22 July 2009, Rafael J. Wysocki wrote:
> > Index: linux-2.6/drivers/base/dd.c
> > ===================================================================
> > --- linux-2.6.orig/drivers/base/dd.c
> > +++ linux-2.6/drivers/base/dd.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/wait.h>
> >  #include <linux/async.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #include "base.h"
> >  #include "power/power.h"
> > @@ -202,7 +203,9 @@ int driver_probe_device(struct device_dr
> >        pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
> >                 drv->bus->name, __func__, dev_name(dev), drv->name);
> >
> > +       pm_runtime_get_noresume(dev);
> >        ret = really_probe(dev, drv);
> > +       pm_runtime_put_noidle(dev);
> >
> >        return ret;
> >  }
> 
> This creates problems when drivers want to performing runtime resume
> from within probe(). For more details please have a look at "[PATCH
> 04/04] video: Runtime PM hack for SuperH LCDC driver".

Ah, I see.  You'd like to call pm_runtime_get_sync() from .probe(), but that
sees the usage counter different from zero and exits immediately.

OTOH, I think we should prevent suspends from racing with .probe() at the core
level.  Hmm.

One possible approach could be to call pm_runtime_resume() from
sh_mobile_lcdc_probe() instead of pm_runtime_put_noidle().  Then, the platform
code will have a chance to turn the device on and the later pm_runtime_get*()
and pm_runtime_put*() calls will be balanced.  Of course, in that case the
pm_runtime_get_noresume() in sh_mobile_lcdc_probe() won't be necessary any
more.  Am I overlooking anything?

Rafael
