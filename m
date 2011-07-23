From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH] PM: runtime: add might_sleep to PM runtime
	functions
Date: Sat, 23 Jul 2011 16:26:15 -0700
Message-ID: <CAMbhsRTdQLd5GRew9GMx6O287k3O17SKE18jvK2k7oyZpOrZfg__29971.5884183117$1311463639$gmane$org@mail.gmail.com>
References: <1311396967-16721-1-git-send-email-ccross@android.com>
	<201107240057.00197.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107240057.00197.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, Jul 23, 2011 at 3:57 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, July 23, 2011, Colin Cross wrote:
>> The list of functions that can be called in atomic context is
>> non-intuitive (pm_runtime_put_sync can not, but
>> pm_runtime_put_sync_suspend can, if pm_runtime_irq_safe has
>> been called?).
>
> However, this behavior is documented.
>
> Also, if you have a clean use case for calling rpm_idle() with interrupts
> off, it can be modified to work in analogy with rpm_suspend() in that res=
pect.

Yes, Kevin posted that patch in response to a bug that would never
have existed with this patch.  Even with Kevin's change, this patch
still detects drivers that are missing pm_runtime_irq_safe().

>> The code is actively misleading - the entry
>> points all start with spin_lock_irqsave, suggesting they
>> are safe to call in atomic context, but may later
>> enable interrupts.
>
> May I say it is this way for a reason?

I'll reword that

>> Add might_sleep_if to all the __pm_runtime_* entry points
>> to enforce correct usage.
>
> I'm not sure how this makes things better.

I spent hours tracking down a bug that was caused by
pm_runtime_put_sync enabling interrupts when entering idle, which was
causing the timer interrupt to be serviced before the cpu entered
idle, and the cpu to idle forever until a non-timer interrupt
occurred.  The bug would never have been introduced with this patch.
When I ran with this patch, it immediately caught 3 other cases of
incorrect usage in atomic context, any of which could cause deadlocks:
spin_lock_irqsave(driver lock)
pm_runtime_put_sync
spin_lock_irqsave(dev lock)
spin_unlock_irq(dev_lock) - enables interrupts
driver irq
spin_lock(driver lock)

One of the bugs was put_sync instead of put_sync_suspend, which would
not be a problem after Kevin's patch, but the other two were missing
pm_runtime_irq_safe.

Not every developer who calls a pm_runtime function is going to read
the documentation, and this patch will catch the common incorrect
usage the first time it is run.

I'll update this patch on top of Kevin's.

>> Also add pm_runtime_put_sync_autosuspend to the list of
>> functions that can be called in atomic context.
>
> OK
>
> In addition to that rpm_idle() is missing the __releases __acquires
> annotations.

Do you want that added to this patch?  It seems like that fits better
into Kevin's patch, or a third patch.

>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> =A0Documentation/power/runtime_pm.txt | =A0 =A01 +
>> =A0drivers/base/power/runtime.c =A0 =A0 =A0 | =A0 16 ++++++++++++++--
>> =A02 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/ru=
ntime_pm.txt
>> index b24875b..22852b3 100644
>> --- a/Documentation/power/runtime_pm.txt
>> +++ b/Documentation/power/runtime_pm.txt
>> @@ -469,6 +469,7 @@ pm_runtime_autosuspend()
>> =A0pm_runtime_resume()
>> =A0pm_runtime_get_sync()
>> =A0pm_runtime_put_sync_suspend()
>> +pm_runtime_put_sync_autosuspend()
>>
>> =A05. Run-time PM Initialization, Device Probing and Removal
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 0d4587b..fdc4567 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -732,6 +732,8 @@ int __pm_runtime_idle(struct device *dev, int rpmfla=
gs)
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 int retval;
>>
>> + =A0 =A0 might_sleep_if(!(rpmflags & RPM_ASYNC));
>> +
>> =A0 =A0 =A0 if (rpmflags & RPM_GET_PUT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!atomic_dec_and_test(&dev->power.usage_c=
ount))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> @@ -754,13 +756,16 @@ EXPORT_SYMBOL_GPL(__pm_runtime_idle);
>> =A0 * return immediately if it is larger than zero. =A0Then carry out a =
suspend,
>> =A0 * either synchronous or asynchronous.
>> =A0 *
>> - * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set.
>> + * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set,
>> + * or if pm_runtime_irq_safe() has been called.
>> =A0 */
>> =A0int __pm_runtime_suspend(struct device *dev, int rpmflags)
>> =A0{
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 int retval;
>>
>> + =A0 =A0 might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe=
);
>> +
>> =A0 =A0 =A0 if (rpmflags & RPM_GET_PUT) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!atomic_dec_and_test(&dev->power.usage_c=
ount))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>> @@ -782,13 +787,16 @@ EXPORT_SYMBOL_GPL(__pm_runtime_suspend);
>> =A0 * If the RPM_GET_PUT flag is set, increment the device's usage count=
. =A0Then
>> =A0 * carry out a resume, either synchronous or asynchronous.
>> =A0 *
>> - * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set.
>> + * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set,
>> + * or if pm_runtime_irq_safe() has been called.
>> =A0 */
>> =A0int __pm_runtime_resume(struct device *dev, int rpmflags)
>> =A0{
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 int retval;
>>
>> + =A0 =A0 might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe=
);
>> +
>> =A0 =A0 =A0 if (rpmflags & RPM_GET_PUT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 atomic_inc(&dev->power.usage_count);
>>
>> @@ -978,6 +986,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_barrier);
>> =A0 */
>> =A0void __pm_runtime_disable(struct device *dev, bool check_resume)
>> =A0{
>> + =A0 =A0 might_sleep();
>> +
>
> Well, it's not correct to call spin_lock_irq() from interrupt context any=
way.
>
>> =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
>>
>> =A0 =A0 =A0 if (dev->power.disable_depth > 0) {
>> @@ -1184,6 +1194,8 @@ void __pm_runtime_use_autosuspend(struct device *d=
ev, bool use)
>> =A0{
>> =A0 =A0 =A0 int old_delay, old_use;
>>
>> + =A0 =A0 might_sleep();
>> +
>> =A0 =A0 =A0 spin_lock_irq(&dev->power.lock);
>> =A0 =A0 =A0 old_delay =3D dev->power.autosuspend_delay;
>> =A0 =A0 =A0 old_use =3D dev->power.use_autosuspend;
>>
>
> Thanks,
> Rafael
>
