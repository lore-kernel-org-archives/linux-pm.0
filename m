From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Thu, 22 Mar 2007 11:29:27 -0700
Message-ID: <200703221129.28722.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-arm@lists.arm.linux.org.uk, alexey.y.starikovskiy@intel.com, johannes@sipsolutions.net, pavel@ucw.cz, dirk.behme@de.bosch.com, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Thursday 22 March 2007 6:44 am, Scott E. Preece wrote:
> | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> | =

> | I think we can define "standby" a bit more precisely.  Something like:
> | - processes are frozen,
> | - devices are suspended,

True of all sleep states, although one wants "suspended" to
allow different levels of device functionality.  (Maybe it
can wake up, maybe its firmware is monitoring the WLAN, etc.)


> | - nonboot CPUs are down (and in low powered states, if possible),
> | - the boot CPU may or may not be in a low power state, depending on the=
 platform,

Both seem platform-specific.  One might want the DSP to be fully
active while the control CPU is in a lowpower state, etc.


> | - "system" devices may or may not be suspended, depending on the platfo=
rm,

... so this "restriction" is meaningless ...


> | - RAM is powered

I think that's assumed by all states except suspend-to-disk.  Modulo
the potential for powering off the unused banks, of course.


> | - wake up need not be BIOS-driven (main difference from "mem")
> ---
> =

> I would be tempted to say that that last bullet is the distinguishing
> characteristic - that you come back from standby by just continuing
> where you left off, but you come back from StR by something akin to
> booting.

I was going to say that even thinking about a "BIOS" is an x86-ism,
so this would be an unusably non-generic rule.  :)

SOC systems often need to drive their deepest sleep states from code
living in on-chip SRAM (maybe 16 KB).  Sometimes that's also done in
conjunction with code from an on-chip mask ROM, especially if the CPU
itself gets powered off.  That's not BIOS...


... but I guess I don't see why one would want to try to nail down
a definition of either "standby" or "STR".  The implementation will
necessarily be highly platform-specific, to the extent that almost
any rule will need to be broken somewhere.  So, why bother trying
to fit every system into the mold of APM/ACPI terminology?

- Dave
