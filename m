From: Matthew Locke <matt@nomadgs.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Thu, 10 Aug 2006 00:44:39 -0700
Message-ID: <26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <5da81756733c335565f969bab0c9b934@mvista.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: david singleton <dsingleton@mvista.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Aug 9, 2006, at 9:39 PM, david singleton wrote:

>
> On Aug 9, 2006, at 2:17 PM, Matthew Locke wrote:
>
>> Dave,
>>
>> I think we need to focus on defining a powerop interface that will =

>> work for all (or as close to all as possible) architectures and =

>> devices types including embedded, laptop, server.   As discussed in =

>> previous emails, some of the goals for powerop are:
>
>
> Matt,
> 	I'd hoped I had joined the discussion about the interface.  Is =

> linux-pm not the right mailing list to discuss this?  I asked
> Todd and he pointed me at linux-pm.

Well, that is not what I meant.  Clearly this is the right list - at =

least I hope so because I haven't seen any of the cpufreq developers =

respond to yours or Eugney's patches:)

>
> 	 I find sending patches that actually work and that people can apply =

> and try makes it easier to discuss and evaluate the
> concepts and interfaces.  I  find it necessary to actually have =

> working code to prove a concept.
>

Yes, which is why Eugeny and I sent out the take 3 PowerOP patches.  A =

good discussion ensued and our updated patches are a result of that =

discussion.  If you disagree with our approach or think something is =

missing, give us some specific feedback.  Simply sending out a separate =

set of PowerOP patches is not joining in the current discussion.  It is =

confusing and probably turning people off to the ideas.   Is there =

something specific missing or wrong with the patches we submitted that =

required another set of patches to be developed?  By joining in the =

discussion, I mean that you should let us know this information.  If =

patches are your method for doing so, then at least provide a =

description of what your patches address that ours does not.  Right =

now, its just unclear why there are two different powerop patchsets.

> I also thought the powerop write up and patches I had sent out did =

> address the goals discussed so far:
>

Um,  I thought the powerop write up and  patches already sent out =

addressed the goals discussed so far.  We (everyone on the list) need =

to collaborate on the powerop effort.  Isolated development and =

attempting to discuss two separate implementations won't get us very =

far.

>
>>
>> - Architecture/board independent interface
>
> It has an architecture/board independent interface,  /sys/power/state, =

> /sys/power/supported_states, which presents
> a simplified interface to the user (and power manager).  These two =

> files present the entire interface to the user.
>
> The powerop struct provides the independent interface to the routines =

> to prepare_transition, transition and
> finish_transition is arch independent, through the prepare_transition, =

> transition and finish_transition function pointers.
> The powerop struct also provides the void *md_data pointer which keeps =

> the details an arch/board's  clocks, their divisors/multipliers,
> etc. in the arch/board pieces of code.

The transition callbacks are not needed in every operating point and =

has nothing to do with the operating point definition.  Again, if =

something is missing from the PowerOP patches, let us know.

>
> The powerop struct is arch/board independent.   The functions to =

> control clocks, frequencies, voltages, etc are very
> arch/board dependent, but have an arch independent interface through =

> their op_vector in the powerop struct.
>
>
>> - Integrate with clk framework (and a voltage framework in the =

>> future) for SoC/Board register setting abstraction
>
> This is the patch I'm working on now.  I want to actually integrate it =

> and keep the boundary between arch independent
> and arch/board dependent clear.

We already have done this.  Why duplicate design and implementation =

effort?

>
>> - Provide a layer that knows the SoC and board specifics about =

>> relationship between voltage and frequency and setting operating =

>> points (we call it PM Core)
>
> The patch I'm working on now shows the clock/register abstraction for =

> SoC/board stuff.

The kernel already has a clk framework that provides an API to set =

frequencies by clk name.  It probably could be made even more =

architecture independent.  There is no reason to start from scratch.

>
> The centrino abstraction examle I sent out is quite simple since the =

> perfctl register msr bits can be calculated from the frequency
>  and voltage.  For a more complex board there will be a lot more =

> information, like clocks, their divisors/multipliers for each =

> operating point, etc.

Right, we chose OMAP1 for the first implementation to show an example =

SoC with the lot more information.
>
> But the abstraction is the same for simple or complex boards.  Each =

> operating point has an md_data pointer that
> points to a struct of arch/board dependent data that the transition =

> routines need.  The rest of the abstraction lies
> within the three routines to prepare_transition, transition and =

> finish_transition.  These routines handle the
> arch/board details while the interface remains the same, the function =

> pointers in each operating point

The transition callbacks in the operating point are not necessary.  =

Take a look at how we did this and I think you will find it much more =

flexible and applicable to a wider range of situations.  For example, =

by including frequency and voltage in the generic operating point =

structure, you are already violating the architecture/board =

independence.  Embedded SoC's, SMP systems, and MP systems will have =

multiple frequency and voltages parameters.

>
>
>> - Provide a clean interface to build on top of (for cpu freq =

>> governors, etc).
>
> The point of the powerop patches I've sent is to make a simple =

> interface for power daemons and move all the policy, class
> and governor code out of the kernel and into user space, where I =

> believe it belongs.

Agreed.  The patches we sent have the same goal.

>
>>
>> I think we can defer the discussion around creation of op points from =

>> userspace, suspend/resume integration and transition notifiers.  Once =

>> we get the basics submitted we can add features piece by piece.
>
> I'd prefer not to.  One of the points of sending patches that work is =

