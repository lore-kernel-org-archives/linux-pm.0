From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 04/13] PM: QoS: implement the per-device
	latency constraints
Date: Tue, 2 Aug 2011 12:05:17 +0200
Message-ID: <CAORVsuXzn8wGZsyxUcAN7stjbU4Kshwdg2CW06w17Y5O7oJVsA__6181.14751200682$1312279580$gmane$org@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-5-git-send-email-j-pihet@ti.com>
	<201107310030.29286.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107310030.29286.rjw@sisk.pl>
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
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Rafael,

2011/7/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Re-design the PM QoS implementation to support the per-device
>> constraints:
>
> Well, I guess I should have reviewed this patch before [03/13].
Hmm indeed. The split of patches into API and implementation patches
wakes it rather confusing. I could add a comment in [03/13] about it.

...

>> - Misc fixes to improve code readability:
>> =A0 . rename of fields names (request, list, constraints, class),
>
> Please avoid doing renames along with functional changes. =A0It makes rev=
iewing
> extremely hard.
Ok I will move the renames in a different patch.

...
>> @@ -97,7 +97,12 @@ void device_pm_add(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(dev->parent));
>> =A0 =A0 =A0 list_add_tail(&dev->power.entry, &dpm_list);
>> =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
>> - =A0 =A0 plist_head_init(&dev->power.latency_constraints, &dev->power.l=
ock);
>> + =A0 =A0 plist_head_init(&dev->power.latency_constraints.list, &dev->po=
wer.lock);
>> + =A0 =A0 dev->power.latency_constraints.target_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.default_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.type =3D PM_QOS_MIN;
>
> Perhaps add a helper doing these assignments?
This code is later moved into the device insertion and removal
functions. Cf. [05/13].

