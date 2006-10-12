From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
 integration, Intro 0/3]
Date: Fri, 13 Oct 2006 02:43:48 +0400
Message-ID: <452EC524.5000608@gmail.com>
References: <44ECFF94.3030506@gmail.com>
	<20061007023620.GD30380@dominikbrodowski.de>
Mime-Version: 1.0
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
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Dominik Brodowski wrote:
> Hi!
> =

> As you know, I never looked too friendly upon PowerOP and the "operating
> points" concept. My latest messages may have illustrated this point even
> further -- but the reason for that is that I more and more get the feeling
> that PowerOP and "operating points" and the so-called new "PM core" is
> trying to do too many things at once, and therefore mixes up differnt
> levels. Here is a rough sketch of what I'd like to discuss[1] as an
> alternative:
> =

> =

> A) The lowest level: lots of knobs.
> =

> Somewhere in a "computer system"[2] there are very many "knobs" which may
> be turned to influence various voltages, clock levels, or operating modes
> ("turbo", "performance" or "powersave", for example).
> =

> Also, there might be many dependencies on how these "knobs" may be
> changed.
> =

> Let's assume the system is in a well-defined, working state right now.
In terms which we use to describe PowerOP a "kbob" is "power parameter"
and "operating point" is an entity which corresponds to "well-defined, _wor=
king_
[system power] state".

So, what PowerOP Core does: it just maintains a collection of operating poi=
nt,
i.e. collection of known-to-be-working system power states. On many platfor=
ms
(especially embedded) not all combinations of power parameters are valid.  =
Some
[invalid] combinations of the power parameters may crash or damage the syst=
em.

PowerOP Core operates with operating points and thus provides capability to
switch ONLY between _known-to-be-working_ system power states and bypass any
invalid.

I feel like you are basically talking about similar things. Lets see.

Each time you call ->set(SOME_PLATFORM_POWER_PARAMETER, value1) you want the
system to switch to the set of power parameter values where value of
SOME_PLATFORM_POWER_PARAMETER is equal to 'value1'. Further you
are saying there are two options here:

1) you have a table which tells you that there are some  combinations of po=
wer
parameter values which are
a) _known-to-be-working_
and
b) contains SOME_PLATFORM_POWER_PARAMETER=3Dvalue1.
Then you chose one of these operating points and switch to it.

The table creation is simply registration of operating points with POwerOP =
Core.

Now selection and switch. Obviously the functionality of selection between
operating points based on some algo (which btw varies even not across platf=
orms
but even across different profiles of the same platform) has nothing to do =
with
the code which actually switches operating points. So having such
functionalities coupled within the ->set() method is just invalid design - =
they
have to be separated. That's exactly what PowerOP approach does: an upper l=
ayer
can implement selection logic leveraging PowerOP Core interface and then re=
quest
POwerOP Core to switch system to the selected operating point.

2) table does not exist. There are two options here:

Either,
a)an entity which calls ->set() for a particular power parameter IS
RESPONSIBLE for that resulting combination of power parameter values (once =
the
set has been executed) IS valid one

OR
b) the system executes complex logic you described under D) 1) (in fact,
cpufreq policy notifiers) to get a valid combination of power parameter val=
ues
with a predefined value of a certain power parameter.

Let me illustrate why 2)a) is just particular case in contrast to POwerOP w=
hich
is general case in this situation.

i) PowerOP Core provides interface to get/set value of a particular power p=
arameter

ii)  Let's assume we limit the set of operating points for a platform to on=
e =

point.  This one operating point is always the current operating point.  Al=
l =

operations occur on the the current operating point.

iii)in the assumptions above your  ->set() is nothing else than:
set(param, value)
{
  struct powerop_pwr_param p;

  p.attr =3D param;
  p.value =3D value;
  powerop_set_pwr_params(CURRENT_POINT, &p, 1);
  powerop_set_point(CURRENT_POINT);
}

where CURRENT_POINT may be NULL for example (since in current PowerOP Core =
NULL =

identifier corresponds exactly to "current" operating point).

THe 2)b)(complex logic as the approach to get a valid combination of power
parameter values). This might be point for discussion.
IMO definition of operating points approach as a way to determine a valid
combination of power parameter values is much simple.

That's it. Bottom line is: what you are talking about is NOT an Alternative
Concept but a particular case instead. While PowerOP design is generic case.

I'm not talking about notification (transition notifiers in cpufreq terms)a=
nd
constraints because here we basically on the same page.

