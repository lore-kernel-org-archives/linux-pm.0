From: Matthew Locke <matt@nomadgs.com>
Subject: Re: Alternative Concept
Date: Mon, 12 Mar 2007 17:57:42 -0700
Message-ID: <CFF99858-3B0C-4492-807E-B61E9CA891E5@nomadgs.com>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061007023620.GD30380@dominikbrodowski.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pm list <linux-pm@lists.osdl.org>
Cc: Eugeny Mints <eugeny@nomadgs.com>, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

So, Its time to restart this discussion:)  After all the discussion  =

last year, Eugeny and I went back to the drawing board to review the  =

requirements and possible solutions.  I thought it would be best to  =

respond to this email to remind everyone where we left off.    David  =

Brownell's latest email on this topic (subject has something with  =

cpufreq in it) is also a good one to read.

Basically, we finally agree that the operating point concept won't  =

work for every platform and it is actually too limited to be the base  =

abstraction.  Please hold applause until the end:)

We dove into A) in Dominik's email and started looking at what a knob  =

layer would require in more detail.  For the moment let's put aside  =

operating points.  We believe that a knob type layer makes sense to  =

be the lowest level as Dominik proposed.  This layer is responsible  =

for controlling hardware resources that affect power management and  =

capturing the relationships between resources.  Power management  =

resources include components such as clock dividers, pll's, voltage  =

regulators, and power domains.  These resources are not always  =

independent and often have a dependency relationship between them.    =

Knob isn't quite the right word for this layer - pm resources are  =

knobs, switches, dials:)   We suggest calling this layer a Power  =

Parameter Framework.


The goal of this parameter framework is to expose the resources in  a  =

way that allows other s/w (governors, policy mangers, etc) to control  =

the resources while keeping the system operational.  One of the main  =

requirements in our thinking is that we want this layer to represent  =

the h/w and not include policy or decision making.  Meaning the  =

software using the parameter framework would be responsible for  =

deciding the appropriate value for the parameters.   The framework  =

breaks down into 4 parts:

- PM resource representation
Similar to the device abstraction available today.  Platforms need to  =

define which resources will be controlled by the parameter  =

framework.  We need to take into account that resources will be from  =

SoCs and boards.

- PM resource control
Architecture independent API for enable/disable get/set of  =

parameters.  Also provide information such as valid ranges or values  =

for the parameter based on hardware limitations.
	- The API would work in terms of parameter values such as  =

frequencies and voltage not register or divider values.
	- Each parameter is referenced by a id/handle to maintain  =

architecture independence.
	- The set function accepts a list of parameter value pairs as well  =

as a single parameter value pair.

- Dependency relationships
We believe 3 types of dependencies need to be addressed.
	- Parent/Child.   This relationship would be for parameters of the  =

same type such as clocks that depend on each other.  Mostly likely a  =

tree structure similar (or exactly the same as) the clock framework  =

except generic for any type of parameter.

	- Domain.  This relationship is for parameters of different types.   =

For example some platforms provide a  gate for the voltage supply to  =

a set of clocks.  The framework would capture the relationship of the  =

voltage gate to the clocks so that information can be used when  =

setting parameters.

	- Functional -  Often there are platform specific dependency  =

relationships that need to be captured and addressed in some way.    =

Some examples: A single register may be used to control several  =

independent clocks requiring some coordination when setting a new  =

value for one or more of the clocks; One parameter may need be  =

changed before another due to some platform specific peculiarities.

- Resource reference counting
Its important to keep track of when a resource is being used.  If no  =

one is using a resource, then a higher level s/w component (governor/ =

policy manager) can decide to turn off the resource.  The framework  =

would provide a claim/release set of APIs for other subsystems/ =

drivers to use.


What is and is not included in the parameter framework?
  - Resources that affect more than one component would go into the  =

framework.  For example, a clock that is used by two or more I/O  =

devices would need coordination to change.  Therefore it goes into  =

the parameter framework.  A resource used by only one device driver  =

and doesn't affect other devices/parameters should be controlled  =

