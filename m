From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Wed, 8 Jul 2009 14:45:54 +0900
Message-ID: <aec7e5c30907072245i63b632f4r9a2b7ae0d819b446__33523.7118103125$1247032035$gmane$org@mail.gmail.com>
References: <200907060252.12755.rjw@sisk.pl>
	<aec7e5c30907070812n7b418c9bobf64a5259cb6c58d@mail.gmail.com>
	<200907080007.38595.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907080007.38595.rjw@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 8, 2009 at 7:07 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> On Tuesday 07 July 2009, Magnus Damm wrote:
>> On Mon, Jul 6, 2009 at 9:52 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
>> > Hi,
>> >
>> > There's a rev. 8 of the run-time PM framework patch.

>> All good with the code above, but there seem to be some issue with how
>> usage_count is counted up and down and when runtime_disabled is set:
>>
>> 1. pm_runtime_init(): usage_count =3D 1, runtime_disabled =3D true
>> 2. driver_probe_device(): pm_runtime_get_sync()
>> 3. pm_runtime_get_sync(): usage_count =3D 2
>> 4. device driver probe(): pm_runtime_enable()
>> 5. pm_runtime_enable(): usage_count =3D 1
>> 6. driver_probe_device(): pm_runtime_put()
>> 7. pm_runtime_put(): usage_count =3D 0
>>
>> I expect runtime_disabled =3D false in 7. Modifying the get/put calls to
>> do enable/disable may work around the issue, but that's probably not
>> what you guys want.
>
> Sure, that's my mistake. =A0I should have used a separate counter for
> disable/enable, but I thought usage_counter would be sufficient. =A0Will =
fix.

Thank you. No problem.

>> Issue 2:
>> ------------
>> I cannot get any bus ->runtime_resume() callbacks from probe(). This
>> also seems related to usage_count and pm_runtime_get_sync() in
>> driver_probe_device(). Basically, from probe(), calling
>> pm_runtime_resume() after pm_runtime_set_suspended() results in error
>> and not in a ->runtime_resume() callback. Some device drives access
>> hardware in probe(), so the ->runtime_resume() callback is needed at
>> that point to turn on clocks before the hardware can be accessed.
>
> I think the problem is that pm_runtime_get_sync() in driver_probe_device()
> calls ->runtime_resume(), so the device is active from the core's point of
> view when you call pm_runtime_resume() from probe().
>
> Hmm. =A0OK, perhaps we should just increment usage_count in
> driver_device_probe() to prevent suspends from happening at that time, wi=
thout
> calling ->runtime_resume() so that the driver can do it by itself. =A0I'l=
l do
> that in the next version.

Sounds good.

>> Random thought:
>> -------------------------
>> The runtime_pm_get() and runtime_pm_put() look very nice. I assume
>> that inteface is supposed to be used by bus code. I wonder if it would
>> be cleaner to use a similar counter based interface from the driver
>> instead of the pm_runtime_idle()/suspend()/resume()...
>>
>> Let me know what you think!
>
> In fact I thought drivers could also use pm_runtime_[get|put]() and the '=
sync'
> versions. =A0At least, I don't see why not at the moment (well, I'm a bit=
 tired
> right now ...).

I think that's a nicer interface, but I must figure out how to use
->runtime_idle before I can switch to that...

> However, I'm now thinking it should work like this:
>
> * pm_runtime_get() increments usage_count and if it was zero before the
> =A0incrementation, it calls pm_request_resume() (pm_runtime_resume() is c=
alled
> =A0by the 'sync' version).
>
> * pm_runtime_put() decrements usage_count and if it's zero after the
> =A0decrementation, it calls pm_request_idle() (pm_runtime_idle() is calle=
d by
> =A0the 'sync' version).
>
> * The 'suspend' callbacks won't succeed for usage_count > 0.
>
> This way we would avoid calling the 'suspend' and 'idle' functions each t=
ime
> unnecessarily, but then usage_count would have to be modified under the
> spinlock only.

If all usage_count users are moved under the spinlock then there would
be no need for atomic operations, right?

This get()/put() interface is interesting.

So I'd like to tie in two levels of power management in our runtime PM
implementation. The most simple level is clock stopping, and I can do
that using the bus callbacks ->runtime_suspend() and
->runtime_resume() with v8. The driver runtime callbacks are never
invoked for clock stopping.

On top of the clock stopping I'd like to turn off power to the domain.
So if all clocks are stopped to the devices within a domain, then I'd
like to call the per-device ->runtime_suspend() callbacks provided by
the drivers.

I wonder how to fit these two levels of power management into the
runtime PM in a nice way. My first attempts simply made use of
pm_runtime_resume() and pm_runtime_suspend(), but I'd like to move to
get()/put() if possible. But for that to work I need to implement
->runtime_idle() in my bus code, and I wonder if the current runtime
PM idle behaviour is a good fit.

Below is how I'd like to make use of the runtime PM code. I'm not sure
if it's compatible with your view. =3D)

Drivers call pm_runtime_get_sync() and pm_runtime_put() before and
after using the hardware. The runtime PM code invokes the bus
->runtime_idle() callback ASAP (of course depending on put() or
put_sync(), but no timer). The bus->runtime_idle() callback stops the
clock and decreases the power domain usage count. If the power domain
is unused, then the pm_schedule_suspend() is called for each of the
devices in the power domain. This in turn will invoke the
->runtime_suspend() callback which starts the clock, calls the driver
->runtime_suspend() and stops the clock again. When all devices are
runtime suspended the power domain is turned off.

I can't get the above to work with v8 though. This is because after
the clock is stopped with ->runtime_idle() the runtime_status of the
device is still RPM_ACTIVE, so when pm_runtime_get_sync() gets called
the ->runtime_resume() never gets invoked and the clock is never
started...

So I don't know if you think the ->runtime_idle usage above is a good
plan. I guess no, it's probably quite different from the USB case. I
can of course always skip using ->runtime_idle() and just use
suspend()/resume().

Any thoughts?

Thanks,

/ magnus
