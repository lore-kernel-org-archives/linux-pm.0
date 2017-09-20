From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM: Document rules on using pm_runtime_resume() in system
 suspend callbacks
Date: Wed, 20 Sep 2017 16:01:32 +0200
Message-ID: <CAJZ5v0h2gZJbtF2E=+9Ya5NtZCRy+5eVh=OaJJA81rTZR0907g@mail.gmail.com>
References: <1849600.vI30ccvhCD@aspire.rjw.lan> <CAPDyKFrPGA9OproyQHwVTY5EfAQJnLZuHL+cnJv+1fPYXLLW2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrPGA9OproyQHwVTY5EfAQJnLZuHL+cnJv+1fPYXLLW2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 20, 2017 at 2:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 20 September 2017 at 02:26, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It quite often is necessary to resume devices from runtime suspend
>> during system suspend for various reasons (for example, if their
>> wakeup settings need to be changed), but that requires middle-layer
>> or subsystem code to follow additional rules which currently are not
>> clearly documented.
>>
>> Namely, if a driver calls pm_runtime_resume() for the device from
>> its ->suspend (or equivalent) system sleep callback, that may not
>> work if the middle layer above it has updated the state of the
>> device from its ->prepare or ->suspend callbacks already in an
>> incompatible way.  For this reason, all middle layers must follow
>> the rule that, until the ->suspend callback provided by the device's
>> driver is invoked, the only way in which the device's state can be
>> updated is by calling pm_runtime_resume() for it, if necessary.
>> Fortunately enough, all middle layers in the code base today follow
>> this rule, but it is not explicitly stated anywhere, so do that.
>>
>> Note that calling pm_runtime_resume() from the ->suspend callback
>> of a driver will cause the ->runtime_resume callback provided by the
>> middle layer to be invoked, but the rule above guarantees that this
>> callback will nest properly with the middle layer's ->suspend
>> callback and it will play well with the ->prepare one invoked before.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> Still, some comments below..
>
>> ---
>>
>> This is a follow-up for the system suspend callbacks discussion during
>> the Power Management and Energy-Awareness session at the LPC last week.
>>
>> In particular, I have been thinking about using pm_runtime_resume() from
>> driver ->suspend callbacks and it actually appears to be quite defendable to
>> me as long as it is guaranteed that middle layers will not mess up with the
>> device state before the driver's ->suspend callback is invoked.  If that
>> is the case, and I *think* that it currently is the case for all of the
>> middle layers in the tree unless I overlook something (USB anyone?), the
>> middle layer callbacks involved (->prepare, ->suspend and ->runtime_resume)
>> should actually nest properly and there should not be problems with that.
>> So, my proposal here would be to simply go ahead and document the rules
>> regarding this case without modifying the code.
>>
>> At the same time, I see at least two general problems with calling
>> pm_runtime_force_suspend() from the ->suspend callbacks of device drivers
>> (unless the middle layers involved are trivial).
>>
>> First, note that the middle layer callbacks involved in that case are
>> ->prepare, ->suspend, ->runtime_suspend (called indirectly from within the
>> former) and then *also* ->suspend_late and ->suspend_noirq, because the PM
>> core will call the last two from the middle layer as it has no information
>> that pm_runtime_force_suspend() was called for the device in the "suspend"
>> phase.  Of course, in general, what the middle layer ->suspend_late and
>> ->suspend_noirq do is not guaranteed to play well with what its
>> ->runtime_suspend does even if ->suspend itself is OK (but for ->runtime_resume
>> all of that actually works, because the state it leaves the device in should
>> be compatible with the system suspend callbacks invoked in the later phases).
>>
>> Second, leaving devices in runtime suspend in the "suspend" phase of system
>> suspend is fishy even when their runtime PM is disabled, because that doesn't
>> guarantee anything regarding their children or possible consumers.  Runtime
>> PM may still be enabled for those devices at that time and runtime resume may
>> be triggered for them later, in which case it all quickly falls apart.
>
> This is true, although to me this is a about a different problem and
> has very little to do with pm_runtime_force_suspend().
>
> More precisely, whether runtime PM becomes disabled in the suspend
> phase or suspend_late phase, really doesn't matter. Because in the end
> this is about suspending/resuming devices in the correct order.

Yes, it is, but this is not my point (I didn't make it clear enough I guess).

At the time you make the decision to disable runtime PM for a parent
(say) and leave it in runtime suspend, all of its children are
suspended just fine (otherwise the parent wouldn't have been suspended
too).  However, you *also* need to make sure that there will be no
attempts to resume any of them *after* that point, which practically
means that either runtime PM has to have been disabled already for all
of them at the time it is disabled for the parent, or there has to be
another guarantee in place.

That's why the core tries to enforce the "runtime PM disabled for the
entire hierarchy below" guarantee for the devices with direct_complete
set, but that may just be overkill in many cases.  I guess it may be
better to use WARN_ON() to catch the cases in which things may really
go wrong.

>> IOW, there are reasons why the PM core bumps up the runtime PM usage counters
>> of all devices during system suspend and they also apply to runtime suspend
>> callbacks being invoked directly with runtime PM disabled for the given device.
>> Frankly, it generally is only safe to leave a device in runtime suspend during
>> system suspend if it can be guarateed that the system suspend callbacks in the
>> subsequent suspend phases will not be invoked for it at all.
>
> I understand this is perfectly true for some of the non-trivial middle
> layers, however just to be clear, this statement don't have to serve
> as a general rule for all cases, right?

Well, a really general version of it is something like "it is only
safe to leave a device in runtime suspend during system suspend if it
can be guaranteed that the system suspend callbacks in the subsequent
suspend phases will not change its state" and the most effective way
to make that guarantee is to prevent them from being invoked at all.
:-)

> Moreover, bumping the runtime PM usage count
> (pm_runtime_get_noresume()) in the device_prepare/suspend() phase, was
> originally added to prevent the runtime PM core from runtime
> suspending a device, in cases when runtime PM has been enabled for it.
> Preventing the ->runtime_suspend() callback from being invoked when
> runtime PM is disabled, just doesn't make any sense to me.

The problem is that the functionality of ->runtime_suspend() in
principle overlaps with the functionality of ->suspend(),
->suspend_late() and ->suspend_noirq() combined, but it need not be
entirely the same.  Therefore if you invoke ->runtime_suspend()
anywhere between the beginning of ->suspend() and the end of
->suspend_noirq(), the remaining code in the system sleep callbacks
needs to know about that in order to avoid, for example, attempting to
power down the device for the second time in a row, which very well
may kill the system in some extreme cases.

Of course, if those callbacks are trivial, this problem goes away, but
they need not be trivial and if you are a platform driver (or an
i2c/spi driver too for that matter), you aren't guaranteed that they
will always be trivial.  That is quite a bit of an issue to me.

Thanks,
Rafael
