From: Matthew Locke <matt@nomadgs.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Fri, 23 Mar 2007 12:21:37 -0700
Message-ID: <C0893D0E-60E9-4F0F-A731-FCA92C9368DA@nomadgs.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703221655.17693.david-b@pacbell.net>
	<C336656C-88D7-4B34-8464-09FEEF9FD57E@nomadgs.com>
	<200703231129.26643.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703231129.26643.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org


On Mar 23, 2007, at 11:29 AM, David Brownell wrote:

> On Thursday 22 March 2007 6:14 pm, Matthew Locke wrote:
>>>
>>> So the fundamental definition needs to be in relative terms,
>>> because platform-specific differences otherwise make trouble.
>>
>> The problem is that a 1:1 mapping between system low power state and
>> a processor low power state is trying to be forced on every
>> platform.
>
> Sort of.  There are only two labels available for "system" states,
> and the platform-specific code entering those states will probably
> kick in a processor low power state.  But there'd be no point in
> preventing that code from kicking in deeper power save states.

Unless I've misread something, it is exactly a 1:1 mapping between  =

the system state and the cpu state.  There is no code to support  =

mapping multiple cpu states to the system state and then selecting  =

the cpu state that is entered for a system state at runtime.

>
> Consider the PXA 255, which has an "idle" mode that's natural for
> the idle loop, a "33 MHz idle" mode that saves more power but
> means most peripherals can't be clocked, and a "sleep" mode that
> turns the CPU off.  A "standby" might normally use "idle", but
> might likewise use "33 MHz idle" if all the peripheral clocks
> happen to be gated off after the drivers suspend().  That wouldn't
> be a one-to-one mapping ... and smarter hardware might do very
> similar stuff automatically, too.
>


You are saying existing code handles this case?

>
>> As Dave pointed out, embedded SoC's provide multiple low
>> power states that qualify for the suspend-to-ram definition.  The
>> only reasonable platform independent definition is that in STR memory
>> is powered and contents preserved.  The rest is platform specific.
>
> That definition also applies to "standby" of course ... there may
> be a LOT of states where the "standby" label can usefully apply.

Sure, but its easier to start with one thing at time.  Frankly I  =

don't know what do with standby, but if have this ability to change  =

the mapping to the platform state at runtime, then it doesn't really  =

matter.

>
>
>> I think the right answer is that a mechanism for mapping platform
>> specific states to the system states is needed.
>
> That could be done, but in practice not all platform states will
> necessarily be implemented by the platform code.

Ok, does this matter?  Certainly more than two will be implemented.   =

The latest pxa's have much more than that.

>
>
>> Platforms define
>> their low power states and define the default for each system
>> state .  On x86 platforms, the default just works and is probably
>> never changed.
>
> That's the way it works today on all Linux platforms.  The x86
> ones actually don't "just work" in my observation ... when either
> "standby" or "STR" actually work, I've been quite surprised; the
> basic issue seems to be that ACPI resume paths often misbehave.

That is a different problem.  My point is that platforms that don't  =

need to change mappings don't have to do anything different.   Of  =

course there is no  magic that will make them work if they didn't  =

already.

>
>
>> On embedded platforms, a policy manager can change
>> the other low power states according to its latency and operational
>> requirements.
>
> That's not yet a proposal to change things; no details.  :)

Funny.   The details on changing the mapping should be simple enough.

>
> If I were to want to change things in that area, I'd likely want
> to let platforms define their own states and names (*),

Sure.  Much of the behavior is platform specific.  It really depends  =

on who is going to use /sys/power/state.  Will it be a general pm  =

daemon that can be used on every platform or will it be specific to  =

the platform.

> but in
> fact I think it's probably a lot more imporant for embedded cases
> to support top notch *runtime* PM rather than /sys/power/state
> kinds of transitions.

Then why bother contributing to this thread.   Since someone is  =

changing code in this area already and discussing definitions, its  =

good to let everyone what works for other platforms.

>
> - Dave
>
> (*) For example, predefine more suspend_state_t values -- maybe
>     PM_SUSPEND_PLATFORM_{0-9}, to start with -- and then add a
>     label-that-state callback to "struct pm_ops".  Then make
>     /sys/power/state do the obvious stuff to read and write
>     additional states ... voila, platforms can now add new low
>     power states with their own names.  Their clk_must_disable()
>     could let drivers see some of the state differences; there
>     might need to be similar mechanisms for other PM resources.
>
>
