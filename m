From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Fri, 7 Nov 2014 19:25:08 +0200
Message-ID: <545D0074.7060205@ti.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
 <2024276.CFr3nVUAlA@vostro.rjw.lan>
 <CAPDyKFp=T8Luomeaoz5Y=eLAuFaOfdb+-aoU3QVnpjoDYVKPjg@mail.gmail.com>
 <17707586.6KbjDf5Kep@vostro.rjw.lan>
 <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFo-On2MfqHk081o_JZvwbrbi0=n9h6o7A9dJ+X4c8goKg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Simon Horman <horms@verge.net.au>, Philipp Zabel <philipp.zabel@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>, Tomasz Figa <tomasz.figa@gmail.com>, Pavel Machek <pavel@ucw.cz>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Jack Dai <jack.dai@rock-chips.com>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Jinkun Hong <jinkun.hong@rock-chips.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Aaron Lu <aaron.lu@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry
List-Id: linux-pm@vger.kernel.org

Hi All,

Uh... just finished reading this thread and finally decided to add my 5 cents here
as I've already had very bad experience with some changes introduced to DD/PM core :(
(just check the history of the change 1e2ef05bb
"PM: Limit race conditions between runtime PM and system sleep (v2)"

On 11/04/2014 06:42 PM, Ulf Hansson wrote:
> On 4 November 2014 14:51, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Tuesday, November 04, 2014 09:54:19 AM Ulf Hansson wrote:
>>> [...]
>>>
>>>> Generally, there are two or even three levels of runtime PM handling,
>>>> driver, (possibly) bus type and (possibly) PM domain (and multiple levels
>>>> of these are possible in principle).  All of them have to be initialized
>>>> at different times.
>>>>
>>>> Quite arguably, the PM domain and/or bus type runtime PM handling should
>>>> be initialized even before registerind the device or during device
>>>> registration.  Doing that later may be too late.  When the device has been
>>>> registered, runtime PM should work to an extent allowing the driver to access
>>>> the device and configure it further after calling pm_runtime_resume().
>>>>
>>>> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
>>>> it must take the fact that the driver's own ->runtime_resume() may be called
>>>> as a result of this into account.  That's why I'm asking whether or not the
>>>> core should call pm_runtime_resume() before calling really_probe() in a
>>>> followup branch of this thread.
>>>
>>> I am reading the other thread, let's see.
>>>
>>>>
>>>> The driver's own runtime PM handling must be initialized in the driver and
>>>> the only place suitable for that is ->probe().  However, it needs to be done
>>>> *before* the driver's own ->runtime_resume() or ->runtime_suspend() callback
>>>> is executed.  If that is done properly, it should be possible to cover
>>>> both the CONFIG_PM_RUNTIME set/unset cases in that code.
>>>>
>>>> And I wouldn't recommend anyone to do the runtime PM initialization in
>>>> ->runtime_resume() (when it is called for the first time), as that would be
>>>> error prone and fragile.
>>>
>>> Great! That's means we are at least aligned on this topic. :-)
>>>
>>>>
>>>>> The AMBA bus and some of its drivers a good example of how this has
>>>>> been implemented:
>>>>> driver/amba/bus.c
>>>>> drivers/mmc/host/mmci.c
>>>>> drivers/spi/spi-pl022.c
>>>>>
>>>>> This conclusion I have made from this is:
>>>>> - Using pm_runtime_get_sync() during the ->probe() path to explicitly
>>>>> power up a PM domain, is not suitable as the _common_ solution to
>>>>> solve the race condition. It certainly may work for some scenarios,
>>>>> but not for those I am looking at.

Amba bus is not good example as for me, because it's cheating ;)
Why? Bus/Host can't know when its child device is powered on or not unless it's
been notified directly about that and, therefor it's not correct to call
pm_runtime_set_active() from amba_probe() - instead it should be called from driver.
For example:
drivers/mmc/host/mmci.c will be active only when its functional clock is enabled.

Apparently someone decided to save few lines of code.

[Pls, don't comment here unless you have read all my reply :)]

>>>>
>>>> I think, however, that it might work if the core calls pm_runtime_get_sync()
>>>> from driver_probe_device().
>>>
>>> Currently this won't work.
>>>
>>> That's because the buses' ->probe() are invoked in this path and they
>>> are doing the attachment of the device to its PM domain.
>>>
>>> In other words, we can't power up the PM domain using
>>> pm_runtime_get_sync(), until the device has been attached to its PM
>>> domain. Right?
>>
>> Yes, but my point was that those bus types might need to be changed.
>>
>> We can't make everyone happy at the same time if their ideas about what to do
>> are different.
> 
> Urgh. I fail to understand this comment.
> 
> Why do we prefer the pm_runtime_get_sync() solution in favour of this
> pathset's approach?
> 
> What are the benefit do we get with pm_runtime_get_sync()?
> 

So, few points below:
1) It will be good to treat Generic Power domain as new feature (in 3.18 there are
 only 5 users of it). From another side, there are at about 500 users of Runtime PM.
So, Problems discussed here could be treated as not related to Runtime PM but rather
related to GPD ;)

