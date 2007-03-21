From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Wed, 21 Mar 2007 22:01:15 +0100 (CET)
Message-ID: <Pine.LNX.4.60.0703212153350.7211@poirot.grange>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320102551.GB19283@elf.ucw.cz>
	<1174388812.3770.29.camel@johannes.berg>
	<200703201644.59046.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703201644.59046.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Ben Dooks <ben@simtec.co.uk>, linux-arm@lists.arm.linux.org.uk, Dirk Behme <dirk.behme@de.bosch.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@lists.linux-foundation.org, Nicolas Pitre <nico@cam.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Mar 2007, David Brownell wrote:

> On Tuesday 20 March 2007 4:06 am, Johannes Berg wrote:
> > Almost all users of pm_ops only support mem sleep, don't check in .valid
> > and don't reject any others in .prepare so users can be confused if they
> > check /sys/power/state, especially when new states are ever added.
> =

> By the way ... as a note to implementors, it should be trivial to
> implement a basic "standby" state that suspends drivers, disables
> many clocks, and probably puts DRAM into self-refresh mode, but
> uses only the wait-for-interrupt CPU lowpower mode.
> =

> A key difference between that and STR would then be that STR does
> extra magic, like switching the CPU to a slow clock and then turning
> off all the clocks that drive the chip "fast".  Also, that because
> it disables so many clocks, the SOC probably can't support as many
> types of wakeup events in STR.

Hm, interesting. What you described above is very similar to what I've =

just implemented for a 8241 based system (linkstation: =

http://ozlabs.org/pipermail/linuxppc-dev/2007-March/thread.html#33203).
But Paul Mackerras suggested to consider it a StR, whereas Johannes Berg =

proposed to call it a standby, which is also what seems to be more logical =

to me. May we agree on some "simple" criteria, like "CPU power on, i.e., =

CPU registers preserved"? If yes - standby, CPU off, registers lost - StR? =

I can imagine CPUs with multiple power sources allowing to switch some of =

them on and off respectively losing / keeping some register sets...

Thanks
Guennadi
---
Guennadi Liakhovetski
