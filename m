From: david singleton <dsingleton@mvista.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Wed, 9 Aug 2006 21:39:06 -0700
Message-ID: <5da81756733c335565f969bab0c9b934@mvista.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <bb52214749a48f317fba09eb522537bb@nomadgs.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Matthew Locke <matt@nomadgs.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Aug 9, 2006, at 2:17 PM, Matthew Locke wrote:

> Dave,
>
> I think we need to focus on defining a powerop interface that will =

> work for all (or as close to all as possible) architectures and =

> devices types including embedded, laptop, server.   As discussed in =

> previous emails, some of the goals for powerop are:


Matt,
	I'd hoped I had joined the discussion about the interface.  Is =

linux-pm not the right mailing list to discuss this?  I asked
Todd and he pointed me at linux-pm.

	 I find sending patches that actually work and that people can apply =

and try makes it easier to discuss and evaluate the
concepts and interfaces.  I  find it necessary to actually have working =

code to prove a concept.

I also thought the powerop write up and patches I had sent out did =

address the goals discussed so far:


>
> - Architecture/board independent interface

It has an architecture/board independent interface,  /sys/power/state, =

/sys/power/supported_states, which presents
a simplified interface to the user (and power manager).  These two =

files present the entire interface to the user.

The powerop struct provides the independent interface to the routines =

to prepare_transition, transition and
finish_transition is arch independent, through the prepare_transition, =

transition and finish_transition function pointers.
The powerop struct also provides the void *md_data pointer which keeps =

the details an arch/board's  clocks, their divisors/multipliers,
etc. in the arch/board pieces of code.

The powerop struct is arch/board independent.   The functions to =

control clocks, frequencies, voltages, etc are very
arch/board dependent, but have an arch independent interface through =

their op_vector in the powerop struct.


> - Integrate with clk framework (and a voltage framework in the future) =

> for SoC/Board register setting abstraction

This is the patch I'm working on now.  I want to actually integrate it =

and keep the boundary between arch independent
and arch/board dependent clear.

> - Provide a layer that knows the SoC and board specifics about =

> relationship between voltage and frequency and setting operating =

> points (we call it PM Core)

The patch I'm working on now shows the clock/register abstraction for =

SoC/board stuff.

The centrino abstraction examle I sent out is quite simple since the =

perfctl register msr bits can be calculated from the frequency
  and voltage.  For a more complex board there will be a lot more =

information, like clocks, their divisors/multipliers for each operating =

point, etc.

But the abstraction is the same for simple or complex boards.  Each =

operating point has an md_data pointer that
points to a struct of arch/board dependent data that the transition =

routines need.  The rest of the abstraction lies
within the three routines to prepare_transition, transition and =

finish_transition.  These routines handle the
arch/board details while the interface remains the same, the function =

pointers in each operating point


> - Provide a clean interface to build on top of (for cpu freq =

> governors, etc).

The point of the powerop patches I've sent is to make a simple =

interface for power daemons and move all the policy, class
and governor code out of the kernel and into user space, where I =

believe it belongs.

>
> I think we can defer the discussion around creation of op points from =

> userspace, suspend/resume integration and transition notifiers.  Once =

> we get the basics submitted we can add features piece by piece.

I'd prefer not to.  One of the points of sending patches that work is =

to make sure any new requirements still work without breaking
the existing framework.

>
> Rather than continue submitting different powerop patches I would =

> encourage you to join in the discussion about the interface.  I think =

> Eugeny's latest patches are pretty close to satisfying the points made =

> so far.  However, we are eagerly waiting feedback because there always =

> tradeoffs that need to be made when trying to satisfy the goals listed =

> above.

My hope is that by sending patches that work for more and more boards  =

people will see that the concepts and interfaces work
across a wide range of platforms, from embedded to servers.

David
	=

>
> Thanks
>
> Matt
> On Aug 8, 2006, at 11:12 AM, David Singleton wrote:
>
>> The patches provided in the following three emails continue the =

>> unified,
>>         simplified PowerOp concept of power management.  The patches
>>         can be found at:
>>
>>                 http://source.mvista.com/~dsingleton
>>
>>                         powerop-core.patch
>>                         powerop-cpufreq.patch
>>                         powerop-x86-centrino.patch
>>
>>
>>                 The patches break the working PowerOP feature into
>>         three logical parts.  The first patch is the =

>> powerop-core.patch
>>         that adds support for an operating point in the standard linux
>>         power management infrastructure (CONFIG_PM) and adds a new
>>         function to perform transitioning to operating points other
>>         than suspend to memory or disk.
>>
>>                 The second patch, powerop-cpufreq.patch, adds the =

>> cpufreq
>>         portion of the patch that makes cpufreq tables a set of =

>> PowerOp
>>         operating points.
>>
>>                 The third patch, powerop-x86-centrino.patch, adds
>>         operating points for all the centrino-speedstep processors.
>>
>>
>>         This set of patches has changed in the following ways.
>>
>>         1) The patch is now broken out of the cpufreq code and =

>> implements
>>         operating points for whatever speedstep-centrino the system
>>         detects upon boot.
>>
>>         2) The naming scheme for operating points has been unified to
>>         provide a better interface to the PowerOp power manager =

>> daemon.
>>         The names range from:
>>
>>                         highest
>>                         high
>>                         medhigh
>>                         medium
>>                         medlow
>>                         low
>>                         lowest
>>
>>         PowerOp maps the supported processor frequencies onto this
>>         namespace list.  The set of centrino processors it supports =

>> have
>>         supported sets of between four and six different operating =

>> points.
>>
>>         The PowerOP daemon, coming soon, can simply read the supported
>>         set of operating points and make some simple rules based
>>         decisions about when to transition to various operating =

>> points.
>>
>>         The goal of a unified name space is to provide a PowerOp =

>> manager
>>         that runs out of the box, with very little setup by the user.
>>
>>
>>         3) This patch supports the ability to provide dynamic, =

>> on-the-fly
>>         operating points to the framework via a loadable module.  The
>> operating
>>         point parameters of frequency, voltage and transition latency
>>         can be passed at insmod time to create any new operating point
>>         the centrino hardware will support.
>>
>>
>>         I think I finally understand the 'why' of hardware vendors =

>> asking
>>         for a requirement of dynamic, on the fly, operating points.
>>
>>         I have two sets of hardware that support a wide range of
>>         processor speeds and voltages depending on:
>>
>>         a) the rotary and dip switch setting of the board (the =

>> mainstone).
>>
>>         or
>>
>>         b) the revision or stepping of the hardware on the board.
>>
>>         Certain revs of hardware support different frequencies and
>> voltages.
>>         Some steppings won't run all the frequencies.
>>
>>         The hardware vendors want to provide support for all the
>>         frequencies and voltages that the system could support,
>>         depending on the switch settings or rev of hardware without
>>         having to change kernel code and recompile the kernel.
>>
>>         The new dynamic, on the fly, operating point module will allow
>>         for this feature.
>>
>>
>> David
>>
>> _______________________________________________
>> linux-pm mailing list
>> linux-pm@lists.osdl.org
>> https://lists.osdl.org/mailman/listinfo/linux-pm
>>
>
