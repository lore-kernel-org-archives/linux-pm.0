From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] PM / QoS: Add function
	dev_pm_qos_read_value()
Date: Fri, 2 Sep 2011 00:07:22 +0200
Message-ID: <201109020007.22743.rjw__28712.8989272334$1314932946$gmane$org@sisk.pl>
References: <201108310017.03103.rjw@sisk.pl> <201108310021.13800.rjw@sisk.pl>
	<CAORVsuX=vKiGxHrR4hZjeT4DV0vhUh+MXLwNjoOwgBDu1HRR5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuX=vKiGxHrR4hZjeT4DV0vhUh+MXLwNjoOwgBDu1HRR5A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, September 01, 2011, Jean Pihet wrote:
> Hi Rafael,
> 
> On Wed, Aug 31, 2011 at 12:21 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > To read the current PM QoS value for a given device we need to
> > make sure that the device's power.constraints object won't be
> > removed while we're doing that.  For this reason, put the
> > operation under dev->power.lock and acquire the lock
> > around the initialization and removal of power.constraints.
> Ok.
> 
> > Moreover, since we're using the value of power.constraints to
> > determine whether or not the object is present, the
> > power.constraints_state field isn't necessary any more and may be
> > removed.  However, dev_pm_qos_add_request() needs to check if the
> > device is being removed from the system before allocating a new
> > PM QoS constraints object for it, so it has to use device_pm_lock()
> > and the device PM QoS initialization and destruction should be done
> > under device_pm_lock() as well.
> Ok that makes sense.
> The constraints_state field can be replaced by a combination of
> dev->power.constraints and list_empty(&dev->power.entry), which makes
> the code more compact and less redundant.
> 
> >
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> >  drivers/base/power/main.c |    4 -
> >  drivers/base/power/qos.c  |  167 ++++++++++++++++++++++++++--------------------
> >  include/linux/pm.h        |    8 --
> >  include/linux/pm_qos.h    |    3
> >  4 files changed, 101 insertions(+), 81 deletions(-)
> >
> > Index: linux/drivers/base/power/qos.c
> > ===================================================================
> > --- linux.orig/drivers/base/power/qos.c
> > +++ linux/drivers/base/power/qos.c
> > @@ -30,15 +30,6 @@
> ...
> 
> >
> > @@ -178,8 +202,8 @@ void dev_pm_qos_constraints_destroy(stru
> >  *
> >  * Returns 1 if the aggregated constraint value has changed,
> >  * 0 if the aggregated constraint value has not changed,
> > - * -EINVAL in case of wrong parameters, -ENODEV if the device has been
> > - * removed from the system
> > + * -EINVAL in case of wrong parameters, -ENOMEM if there's not enough memory
> > + * to allocate for data structures.
> Why not use -ENODEV in case there is no device?

I don't think it's useful for the caller.  If the device is gone, the
constraing simply doesn't matter, so there's no error to handle.

> >  */
> >  int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
> >                           s32 value)
> > @@ -195,28 +219,35 @@ int dev_pm_qos_add_request(struct device
> >                return -EINVAL;
> >        }
> >
> > -       mutex_lock(&dev_pm_qos_mtx);
> >        req->dev = dev;
> >
> > -       /* Return if the device has been removed */
> > -       if (req->dev->power.constraints_state == DEV_PM_QOS_NO_DEVICE) {
> > -               ret = -ENODEV;
> > -               goto out;
> > -       }
> > +       device_pm_lock();
> > +       mutex_lock(&dev_pm_qos_mtx);
> >
> > -       /*
> > -        * Allocate the constraints data on the first call to add_request,
> > -        * i.e. only if the data is not already allocated and if the device has
> > -        * not been removed
> > -        */
> > -       if (dev->power.constraints_state == DEV_PM_QOS_DEVICE_PRESENT)
> > -               ret = dev_pm_qos_constraints_allocate(dev);
> > +       if (dev->power.constraints) {
> > +               device_pm_unlock();
> > +       } else {
> > +               if (list_empty(&dev->power.entry)) {
> > +                       /* The device has been removed from the system. */
> > +                       device_pm_unlock();
> > +                       goto out;
> 0 is silently returned in case the device has been removed. Is that
> the intention?

Pretty much it is.  Is that a problem?

Rafael
