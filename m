From: David Brownell <david-b@pacbell.net>
Subject: [patch/rft 2.6.17-rc5-git 2/6] add PM_EVENT_PRETHAW
Date: Mon, 5 Jun 2006 09:37:07 -0700
Message-ID: <200606050937.07871.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_z2FhErRHoXNTor2"
Return-path: <linux-pm-bounces@lists.osdl.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_z2FhErRHoXNTor2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This adds a new pm_message_t event type to use when preparing to switch
into a swsusp snapshot.  Devices that have been initialized by Linux
after resume (rather than left in power-up-reset state) may need to be
reset; this new event type gives drivers the chance to do that.

The drivers that will care about this are those which understand more
hardware states than just "on" and "reset", and read the hardware state
during resume().   Hardware state during resume() should be either the
state left by the preceding suspend(), or a power-lost reset.  When
the swsusp freeze/thaw mechanism kicks in, a troublesome third state
could exist:  one state set up by a different kernel instance, before
a snapshot image is resumed.  This mechanism helps eliminate that state.

(In particular, without the mechanism provided by this patch series,
USB host controller drivers which are statically linked will misbehave
badly during swsusp resume, since swsusp now forces those controllers
into that bogus third state.)
---
 include/linux/pm.h |   64 +++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 16 deletions(-)


--Boundary-00=_z2FhErRHoXNTor2
Content-Type: text/x-diff; charset="us-ascii"; name="prethaw-header.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="prethaw-header.patch"

This adds a new pm_message_t event type to use when preparing to switch
into a swsusp snapshot.  Devices that have been initialized by Linux
after resume (rather than left in power-up-reset state) may need to be
reset; this new event type gives drivers the chance to do that.

The drivers that will care about this are those which understand more
hardware states than just "on" and "reset", and read the hardware state
during resume().   Hardware state during resume() should be either the
state left by the preceding suspend(), or a power-lost reset.  When
the swsusp freeze/thaw mechanism kicks in, a troublesome third state
could exist:  one state set up by a different kernel instance, before
a snapshot image is resumed.  This mechanism helps eliminate that state.

(In particular, without the mechanism provided by this patch series,
USB host controller drivers which are statically linked will misbehave
badly during swsusp resume, since swsusp now forces those controllers
into that bogus third state.)

---
 include/linux/pm.h |   64 +++++++++++++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 16 deletions(-)

Index: g26/include/linux/pm.h
===================================================================
--- g26.orig/include/linux/pm.h	2006-06-02 18:08:30.000000000 -0700
+++ g26/include/linux/pm.h	2006-06-02 18:11:26.000000000 -0700
@@ -143,29 +143,61 @@ typedef struct pm_message {
 } pm_message_t;
 
 /*
- * There are 4 important states driver can be in:
- * ON     -- driver is working
- * FREEZE -- stop operations and apply whatever policy is applicable to a
- *           suspended driver of that class, freeze queues for block like IDE
- *           does, drop packets for ethernet, etc... stop DMA engine too etc...
- *           so a consistent image can be saved; but do not power any hardware
- *           down.
- * SUSPEND - like FREEZE, but hardware is doing as much powersaving as
- *           possible. Roughly pci D3.
- *
- * Unfortunately, current drivers only recognize numeric values 0 (ON) and 3
- * (SUSPEND).  We'll need to fix the drivers. So yes, putting 3 to all different
- * defines is intentional, and will go away as soon as drivers are fixed.  Also
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
 
 #define PM_EVENT_ON 0
 #define PM_EVENT_FREEZE 1
 #define PM_EVENT_SUSPEND 2
+#define PM_EVENT_PRETHAW 3
 
 #define PMSG_FREEZE	((struct pm_message){ .event = PM_EVENT_FREEZE, })
+#define PMSG_PRETHAW	((struct pm_message){ .event = PM_EVENT_PRETHAW, })
 #define PMSG_SUSPEND	((struct pm_message){ .event = PM_EVENT_SUSPEND, })
 #define PMSG_ON		((struct pm_message){ .event = PM_EVENT_ON, })
 

--Boundary-00=_z2FhErRHoXNTor2
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_z2FhErRHoXNTor2--
