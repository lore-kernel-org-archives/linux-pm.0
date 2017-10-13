From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / core: Fix kerneldoc comments of three functions
Date: Fri, 13 Oct 2017 15:05:25 +0200
Message-ID: <1593070.jr9culxkab@aspire.rjw.lan>
References: <1805031.1a2Ur49QVy@aspire.rjw.lan> <CAPDyKFoi_UGJzk9nWR6V5PgecvdVVSBzg8EQBLF6aMUXVFj_ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoi_UGJzk9nWR6V5PgecvdVVSBzg8EQBLF6aMUXVFj_ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux Documentation <linux-doc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, October 13, 2017 8:48:30 AM CEST Ulf Hansson wrote:
> On 13 October 2017 at 02:33, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Fix kerneldoc comments of __device_suspend_noirq(),
> > __device_suspend_late() and __device_suspend() where the function
> > names in kerneldoc don't match the actual names of the functions.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |    6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Index: linux-pm/drivers/base/power/main.c
> > ===================================================================
> > --- linux-pm.orig/drivers/base/power/main.c
> > +++ linux-pm/drivers/base/power/main.c
> > @@ -1077,7 +1077,7 @@ static pm_message_t resume_event(pm_mess
> >  }
> >
> >  /**
> > - * device_suspend_noirq - Execute a "late suspend" callback for given device.
> > + * __device_suspend_noirq - Execute a "late suspend" callback for given device.
> 
> While at it, I suggest to also change "late suspend" to "noirq suspend".
> 
> As a matter of fact I found the similar text to be wrong also for
> device_resume_noirq(), perhaps that should be fixed as well.

Right, I will do that.

Thanks,
Rafael
