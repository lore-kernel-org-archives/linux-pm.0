From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 06/15] PM QoS: implement the per-device PM
	QoS constraints
Date: Sun, 14 Aug 2011 10:50:09 +0200
Message-ID: <CAORVsuVZjrqY0qhEvCpRRvt5RDcG-YT5SJo6Ejhyr-_fTyk9HQ__13036.3858108923$1313311872$gmane$org@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-7-git-send-email-j-pihet@ti.com>
	<201108132308.26265.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108132308.26265.rjw@sisk.pl>
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
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Rafael,

2011/8/13 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> Well, it looks like I should have reviewed this one more carefully.
>
> On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Implement the per-device PM QoS constraints by creating a device
>> PM QoS API, which calls the PM QoS constraints management core code.
>>
>> The per-device latency constraints data strctures are stored
>> in the device dev_pm_info struct.
>>
>> The device PM code calls the init and destroy of the per-device constrai=
nts
>> data struct in order to support the dynamic insertion and removal of the
>> devices in the system.
>>
>> To minimize the data usage by the per-device constraints, the data struct
>> is only allocated at the first call to dev_pm_qos_add_request.
>> The data is later free'd when the device is removed from the system.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
...
>> +/*#define DEBUG*/
>
> Please remove this.
Ok

>
>> +
>> +#include <linux/pm_qos.h>
>> +#include <linux/sched.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/slab.h>
>> +#include <linux/time.h>
>> +#include <linux/fs.h>
>> +#include <linux/device.h>
>> +#include <linux/string.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>
> Are you sure all of the headers are necessary?
No. I can check that.

>
>> +
>> +
>> +static void dev_pm_qos_constraints_allocate(struct device *dev);
>> +
>> +int dev_pm_qos_request_active(struct dev_pm_qos_request *req)
>> +{
>> + =A0 =A0 return req->dev !=3D 0;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_request_active);
>
> That should be a static inline in a header.
Ok

>
>> +
>> +/**
>> + * dev_pm_qos_add_request - inserts new qos request into the list
>> + * @req: pointer to a preallocated handle
>> + * @dev: target device for the constraint
>> + * @value: defines the qos request
>> + *
>> + * This function inserts a new entry in the device constraints list of
>> + * requested qos performance characteristics. It recomputes the aggrega=
te
>> + * QoS expectations of parameters and initializes the dev_pm_qos_request
>> + * handle. =A0Caller needs to save this handle for later use in updates=
 and
>> + * removal.
>> + */
>> +void dev_pm_qos_add_request(struct dev_pm_qos_request *req, struct devi=
ce *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 value)
>
> I'd use a different ordering of arguments, namely (dev, req, value).
Ok

