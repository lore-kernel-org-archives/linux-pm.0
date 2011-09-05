From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/5] PM / QoS: Add function
	dev_pm_qos_read_value()
Date: Mon, 5 Sep 2011 09:51:54 +0200
Message-ID: <CAORVsuXtgd6hTvpkoHobSGKrXgMB1L8dSVbkkt071useNRdngg__27103.5146587112$1315209176$gmane$org@mail.gmail.com>
References: <201108310017.03103.rjw@sisk.pl>
	<CAORVsuVAzc8Q2tG0-WW+96Ad9GhR5OCq2bAuweggs1rimFMcqg@mail.gmail.com>
	<201109030155.28031.rjw@sisk.pl> <201109031002.51487.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201109031002.51487.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sat, Sep 3, 2011 at 10:02 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Saturday, September 03, 2011, Rafael J. Wysocki wrote:
>> On Friday, September 02, 2011, Jean Pihet wrote:
>> > On Fri, Sep 2, 2011 at 12:07 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> ...
>> > >> >
>> > >> > - =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>> > >> > =A0 =A0 =A0 =A0req->dev =3D dev;
>> > >> >
>> > >> > - =A0 =A0 =A0 /* Return if the device has been removed */
>> > >> > - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM=
_QOS_NO_DEVICE) {
>> > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > >> > - =A0 =A0 =A0 }
>> > >> > + =A0 =A0 =A0 device_pm_lock();
>> > >> > + =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>> > >> >
>> > >> > - =A0 =A0 =A0 /*
>> > >> > - =A0 =A0 =A0 =A0* Allocate the constraints data on the first cal=
l to add_request,
>> > >> > - =A0 =A0 =A0 =A0* i.e. only if the data is not already allocated=
 and if the device has
>> > >> > - =A0 =A0 =A0 =A0* not been removed
>> > >> > - =A0 =A0 =A0 =A0*/
>> > >> > - =A0 =A0 =A0 if (dev->power.constraints_state =3D=3D DEV_PM_QOS_=
DEVICE_PRESENT)
>> > >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constraints_allo=
cate(dev);
>> > >> > + =A0 =A0 =A0 if (dev->power.constraints) {
>> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
>> > >> > + =A0 =A0 =A0 } else {
>> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&dev->power.entry)) {
>> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The device has b=
een removed from the system. */
>> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
>> > >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> > >> 0 is silently returned in case the device has been removed. Is that
>> > >> the intention?
>> > >
>> > > Pretty much it is. =A0Is that a problem?
>> > I think the caller needs to know if the constraint has been applied
>> > correctly or not.
>>
>> However, the removal of the device is a special case. =A0What would the =
caller
>> be supposed to do when it learned that the device had been removed while=
 it had
>> been trying to add a QoS constraing for it? =A0Not much I guess.
>
> Anyway, since returning an error code in that case won't hurt either,
> below is a v2 of the patch doing that and resetting the dev field in the
> req structure.
Ok thanks for the update. The comments are inlined below.

>
> Thanks,
> Rafael
>
> ---
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM / QoS: Add function dev_pm_qos_read_value() (v2)
>
> To read the current PM QoS value for a given device we need to
> make sure that the device's power.constraints object won't be
> removed while we're doing that. =A0For this reason, put the
> operation under dev->power.lock and acquire the lock
> around the initialization and removal of power.constraints.
>
> Moreover, since we're using the value of power.constraints to
> determine whether or not the object is present, the
> power.constraints_state field isn't necessary any more and may be
> removed. =A0However, dev_pm_qos_add_request() needs to check if the
> device is being removed from the system before allocating a new
> PM QoS constraints object for it, so it has to use device_pm_lock()
> and the device PM QoS initialization and destruction should be done
> under device_pm_lock() as well.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/base/power/main.c | =A0 =A04 -
> =A0drivers/base/power/qos.c =A0| =A0170 ++++++++++++++++++++++++++-------=
-------------
> =A0include/linux/pm.h =A0 =A0 =A0 =A0| =A0 =A08 --
> =A0include/linux/pm_qos.h =A0 =A0| =A0 =A03
> =A04 files changed, 104 insertions(+), 81 deletions(-)
>
> Index: linux/drivers/base/power/qos.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/base/power/qos.c
> +++ linux/drivers/base/power/qos.c
> @@ -30,15 +30,6 @@
> =A0* . To minimize the data usage by the per-device constraints, the data=
 struct
> =A0* =A0 is only allocated at the first call to dev_pm_qos_add_request.
> =A0* . The data is later free'd when the device is removed from the syste=
m.
> - * . The constraints_state variable from dev_pm_info tracks the data str=
uct
> - * =A0 =A0allocation state:
> - * =A0 =A0DEV_PM_QOS_NO_DEVICE: No device present or device removed, no =
data
> - * =A0 =A0 allocated,
> - * =A0 =A0DEV_PM_QOS_DEVICE_PRESENT: Device present, data not allocated =
and will be
> - * =A0 =A0 allocated at the first call to dev_pm_qos_add_request,
> - * =A0 =A0DEV_PM_QOS_ALLOCATED: Device present, data allocated. The per-=
device
> - * =A0 =A0 PM QoS constraints framework is operational and constraints c=
an be
> - * =A0 =A0 added, updated or removed using the dev_pm_qos_* API.
> =A0* =A0. A global mutex protects the constraints users from the data bei=
ng
> =A0* =A0 =A0 allocated and free'd.
> =A0*/
> @@ -51,8 +42,30 @@
>
>
> =A0static DEFINE_MUTEX(dev_pm_qos_mtx);
> +
> =A0static BLOCKING_NOTIFIER_HEAD(dev_pm_notifiers);
>
> +/**
> + * dev_pm_qos_read_value - Get PM QoS constraint for a given device.
> + * @dev: Device to get the PM QoS constraint value for.
> + */
> +s32 dev_pm_qos_read_value(struct device *dev)
> +{
> + =A0 =A0 =A0 struct pm_qos_constraints *c;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 s32 ret =3D 0;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&dev->power.lock, flags);
> +
> + =A0 =A0 =A0 c =3D dev->power.constraints;
> + =A0 =A0 =A0 if (c)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D pm_qos_read_value(c);
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&dev->power.lock, flags);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/*
> =A0* apply_constraint
> =A0* @req: constraint request to apply
> @@ -105,27 +118,37 @@ static int dev_pm_qos_constraints_alloca
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0BLOCKING_INIT_NOTIFIER_HEAD(n);
>
> + =A0 =A0 =A0 plist_head_init(&c->list);
> + =A0 =A0 =A0 c->target_value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
> + =A0 =A0 =A0 c->default_value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
> + =A0 =A0 =A0 c->type =3D PM_QOS_MIN;
> + =A0 =A0 =A0 c->notifiers =3D n;
> +
> + =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> =A0 =A0 =A0 =A0dev->power.constraints =3D c;
> - =A0 =A0 =A0 plist_head_init(&dev->power.constraints->list);
> - =A0 =A0 =A0 dev->power.constraints->target_value =3D PM_QOS_DEV_LAT_DEF=
AULT_VALUE;
> - =A0 =A0 =A0 dev->power.constraints->default_value =3D PM_QOS_DEV_LAT_DE=
FAULT_VALUE;
> - =A0 =A0 =A0 dev->power.constraints->type =3D PM_QOS_MIN;
> - =A0 =A0 =A0 dev->power.constraints->notifiers =3D n;
> - =A0 =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_ALLOCATED;
> + =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void __dev_pm_qos_constraints_init(struct device *dev)
> +{
> + =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
> + =A0 =A0 =A0 dev->power.constraints =3D NULL;
> + =A0 =A0 =A0 spin_unlock_irq(&dev->power.lock);
> +}
> +
> =A0/**
> - * dev_pm_qos_constraints_init
> + * dev_pm_qos_constraints_init - Initalize device's PM QoS constraints p=
ointer.
> =A0* @dev: target device
> =A0*
> - * Called from the device PM subsystem at device insertion
> + * Called from the device PM subsystem at device insertion under
> + * device_pm_lock().
> =A0*/
> =A0void dev_pm_qos_constraints_init(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
> - =A0 =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_DEVICE_PRESENT;
> + =A0 =A0 =A0 dev->power.constraints =3D NULL;
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> =A0}
>
> @@ -133,34 +156,35 @@ void dev_pm_qos_constraints_init(struct
> =A0* dev_pm_qos_constraints_destroy
> =A0* @dev: target device
> =A0*
> - * Called from the device PM subsystem at device removal
> + * Called from the device PM subsystem at device removal under device_pm=
_lock().
> =A0*/
> =A0void dev_pm_qos_constraints_destroy(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct dev_pm_qos_request *req, *tmp;
> + =A0 =A0 =A0 struct pm_qos_constraints *c;
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 if (dev->power.constraints_state =3D=3D DEV_PM_QOS_ALLOCATE=
D) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Flush the constraints list for the devic=
e */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 plist_for_each_entry_safe(req, tmp,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &dev->power.constraints->list,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 node) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Update constraints lis=
t and call the notification
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* callbacks if needed
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 apply_constraint(req, PM_QO=
S_REMOVE_REQ,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0PM_QOS_DEFAULT_VALUE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(req, 0, sizeof(*req)=
);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 c =3D dev->power.constraints;
> + =A0 =A0 =A0 if (!c)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints->notifiers);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.constraints =3D NULL;
> + =A0 =A0 =A0 /* Flush the constraints list for the device */
> + =A0 =A0 =A0 plist_for_each_entry_safe(req, tmp, &c->list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Update constraints list and call the n=
otification
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* callbacks if needed
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 apply_constraint(req, PM_QOS_REMOVE_REQ, PM=
_QOS_DEFAULT_VALUE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(req, 0, sizeof(*req));
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_NO_DEVICE;
>
> + =A0 =A0 =A0 __dev_pm_qos_constraints_init(dev);
> +
> + =A0 =A0 =A0 kfree(c->notifiers);
> + =A0 =A0 =A0 kfree(c);
> +
> + out:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> =A0}
>
> @@ -178,8 +202,9 @@ void dev_pm_qos_constraints_destroy(stru
> =A0*
> =A0* Returns 1 if the aggregated constraint value has changed,
> =A0* 0 if the aggregated constraint value has not changed,
> - * -EINVAL in case of wrong parameters, -ENODEV if the device has been
> - * removed from the system
> + * -EINVAL in case of wrong parameters, -ENOMEM if there's not enough me=
mory
> + * to allocate for data structures, -ENODEV if the device has just been =
removed
> + * from the system.
> =A0*/
> =A0int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_reque=
st *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 value)
> @@ -195,28 +220,37 @@ int dev_pm_qos_add_request(struct device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
> =A0 =A0 =A0 =A0req->dev =3D dev;
>
> - =A0 =A0 =A0 /* Return if the device has been removed */
> - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_QOS_NO_=
DEVICE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 device_pm_lock();
> + =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Allocate the constraints data on the first call to add=
_request,
> - =A0 =A0 =A0 =A0* i.e. only if the data is not already allocated and if =
the device has
> - =A0 =A0 =A0 =A0* not been removed
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (dev->power.constraints_state =3D=3D DEV_PM_QOS_DEVICE_P=
RESENT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constraints_allocate(dev=
);
> + =A0 =A0 =A0 if (dev->power.constraints) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&dev->power.entry)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The device has been remo=
ved from the system. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->dev =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Allocate the constrain=
ts data on the first call to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* add_request, i.e. only=
 if the data is not already
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* allocated and if the d=
evice has not been removed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constrai=
nts_allocate(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (!ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D apply_constraint(req, PM_QOS_ADD_R=
EQ, value);
>
> -out:
> + out:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> +
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
> @@ -252,13 +286,13 @@ int dev_pm_qos_update_request(struct dev
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_QOS_ALL=
OCATED) {
> + =A0 =A0 =A0 if (req->dev->power.constraints) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (new_value !=3D req->node.prio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D apply_constraint(r=
eq, PM_QOS_UPDATE_REQ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 new_value);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Return if the device has been removed */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
The retcode should be -ENODEV. Is the kerneldoc still OK?

> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> @@ -293,7 +327,7 @@ int dev_pm_qos_remove_request(struct dev
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_QOS_ALL=
OCATED) {
> + =A0 =A0 =A0 if (req->dev->power.constraints) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D apply_constraint(req, PM_QOS_REMOV=
E_REQ,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PM_QOS_DEFAULT_VALUE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memset(req, 0, sizeof(*req));
> @@ -323,15 +357,12 @@ int dev_pm_qos_add_notifier(struct devic
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 /* Silently return if the device has been removed */
> - =A0 =A0 =A0 if (dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> -
> - =A0 =A0 =A0 retval =3D blocking_notifier_chain_register(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.constraints->not=
ifiers,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
> + =A0 =A0 =A0 /* Silently return if the constraints object is not present=
. */
> + =A0 =A0 =A0 if (dev->power.constraints)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D blocking_notifier_chain_register(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.=
constraints->notifiers,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
>
> -out:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> =A0 =A0 =A0 =A0return retval;
> =A0}
> @@ -354,15 +385,12 @@ int dev_pm_qos_remove_notifier(struct de
>
> =A0 =A0 =A0 =A0mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 /* Silently return if the device has been removed */
> - =A0 =A0 =A0 if (dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATED)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> -
> - =A0 =A0 =A0 retval =3D blocking_notifier_chain_unregister(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.constraints->not=
ifiers,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
> + =A0 =A0 =A0 /* Silently return if the constraints object is not present=
. */
> + =A0 =A0 =A0 if (dev->power.constraints)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D blocking_notifier_chain_unregist=
er(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.=
constraints->notifiers,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
>
> -out:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> =A0 =A0 =A0 =A0return retval;
> =A0}
> Index: linux/include/linux/pm_qos.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/linux/pm_qos.h
> +++ linux/include/linux/pm_qos.h
> @@ -77,6 +77,7 @@ int pm_qos_remove_notifier(int pm_qos_cl
> =A0int pm_qos_request_active(struct pm_qos_request *req);
> =A0s32 pm_qos_read_value(struct pm_qos_constraints *c);
>
> +s32 dev_pm_qos_read_value(struct device *dev);
> =A0int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_reque=
st *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 value);
> =A0int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_=
value);
> @@ -117,6 +118,8 @@ static inline int pm_qos_request_active(
> =A0static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0{ return 0; }
>
> +static inline s32 dev_pm_qos_read_value(struct device *dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
> =A0static inline int dev_pm_qos_add_request(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct dev_pm_qos_request *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 s32 value)
> Index: linux/drivers/base/power/main.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/base/power/main.c
> +++ linux/drivers/base/power/main.c
> @@ -98,8 +98,8 @@ void device_pm_add(struct device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(dev, "parent %s should not be sle=
eping\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_name(dev->parent));
> =A0 =A0 =A0 =A0list_add_tail(&dev->power.entry, &dpm_list);
> - =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0dev_pm_qos_constraints_init(dev);
> + =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
> =A0}
>
> =A0/**
> @@ -110,9 +110,9 @@ void device_pm_remove(struct device *dev
> =A0{
> =A0 =A0 =A0 =A0pr_debug("PM: Removing info for %s:%s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->bus ? dev->bus->name : "No Bus", dev=
_name(dev));
> - =A0 =A0 =A0 dev_pm_qos_constraints_destroy(dev);
> =A0 =A0 =A0 =A0complete_all(&dev->power.completion);
> =A0 =A0 =A0 =A0mutex_lock(&dpm_list_mtx);
> + =A0 =A0 =A0 dev_pm_qos_constraints_destroy(dev);
> =A0 =A0 =A0 =A0list_del_init(&dev->power.entry);
> =A0 =A0 =A0 =A0mutex_unlock(&dpm_list_mtx);
> =A0 =A0 =A0 =A0device_wakeup_disable(dev);
> Index: linux/include/linux/pm.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/linux/pm.h
> +++ linux/include/linux/pm.h
> @@ -421,13 +421,6 @@ enum rpm_request {
> =A0 =A0 =A0 =A0RPM_REQ_RESUME,
> =A0};
>
> -/* Per-device PM QoS constraints data struct state */
> -enum dev_pm_qos_state {
> - =A0 =A0 =A0 DEV_PM_QOS_NO_DEVICE, =A0 =A0 =A0 =A0 =A0 /* No device pres=
ent */
> - =A0 =A0 =A0 DEV_PM_QOS_DEVICE_PRESENT, =A0 =A0 =A0/* Device present, da=
ta not allocated */
> - =A0 =A0 =A0 DEV_PM_QOS_ALLOCATED, =A0 =A0 =A0 =A0 =A0 /* Device present=
, data allocated */
> -};
> -
> =A0struct wakeup_source;
>
> =A0struct pm_domain_data {
> @@ -489,7 +482,6 @@ struct dev_pm_info {
> =A0#endif
> =A0 =A0 =A0 =A0struct pm_subsys_data =A0 *subsys_data; =A0/* Owned by the=
 subsystem. */
> =A0 =A0 =A0 =A0struct pm_qos_constraints *constraints;
> - =A0 =A0 =A0 enum dev_pm_qos_state =A0 constraints_state;
> =A0};
>
> =A0extern void update_pm_runtime_accounting(struct device *dev);
>

Thanks,
Jean
