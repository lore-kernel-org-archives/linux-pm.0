From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Fri, 12 Jun 2009 19:54:56 +0900
Message-ID: <aec7e5c30906120354k6a6a06a3iaff9418684156b85__38561.8536071435$1244804277$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org>
	<200906111108.40785.oliver@neukum.org>
	<aec7e5c30906112013q2d2827feh54192d518156f203@mail.gmail.com>
	<200906121011.13592.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906121011.13592.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 12, 2009 at 5:11 PM, Oliver Neukum<oliver@neukum.org> wrote:
> Am Freitag, 12. Juni 2009 05:13:12 schrieb Magnus Damm:
>> Hi Oliver,
>>
>> On Thu, Jun 11, 2009 at 6:08 PM, Oliver Neukum<oliver@neukum.org> wrote:
>> > Am Donnerstag, 11. Juni 2009 07:18:46 schrieb Magnus Damm:
>> >> 3) When all devices in the power domain are suspended the bus code can
>> >> turn off the power. The reason why I'd like to only autosuspend when
>> >
>> > So you are saying that you have power dependencies independent
>> > of the device tree?
>>
>> I can think of the following power dependencies:
>> - hardware bus topology
>> - clocks
>> - power domains
>
> That means that some devices otherwise unrelated have a common power
> switch, doesn't it?

Yes, various on chip devices share the same power switch.

On the SuperH Mobile SoCs that I've seen we basically have two power
domains. One big which contains almost everything except what's in the
second domain: a timer, watchdog and a rtc. I guess the devices are
related to each other because they are in the same SoC, but exactly
how they relate to each other depends on actual processor type. Same
for clocks.

This presentation may give you an overview of the SuperH Mobile
hardware and where we are today:

http://www.celinuxforum.org/CelfPubWiki/ELC2009Presentations?action=AttachFile&do=view&target=Runtime-Power-Management-on-SuperH-Mobile-20090407.pdf

>> >> all devices are idle is simply that we don't get any power savings
>> >> from the per device autosuspend() callbacks, only from turning off
>> >> power to the entire per-domain. So bindly autosuspending and
>> >> autoresuming devices is just pure overhead unless we know we can do it
>> >> for all devices in the domain.
>> >
>> > Why can't you do this within the framework? You simply suspend when
>> > all a domain's devices have been autosuspended.
>>
>> So you mean I should handle that in my arch/bus specific
>> dev->bus->pm->autosuspend() code? So instead of calling
>> dev->driver->pm->autosuspend() straight away I keep track of the use
>> count of the power domain and when the domain is unused I call
>> dev->driver->pm->autosuspend() for all devices in the power domain
>> before powering off?
>
> How much overhead do you have in autosuspend() if it actually powers
> down the devices? If it is small, I suggest you really run the autosuspend
> methods in the drivers but use a counter for the actual power switching
> on a bus level.

On a SoC scale, returning from the deepest sleep state takes a bit of
time. It depends on clock configuration, but worst case i think it
takes ~3ms to come back from the deepest sleep. Just to let the cpu
core start executing instructions. And on the way back we also have to
setup almost the entire system from scratch which probaly takes quite
a bit of time.

Why I don't want to call dev->driver->pm_autosuspend() directly is
basically our per-processor model hard coded clock dependencies. Some
open devices may block deep sleep, for instance if a serial port is
open we may not deep sleep unless we can live with stopping the clock
and potentially loosing incoming data. So if these open devices block
the entire power domain then there is no point in executing the
dev->driver->pm autosuspend()/autoresume() all the time since we
basically will never power off the domain.

The autosuspend()/autoresume() driver callbacks will save and restore
registers which is quite expensive since each memory access is
uncached. So I don't want to do that more than absolutely necessary.

But I can handle that in the bus type code, no problem. I'm sure ARM
can as well.

>> I guess hooking in things in dev->bus->pm->autosuspend() is doable,
>> but then dev->power.runtime_status will be set to RPM_SUSPENDED even
>> though the actual device isn't suspended at all. And RPM_IDLE state
>
> Why do you care about a device being in RPM_SUSPENDED while
> active. The inverse is a bug, but this seems harmless.

Ok, just wanted to check if you guys agreed with that as a valid combination.

>> will be more or less unused since the drivers should pass a delay of
>> zero to make sure the bus code gets notified about the idle state
>> straight away.
>
> So? You are not getting a common code without a little overhead
> for some cases.

Some overhead is of course acceptable. If it's too much then we can
always optimize later.

>> Basically, for my use case it would make more sense to let the
>> bus_type directly decide when a device should be suspended instead of
>> using a timeout before calling the bus_type code. I rather let the
>> bus_type decide if a timeout should be used or not instead of using it
>> for all bus_types.
>
> So call with a delay of 0.

Sure.

>> So I guess the plan is that drivers directly should invoke
>> pm_request_suspend() to notify the bus that they are idle? (I guess
>> similar to my platform_device_idle()?)
>
> Yes.

Ok, sounds good.

>> So yes, I'd like to do things in dev->bus->pm->autosuspend(), and the
>> code is quite close. I can't figure out why anyone would want the
>> suspend delay at the current level though, but I guess other busses
>> want to use that?
>
> In your case resumption seems to cost almost no energy. In other
> cases you must avoid short sleeps, as you conserve less energy
> sleeping than it takes to resume.

I want to avoid that as well, but I don't think a per-device timeout
is enough. I need to tie in latencies into this somehow. But I prefer
to do that after getting the basic stuff working. Step by step.

Thanks,

/ magnus
