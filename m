From: David Brownell <david-b@pacbell.net>
Subject: Re: RE: on-ness
Date: Fri, 21 Apr 2006 08:27:32 -0700
Message-ID: <200604210827.33274.david-b@pacbell.net>
References: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
	<20060420132542.GA2668@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17511749086249839=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060420132542.GA2668@ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============17511749086249839==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 20 April 2006 6:25 am, Pavel Machek wrote:
> > no, if the numbers happen to corrolate to ACPI states,
> > that is purely lucky for the ACPI maintainer:-)
> > But honestly, we should "leverage" all we can from ACPI.
> > My role, of course, it to make sure that the generic
> > description can accommodate everything ACPI can do.
> 
> Please, put there translation layer from the begining. Otherwise
> people will assme they *are* ACPI states, and great confusion will
> begin.

Better yet, don't use numbers, since that's the root cause of the
problem.  Typed enums are OK.  (But of course, ACPI-specific enums
should appear *only* inside the ACPI code...)


> See suspend functions, where half people assumed they are acpi Dx
> states, half people thought they are pci Dx states, and half the
> people assumed they are system Sx states.

When I did the research on this a while back, it was self-evident
that the original 2.4 suspend calls expected system Sx states.

Otherwise the drivers which looked at the parameter and used it
when selecting a target device state would have made no sense.
(Likewise, all those drivers had to **remove functionality** as
part of the pm_message_t search'n'destroy mission...)

There was mild confusion about them being PCI_Dx states, mostly
because the simplest mostly-works mapping of ACPI_Sx states to
PCI_Dx states was the identity mapping.  And especially for PM,
many driver writers are lazy.

I don't ever recall seeing drivers assume the parameter was an
ACPI_Dx state.  That would have been deeply wrong, since most
hardware will never run ACPI.  What I did see was that the first
incarnation of the 2.6 power management framework changed the
state numbers in a way that broke most of the drivers relying on
that identity mapping ... and I also saw disagreement between that
framework and the swsusp code about what numbers to pass.

All that's resolved now, but with a net loss of functionality.
And yes, the root cause was the initial use of (untyped) numbers,
where a translation layer would have reduced trouble.  But not
using numbers could have avoided the problems entirely!
 

> > Re: strings.
> > we breifly debated strings vs numbers.
> > I'm not confident that there are enough unique strings
> > available without falling into state0, state1, state2, state3 --
> > so numbers seemed simpler.

This is called a "lack of imagination".  ;)

Most SOC specs I look at don't use numbers to describe either
device, CPU, or system states ...  many don't even distinguish
CPU sleep/idle states from system states.  They use a variety
of names to describe various aspects of the hardware states, and
often the issues are more like "which clocks are available".
(Or, for system states, "clock domains" ... e.g. "everything
derived from oscillator X" or tied to a given PLL.)


> > The only issue I see with numbers is that they imply order,
> > and it may be that some operating points might not have
> > such a strict order.

In my observation, "strict order" would be the exception not
the rule.  There are often three or four orthogonal factors,
and they don't naturally fit any two-dimensional linear order.


> Second issue is that you might want to "insert" between states.
> ...

Of course, "between" implies some strict/linear order...


> Yes, inventing good names may be tricky in some cases, but in other
> cases names are very natural (arm has sleep, deep sleep and big sleep,
> iirc).... And we can always fall back to state0..state5.

Well, OMAP is one implementation that uses ARM, and it certainly has
"deep sleep" and "big sleep".  But other ARM based SOCs provide very
different power abstractions (consider "slow clock mode", "idle",
"frozen", "standby", "stop", "sleep") and may use the same names to
indicate different things.  System state names are system specific.

If ACPI wants to use names like "ACPI_S0".."ACPI_S5", that's fine;
but Linux should not inflict such an approach on systems that don't
use ACPI.  Developers might find it handy to contrast one SOC's
"deep sleep" to "ACPI_S3" (or to "deep sleep" on another SOC), but
it won't be an exact match; square peg, round hole.

- Dave


--===============17511749086249839==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17511749086249839==--
