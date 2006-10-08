From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: Alternative Concept [Was: Re: [RFC] CPUFreq
	PowerOPintegration, Intro 0/3]
Date: Sun, 8 Oct 2006 09:28:15 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A50800FCF4@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dominik Brodowski <linux@dominikbrodowski.net>, "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

> C) Notification
> =

> Let's look at the "notification" stage first -- that's what =

> current cpufreq
> notifiers do in a very basic way. However, this is also what =

> the new clock
> and voltage frameworks are trying to do, right? So that's the =

> lesser problem
> now.

No, the clock frame work does not do notifications to drivers.

The procedure for system wide frequency scaling using the clock frame
work:
 1: Get a root clock handle (clk_get)
 2: Validate a new target clock rate (clk_get_rate + clk_round_rate)
*3: Use Notification services from some _other_ frame work to drivers
 4: Set the new rate (clk_set_rate)
	- This setting changes potentially several levels of derived
clocks

The clock frame work allows simple maintenance of device local clocks or
the ability to change root clocks or groups of root clocks.  Root clock
changes are the ones which are used with system frequency scaling and
these changes _may_ need the notification depending on the level of
system coupling.


* Reading below in your message you address and seem to get this...  The
following text just shows generally what happens in some current
operating point centric systems.

--------------------
- In an operating point centric system the key root clocks (or other
fundamental system wide variables like power domain) are parameters in
the operating point.  =


- Prior to trying to change in an operating point or a parameter in a
given point, the frame work does a dependency check to registered
drivers which care about operating point parameter changes.  Drivers
which are sensitive to these changes may register constraints to be
_considered_ by the frame work at change times.

- Once the system has decided the change is ok it then notifies the
driver to prepare for the parameter set change.  The controlling frame
works (possibly multiple ones) are used to make the system changes.  The
driver is then notified the change is done.
--------------------

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

That is a pretty good summary.

Depending on your operating point definition you don't always have to
limit yourself here.  An operating point parameter need not directly be
associated with the physical value of the domain it represents.  Meaning
you don't need to put 1.05 volts in for the parameter, you can define it
as some other value which needs translating/defining by the core.

> E) So, why not combine the best of both worlds?

More reading necessary ...

Thanks,
Richard W.