directly in the device driver and not exposed in the parameter  =

framework.

  - The platform designer (or the guy doing the board port) decides  =

which resources makes sense to expose on their platform.  Not all  =

resources are required to be included.  In fact, it may make sense to  =

expose multiple resources as a single parameter.

  - Use case and value based parameter relationships would not be  =

included in the parameter framework.  These relationships are not  =

required to keep the system operational and not every platform will  =

have them. This is where operating points start to make sense.  An  =

optional layer on top of the parameter framework would provide the  =

ability to group parameters together in a similar manner to operating  =

points.  If a platform has a set of optimal parameter values for  =

specific use cases, then it would define parameter groups and assign  =

a group id for the set of values.


Notifications
The framework needs to provide the ability to subscribe to  =

notifications for individual parameter changes.  Device drivers would  =

be able to subscribe for pre and post change events and act accordingly.

Verification
The framework API provides the range or the valid set of values for a  =

parameter so a potential value can be verified.  Also, the parameter  =

dependencies relationships are followed when a parameter or set of  =

parameters are set.

If we can agree to and get a basic framework as described above in  =

place,  we have a good building block for solving some of the other  =

issues such as constraints and policy decisions.  Also, we have a  =

framework in the kernel for clocks today.  This framework would  =

incorporate the clock framework ideas making them generic for any  =

time of power resources and easier to define/use.

I believe this power parameter framework should solve many (if not  =

all) of the issues raised by using operating points as the base  =

abstraction and provide a common layer across architectures.  Eugeny  =

and I have the beginnings of an API proposal for this framework, but  =

we wanted to get some high level feedback on the concepts so we can  =

adjust the API if necessary.  So, comments?


Matt

On Oct 6, 2006, at 7:36 PM, Dominik Brodowski wrote:

> Hi!
>
> As you know, I never looked too friendly upon PowerOP and the  =

> "operating
> points" concept. My latest messages may have illustrated this point  =

> even
> further -- but the reason for that is that I more and more get the  =

> feeling
> that PowerOP and "operating points" and the so-called new "PM core" is
> trying to do too many things at once, and therefore mixes up differnt
> levels. Here is a rough sketch of what I'd like to discuss[1] as an
> alternative:
>
>
> A) The lowest level: lots of knobs.
>
> Somewhere in a "computer system"[2] there are very many "knobs"  =

> which may
> be turned to influence various voltages, clock levels, or operating  =

> modes
> ("turbo", "performance" or "powersave", for example).
>
> Also, there might be many dependencies on how these "knobs" may be
> changed.
>
> Let's assume the system is in a well-defined, working state right now.
>
>
> B) I want to change one such knob!!!
>
> Now, let's say that we want to change one value controlled by such  =

> a knob.
> What must we do? We need to check that changing it
> 	a) does not violate any dependency ["verification"]
> 	b) all dependencies are handled in correct order ["notification"]
>
>
> C) Notification
>
> Let's look at the "notification" stage first -- that's what current  =

> cpufreq
> notifiers do in a very basic way. However, this is also what the  =

> new clock
> and voltage frameworks are trying to do, right? So that's the  =

> lesser problem
> now.
>
>
> D) Verification
>
> So, how to do this verification? Basically, there are two approaches:
>
> 1) ask every other subsystem whether the new value is OK with it.
> 	This is what cpufreq currently suggests to do. It is evident
> 	that this gets overly complicated with lots of dependencies
> 	and dependencies within the dependencies -- both in terms
> 	of concept and in terms of time the verification code takes
> 	to execute.
> 	Advantages:
> 	- easy to expand, also in runtime (e.g. USB system is
> 		modprobed and telling you of a new minimum voltage
> 		requirement on certain circumstances)
> 	- does not limit choices for each knob
> 	Disadvantages:
> 	- might get very complex
>
> 2) look up all valid states in a table
> 	This is basically what PowerOP and the "operating points"
> 	concept suggests: if you want to change one value, you check
> 	what operating points a) contain the new value and b) is
> 	most suitable to you.
> 	Advantages:
> 	- fast
> 	- pre-defined set of operating points which the system
> 	  designer is comfortable with
> 	Disadvantages:
> 	- needs to be limited to "core" of the system as else
> 	  the tables may get overly large
> 	- limits the choices
>
>
> E) So, why not combine the best of both worlds?
>
>
> If you want to change a knob, the "PM core" looks both at every other
> subsystem adding dependencies, and at a "operating points" table  =

