From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 21:04:31 +0100
Message-ID: <200703242104.33123.rjw@sisk.pl>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703231443.19536.rjw@sisk.pl>
	<17924.38452.751960.134885@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <17924.38452.751960.134885@cargo.ozlabs.ibm.com>
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
To: Paul Mackerras <paulus@samba.org>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Saturday, 24 March 2007 04:08, Paul Mackerras wrote:
> Rafael J. Wysocki writes:
> =

> > > You said that if the hardware doesn't support a "turn CPU off" mode, =
then
> > > you'd define that as being incapable of implementing suspend-to-RAM.
> > =

> > That's _if_ the suspend-to-RAM is defined as the state in which the CPU
> > is off, which I _think_ would be a reasonable definition.  I don't mean=
 the
> > platforms incapable of doing this should be restricted from entering any
> > system-wide low-power states, but perhaps we can call these states
> > differently.
> =

> My old powerbook 3400 has a "sleep" mode where the CPU is in sleep
> mode, consuming very little power (and I suspect its clock is switched
> off), the RAM is kept refreshed, most of the peripherals are switched
> off (except that the video chip keeps its register settings), and
> wakeup is under the control of the PMU (power management unit).
> =

> My G4 powerbook has a "sleep" mode where the CPU is switched off, the
> RAM is kept refreshed, most of the peripherals including the video
> chip are switched off, and wakeup is under the control of the PMU.
> =

> As far as a user is concerned, both machines are doing the same thing
> - they're asleep.  Tell me why we should draw a distinction at a
> user-visible level between what these machines are doing, when there
> is no user-visible difference in behaviour?

What I have in mind is the level at which we pass some argument (eg.
PMSG_SUSPEND) to a driver's .suspend() routine and this argument should
depend on the low-power state we want to enter and the meaning of it for
the driver should be exatly known.

Greetings,
Rafael