...
>> @@ -464,7 +465,7 @@ struct dev_pm_info {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 accounting_timestamp;
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*subsys_data; =
=A0/* Owned by the subsystem. */
>> =A0#endif
>> - =A0 =A0 struct plist_head =A0 =A0 =A0 latency_constraints;
>> + =A0 =A0 struct pm_qos_constraints =A0 =A0 =A0 latency_constraints;
>
> Why don't you simply call it "qos"? =A0The data type provides the informa=
tion
> about what it's for now.
Ok

...
>> +struct pm_qos_constraints {
>> + =A0 =A0 struct plist_head list;
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Do not change target_value to 64 bit in order to guarantee
>> + =A0 =A0 =A0* accesses atomicity
>> + =A0 =A0 =A0*/
>
> The comment doesn't belong here. =A0Please put it outside of the structure
> definition or after the field name (or both, in which case the "inline"
> one may be shorter, like "must not be 64-bit").
Ok

>
>> + =A0 =A0 s32 target_value;
>> + =A0 =A0 s32 default_value;
>> + =A0 =A0 enum pm_qos_type type;
>> +};
>> +
>> +/*
>> + * Struct that is pre-allocated by the caller.
>> + * The handle is kept for future use (update, removal)
>> + */
>> =A0struct pm_qos_request {
>> - =A0 =A0 struct plist_node list;
>> + =A0 =A0 struct plist_node node;
>
> Please avoid doing such things along with functional changes.
Ok

...
>> +enum pm_qos_req_action {
>> + =A0 =A0 PM_QOS_ADD_REQ,
>> + =A0 =A0 PM_QOS_UPDATE_REQ,
>> + =A0 =A0 PM_QOS_REMOVE_REQ
>> =A0};
>
> A comment describing the meaning of these would be helpful.
Ok

...
>> -static inline int pm_qos_get_value(struct pm_qos_object *o)
>> +static inline int pm_qos_get_value(struct pm_qos_constraints *c)
>
> I'd remove the "inline" if you're at it. =A0It's only a hint if the kernel
> is not built with "always inline" and the compiler should do the inlining
> anyway if that's a better choice.
Ok

...
>> -static inline s32 pm_qos_read_value(struct pm_qos_object *o)
>> +/*
>> + * pm_qos_read_value atomically reads and returns target_value.
>
> We have a standard for writing kerneldoc comments, please follow it.
Ok

>
>> + * target_value is updated upon update of the constraints list, using
>> + * pm_qos_set_value.
>> + *
>> + * Note: The lockless read path depends on the CPU accessing
>> + * target_value atomically. =A0Atomic access is only guaranteed on all =
CPU
>> + * types linux supports for 32 bit quantites
>
> You should say "data types" rather than "quantities" here.
Ok

>
>> + */
>> +static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
>> =A0{
>> - =A0 =A0 return o->target_value;
>> + =A0 =A0 if (c)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return c->target_value;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> =A0}
>>
>> -static inline void pm_qos_set_value(struct pm_qos_object *o, s32 value)
>> +static inline void pm_qos_set_value(struct pm_qos_constraints *c, s32 v=
alue)
>> =A0{
>> - =A0 =A0 o->target_value =3D value;
>> + =A0 =A0 c->target_value =3D value;
>> =A0}
>
> Well, I'm not sure that this function is necessary at all. =A0You might a=
s well
> simply remove it as far as I'm concerned.
The idea is to provide an efficient and lockless way to get the
aggregated constraint class value. When the constraints a re changing
the new value is calculated and stored using pm_qos_get_value and
pm_qos_set_value. Then pm_qos_read_value is used to retrieve the
value. For example cpuidle calls pm_qos_request which uses
pm_qos_read_value to get the CPU/DMA minimum latency.

>
>> -static void update_target(struct pm_qos_object *o, struct plist_node *n=
ode,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int del, int value)
>> +static void update_target(struct pm_qos_request *req,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum pm_qos_req_action act=
ion, int value)
>> =A0{
>> =A0 =A0 =A0 unsigned long flags;
>> - =A0 =A0 int prev_value, curr_value;
>> + =A0 =A0 int prev_value, curr_value, new_value;
>> + =A0 =A0 struct pm_qos_object *o =3D pm_qos_array[req->class];
>> + =A0 =A0 struct pm_qos_constraints *c;
>> +
>> + =A0 =A0 switch (req->class) {
>> + =A0 =A0 case PM_QOS_DEV_LATENCY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!req->dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "PM QoS API c=
alled with NULL dev\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 c =3D &req->dev->power.latency_constraints;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PM_QOS_CPU_DMA_LATENCY:
>> + =A0 =A0 case PM_QOS_NETWORK_LATENCY:
>> + =A0 =A0 case PM_QOS_NETWORK_THROUGHPUT:
>> + =A0 =A0 =A0 =A0 =A0 =A0 c =3D o->constraints;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PM_QOS_RESERVED:
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "PM QoS API called with wrong=
 class %d, "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "req 0x%p\n", req->class, req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>
> Do we _really_ need that switch()?
>
> What about introducing dev_pm_qos_add_request() and friends specifically
> for devices, such that they will take the target device object (dev) as
> their first argument? =A0Then, you could keep pm_qos_add_request() pretty
> much as is, right?
Yes but in that case I need to duplicate the API functions for devices
(add, update, remove). Those functions will call update_target.
I prefer the way this patch does it: simplify the API functions and
have only 1 place with the constraints management and notification
logic (in update_target).

>
>>
>> =A0 =A0 =A0 spin_lock_irqsave(&pm_qos_lock, flags);
>> - =A0 =A0 prev_value =3D pm_qos_get_value(o);
>> - =A0 =A0 /* PM_QOS_DEFAULT_VALUE is a signal that the value is unchange=
d */
>> - =A0 =A0 if (value !=3D PM_QOS_DEFAULT_VALUE) {
>> +
>> + =A0 =A0 prev_value =3D pm_qos_get_value(c);
>> + =A0 =A0 if (value =3D=3D PM_QOS_DEFAULT_VALUE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_value =3D c->default_value;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_value =3D value;
>
> What about writing that as
>
> =A0 =A0 =A0 =A0new_value =3D value !=3D PM_QOS_DEFAULT_VALUE ? value : c-=
>default_value;
This is shorter but more difficult to read ;8

>
>> +
>> + =A0 =A0 switch (action) {
>> + =A0 =A0 case PM_QOS_REMOVE_REQ:
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&req->node, &c->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case PM_QOS_UPDATE_REQ:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to change the list, we atomically remov=
e, reinit
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* with new value and add, then see if the=
 extremal
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* changed
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 plist_del(node, &o->requests);
>> - =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(node, value);
>> - =A0 =A0 =A0 =A0 =A0 =A0 plist_add(node, &o->requests);
>> - =A0 =A0 } else if (del) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 plist_del(node, &o->requests);
>> - =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 plist_add(node, &o->requests);
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_del(&req->node, &c->list);
>> + =A0 =A0 case PM_QOS_ADD_REQ:
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_node_init(&req->node, new_value);
>> + =A0 =A0 =A0 =A0 =A0 =A0 plist_add(&req->node, &c->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* no action */
>> + =A0 =A0 =A0 =A0 =A0 =A0 ;
>> =A0 =A0 =A0 }
>> - =A0 =A0 curr_value =3D pm_qos_get_value(o);
>> - =A0 =A0 pm_qos_set_value(o, curr_value);
>> +
>> + =A0 =A0 curr_value =3D pm_qos_get_value(c);
>> + =A0 =A0 pm_qos_set_value(c, curr_value);
>> =A0 =A0 =A0 spin_unlock_irqrestore(&pm_qos_lock, flags);
>>
>> =A0 =A0 =A0 if (prev_value !=3D curr_value)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(o->notifiers,
>
> That's why I'm thinking that it would be helpful to have a pointer
> to the notifier list from struct pm_qos_constraints .
I think having a per-device notifier list is complicating things. If a
subsystem needs te be notified it needs to register a notifier
callback for _every_ device in the system.
As a first implementation for OMAP the low-level PM code is using a
single notifier to retrieve all the devices latency constraints and
apply them to the pwer domains. I do not see how this could work with
a per-device notifier list.

>
> Besides, you can use "pm_qos_array[req->class]->notifiers" instead of
> "o->notifiers".
Ok

...
>> +static int find_pm_qos_object_by_minor(int minor)
>> +{
>> + =A0 =A0 int pm_qos_class;
>> +
>> + =A0 =A0 for (pm_qos_class =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_class < PM_QOS_NUM_CLASSES; pm_qos_clas=
s++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (minor =3D=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_array[pm_qos_class]->pm=
_qos_power_miscdev.minor)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pm_qos_class;
>> + =A0 =A0 }
>> + =A0 =A0 return -1;
>> +}
>
> This function doesn't seem to be used anywhere, what's the purpose of it?
It is used by pm_qos_power_open in order to retrieve the class
associated with the MISC device.
BTW this patch is moving the code so that all the MISC related
functions are grouped together.

>
>> +
>> =A0static int pm_qos_power_open(struct inode *inode, struct file *filp)
>> =A0{
>> =A0 =A0 =A0 struct pm_qos_parameters pm_qos_params;
...
>
> Thanks,
> Rafael

Thanks,
Jean
