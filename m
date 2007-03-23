From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 11:51:13 -0700
Message-ID: <D72CCDBA-7D0E-41FA-9ABD-761D5B8409BC@nomadgs.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221556.08948.david-b@pacbell.net>
	<200703230021.04470.rjw@sisk.pl>
	<200703221655.17693.david-b@pacbell.net>
	<C336656C-88D7-4B34-8464-09FEEF9FD57E@nomadgs.com>
	<20070323131746.GB12226@atomide.com>
	<1174656902.20521.134.camel@Dogbert.NOE.nokia.com>
	<20070323145235.GG12226@atomide.com>
	<1174663030.20521.183.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174663030.20521.183.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: alexey.y.starikovskiy@intel.com, ben@simtec.co.uk, dirk.behme@de.bosch.com, pavel@ucw.cz, johannes@sipsolutions.net, nico@cam.org, linux-pm@lists.linux-foundation.org, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org


On Mar 23, 2007, at 8:17 AM, Igor Stoppa wrote:

> On Fri, 2007-03-23 at 10:52 -0400, ext tony@atomide.com wrote:
>> * Igor Stoppa <igor.stoppa@nokia.com> [070323 09:37]:
>>> On Fri, 2007-03-23 at 09:17 -0400, ext
>>> linux-pm-bounces@lists.linux-foundation.org wrote:
>>>> * Matthew Locke <matt@nomadgs.com> [070322 21:15]:
>>>>>
>>>>> On Mar 22, 2007, at 4:55 PM, David Brownell wrote:
>>>>>
>>>>>> On Thursday 22 March 2007 4:21 pm, Rafael J. Wysocki wrote:
>>>>>>
>>>>>>>> My answer:  there is NO value to such an arbitrary restriction.
>>>>>>>
>>>>>>> I'm not talking on restrictions.
>>>>>>
>>>>>> You most certainly did talk about them.  You said that if the
>>>>>> hardware doesn't support a "turn CPU off" mode, then you'd
>>>>>> define that as being incapable of implementing suspend-to-RAM.
>>>>>> That's a restriction ... a very arbitrary one.
>>>>>>
>>>>>>
>>>>>>> I'm talking on being able to define
>>>>>>> _anything_ more precisely then just a low-power system-wide  =

>>>>>>> state.
>>>>>>
>>>>>> Me too.  And I'm trying to convey to you the results of the
>>>>>> investigations I did on that topic.  You don't seem to like
>>>>>> those results though ...
>>>>>>
>>>>>>
>>>>>>> And let's start from just something, please.  Like STR and
>>>>>>> "standby" to begin
>>>>>>> with?  At least on ACPI systems we can distinguish one from the
>>>>>>> other quite
>>>>>>> clearly, so why can't we start from that and _then_ generalize?
>>>>>>
>>>>>> That's exactly what I did.  Looked also at APM, and several
>>>>>> different SOC designs (AT91, OMAP1, PXA25x, SA1100, more).
>>>>>>
>>>>>> The generalization I came up with is what I've described.
>>>>>> Namely, that coming up with one definition of those states
>>>>>> that can usefully be mapped all platforms is impractical.
>>>>>> They're just labels.  The platform implementor can choose
>>>>>> two states to implement, but non-x86 hardware states rarely
>>>>>> match the expectations of ACPI.
>>>>>>
>>>>>> So the fundamental definition needs to be in relative terms,
>>>>>> because platform-specific differences otherwise make trouble.
>>>>>
>>>>> The problem is that a 1:1 mapping between system low power  =

>>>>> state and
>>>>> a processor low power state is trying to be forced on every
>>>>> platform.  As Dave pointed out, embedded SoC's provide multiple  =

>>>>> low
>>>>> power states that qualify for the suspend-to-ram definition.  The
>>>>> only reasonable platform independent definition is that in STR  =

>>>>> memory
>>>>> is powered and contents preserved.  The rest is platform specific.
>>>>>
>>>>> I think the right answer is that a mechanism for mapping platform
>>>>> specific states to the system states is needed. Platforms define
>>>>> their low power states and define the default for each system
>>>>> state .  On x86 platforms, the default just works and is probably
>>>>> never changed.  On embedded platforms, a policy manager can change
>>>>> the other low power states according to its latency and  =

>>>>> operational
>>>>> requirements.
>>>>
>>>> Plus the states should be distributed. Trying to force the whole
>>>> system into certain state turns things messy.
>>>>
>>>> Some devices may be active while some are in retention or suspend.
>>>>
>>>> Basically everything should idle itself automatically whenever
>>>> possible based on a idle timer or some other policy, such as
>>>> suspending a device from user space via sysfs.
>>>
>>> The timer sound like a reasonable idea, as long as there is one  =

>>> timer
>>> for each shared resource, not user.
>>>
>>> Example:
>>>
>>> Devices A & B share the same voltage domain.
>>>
>>> Device A has timeout period Timeout(A)
>>> Device B has timeout period Timeout(B)
>>>
>>> One timer is associated to the voltage regulator/switch and will  =

>>> expire
>>> at t=3DTIM
>>>
>>> Every time the device d (either A or B) performs some activity, then
>>>
>>> TIM =3D max(TIM, now + Timeout(d))
>>>
>>> When t=3DTIM (timer expired), then the suspend() function for each  =

>>> device
>>> is called.
>>
>> What problem do you see with with device specific idle timers?
>
> That the number of idle timers grows linearly with the number of
> resources consumers rather than _providers_
>
> See also my comment below.
>
>> For example, what's wrong with the following:
>>
>> When the device specific idle timer expires, the driver's suspend
>> function would get called, and the device would release it's clock
>> and voltage.
>
> We might end up doing extra useless activity by saving the state of a
> device that is re-enabled without even going off.
>
> Of course the restoring can be optimised so that it doesn't happen
> unless the voltage has actually been removed (this implies that the
> state saving happens in such a way that doesn't compromise the current
> settings of the device).
>
>> Then when a shared voltage domain has 0 users, that voltage domain
>> can be shut off.
>
> Both your and my approaches have drawbacks: in your case the system  =

> will
> probably end up doing extra state saving, but will be ready to perform
> immediately the transition to off; in my case there will be the  =

> overhead
> of saving the state of the peripherals.

I think we again have the problem that the behavior is very device  =

specific.  Some i/o devices have internal low power states that may  =

or may not require saving state.  Others have no notion of low power  =

states. And on some platforms register contents are preserved even  =

when a device is "off".

How about something like:

  - When idle timer pops,  driver releases pm resources (clock,  =

voltage, whatever).
  - Then driver does device specific stuff which may or may not  =

include going into a low power state and saving state.
  - If a pm resource (clock, voltage, whatever) reference count goes  =

to zero, something will decide to turn it off.
  - Users of the pm resource are told they are going to lose power.
  - Then driver does device specific stuff.  If the device driver  =

already saved state, then ignore.  Otherwise do what the device needs  =

done.

>
> However saving state in a preemptive way is decoupled by having idle
> timers associated to resources providers rather than consumers.
>
>> Same thing with clock domains.
>
> Clocks is fine, since no saving/restoring is needed, albeit we might
> consider PLL relock time to fall in this "costy" class of activities.
>
> -- =

> Cheers, Igor
>
> Igor Stoppa <igor.stoppa@nokia.com>
> (Nokia Multimedia - CP - OSSO / Helsinki, Finland)
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