>
>> +{
>> + =A0 =A0 if (!req) /*guard against callers passing in null */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> Why not to check for !dev too?
Ok that makes sense

>
>> +
>> + =A0 =A0 if (dev_pm_qos_request_active(req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "dev_pm_qos_add_request() cal=
led for already "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "added request\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 req->dev =3D dev;
>> +
>> + =A0 =A0 /* Allocate the constraints struct on the first call to add_re=
quest */
>> + =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_QOS_DEVICE=
_PRESENT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_pm_qos_constraints_allocate(dev);
>
> Why not to do
>
> + =A0 =A0 =A0 if (!req->dev->power.constraints)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_pm_qos_constraints_allocate(dev);

Cf. my comments at the end of this message for the data structs
alloc/free and the locking.

>
>> +
>> + =A0 =A0 /* Silently return if the device has been removed */
>> + =A0 =A0 if (req->dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATE=
D)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>
> Hmm. =A0What will happen if two callers run dev_pm_qos_add_request()
> concurrently for the same device?
update_target is using the power.lock to protect the constraints lists chan=
ges.

>
>> + =A0 =A0 pm_qos_update_target(dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&req->node, PM_QOS_=
ADD_REQ, value);
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
>> +
>> +/**
>> + * dev_pm_qos_update_request - modifies an existing qos request
>> + * @req : handle to list element holding a dev_pm_qos request to use
>> + * @value: defines the qos request
>> + *
>> + * Updates an existing dev PM qos request along with updating the
>> + * target value.
>> + *
>> + * Attempts are made to make this code callable on hot code paths.
>> + */
>> +void dev_pm_qos_update_request(struct dev_pm_qos_request *req,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s32 new_value)
>> +{
>> + =A0 =A0 if (!req) /*guard against callers passing in null */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!dev_pm_qos_request_active(req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "dev_pm_qos_update_request() =
called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unknown object\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Silently return if the device has been removed */
>> + =A0 =A0 if (req->dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATE=
D)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (new_value !=3D req->node.prio)
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_update_target(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &req->node, PM_QOS_UPDATE_REQ,=
 new_value);
>
> I'm not sure what prevents dev_pm_qos_constraints_destroy() from removing
> the list from under us while we're executing this?
Cf. my comments at the end of this message for the data structs
alloc/free and the locking.

>
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_update_request);
>> +
>> +/**
>> + * dev_pm_qos_remove_request - modifies an existing qos request
>> + * @req: handle to request list element
>> + *
>> + * Will remove pm qos request from the list of constraints and
>> + * recompute the current target value. Call this on slow code paths.
>> + */
>> +void dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
>> +{
>> + =A0 =A0 if (!req) /*guard against callers passing in null */
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 if (!dev_pm_qos_request_active(req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "dev_pm_qos_remove_request() =
called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unknown object\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Silently return if the device has been removed */
>> + =A0 =A0 if (req->dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATE=
D)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 pm_qos_update_target(req->dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&req->node, PM_QOS_=
REMOVE_REQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PM_QOS_DEFAULT_VALU=
E);
>
> Same here.
>
>> + =A0 =A0 memset(req, 0, sizeof(*req));
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>> +
>> +/**
>> + * dev_pm_qos_add_notifier - sets notification entry for changes to tar=
get value
>> + * of per-device PM QoS constraints
>> + *
>> + * @dev: target device for the constraint
>> + * @notifier: notifier block managed by caller.
>> + *
>> + * Will register the notifier into a notification chain that gets called
>> + * upon changes to the target value for the device.
>> + */
>> +int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *=
notifier)
>> +{
>> + =A0 =A0 int retval =3D 0;
>> +
>> + =A0 =A0 /* Silently return if the device has been removed */
>> + =A0 =A0 if (dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> +
>> + =A0 =A0 retval =3D blocking_notifier_chain_register(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.constraints->notifi=
ers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
>
> That may be racing with dev_pm_qos_constraints_destroy() too.
>
>> +
>> + =A0 =A0 return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_add_notifier);
>> +
>> +/**
>> + * dev_pm_qos_remove_notifier - deletes notification for changes to tar=
get value
>> + * of per-device PM QoS constraints
>> + *
>> + * @dev: target device for the constraint
>> + * @notifier: notifier block to be removed.
>> + *
>> + * Will remove the notifier from the notification chain that gets called
>> + * upon changes to the target value.
>> + */
>> +int dev_pm_qos_remove_notifier(struct device *dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct notifier=
_block *notifier)
>> +{
>> + =A0 =A0 int retval =3D 0;
>> +
>> + =A0 =A0 /* Silently return if the device has been removed */
>> + =A0 =A0 if (dev->power.constraints_state !=3D DEV_PM_QOS_ALLOCATED)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return retval;
>> +
>> + =A0 =A0 retval =3D blocking_notifier_chain_unregister(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->power.constraints->notifi=
ers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notifier);
>
> Same here.
>
>> +
>> + =A0 =A0 return retval;
>> +}
>> +EXPORT_SYMBOL_GPL(dev_pm_qos_remove_notifier);
>> +
>> +/* Called at the first call to add_request, for constraint data allocat=
ion */
>> +static void dev_pm_qos_constraints_allocate(struct device *dev)
>> +{
>> + =A0 =A0 struct pm_qos_constraints *c;
>> + =A0 =A0 struct blocking_notifier_head *n;
>> +
>> + =A0 =A0 c =3D kzalloc(sizeof(*c), GFP_KERNEL);
>> + =A0 =A0 if (!c)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 n =3D kzalloc(sizeof(*n), GFP_KERNEL);
>> + =A0 =A0 if (!n) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(c);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 BLOCKING_INIT_NOTIFIER_HEAD(n);
>> +
>> + =A0 =A0 dev->power.constraints =3D c;
>> + =A0 =A0 plist_head_init(&dev->power.constraints->list, &dev->power.loc=
k);
>> + =A0 =A0 dev->power.constraints->target_value =3D PM_QOS_DEV_LAT_DEFAUL=
T_VALUE;
>> + =A0 =A0 dev->power.constraints->default_value =3D PM_QOS_DEV_LAT_DEFAU=
LT_VALUE;
>> + =A0 =A0 dev->power.constraints->type =3D PM_QOS_MIN;
>> + =A0 =A0 dev->power.constraints->notifiers =3D n;
>> + =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_ALLOCATED;
>> +}
>> +
>> +/* Called from the device PM subsystem at device insertion */
>> +void dev_pm_qos_constraints_init(struct device *dev)
>> +{
>> + =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_DEVICE_PRESENT;
>
> Hmm. =A0Is it insufficient to check if "constraints" is not NULL?
>
>> +}
>> +
>> +/* Called from the device PM subsystem at device removal */
>> +void dev_pm_qos_constraints_destroy(struct device *dev)
>> +{
>> + =A0 =A0 struct dev_pm_qos_request *req, *tmp;
>> + =A0 =A0 enum dev_pm_qos_state constraints_state =3D dev->power.constra=
ints_state;
>> +
>> + =A0 =A0 dev->power.constraints_state =3D DEV_PM_QOS_NO_DEVICE;
>
> I'm not sure what the purpose of this is. =A0I'd simply check if "constra=
ints"
> is not NULL and I'd flush the list if not.
>
> Moreover, that has to go under a lock so that it doesn't race with
> the other functions above. =A0I think you can reuse power.lock for that.
>

Your remarks are inline with the concerns I had about the adata
structs alloc/free and the locking.

1) data structs alloc/free
As described in the changelog:
>> To minimize the data usage by the per-device constraints, the data struct
>> is only allocated at the first call to dev_pm_qos_add_request.
>> The data is later free'd when the device is removed from the system.
A basic state machine is needed in order to allocate the data at the
first call to add_request and free it when the device is removed.
Another option is to allocate the data when the device is added to the
system and free it when the device is removed. That would make the
code simpler but it is using a lot of memory for unneeded data.

2) Race conditions
I will add a lock to isolate the API callers from
dev_pm_qos_constraints_destroy().
The power.lock is already used by update_target so another lock is
needed to protect the data allocation/free.

I will rework this tomorrow and re-submit asap when it is ready.
Is that OK?

>
> Thanks,
> Rafael
>

Thanks,
Jean
