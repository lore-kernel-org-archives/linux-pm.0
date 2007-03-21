From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Wed, 21 Mar 2007 15:07:54 -0700
Message-ID: <200703211507.55125.david-b@pacbell.net>
References: <20070320015846.636692000@sipsolutions.net>
	<200703201644.59046.david-b@pacbell.net>
	<Pine.LNX.4.60.0703212153350.7211@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.60.0703212153350.7211@poirot.grange>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Wednesday 21 March 2007 2:01 pm, Guennadi Liakhovetski wrote:
> On Tue, 20 Mar 2007, David Brownell wrote:
> > =

> > By the way ... as a note to implementors, it should be trivial to
> > implement a basic "standby" state that suspends drivers, disables
> > many clocks, and probably puts DRAM into self-refresh mode, but
> > uses only the wait-for-interrupt CPU lowpower mode.
> > =

> > A key difference between that and STR would then be that STR does
> > extra magic, like switching the CPU to a slow clock and then turning
> > off all the clocks that drive the chip "fast".  Also, that because
> > it disables so many clocks, the SOC probably can't support as many
> > types of wakeup events in STR.
> =

> Hm, interesting. What you described above is very similar to what I've =

> just implemented for a 8241 based system (linkstation: =

> http://ozlabs.org/pipermail/linuxppc-dev/2007-March/thread.html#33203).

Just the other day.  :)


> But Paul Mackerras suggested to consider it a StR, whereas Johannes Berg =

> proposed to call it a standby, which is also what seems to be more logica=
l =

> to me. =


Seems more like a "standby" to me too -- at least by comparison to
APM and ACPI definitions of "standby", vs what STR involves.


> May we agree on some "simple" criteria, like "CPU power on, i.e.,  =

> CPU registers preserved"? If yes - standby, CPU off, registers lost - StR=
? =


The ACPI spec has some verbiage on those things, which uses
roughly that distinction.

Which is very much an indication of how weak ACPI is.  It
doesn't contemplate typical SOC behavior, which have a wide
variety of system sleep states that leave the CPU on ... and
which may not even *have* (or need!) a "cpu off" state.

My own definition would be more like:  the minimal RAM-based
power-saving system state is "standby".  If the system
implements a deeper RAM-based system sleep state, that's "STR".

If Linux eventually allows more system sleep states than
just "standby", "mem", and "disk", then most of the new
states will probably fit between "standby" (ACPI S1) and
"mem" (ACPI S3).


> I can imagine CPUs with multiple power sources allowing to switch some of =

> them on and off respectively losing / keeping some register sets...

I can see that more readily with SOC designs that have multiple
power domains.  Consider:  CPU, Peripherals-1, Peripherals-2.
That implies several sleep states:

  - all domains powered
  - only peripherals-1 off
  - only peripherals-2 off
  - both peripheral domains off
  - ...
  - all three domains off

Now, I'm not sure that it would be useful to expose all those
states to userspace, but surely an implementor might find it
useful to implement more than one.  In which case, one would
be called "standby", the next "STR", and ... well, Linux PM
can't handle anything else yet.

- Dave