The last remark about 256 CPU case. Leveraging POwerOP such systems will be
built using just one (current) operating point approach as described above.
> =

> =

> B) I want to change one such knob!!!
> =

> Now, let's say that we want to change one value controlled by such a knob.
> What must we do? We need to check that changing it
> 	a) does not violate any dependency ["verification"]
> 	b) all dependencies are handled in correct order ["notification"]
> =

> =

> C) Notification
> =

> Let's look at the "notification" stage first -- that's what current cpufr=
eq
> notifiers do in a very basic way. However, this is also what the new clock
> and voltage frameworks are trying to do, right? So that's the lesser prob=
lem
> now.
> =

> =

> D) Verification
> =

> So, how to do this verification? Basically, there are two approaches:
> =

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
> =

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
> =

> =

> E) So, why not combine the best of both worlds?
> =

> =

> If you want to change a knob, the "PM core" looks both at every other
> subsystem adding dependencies, and at a "operating points" table _ifff_ it
> exists.
> =

> =

> =

> F) So, how would this work for OMAP1?
> =

> Let's limit it, to keep it somewhat simple, to the values contained in yo=
ur
> "struct pm_core_point" for OMAP:
> =

> 	int cpu_vltg; /* voltage in mV */
> 	int dpll;     /* in KHz */
> 	int cpu;      /* CPU frequency in KHz */
> 	int tc;       /* in KHz */
> 	int per;      /* in KHz */
> 	int dsp;      /* in KHz */
> 	int dspmmu;   /* in KHz */
> 	int lcd;      /* in KHz */
> =

> and let's also add a
> =

> 	int i_am_special;
> =

> Let's assume that there is an OMAP1 PM module which implements a ->set and
> ->get function for all of them. A yet-to-be-defined interface then tells
> this PM module
> =

> "I want to increase the CPU frequency from C1 MHz to C2 MHz!"
> =

> ->set(CPU_VLTG, C2);
> =

> The ->set function would then ask whether it is allowed to switch to
> frequency B. How would it ask for that? It would both call the "operating
> points" layer to check whether such a table is registered. Now, let's ass=
ume
> there are no external subsystems affected by this change, and the system
> engineer has defined such a table:
> =

> Nr.	CPU_VLTG	CPU	TC	... 	i_am_special
> 1	A1		C1	D1		1
> 2	A2		C1	D1		2
> 3	A1		C2	D2		3
> 4	A2		C2	D3		4
> =

> The core would determine that the latter two states are now allwed, and
> using some sensible algorithm (e.g. "where do I not have to switch too ma=
ny
> knobs", or minimize the costs of switching) decide between those two.
> Basically, it would recignize now that it is OK to proceed from state Nr.=
 1
> to Nr. 3, but that this means that "tc" also needs to be changed. After
> notifing relevant subsystems using the clock and voltage frameworks, it
> would then proceed to set the hardware accordingly.
> =

> Now, some might argue "I want to tell the interface to enter mp3-mode, and
> not enter some CPU_VLTG and hope that it selects the right table entry th=
en
> in the verifcation stage!" Well, you can do that. Using the i_am_special
> pseudo-knob. You just tell the yet-to-be-defined interface "I want to swi=
tch
> knob I_AM_SPECIAL to 4". The process is the same.
> =

> =

> G) So, what does this get us?
> =

> It may look as "Operating Points" turned on its head now. And yes, it is.
> But you can do the following now:
> - let cpufreq call ->set(CPU_FREQ, <value>), if you want dynamic frequency
>   scaling,
> - use pre-defined operating points if it's suitable to do so,
> - handles all dependencies either way.
> =

> Oh, and as the operating point concept is only introduced as an element
> between the low-level setting and the "high-level policy decision", it do=
es
> not need to be squeezed into current cpufreq drivers or even the current
> cpufreq core in any way. cpufreq may call it, but that should be relative=
ly
> easy to implement.
> =

> =

> I think that this might be much easier to implement than your PowerOP /
> operating points / PM core / PowerOP - cpufreq interaction patches. As a
> matter of fact, some parts of your operating points table infrastructure
> may be usable for the concept outlined above. So, what do you think? What
> does everyone else involved think about this alternative approach?
> =

> =

> Thanks,
> 	Dominik
> =

> =

> [1] As many here are aware, I will have very limited time to actually
>     implement it.
> [2] embedded device, notebook, cluster, desktop with lots of USB devices
>     connected, and so on
> =
