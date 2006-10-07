From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Alternative Concept [Was: Re: [RFC] CPUFreq PowerOP
	integration, Intro 0/3]
Date: Fri, 6 Oct 2006 22:36:20 -0400
Message-ID: <20061007023620.GD30380@dominikbrodowski.de>
References: <44ECFF94.3030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <44ECFF94.3030506@gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

As you know, I never looked too friendly upon PowerOP and the "operating
points" concept. My latest messages may have illustrated this point even
further -- but the reason for that is that I more and more get the feeling
that PowerOP and "operating points" and the so-called new "PM core" is
trying to do too many things at once, and therefore mixes up differnt
levels. Here is a rough sketch of what I'd like to discuss[1] as an
alternative:


A) The lowest level: lots of knobs.

Somewhere in a "computer system"[2] there are very many "knobs" which may
be turned to influence various voltages, clock levels, or operating modes
("turbo", "performance" or "powersave", for example).

Also, there might be many dependencies on how these "knobs" may be
changed.

Let's assume the system is in a well-defined, working state right now.


B) I want to change one such knob!!!

Now, let's say that we want to change one value controlled by such a knob.
What must we do? We need to check that changing it
	a) does not violate any dependency ["verification"]
	b) all dependencies are handled in correct order ["notification"]


C) Notification

Let's look at the "notification" stage first -- that's what current cpufreq
notifiers do in a very basic way. However, this is also what the new clock
and voltage frameworks are trying to do, right? So that's the lesser problem
now.


D) Verification

So, how to do this verification? Basically, there are two approaches:

1) ask every other subsystem whether the new value is OK with it.
	This is what cpufreq currently suggests to do. It is evident
	that this gets overly complicated with lots of dependencies
	and dependencies within the dependencies -- both in terms
	of concept and in terms of time the verification code takes
	to execute.
	Advantages:
	- easy to expand, also in runtime (e.g. USB system is
		modprobed and telling you of a new minimum voltage
		requirement on certain circumstances)
	- does not limit choices for each knob
	Disadvantages:
	- might get very complex

2) look up all valid states in a table
	This is basically what PowerOP and the "operating points"
	concept suggests: if you want to change one value, you check
	what operating points a) contain the new value and b) is
	most suitable to you.
	Advantages:
	- fast
	- pre-defined set of operating points which the system
	  designer is comfortable with
	Disadvantages:
	- needs to be limited to "core" of the system as else
	  the tables may get overly large
	- limits the choices


E) So, why not combine the best of both worlds?


If you want to change a knob, the "PM core" looks both at every other
subsystem adding dependencies, and at a "operating points" table _ifff_ it
exists.



F) So, how would this work for OMAP1?

Let's limit it, to keep it somewhat simple, to the values contained in your
"struct pm_core_point" for OMAP:

	int cpu_vltg; /* voltage in mV */
	int dpll;     /* in KHz */
	int cpu;      /* CPU frequency in KHz */
	int tc;       /* in KHz */
	int per;      /* in KHz */
	int dsp;      /* in KHz */
	int dspmmu;   /* in KHz */
	int lcd;      /* in KHz */

and let's also add a

	int i_am_special;

Let's assume that there is an OMAP1 PM module which implements a ->set and
->get function for all of them. A yet-to-be-defined interface then tells
this PM module

"I want to increase the CPU frequency from C1 MHz to C2 MHz!"

->set(CPU_VLTG, C2);

The ->set function would then ask whether it is allowed to switch to
frequency B. How would it ask for that? It would both call the "operating
points" layer to check whether such a table is registered. Now, let's assume
there are no external subsystems affected by this change, and the system
engineer has defined such a table:

Nr.	CPU_VLTG	CPU	TC	... 	i_am_special
1	A1		C1	D1		1
2	A2		C1	D1		2
3	A1		C2	D2		3
4	A2		C2	D3		4

The core would determine that the latter two states are now allwed, and
using some sensible algorithm (e.g. "where do I not have to switch too many
knobs", or minimize the costs of switching) decide between those two.
Basically, it would recignize now that it is OK to proceed from state Nr. 1
to Nr. 3, but that this means that "tc" also needs to be changed. After
notifing relevant subsystems using the clock and voltage frameworks, it
would then proceed to set the hardware accordingly.

Now, some might argue "I want to tell the interface to enter mp3-mode, and
not enter some CPU_VLTG and hope that it selects the right table entry then
in the verifcation stage!" Well, you can do that. Using the i_am_special
pseudo-knob. You just tell the yet-to-be-defined interface "I want to switch
knob I_AM_SPECIAL to 4". The process is the same.


G) So, what does this get us?

It may look as "Operating Points" turned on its head now. And yes, it is.
But you can do the following now:
- let cpufreq call ->set(CPU_FREQ, <value>), if you want dynamic frequency
  scaling,
- use pre-defined operating points if it's suitable to do so,
- handles all dependencies either way.

Oh, and as the operating point concept is only introduced as an element
between the low-level setting and the "high-level policy decision", it does
not need to be squeezed into current cpufreq drivers or even the current
cpufreq core in any way. cpufreq may call it, but that should be relatively
easy to implement.


I think that this might be much easier to implement than your PowerOP /
operating points / PM core / PowerOP - cpufreq interaction patches. As a
matter of fact, some parts of your operating points table infrastructure
may be usable for the concept outlined above. So, what do you think? What
does everyone else involved think about this alternative approach?


Thanks,
	Dominik


[1] As many here are aware, I will have very limited time to actually
    implement it.
[2] embedded device, notebook, cluster, desktop with lots of USB devices
    connected, and so on
