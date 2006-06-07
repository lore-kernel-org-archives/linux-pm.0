From: Alan Stern <stern@rowland.harvard.edu>
Subject: Information in PM messages
Date: Wed, 7 Jun 2006 17:53:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0606071722200.32731-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Right now the pm_message structure contains only one member: event.  It =

tells, in rather generic form, the action a driver is supposed to take =

upon receiving the message.

It seems to me that when runtime PM is fully supported, drivers will also
want to know the source of a message.  So there will have to be two pieces
of information:

	The source, or the reason for the message;

	The target, or the desired state or power-level change.

For the messages produced by system sleep transitions (PM_EVENT_FREEZE, =

PM_EVENT_PRETHAW, PM_EVENT_SUSPEND, and PM_EVENT_ON) the source is simply =

"the system".

For messages produced by userspace writing to a sysfs attribute file, the =

source is "the user".

When drivers start supporting autosuspend and autoresume, they will want =

to create PM messages whose source is "the driver".

When a device sends a remote wakeup request, the source could be taken as
"the device".  However since it will always be a driver that generates the
PM message in response to the device request, the source could just as
well be "the driver", as with autoresume.

For system sources, we already have a set of target states.  For user
sources, the target states should be defined by the individual bus or
device driver.  The best way to represent them might be as pointers to
character strings, since strings are easily passed through sysfs.  For
driver sources, the target states are purely a driver-internal matter.  =

They could be pointers to data structures containing operating-point
parameters, for instance.

This suggests that a pm_message_t should include (or should be accompanied =

by) an integer or enum that takes on one of these values:

	PM_SOURCE_SYSTEM, PM_SOURCE_USER, PM_SOURCE_DRIVER

The "event" member could be changed to a void * with very little trouble;  =

this would allow it to represent all sorts of target states.  (It also
could be renamed "target", but this would be a lot of trouble!)  This
could help embedded platforms, which would then find it easy to add new
target states to represent different varieties of system sleep.

Currently hardly any drivers have implemented any serious runtime PM.  =

When more start doing so, we might want to make explicit the following =

policy:

	A message whose source is USER or DRIVER should not be
	allowed to resume a device that was suspended by a message
	whose source was SYSTEM.  In other words, runtime PM and
	autoresume should not interfere with a system sleep transition.

(Mostly this can't happen, because such messages have to be created by =

tasks that normally will be frozen during a system sleep transition.  But =

some transitions don't freeze tasks, such as STR on powermac.)

Individual drivers might have requirements of their own, such as this one:

	A DRIVER suspend message should fail if the device's remote
	wakeup facility is not enabled.

(Obviously some devices, such as USB hubs, shouldn't autosuspend if they =

are unable or not permitted to autoresume.  For other devices, such as =

printers, this wouldn't matter.)

I think it makes sense to keep track of the reason behind a PM message.  =

Although there hasn't been much reason to do so up 'til now, in the future =

it will become more important.  Think of this as a proposal for upcoming =

development.

Alan Stern
