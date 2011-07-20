From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 02/11] PM: extend PM QoS with per-device
	wake-up constraints
Date: Wed, 20 Jul 2011 11:13:23 +0200
Message-ID: <CAORVsuV1+F_auuARFySka01+VRomR_Gy0GMPyqsGCrzVJM2v7w__29127.8628087186$1311153272$gmane$org@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-3-git-send-email-j-pihet@ti.com>
	<201107022310.50175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107022310.50175.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, markgross@thegnar.org
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael, Mark,

- Looping in Mark for the user space API

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> - add a new PM QoS class PM_QOS_DEV_WAKEUP_LATENCY for device wake-up
>> constraints. Due to the per-device nature of the new class the constrain=
ts
>> list is stored inside the device dev_pm_info struct instead of the inter=
nal
>> per-class constraints lists.
>
> I think PM_QOS_DEV_LATENCY might be a better name.
Ok, will update.

>
>> The new class is only available from kernel drivers and so is not export=
ed
>> to user space.
>
> It should be available to user space, however, because in many cases driv=
ers
> simply have no idea what values to use (after all, the use decides if he
> wants to trade worse video playback quality for better battery life, for
> example).
Ok. A per-device sysfs entry can be used as the user space interface.
Multiple users could access the same device constraints entry. Cf. the
existing implementation in kernel/pm_qos_params.c as an example.

Mark,
In a previous e-mail discussion you mentioned some concerns about the
user space API. Can you please give more details about it? Is the
proposed user space API suited?

>
>> The new class is used to put constraints on given devices in the system
>> while the existing PM_QOS_CPU_DMA_LATENCY class is used by cpuidle to
>> determine the next MPU subsystem state.
>>
>> - make the pm_qos_add_request API more generic by using a struct
>> pm_qos_parameters parameter
>>
>> - the notification mechanism now passes the constraint request struct ptr
>> in order for the notifier callback to have access to the full set of
>> constraint data, e.g. the struct device ptr
>>
>> - update the pm_qos_add_request callers to the generic API
>>
>> - minor clean-ups and rename of struct fields
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> Well, I think this patch attempts to do too many things at a time, which
> makes it somewhat hard to comprehend at first glance. =A0I'd stronly sugg=
est
> splitting it into a series of patches that first modify the existing API
> to make it suitable for the "real" changes and second introduce those
> "real" chages in the most straightforward way possible.
Ok will split it up in a patch for 'hollow' API changes, then the
implementation itself in a separate patch.

>
>> ---
>> =A0arch/arm/plat-omap/i2c.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 20 ----
>> =A0drivers/i2c/busses/i2c-omap.c =A0 =A0 =A0 =A0 =A0| =A0 35 ++++---
>> =A0drivers/media/video/via-camera.c =A0 =A0 =A0 | =A0 =A05 +-
>> =A0drivers/net/e1000e/netdev.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 +-
>> =A0drivers/net/wireless/ipw2x00/ipw2100.c | =A0 =A06 +-
>> =A0include/linux/pm_qos_params.h =A0 =A0 =A0 =A0 =A0| =A0 40 +++++---
>> =A0kernel/pm_qos_params.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0185 +++++=
++++++++++++++-------------
>
> Hmm. =A0If you're at it, what about moving pm_qos_params.c to kernel/power
> and changing its name to pm_qos.c beforehand?
>
> The header might be called pm_qos.h too, BTW.
Ok, will update it.

