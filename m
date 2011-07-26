From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH v2] PM: runtime: add might_sleep to PM
	runtime functions
Date: Tue, 26 Jul 2011 15:55:37 -0700
Message-ID: <CAMbhsRTrnPxXUt8Q-VDz5GG8=607QSpcoXJsPLQtPaAZfHKjRA__39105.0201528289$1311721087$gmane$org@mail.gmail.com>
References: <1311627344-8097-1-git-send-email-ccross@android.com>
	<201107270014.36910.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107270014.36910.rjw@sisk.pl>
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

On Tue, Jul 26, 2011 at 3:14 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, July 25, 2011, Colin Cross wrote:
>> Some of the entry points to pm runtime are not safe to
>> call in atomic context unless pm_runtime_irq_safe() has
>> been called. =A0Inspecting the code, it is not immediately
>> obvious that the functions sleep at all, as they run
>> inside a spin_lock_irqsave, but under some conditions
>> they can drop the lock and turn on irqs.
>>
>> If a driver incorrectly calls the pm_runtime apis, it can
>> cause sleeping and irq processing when it expects to stay
>> in atomic context.
>>
>> Add might_sleep_if to all the __pm_runtime_* entry points
>> to enforce correct usage.
>>
>> Add pm_runtime_put_sync_autosuspend to the list of
>> functions that can be called in atomic context.
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> ---
>> =A0Documentation/power/runtime_pm.txt | =A0 =A01 +
>> =A0drivers/base/power/runtime.c =A0 =A0 =A0 | =A0 15 ++++++++++++---
>> =A02 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/power/runtime_pm.txt b/Documentation/power/ru=
ntime_pm.txt
>> index c291233..1ad507c 100644
>> --- a/Documentation/power/runtime_pm.txt
>> +++ b/Documentation/power/runtime_pm.txt
>> @@ -469,6 +469,7 @@ pm_runtime_resume()
>> =A0pm_runtime_get_sync()
>> =A0pm_runtime_put_sync()
>> =A0pm_runtime_put_sync_suspend()
>> +pm_runtime_put_sync_autosuspend()
>>
>> =A05. Run-time PM Initialization, Device Probing and Removal
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 2e746f8..f3d8583 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -731,13 +731,16 @@ EXPORT_SYMBOL_GPL(pm_schedule_suspend);
>> =A0 * return immediately if it is larger than zero. =A0Then carry out an=
 idle
>> =A0 * notification, either synchronous or asynchronous.
>> =A0 *
>> - * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set.
>> + * This routine may be called in atomic context if the RPM_ASYNC flag i=
s set,
>> + * or if pm_runtime_irq_safe() has been called.
>> =A0 */
>> =A0int __pm_runtime_idle(struct device *dev, int rpmflags)
>> =A0{
>> =A0 =A0 =A0 unsigned long flags;
>> =A0 =A0 =A0 int retval;
>>
>> + =A0 =A0 might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe=
);
>> +
>
> Now that I think of it, perhaps it's better to put the might_sleep()
> annotations into the actual code paths that should trigger them instead of
> checking the conditions upfront on every call? =A0This way we'll avoid qu=
ite
> some overhead that's only necessary for debugging.
>

You can't put the might_sleep after the spin_lock_irqsave(), because
you are always in atomic context, and you can't put it after the
spin_unlock_irq() that triggers the problem because you have already
unconditionally left atomic context.

Anyways, the sleeps happen in a farily rare case, so putting the
might_sleep in a more specific location will hide the errors when
developers perform simple tests.  For example, every kmalloc ends up
calling might_sleep_if(flags & __GFP_WAIT), so that putting
kmalloc(..., GFP_KERNEL) will print a stack trace every time, instead
of only the very rare case when kmalloc has to block in a low memory
condition.

The calls are very low overhead - the condition in the
might_sleep_if(), and then in the common case:
	if ((preempt_count_equals(preempt_offset) && !irqs_disabled()) || ...)
		return;