> to make sure any new requirements still work without breaking
> the existing framework.

The API isn't going to freeze.  Kernel internals change all the time.  =

Once we have a solid first pass at the kernel portion of powerop we can =

build features and userspace interfaces on top of it.  If you have =

followed the powerop threads, then you know everyone agrees to this =

approach.

>
>>
>> Rather than continue submitting different powerop patches I would =

>> encourage you to join in the discussion about the interface.  I think =

>> Eugeny's latest patches are pretty close to satisfying the points =

>> made so far.  However, we are eagerly waiting feedback because there =

>> always tradeoffs that need to be made when trying to satisfy the =

>> goals listed above.
>
> My hope is that by sending patches that work for more and more boards  =

> people will see that the concepts and interfaces work
> across a wide range of platforms, from embedded to servers.

My goal is to get PowerOP into the mainline kernel.  If everyone =

submits a different powerop implementation for those boards, then =

people will see a fragmented concept that can not be generalized.  The =

possibility of Andrew and Linus accepting PowerOP will go from high to =

never.   Again, I don't see any reason for two separate development =

efforts and patchsets.  Please stop submitting separate patches and at =

least attempt to collaborate on the current PowerOP patchsets under =

discussion.  We should be able to agree since we are both from an =

embedded background:)

I agree that we need a few more boards to prove the interface work and =

I want to see tighter integration of our PowerOP patches and cpufreq.  =

Also we do need a centrino port.  If you don't have any issues with the =

interface we've presented, let's start collaborating.  Perhaps you =

could start from the next rev of patches and add centrino support?

btw, I would like see feedback on Eugeny's last set of patches.

Matt


>
> David
> 	=

>>
>> Thanks
>>
>> Matt
>> On Aug 8, 2006, at 11:12 AM, David Singleton wrote:
>>
>>> The patches provided in the following three emails continue the =

>>> unified,
>>>         simplified PowerOp concept of power management.  The patches
>>>         can be found at:
>>>
>>>                 http://source.mvista.com/~dsingleton
>>>
>>>                         powerop-core.patch
>>>                         powerop-cpufreq.patch
>>>                         powerop-x86-centrino.patch
>>>
>>>
>>>                 The patches break the working PowerOP feature into
>>>         three logical parts.  The first patch is the =

>>> powerop-core.patch
>>>         that adds support for an operating point in the standard =

>>> linux
>>>         power management infrastructure (CONFIG_PM) and adds a new
>>>         function to perform transitioning to operating points other
>>>         than suspend to memory or disk.
>>>
>>>                 The second patch, powerop-cpufreq.patch, adds the =

>>> cpufreq
>>>         portion of the patch that makes cpufreq tables a set of =

>>> PowerOp
>>>         operating points.
>>>
>>>                 The third patch, powerop-x86-centrino.patch, adds
>>>         operating points for all the centrino-speedstep processors.
>>>
>>>
>>>         This set of patches has changed in the following ways.
>>>
>>>         1) The patch is now broken out of the cpufreq code and =

>>> implements
>>>         operating points for whatever speedstep-centrino the system
>>>         detects upon boot.
>>>
>>>         2) The naming scheme for operating points has been unified to
>>>         provide a better interface to the PowerOp power manager =

>>> daemon.
>>>         The names range from:
>>>
>>>                         highest
>>>                         high
>>>                         medhigh
>>>                         medium
>>>                         medlow
>>>                         low
>>>                         lowest
>>>
>>>         PowerOp maps the supported processor frequencies onto this
>>>         namespace list.  The set of centrino processors it supports =

>>> have
>>>         supported sets of between four and six different operating =

>>> points.
>>>
>>>         The PowerOP daemon, coming soon, can simply read the =

>>> supported
>>>         set of operating points and make some simple rules based
>>>         decisions about when to transition to various operating =

>>> points.
>>>
>>>         The goal of a unified name space is to provide a PowerOp =

>>> manager
>>>         that runs out of the box, with very little setup by the user.
>>>
>>>
>>>         3) This patch supports the ability to provide dynamic, =

>>> on-the-fly
>>>         operating points to the framework via a loadable module.  The
>>> operating
>>>         point parameters of frequency, voltage and transition latency
>>>         can be passed at insmod time to create any new operating =

>>> point
>>>         the centrino hardware will support.
>>>
>>>
>>>         I think I finally understand the 'why' of hardware vendors =

>>> asking
>>>         for a requirement of dynamic, on the fly, operating points.
>>>
>>>         I have two sets of hardware that support a wide range of
>>>         processor speeds and voltages depending on:
>>>
>>>         a) the rotary and dip switch setting of the board (the =

>>> mainstone).
>>>
>>>         or
>>>
>>>         b) the revision or stepping of the hardware on the board.
>>>
>>>         Certain revs of hardware support different frequencies and
>>> voltages.
>>>         Some steppings won't run all the frequencies.
>>>
>>>         The hardware vendors want to provide support for all the
>>>         frequencies and voltages that the system could support,
>>>         depending on the switch settings or rev of hardware without
>>>         having to change kernel code and recompile the kernel.
>>>
>>>         The new dynamic, on the fly, operating point module will =

>>> allow
>>>         for this feature.
>>>
>>>
>>> David
>>>
>>> _______________________________________________
>>> linux-pm mailing list
>>> linux-pm@lists.osdl.org
>>> https://lists.osdl.org/mailman/listinfo/linux-pm
>>>
>>
>
