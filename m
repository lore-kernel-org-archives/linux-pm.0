From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Thu, 25 May 2006 20:06:04 -0700
Message-ID: <200605252006.06866.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200604271241.28944.david-b@pacbell.net>
	<20060502161208.GC9337@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060502161208.GC9337@linux.intel.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

On Tuesday 02 May 2006 9:12 am, Patrick Mochel wrote:
> On Thu, Apr 27, 2006 at 12:41:28PM -0700, David Brownell wrote:
> =

> > There does seem to be agreement that the current FREEZE invocation is n=
ot
> > sufficient.  I'm looking at a slightly different solution now ... one w=
hich
> > unfortunately involves changing drivers, but can indeed allow swsusp re=
sume
> > paths to do the right thing (instead of what it does now).
> =

> It's Ok if it involves a drive change, so long as its an optional change,=
 which
> means that it shouldn't affect the interface very much (i.e. the calling =

> convention). That's why it'd be good to augment and/or modify pm_message_t
> to implement the changes, so we wouldn't have to change every single driv=
er
> again.. =


I'll post more patches after I sort out some oddness -- why is swsusp_suspe=
nd()
leaving preempt_count() =3D=3D 1, code I was nowhere near? -- but the patch=
 appended
here shows what I'm pursuing.  Same calling convention, new PRETHAW message
that "pm-naive" drivers (most of them!) can handle just like FREEZE.

Other than this, it affects about 20 files with about 2/3 being drivers; say
that maybe 5% of all in-tree drivers needed trivial changes, most of which
could count as bugfixes _before_ defining the new message.

- Dave

p.s. Note the minor nuance in definition of the "ON" state:  that platforms
     may have "ON" operational states with relevant I/O clocks unavailable,
     so that (by implication!) a driver may not be able to resume() into a
     fully functional state. =




This adds a new pm_message_t event type to use when preparing to switch
into a swsusp snapshot.  Devices that have been initialized by Linux
after resume (rather than left in power-up-reset state) may need to be
reset; this new event type give drivers the chance to do that.

The drivers that will care about this are those which understand more
hardware states than just "on" and "reset", and read the hardware state
during resume().   Hardware state during resume() should be either the
state left by the preceding suspend(), or a power-lost reset.  When
the swsusp freeze/thaw mechanism kicks in, a troublesome third state
could exist:  something set up by a different kernel instance, before
a snapshot image is resumed.  This mechanism helps eliminate that state.

(Later patches start to use these new messages.)


Index: g26/include/linux/pm.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- g26.orig/include/linux/pm.h	2006-04-23 00:34:46.000000000 -0700
+++ g26/include/linux/pm.h	2006-05-21 09:19:40.000000000 -0700
@@ -143,29 +143,61 @@ typedef struct pm_message {
 } pm_message_t;
 =

 /*
- * There are 4 important states driver can be in:
- * ON     -- driver is working
- * FREEZE -- stop operations and apply whatever policy is applicable to a
- *           suspended driver of that class, freeze queues for block like =
IDE
- *           does, drop packets for ethernet, etc... stop DMA engine too e=
tc...
- *           so a consistent image can be saved; but do not power any hard=
ware
- *           down.
- * SUSPEND - like FREEZE, but hardware is doing as much powersaving as
- *           possible. Roughly pci D3.
- *
- * Unfortunately, current drivers only recognize numeric values 0 (ON) and=
 3
- * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all dif=
ferent
- * defines is intentional, and will go away as soon as drivers are fixed. =
 Also
- * note that typedef is neccessary, we'll probably want to switch to
- *   typedef struct pm_message_t { int event; int flags; } pm_message_t
- * or something similar soon.
+ * Several driver power state transitions are externally visible, affecting
+ * the state of pending I/O queues and (for drivers that touch hardware)
+ * interrupts, wakeups, and other hardware state.  There may also be
+ * internal transitions to various low power modes, which are transparent
+ * to the rest of the driver stack (such as a driver that's ON gating off
+ * clocks which are not in active use).
+ *
+ * One transition is triggered by resume(), after a suspend() call; the
+ * message is implicit:
+ *
+ * ON		Driver starts working again, responding to hardware events
+ * 		and software requests.  The hardware may have gone through
+ * 		a power-off reset, or it may have maintained state from the
+ * 		previous suspend() which the driver will rely on while
+ * 		resuming.  On most platforms, there are no restrictions on
+ * 		availability of resources like clocks during resume().
+ *
+ * Other transitions are triggered by messages sent using suspend().  All
+ * these transitions quiesce the driver, so that I/O queues are inactive.
+ * That commonly entails turning off IRQs and DMA; there may be rules
+ * about how to quiesce that are specific to the bus or the device's type.
+ * (For example, network drivers mark the link state.)  Other details may
+ * differ according to the message:
+ *
+ * SUSPEND	Quiesce, enter a low power device state appropriate for
+ * 		the upcoming system state (such as PCI_D3hot), and enable
+ * 		wakeup events as appropriate.
+ *
+ * FREEZE	Quiesce operations so that a consistent image can be saved;
+ * 		but do NOT otherwise enter a low power device state, and do
+ * 		NOT emit system wakeup events.
+ *
+ * PRETHAW	Quiesce as if for FREEZE; additionally, prepare for restoring
+ * 		the system from a snapshot taken after an earlier FREEZE.
+ * 		Some drivers will need to reset their hardware state instead
+ * 		of preserving it, to ensure that it's never mistaken for the
+ * 		state which that earlier snapshot had set up.
+ *
+ * A minimally power-aware driver treats all messages as SUSPEND, fully
+ * reinitializes its device during resume() -- whether or not it was reset
+ * during the suspend/resume cycle -- and can't issue wakeup events.
+ *
+ * More power-aware drivers may also use low power states at runtime as
+ * well as during system sleep states like PM_SUSPEND_STANDBY.  They may
+ * be able to use wakeup events to exit from runtime low-power states,
+ * or from system low-power states such as standby or suspend-to-RAM.
  */
 =

 #define PM_EVENT_ON 0
 #define PM_EVENT_FREEZE 1
 #define PM_EVENT_SUSPEND 2
+#define PM_EVENT_PRETHAW 3
 =

 #define PMSG_FREEZE	((struct pm_message){ .event =3D PM_EVENT_FREEZE, })
+#define PMSG_PRETHAW	((struct pm_message){ .event =3D PM_EVENT_PRETHAW, })
 #define PMSG_SUSPEND	((struct pm_message){ .event =3D PM_EVENT_SUSPEND, })
 #define PMSG_ON		((struct pm_message){ .event =3D PM_EVENT_ON, })
 =