For example (lets use AMBA bus):
- after the commit 207f1a2d "amba: Add support for attach/detach of PM domains" 
and if any device of amba bus will be added to some GPD then
amba_pm_runtime_suspend/resume callbacks will never be called for this device and 
"apb_pclk" will not be enabled/disabled.
Simply because GPD will set dev->pm_domain == &genpd->domain, which PM ops will have higher
priority for Runtime PM than Bus PM ops.

2) There are no requirements for arch/platforms/drivers to work in both cases
CONFIG_PM_RUNTIME=y/n. But they must be built without errors/warning for both
cases. 

For example, for Keystone 2 only CONFIG_PM_RUNTIME=y is going to be supported
and if some one decided to disable it - it can be perfectly done from sys_fs/
user space.

3) pm_runtime_get_sync()(or similar) is good not only because i's waking up device, but also
because:
- it can wake up chain of devices (dev->parent->parent->...)
- it can wake up power domain
- it connects device to domain/class/type/bus and so allow to add additional PM layer on top
  of Platform bus (for example arch/arm/mach-omap2/omap_device.c).

So, it will do all needed things, and if it doesn't that problem is in platfrom/bus/driver
code and not in Runtime PM. 
if pm_runtime_get_sync() will be dropped - than all above will need to be implemented
around the ->probe().

4) I've copied here comment from Rafael:
 >>>> Of course, if ->probe() is to call pm_runtime_resume() for this purpose,
 >>>> it must take the fact that the driver's own ->runtime_resume() may be called
 >>>> as a result of this into account.
 Agree, that's a little bit annoying, but we are living with that for more then
 5 years already (I'm 3 years) - so, I am, as driver developer, expecting above behavior
 (just walk through the drivers and you will see how many drivers expecting the same).

So, any volunteers to check and fix ~500 drivers.

>>
>>>
>>> [...]
>>>
>>>>> For PM domains that are initialized in powered off state, we can't
>>>>> rely on CONFIG_PM_RUNTIME and thus not on pm_runtime_get_sync() to
>>>>> power on these PM domains. We need a different mechanism, which is
>>>>> suggested in this v3 patchset.
>>>>
>>>> That is quite simple to address, though.  You can register a bus type
>>>> notifier that will power up the domain on BUS_NOTIFY_ADD_DEVICE events
>>>> (where the target device belongs to the domain), and do that only for
>>>> CONFIG_PM_RUNTIME unset (otherwise runtime PM should take care of this).
>>>
>>> I guess we could use notifiers, but I am not sure I see any benefit.
>>> The code will be more complex and we need error handling as well.
>>
>> Like "oh, I can't power up this thing, so I should fail ->probe()"?
>>
>> Then your driver would need to depend on the specific knowledge about the
>> given PM domain, I'm afraid.
>>
>> If you want error handling like that, it needs to be handled by the core,
>> so as to avoid calling the bus type's ->probe() as well in that case.
> 
> Yes, I want this error handling - but I fail to understand why the bus
> can't handle the errors.
> 
> If works perfectly in this patchset's approach.
> 
>>
>> So to summarize:
>>
>> - Devices need to be added to power domains before really_probe() is called
>>    for them.  Otherwise we'll have ordering problems all over.

Looks like it's done now. is it?
 

> What ordering problems?
> 
>>
>> - Runtime PM (if compiled in) needs to be enabled for all devices in power
>>    domains by default.  Otherwise devices may lose power as a result for
>>    power management of the other devices in the same domain.

It should prevent enabling/disabling of RPM from sys_fs too.

>>
>> - The core should try to power up domains before calling really_probe() both
>>    for CONFIG_PM_RUNTIME set and unset, so ->probe() can always make the
>>    "device is accessible" assumption.

Here I'm still think that pm_runtime_get_sync() (or similar) API should work.
Another way, PM domain should decide what to do when the first device attached to it
- power up and stay powered on for example
 (It will work if devices are attached before ->probe();
  it will not work if devices will be attached once they've been created, but this is different
  question)

> 
> And how exactly will you then power up the PM domain when
> CONFIG_PM_RUNTIME is unset?
> 
>>
>> - Bus types may need to do more on top of that in their ->probe(), so the
>>    driver's ->probe() can make that assumption too in all cases.
>>
>> Does that make sense to you?
> 

I would like to take the liberty to add a couple of points from me:
 - it seems reasonable to have ability to disable Runtime PM globally from sys_fs:
   once disabled - "get" should power on device, "put" should do nothing all the
   time except when ->remove() is called.
 
 - It might be reasonable to add API like pm_runtime_probe_getXXX() which will do
   everything what standard pm_runtime_get_sync() is doing with one exception:
   it will not call driver's .runtime_resume() callback.

 - Just opinion. For GPD, It looks like integration/design problem and may be
   it shouldn't be integrated with Runtime PM through dev_pm_ops. Instead, it
   might be better to invoke it directly from  RPM core.

regards,
-grygorii