>
>> =A0sound/core/pcm_native.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +-
>> =A08 files changed, 177 insertions(+), 131 deletions(-)
>>
> ...
>> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params=
.h
>> index a7d87f9..e6e16cb 100644
>> --- a/include/linux/pm_qos_params.h
>> +++ b/include/linux/pm_qos_params.h
>> @@ -8,31 +8,41 @@
>> =A0#include <linux/notifier.h>
>> =A0#include <linux/miscdevice.h>
>>
>> -#define PM_QOS_RESERVED 0
>> -#define PM_QOS_CPU_DMA_LATENCY 1
>> -#define PM_QOS_NETWORK_LATENCY 2
>> -#define PM_QOS_NETWORK_THROUGHPUT 3
>> +#define =A0 =A0 =A0PM_QOS_RESERVED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define =A0 =A0 =A0PM_QOS_CPU_DMA_LATENCY =A0 =A0 =A0 =A0 =A01
>> +#define =A0 =A0 =A0PM_QOS_DEV_WAKEUP_LATENCY =A0 =A0 =A0 2
>> +#define =A0 =A0 =A0PM_QOS_NETWORK_LATENCY =A0 =A0 =A0 =A0 =A03
>> +#define =A0 =A0 =A0PM_QOS_NETWORK_THROUGHPUT =A0 =A0 =A0 4
>>
>> -#define PM_QOS_NUM_CLASSES 4
>> -#define PM_QOS_DEFAULT_VALUE -1
>> +#define PM_QOS_NUM_CLASSES =A0 =A0 =A0 =A0 =A0 5
>> +#define PM_QOS_DEFAULT_VALUE =A0 =A0 =A0 =A0 -1
>>
>> -#define PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE =A0 =A0 (2000 * USEC_PER_SEC)
>> -#define PM_QOS_NETWORK_LAT_DEFAULT_VALUE =A0 =A0 (2000 * USEC_PER_SEC)
>> -#define PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE =A0 =A0 =A00
>> +#define =A0 =A0 =A0PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE =A0 =A0 =A0 =A0(200=
0 * USEC_PER_SEC)
>> +#define =A0 =A0 =A0PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE =A0 =A0 0
>> +#define =A0 =A0 =A0PM_QOS_NETWORK_LAT_DEFAULT_VALUE =A0 =A0 =A0 =A0(200=
0 * USEC_PER_SEC)
>> +#define =A0 =A0 =A0PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE 0
>>
>> =A0struct pm_qos_request_list {
>> =A0 =A0 =A0 struct plist_node list;
>> - =A0 =A0 int pm_qos_class;
>> + =A0 =A0 int class;
>> + =A0 =A0 struct device *dev;
>> =A0};
>>
>> -void pm_qos_add_request(struct pm_qos_request_list *l, int pm_qos_class=
, s32 value);
>> +struct pm_qos_parameters {
>> + =A0 =A0 int class;
>> + =A0 =A0 struct device *dev;
>> + =A0 =A0 s32 value;
>> +};
>> +
>> +void pm_qos_add_request(struct pm_qos_request_list *l,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pm_qos_parameters *para=
ms);
>> =A0void pm_qos_update_request(struct pm_qos_request_list *pm_qos_req,
>> - =A0 =A0 =A0 =A0 =A0 =A0 s32 new_value);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s32 new_value);
>> =A0void pm_qos_remove_request(struct pm_qos_request_list *pm_qos_req);
>>
>> -int pm_qos_request(int pm_qos_class);
>> -int pm_qos_add_notifier(int pm_qos_class, struct notifier_block *notifi=
er);
>> -int pm_qos_remove_notifier(int pm_qos_class, struct notifier_block *not=
ifier);
>> +int pm_qos_request(int class);
>> +int pm_qos_add_notifier(int class, struct notifier_block *notifier);
>> +int pm_qos_remove_notifier(int class, struct notifier_block *notifier);
>> =A0int pm_qos_request_active(struct pm_qos_request_list *req);
>>
>> =A0#endif
>> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
>> index 6824ca7..d61c8e5 100644
>> --- a/kernel/pm_qos_params.c
>> +++ b/kernel/pm_qos_params.c
>> @@ -60,7 +60,7 @@ enum pm_qos_type {
>> =A0 * types linux supports for 32 bit quantites
>> =A0 */
>> =A0struct pm_qos_object {
>> - =A0 =A0 struct plist_head requests;
>> + =A0 =A0 struct plist_head *requests;
>> =A0 =A0 =A0 struct blocking_notifier_head *notifiers;
>> =A0 =A0 =A0 struct miscdevice pm_qos_power_miscdev;
>> =A0 =A0 =A0 char *name;
>
> So, I gather the idea is to have "requests" point to the device's private
> list of latency constraints. =A0[BTW, there seems to be a naming confusio=
n,
> because you tend to call those things "constraints" rather that "requests=
".]
Ok will change the naming.

> If so, doesn't that mean we'll need a per-device struct pm_qos_object too?
> In which case why not to make the device object point to that pm_qos_obje=
ct
> object instead?
>
>> @@ -72,9 +72,12 @@ struct pm_qos_object {
>> =A0static DEFINE_SPINLOCK(pm_qos_lock);
>>
>> =A0static struct pm_qos_object null_pm_qos;
>> +
>> =A0static BLOCKING_NOTIFIER_HEAD(cpu_dma_lat_notifier);
>> +static struct plist_head _cpu_dma_reqs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PLIST_HEAD_INIT(_cpu_dma_reqs,=
 pm_qos_lock);
>> =A0static struct pm_qos_object cpu_dma_pm_qos =3D {
>> - =A0 =A0 .requests =3D PLIST_HEAD_INIT(cpu_dma_pm_qos.requests, pm_qos_=
lock),
>> + =A0 =A0 .requests =3D &_cpu_dma_reqs,
>> =A0 =A0 =A0 .notifiers =3D &cpu_dma_lat_notifier,
>> =A0 =A0 =A0 .name =3D "cpu_dma_latency",
>> =A0 =A0 =A0 .target_value =3D PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE,
>> @@ -82,9 +85,20 @@ static struct pm_qos_object cpu_dma_pm_qos =3D {
>> =A0 =A0 =A0 .type =3D PM_QOS_MIN,
>> =A0};
>>
>> +static BLOCKING_NOTIFIER_HEAD(dev_wakeup_lat_notifier);
>> +static struct pm_qos_object dev_wakeup_lat_pm_qos =3D {
>> + =A0 =A0 .notifiers =3D &dev_wakeup_lat_notifier,
>> + =A0 =A0 .name =3D "dev_wakeup_latency",
>> + =A0 =A0 .target_value =3D PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
>> + =A0 =A0 .default_value =3D PM_QOS_DEV_WAKEUP_LAT_DEFAULT_VALUE,
>> + =A0 =A0 .type =3D PM_QOS_MIN,
>> +};
>> +
>> =A0static BLOCKING_NOTIFIER_HEAD(network_lat_notifier);
>> +static struct plist_head _network_lat_reqs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PLIST_HEAD_INIT(_network_lat_r=
eqs, pm_qos_lock);
>> =A0static struct pm_qos_object network_lat_pm_qos =3D {
>> - =A0 =A0 .requests =3D PLIST_HEAD_INIT(network_lat_pm_qos.requests, pm_=
qos_lock),
>> + =A0 =A0 .requests =3D &_network_lat_reqs,
>> =A0 =A0 =A0 .notifiers =3D &network_lat_notifier,
>> =A0 =A0 =A0 .name =3D "network_latency",
>> =A0 =A0 =A0 .target_value =3D PM_QOS_NETWORK_LAT_DEFAULT_VALUE,
>> @@ -94,8 +108,10 @@ static struct pm_qos_object network_lat_pm_qos =3D {
>>
>>
>> =A0static BLOCKING_NOTIFIER_HEAD(network_throughput_notifier);
>> +static struct plist_head _network_throughput_reqs =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PLIST_HEAD_INIT(_network_throu=
ghput_reqs, pm_qos_lock);
>> =A0static struct pm_qos_object network_throughput_pm_qos =3D {
>> - =A0 =A0 .requests =3D PLIST_HEAD_INIT(network_throughput_pm_qos.reques=
ts, pm_qos_lock),
>> + =A0 =A0 .requests =3D &_network_throughput_reqs,
>> =A0 =A0 =A0 .notifiers =3D &network_throughput_notifier,
>> =A0 =A0 =A0 .name =3D "network_throughput",
>> =A0 =A0 =A0 .target_value =3D PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE,
>> @@ -107,6 +123,7 @@ static struct pm_qos_object network_throughput_pm_qo=
s =3D {
>> =A0static struct pm_qos_object *pm_qos_array[] =3D {
>> =A0 =A0 =A0 &null_pm_qos,
>> =A0 =A0 =A0 &cpu_dma_pm_qos,
>> + =A0 =A0 &dev_wakeup_lat_pm_qos,
>> =A0 =A0 =A0 &network_lat_pm_qos,
>> =A0 =A0 =A0 &network_throughput_pm_qos
>> =A0};
>> @@ -129,19 +146,19 @@ static const struct file_operations pm_qos_power_f=
ops =3D {
>> =A0/* unlocked internal variant */
>> =A0static inline int pm_qos_get_value(struct pm_qos_object *o)
>> =A0{
>> - =A0 =A0 if (plist_head_empty(&o->requests))
>> + =A0 =A0 if (plist_head_empty(o->requests))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return o->default_value;
>>
>> =A0 =A0 =A0 switch (o->type) {
>> - =A0 =A0 case PM_QOS_MIN:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(&o->requests)->prio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MIN:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_first(o->requests=
)->prio;
>>
>> - =A0 =A0 case PM_QOS_MAX:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(&o->requests)->prio;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case PM_QOS_MAX:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return plist_last(o->requests)=
->prio;
>>
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not using enum */
>> - =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* runtime check for not using=
 enum */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
>> =A0 =A0 =A0 }
>> =A0}
>>
>> @@ -155,13 +172,22 @@ static inline void pm_qos_set_value(struct pm_qos_=
object *o, s32 value)
>> =A0 =A0 =A0 o->target_value =3D value;
>> =A0}
>>
>> -static void update_target(struct pm_qos_object *o, struct plist_node *n=
ode,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int del, int value)
>> +static void update_target(struct pm_qos_request_list *req, int del, int=
 value)
>> =A0{
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 int prev_value, curr_value;
>> + =A0 =A0 struct pm_qos_object *o =3D pm_qos_array[req->class];
>> + =A0 =A0 struct plist_node *node =3D &req->list;
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&pm_qos_lock, flags);
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* PM_QOS_DEV_WAKEUP_LATENCY:
>> + =A0 =A0 =A0* Use the per-device wake-up latency constraints list for
>> + =A0 =A0 =A0* constraints storage
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (req->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 o->requests =3D &req->dev->power.wakeup_lat_pl=
ist_head;
>
> Ah, I see what the idea is and quite frankly I don't like it.
>
> Changing the requests field on the fly in every second (or so) invocation=
 of
> update_target() for PM_QOS_DEV_WAKEUP_LATENCY class is beyond ugly. =A0Mo=
reover,
> it makes all devices share the default_value field which I don't think is
> correct (the target_value field is shared too, which may lead to all sort=
s of
> problems).
Indeed I had the same concern about the code not being generic enough.

>
> I wouldn't even try to use struct pm_qos_object as it is. =A0Instead, I'd
> introduce something like
>
> struct pm_qos_constraits {
> =A0 =A0 =A0 =A0struct plist_head requests;
> =A0 =A0 =A0 =A0unsigned int current_val;
> =A0 =A0 =A0 =A0unsigned int default_val;
> =A0 =A0 =A0 =A0unsigned int floor_val; =A0/* for adding new requests */
> =A0 =A0 =A0 =A0unsigned int ceiling_val; =A0/* ditto */
> =A0 =A0 =A0 =A0enum pm_qos_type type;
> };
>
> Where I'm not sure if the "type" field is really necessary, but that shou=
ld
> work out at one point and "unsigned int" is on purpose (it should have be=
en
> that way from day one in the first place). =A0That's what is needed for d=
evice
> IMO, the other fields in struct pm_qos_object are simply redundant for th=
is
> use case.
>
> Now, for the compatibility with the existing code I'd redefine struct
> pm_qos_object as:
>
> struct pm_qos_object {
> =A0 =A0 =A0 =A0struct pm_qos_constraints constraints;
> =A0 =A0 =A0 =A0struct blocking_notifier *notifiers;
> =A0 =A0 =A0 =A0struct miscdevice pm_qos_power_miscdev;
> =A0 =A0 =A0 =A0char *name;
> };
>
> and I'd change the code to operate on struct pm_qos_constraits in the fir=
st
> place, with a compatibility layer using struct pm_qos_object on top of th=
at.

>
> Then, each device may have its own struct pm_qos_constraits object that w=
ill
> be operated on by the PM QoS functions.
That makes sense, I am working on an RFC implementation.

>=A0[There is the problem of whether or
> not those object should be embedded in struct dev_pm_info, it may be bett=
er
> to use pointers to them.
Should the object be embedded in the device struct instead? If only a
pointer is used when should the struct be allocated (at first use
...)?

>=A0That may be used for sharing of constraints, for
> example, in which case it will be necessary to add a refcount to struct
> pm_qos_constraits.]
More on sharing in the comments for 0/11.

>
> Thanks,
> Rafael
>

Thanks,
Jean