> _ifff_ it
> exists.
>
>
>
> F) So, how would this work for OMAP1?
>
> Let's limit it, to keep it somewhat simple, to the values contained  =

> in your
> "struct pm_core_point" for OMAP:
>
> 	int cpu_vltg; /* voltage in mV */
> 	int dpll;     /* in KHz */
> 	int cpu;      /* CPU frequency in KHz */
> 	int tc;       /* in KHz */
> 	int per;      /* in KHz */
> 	int dsp;      /* in KHz */
> 	int dspmmu;   /* in KHz */
> 	int lcd;      /* in KHz */
>
> and let's also add a
>
> 	int i_am_special;
>
> Let's assume that there is an OMAP1 PM module which implements a - =

> >set and
> ->get function for all of them. A yet-to-be-defined interface then  =

> tells
> this PM module
>
> "I want to increase the CPU frequency from C1 MHz to C2 MHz!"
>
> ->set(CPU_VLTG, C2);
>
> The ->set function would then ask whether it is allowed to switch to
> frequency B. How would it ask for that? It would both call the  =

> "operating
> points" layer to check whether such a table is registered. Now,  =

> let's assume
> there are no external subsystems affected by this change, and the  =

> system
> engineer has defined such a table:
>
> Nr.	CPU_VLTG	CPU	TC	... 	i_am_special
> 1	A1		C1	D1		1
> 2	A2		C1	D1		2
> 3	A1		C2	D2		3
> 4	A2		C2	D3		4
>
> The core would determine that the latter two states are now allwed,  =

> and
> using some sensible algorithm (e.g. "where do I not have to switch  =

> too many
> knobs", or minimize the costs of switching) decide between those two.
> Basically, it would recignize now that it is OK to proceed from  =

> state Nr. 1
> to Nr. 3, but that this means that "tc" also needs to be changed.  =

> After
> notifing relevant subsystems using the clock and voltage  =

> frameworks, it
> would then proceed to set the hardware accordingly.
>
> Now, some might argue "I want to tell the interface to enter mp3- =

> mode, and
> not enter some CPU_VLTG and hope that it selects the right table  =

> entry then
> in the verifcation stage!" Well, you can do that. Using the  =

> i_am_special
> pseudo-knob. You just tell the yet-to-be-defined interface "I want  =

> to switch
> knob I_AM_SPECIAL to 4". The process is the same.
>
>
> G) So, what does this get us?
>
> It may look as "Operating Points" turned on its head now. And yes,  =

> it is.
> But you can do the following now:
> - let cpufreq call ->set(CPU_FREQ, <value>), if you want dynamic  =

> frequency
>   scaling,
> - use pre-defined operating points if it's suitable to do so,
> - handles all dependencies either way.
>
> Oh, and as the operating point concept is only introduced as an  =

> element
> between the low-level setting and the "high-level policy decision",  =

> it does
> not need to be squeezed into current cpufreq drivers or even the  =

> current
> cpufreq core in any way. cpufreq may call it, but that should be  =

> relatively
> easy to implement.
>
>
> I think that this might be much easier to implement than your  =

> PowerOP /
> operating points / PM core / PowerOP - cpufreq interaction patches.  =

> As a
> matter of fact, some parts of your operating points table  =

> infrastructure
> may be usable for the concept outlined above. So, what do you  =

> think? What
> does everyone else involved think about this alternative approach?
>
>
> Thanks,
> 	Dominik
>
>
> [1] As many here are aware, I will have very limited time to actually
>     implement it.
> [2] embedded device, notebook, cluster, desktop with lots of USB  =

> devices
>     connected, and so on
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/linux-pm
>
