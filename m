From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 03/11] PM QoS: support the dynamic devices
	insertion and removal
Date: Wed, 20 Jul 2011 11:16:01 +0200
Message-ID: <CAORVsuWukz1xNfMEu61cgCYvokBVDhxHsNKDuOjK0Ay5JaH0tQ__12193.551977589$1311153444$gmane$org@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-4-git-send-email-j-pihet@ti.com>
	<201107022314.21713.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107022314.21713.rjw@sisk.pl>
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
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The devices wake-up latency constraints class of PM QoS is
>> storing the constraints list using the device pm_info struct.
>>
>> This patch adds the init and de-init of the per-device constraints
>> list in order to support the dynamic insertion and removal
>> of the devices in the system.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>
> The number of times this patch special cases PM_QOS_DEV_WAKEUP_LATENCY wi=
th
> respect to the other PM QoS classes indicates a design issue, which kind =
of
> corresponds with my comments on [3/11].
Do you mean 02/11? Indeed the special cases changes are introduced by
02/11. Re-designing 02/11 will solve those special cases issues.

Thanks,
Jean

>
> Thanks,
> Rafael
>
>
>> ---
>> =A0drivers/base/power/main.c =A0 =A0 | =A0 =A08 +++--
>> =A0include/linux/pm.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
>> =A0include/linux/pm_qos_params.h | =A0 =A02 +
>> =A0kernel/pm_qos_params.c =A0 =A0 =A0 =A0| =A0 70 ++++++++++++++++++++++=
++++++++++--------
>> =A04 files changed, 64 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index b1fd96b..51f5526 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -27,6 +27,7 @@
>> =A0#include <linux/sched.h>
>> =A0#include <linux/async.h>
>> =A0#include <linux/suspend.h>
>> +#include <linux/pm_qos_params.h>
>>
>> =A0#include "../base.h"
>> =A0#include "power.h"
>> @@ -96,8 +97,8 @@ void device_pm_add(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(dev->parent));
>> =A0 =A0 =A0 list_add_tail(&dev->power.entry, &dpm_list);
>> =A0 =A0 =A0 mutex_unlock(&dpm_list_mtx);
>> - =A0 =A0 /* ToDo: call PM QoS to init the per-device wakeup latency con=
straints */
>> - =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power=
.lock);
>> + =A0 =A0 /* Call PM QoS to init the per-device wakeup latency constrain=
ts */
>> + =A0 =A0 pm_qos_dev_wakeup_lat_init(dev);
>> =A0}
>>
>> =A0/**
>> @@ -108,7 +109,8 @@ void device_pm_remove(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 pr_debug("PM: Removing info for %s:%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus ? dev->bus->name : "No Bus", dev=
_name(dev));
>> - =A0 =A0 /* ToDo: call PM QoS to de-init the per-device wakeup latency =
constraints */
>> + =A0 =A0 /* Call PM QoS to de-init the per-device wakeup latency constr=
aints */
>> + =A0 =A0 pm_qos_dev_wakeup_lat_deinit(dev);
>> =A0 =A0 =A0 complete_all(&dev->power.completion);
>> =A0 =A0 =A0 mutex_lock(&dpm_list_mtx);
>> =A0 =A0 =A0 list_del_init(&dev->power.entry);
>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>> index 35fe682..d9b6092 100644
>> --- a/include/linux/pm.h
>> +++ b/include/linux/pm.h
>> @@ -464,6 +464,7 @@ struct dev_pm_info {
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*subsys_data; =
=A0/* Owned by the subsystem. */
>> =A0#endif
>> =A0 =A0 =A0 struct plist_head =A0 =A0 =A0 wakeup_lat_plist_head;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wakeup_lat_init;
>> =A0};
>>
>> =A0extern void update_pm_runtime_accounting(struct device *dev);
>> diff --git a/include/linux/pm_qos_params.h b/include/linux/pm_qos_params=
.h
>> index e6e16cb..5b6707a 100644
>> --- a/include/linux/pm_qos_params.h
>> +++ b/include/linux/pm_qos_params.h
>> @@ -45,4 +45,6 @@ int pm_qos_add_notifier(int class, struct notifier_blo=
ck *notifier);
>> =A0int pm_qos_remove_notifier(int class, struct notifier_block *notifier=
);
>> =A0int pm_qos_request_active(struct pm_qos_request_list *req);
>>
>> +void pm_qos_dev_wakeup_lat_init(struct device *dev);
>> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev);
>> =A0#endif
>> diff --git a/kernel/pm_qos_params.c b/kernel/pm_qos_params.c
>> index d61c8e5..6f25ccb 100644
>> --- a/kernel/pm_qos_params.c
>> +++ b/kernel/pm_qos_params.c
>> @@ -275,11 +275,21 @@ void pm_qos_add_request(struct pm_qos_request_list=
 *pm_qos_req,
>> =A0 =A0 =A0 struct pm_qos_object *o =3D =A0pm_qos_array[pm_qos_params->c=
lass];
>> =A0 =A0 =A0 int new_value;
>>
>> - =A0 =A0 if ((pm_qos_params->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) &&
>> - =A0 =A0 =A0 =A0 (pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_add_request() called =
for already "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"added request\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 if (pm_qos_params->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_params->dev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_add_r=
equest() called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "invalid devic=
e\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being rele=
ased */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_params->dev->power.wakeup_lat_init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_add_r=
equest() called for "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "already added=
 request\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (pm_qos_params->value =3D=3D PM_QOS_DEFAULT_VALUE)
>> @@ -312,11 +322,16 @@ void pm_qos_update_request(struct pm_qos_request_l=
ist *pm_qos_req,
>> =A0 =A0 =A0 if (!pm_qos_req) /*guard against callers passing in null */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> - =A0 =A0 if ((pm_qos_req->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) &&
>> - =A0 =A0 =A0 =A0 (!pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_update_request() call=
ed for unknown "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"object\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 if (pm_qos_req->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being rele=
ased */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_req->dev->power.wakeup_lat_init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_updat=
e_request() called "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for unknown o=
bject\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (new_value =3D=3D PM_QOS_DEFAULT_VALUE)
>> @@ -343,11 +358,16 @@ void pm_qos_remove_request(struct pm_qos_request_l=
ist *pm_qos_req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* silent return to keep pcm code cleaner */
>>
>> - =A0 =A0 if ((pm_qos_req->class !=3D PM_QOS_DEV_WAKEUP_LATENCY) &&
>> - =A0 =A0 =A0 =A0 (!pm_qos_request_active(pm_qos_req))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_remove_request() call=
ed for unknown "
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"object\n");
>> + =A0 =A0 if (pm_qos_req->class =3D=3D PM_QOS_DEV_WAKEUP_LATENCY) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Silently return if the device is being rele=
ased */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_req->dev->power.wakeup_lat_init)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pm_qos_request_active(pm_qos_req)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(1, KERN_ERR "pm_qos_remov=
e_request() called "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "for unknown o=
bject\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 update_target(pm_qos_req, 1, PM_QOS_DEFAULT_VALUE);
>> @@ -393,6 +413,28 @@ int pm_qos_remove_notifier(int class, struct notifi=
er_block *notifier)
>> =A0}
>> =A0EXPORT_SYMBOL_GPL(pm_qos_remove_notifier);
>>
>> +/* Called from the device PM subsystem at device init */
>> +void pm_qos_dev_wakeup_lat_init(struct device *dev)
>> +{
>> + =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power=
.lock);
>> + =A0 =A0 dev->power.wakeup_lat_init =3D 1;
>> +}
>> +
>> +/* Called from the device PM subsystem at device release */
>> +void pm_qos_dev_wakeup_lat_deinit(struct device *dev)
>> +{
>> + =A0 =A0 struct pm_qos_request_list *req, *tmp;
>> +
>> + =A0 =A0 dev->power.wakeup_lat_init =3D 0;
>> +
>> + =A0 =A0 /* Flush the constraints list for the device */
>> + =A0 =A0 plist_for_each_entry_safe(req, tmp,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dev->powe=
r.wakeup_lat_plist_head,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list)
>> + =A0 =A0 =A0 =A0 =A0 =A0 update_target(req, 1, PM_QOS_DEFAULT_VALUE);
>> + =A0 =A0 plist_head_init(&dev->power.wakeup_lat_plist_head, &dev->power=
.lock);
>> +}
>> +
>> =A0static int pm_qos_power_open(struct inode *inode, struct file *filp)
>> =A0{
>> =A0 =A0 =A0 struct pm_qos_parameters pm_qos_params;
>>
>
>
