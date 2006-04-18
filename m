From: "Brown, Len" <len.brown@intel.com>
Subject: RE: RE: on-ness
Date: Tue, 18 Apr 2006 14:39:37 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB63590D8@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82455390692561648=="
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
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============82455390692561648==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

(restored linux-pm to cc:)

yes, the concept was to explore a language generic enough
that it could describe either CPUs or any other devices.

no, this wasn't expected to be complete, just a start.
yes, wakeup capability is one thing we we discussed.
note that we may need to differentiate between enabling
the device to wakeup the system, and waking up just
the device itself.

no, if the numbers happen to corrolate to ACPI states,
that is purely lucky for the ACPI maintainer:-)
But honestly, we should "leverage" all we can from ACPI.
My role, of course, it to make sure that the generic
description can accommodate everything ACPI can do.

yes, idle refers to either Cx or Dx states -- it depends
on the device.  0 means operating, non zero means non-operating.

Re: strings.
we breifly debated strings vs numbers.
I'm not confident that there are enough unique strings
available without falling into state0, state1, state2, state3 --
so numbers seemed simpler.
The only issue I see with numbers is that they imply order,
and it may be that some operating points might not have
such a strict order.

appology in advace for the top-post, Intel IT re-installed my
laptop and a lot of things are not "quite right"...

-Len

-----Original Message-----
From: David Brownell [mailto:david-b@pacbell.net] 
Sent: Tuesday, April 18, 2006 2:15 PM
To: Brown, Len
Cc: Richard A. Griffiths
Subject: Re: [linux-pm] RE: on-ness

On Monday 17 April 2006 2:43 pm, Brown, Len wrote:
> > Thinking about the discussion of the ON field. How about Limiter?
Then
> > maps to no limit (max power, max freq, whatever) and any
> > other number is
> > some limit of performance/power, similar to what was decided for
Idle.
> 
> my scribbles on generic sysfs device directory file names say:

That is, you're talking about parameters related to individual devices?
Or CPUs?

Let's surface more parameters first, before talking about managers!

One more is the wakeup capability; devices may easily have two parameter
sets, one spending a bit of power to deliver wakeup capability.

Another is which <linux/clk.h> clocks are associated with the device.


> state:
> on	- running and available
> off	- requires a full device initialization to be usable

Also e.g. "bus suspend" causing maybe 2 mA current draw vs normal
usb root port power budgets of 100+ mA ... two modes like that, one
supporting remote wakeup and one not.


> idle: # = "how idle"
> 0 - active, not idle at all eg C0, D0
> 1 - idle. eg C1, D1
> ...
> n - most power saving, highest latency idle state, eg. Cn, Dn

These are ACPI CPU states Cx?  Or device states Dx?  Such values
should be a string, which need not match acpi conventions...

- Dave


--===============82455390692561648==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82455390692561648==--
