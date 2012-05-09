From: Amit Kachhap <amit.kachhap@linaro.org>
Subject: Re: [PATCH v3 2/6] thermal: Add generic cpufreq cooling
	implementation
Date: Wed, 9 May 2012 13:57:01 +0530
Message-ID: <CAK44p20fjH7B8O3whMXh8C+X2nQ31=Sx5iNqW8LHrfOWUt_VpA@mail.gmail.com>
References: <1336493898-7039-1-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-2-git-send-email-amit.kachhap@linaro.org>
	<1336493898-7039-3-git-send-email-amit.kachhap@linaro.org>
	<20120508131626.ffe262f6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20120508131626.ffe262f6.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-samsung-soc@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 9 May 2012 01:46, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, =A08 May 2012 21:48:14 +0530
> Amit Daniel Kachhap <amit.kachhap@linaro.org> wrote:
>
>> This patch adds support for generic cpu thermal cooling low level
>> implementations using frequency scaling up/down based on the registration
>> parameters. Different cpu related cooling devices can be registered by t=
he
>> user and the binding of these cooling devices to the corresponding
>> trip points can be easily done as the registration APIs return the
>> cooling device pointer. The user of these APIs are responsible for
>> passing clipping frequency . The drivers can also register to recieve
>> notification about any cooling action called. Even the driver can effect
>> the cooling action by modifying the default data such as freq_clip_max if
>> needed.
>>
>>
>> ...
>>
>> +struct cpufreq_cooling_device {
>> + =A0 =A0 int id;
>> + =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 struct freq_clip_table *tab_ptr;
>> + =A0 =A0 unsigned int tab_size;
>> + =A0 =A0 unsigned int cpufreq_state;
>> + =A0 =A0 const struct cpumask *allowed_cpus;
>> + =A0 =A0 struct list_head node;
>> +};
>
> It would be nice to document the fields. =A0Especially id, tab_size,
> cpufreq_state and node. =A0For `node' we should describe the locking for
> the list, and describe which list_head anchors this list.

Thanks Andrew for the detailed review. I will add more documentation
and post the next version shortly.
>
>> +static LIST_HEAD(cooling_cpufreq_list);
>> +static DEFINE_MUTEX(cooling_cpufreq_lock);
>> +static DEFINE_IDR(cpufreq_idr);
>> +static DEFINE_PER_CPU(unsigned int, max_policy_freq);
>> +static struct freq_clip_table *notify_table;
>> +static int notify_state;
>> +static BLOCKING_NOTIFIER_HEAD(cputherm_state_notifier_list);
>> +
>> +static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>> +{
>> + =A0 =A0 int err;
>> +again:
>> + =A0 =A0 if (unlikely(idr_pre_get(idr, GFP_KERNEL) =3D=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(lock);
>
> The test for NULL `lock' is unneeded. =A0In fact the `lock' argument
> could be removed altogether - just use cooling_cpufreq_lock directly.
Agreed
>
>> + =A0 =A0 err =3D idr_get_new(idr, NULL, id);
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(lock);
>> + =A0 =A0 if (unlikely(err =3D=3D -EAGAIN))
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto again;
>> + =A0 =A0 else if (unlikely(err))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> +
>> + =A0 =A0 *id =3D *id & MAX_ID_MASK;
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void release_idr(struct idr *idr, struct mutex *lock, int id)
>> +{
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(lock);
>
> Ditto.
>
>> + =A0 =A0 idr_remove(idr, id);
>> + =A0 =A0 if (lock)
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(lock);
>> +}
>> +
>>
>> ...
>>
>> +
>> +/*Below codes defines functions to be used for cpufreq as cooling devic=
e*/
>> +static bool is_cpufreq_valid(int cpu)
>> +{
>> + =A0 =A0 struct cpufreq_policy policy;
>> + =A0 =A0 return !cpufreq_get_policy(&policy, cpu) ? true : false;
>
> Can use
Ok
>
> =A0 =A0 =A0 =A0return !cpufreq_get_policy(&policy, cpu);
>
>> +}
>> +
>> +static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq=
_device,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long =
cooling_state)
>> +{
>> + =A0 =A0 unsigned int event, cpuid;
>> + =A0 =A0 struct freq_clip_table *th_table;
>> +
>> + =A0 =A0 if (cooling_state > cpufreq_device->tab_size)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 cpufreq_device->cpufreq_state =3D cooling_state;
>> +
>> + =A0 =A0 /*cpufreq thermal notifier uses this cpufreq device pointer*/
>
> This code looks like it was written by two people.
>
> =A0 =A0 =A0 =A0/* One who does this */
> =A0 =A0 =A0 =A0/*And one who does this*/
>
> The first one was right. =A0Please go through all the comments in all the
> patches and get the layout consistent?
Sure will add more details.
>
>
>> + =A0 =A0 notify_state =3D cooling_state;
>> +
>> + =A0 =A0 if (notify_state > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 th_table =3D &(cpufreq_device->tab_ptr[cooling=
_state - 1]);
>> + =A0 =A0 =A0 =A0 =A0 =A0 memcpy(notify_table, th_table, sizeof(struct f=
req_clip_table));
>> + =A0 =A0 =A0 =A0 =A0 =A0 event =3D CPUFREQ_COOLING_TYPE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&cputherm_state_n=
otifier_list,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 event, notify_table);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 for_each_cpu(cpuid, cpufreq_device->allowed_cpus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (is_cpufreq_valid(cpuid))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_update_policy(cpuid);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 notify_state =3D -1;
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int cpufreq_thermal_notifier(struct notifier_block *nb,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 unsigned long event, void *data)
>> +{
>> + =A0 =A0 struct cpufreq_policy *policy =3D data;
>> + =A0 =A0 unsigned long max_freq =3D 0;
>> +
>> + =A0 =A0 if ((event !=3D CPUFREQ_ADJUST) || (notify_state =3D=3D -1))
>
> Please document `notify_state', at its definition site. =A0This reader
> doesn't know what "notify_state =3D=3D -1" *means*.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> +
>> + =A0 =A0 if (notify_state > 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D notify_table->freq_clip_max;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy->cpu) =3D=
=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, polic=
y->cpu) =3D policy->max;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (per_cpu(max_policy_freq, policy->cpu) !=3D=
 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D per_cpu(max_polic=
y_freq, policy->cpu);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 per_cpu(max_policy_freq, polic=
y->cpu) =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy->max;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Never exceed user_policy.max*/
>> + =A0 =A0 if (max_freq > policy->user_policy.max)
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D policy->user_policy.max;
>> +
>> + =A0 =A0 if (policy->max !=3D max_freq)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_verify_within_limits(policy, 0, max_fr=
eq);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>>
>> ...
>>
>> +/*This cooling may be as PASSIVE/ACTIVE type*/
>> +static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned lo=
ng state)
>> +{
>> + =A0 =A0 int ret =3D -EINVAL;
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_device;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_device, &cooling_cpufreq_list, nod=
e) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_device && cpufreq_device->cool_dev=
 =3D=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cpufreq_apply_cooling(cpufreq_device, =
state);
>
> Now that we've dropped the lock, what prevents *cpufreq_device from
> getting freed, or undesirably altered?
Agreed the lock can be put over the entire funtion.
>
>> + =A0 =A0 return ret;
>> +}
>> +
>> +/* bind cpufreq callbacks to cpufreq cooling device */
>> +static struct thermal_cooling_device_ops cpufreq_cooling_ops =3D {
>
> Can it be made const?
Yes it can be made const as it is unmodified.
>
>> + =A0 =A0 .get_max_state =3D cpufreq_get_max_state,
>> + =A0 =A0 .get_cur_state =3D cpufreq_get_cur_state,
>> + =A0 =A0 .set_cur_state =3D cpufreq_set_cur_state,
>> +};
>> +
>> +static struct notifier_block thermal_cpufreq_notifier_block =3D {
>> + =A0 =A0 .notifier_call =3D cpufreq_thermal_notifier,
>> +};
>> +
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val)
>> +{
>> + =A0 =A0 struct thermal_cooling_device *cool_dev;
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 unsigned int cpufreq_dev_count =3D 0;
>> + =A0 =A0 char dev_name[THERMAL_NAME_LENGTH];
>> + =A0 =A0 int ret =3D 0, id =3D 0, i;
>> +
>> + =A0 =A0 if (tab_ptr =3D=3D NULL || tab_size =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> +
>> + =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;
>> +
>> + =A0 =A0 cpufreq_dev =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(struct cpufreq_cooling_device),=
 GFP_KERNEL);
>
> The 80-col contortions are ugly. =A0Alternatives are
>
> =A0 =A0 =A0 =A0cpufreq_dev =3D kzalloc(sizeof(struct cpufreq_cooling_devi=
ce),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KERNEL);
>
> or, better,
>
> =A0 =A0 =A0 =A0cpufreq_dev =3D kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);

Ok will use shorter variables.
>
>
>> + =A0 =A0 if (!cpufreq_dev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> +
>> + =A0 =A0 if (cpufreq_dev_count =3D=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 notify_table =3D kzalloc(sizeof(struct freq_cl=
ip_table),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 GFP_KERNEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!notify_table) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 cpufreq_dev->tab_ptr =3D tab_ptr;
>> + =A0 =A0 cpufreq_dev->tab_size =3D tab_size;
>> + =A0 =A0 cpufreq_dev->allowed_cpus =3D mask_val;
>> +
>> + =A0 =A0 /* Initialize all the tab_ptr->mask_val to the passed mask_val=
 */
>> + =A0 =A0 for (i =3D 0; i < tab_size; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 ((struct freq_clip_table *)&tab_ptr[i])->mask_=
val =3D mask_val;
>> +
>> + =A0 =A0 ret =3D get_idr(&cpufreq_idr, &cooling_cpufreq_lock, &cpufreq_=
dev->id);
>
> hm, "get_idr" is a poor name. =A0One would expect it to do a lookup, but
> it actually does an installation. =A0That's a result of the poorly-named
> idr_get_new(), I expect.
>
>
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 sprintf(dev_name, "thermal-cpufreq-%d", cpufreq_dev->id);
>> +
>> + =A0 =A0 cool_dev =3D thermal_cooling_device_register(dev_name, cpufreq=
_dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 &cpufreq_cooling_ops);
>> + =A0 =A0 if (!cool_dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 release_idr(&cpufreq_idr, &cooling_cpufreq_loc=
k,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 cpufreq_dev->id);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(cpufreq_dev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
>> + =A0 =A0 }
>> + =A0 =A0 cpufreq_dev->id =3D id;
>> + =A0 =A0 cpufreq_dev->cool_dev =3D cool_dev;
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_add_tail(&cpufreq_dev->node, &cooling_cpufreq_list);
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 /*Register the notifier for first cpufreq cooling device*/
>> + =A0 =A0 if (cpufreq_dev_count =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_register_notifier(&thermal_cpufreq_not=
ifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 CPUFREQ_POLICY_NOTIFIER);
>> + =A0 =A0 return cool_dev;
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_register);
>> +
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
>> +{
>> + =A0 =A0 struct cpufreq_cooling_device *cpufreq_dev =3D NULL;
>> + =A0 =A0 unsigned int cpufreq_dev_count =3D 0;
>> +
>> + =A0 =A0 mutex_lock(&cooling_cpufreq_lock);
>> + =A0 =A0 list_for_each_entry(cpufreq_dev, &cooling_cpufreq_list, node) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cpufreq_dev && cpufreq_dev->cool_dev =3D=
=3D cdev)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_dev_count++;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!cpufreq_dev || cpufreq_dev->cool_dev !=3D cdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 list_del(&cpufreq_dev->node);
>> + =A0 =A0 mutex_unlock(&cooling_cpufreq_lock);
>> +
>> + =A0 =A0 /*Unregister the notifier for the last cpufreq cooling device*/
>> + =A0 =A0 if (cpufreq_dev_count =3D=3D 1) {
>
> But we dropped the lock, so local variable cpufreq_dev_count is now
> meaningless. =A0What prevents a race here?
Yes lock can be extended to include it.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 cpufreq_unregister_notifier(&thermal_cpufreq_n=
otifier_block,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 CPUFREQ_POLICY_NOTIFIER);
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(notify_table);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
>> + =A0 =A0 release_idr(&cpufreq_idr, &cooling_cpufreq_lock, cpufreq_dev->=
id);
>> + =A0 =A0 kfree(cpufreq_dev);
>> +}
>> +EXPORT_SYMBOL(cpufreq_cooling_unregister);
>>
>> ...
>>
>> +struct freq_clip_table {
>> + =A0 =A0 unsigned int freq_clip_max;
>> + =A0 =A0 unsigned int polling_interval;
>> + =A0 =A0 unsigned int temp_level;
>> + =A0 =A0 const struct cpumask *mask_val;
>> +};
>
> hm, what does this thing do. =A0Needs a nice comment for the uninitiated,
> please. =A0Something which describes the overall roles, responsibilities
> and general reasons for existence.
Ok
>
>> +int cputherm_register_notifier(struct notifier_block *nb, unsigned int =
list);
>> +int cputherm_unregister_notifier(struct notifier_block *nb, unsigned in=
t list);
>> +
>> +#ifdef CONFIG_CPU_FREQ
>> +struct thermal_cooling_device *cpufreq_cooling_register(
>> + =A0 =A0 struct freq_clip_table *tab_ptr, unsigned int tab_size,
>> + =A0 =A0 const struct cpumask *mask_val);
>> +
>> +void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
>> +#else /*!CONFIG_CPU_FREQ*/
>
> (more whacky comment layout)
>
>>
>> ...
>>
>
