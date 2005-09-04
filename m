From: Alan Stern <stern@rowland.harvard.edu>
Subject: Suspended devices and drivers
Date: Sun, 4 Sep 2005 12:13:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509041209570.29929-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99054157751727256=="
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

--===============99054157751727256==
Content-Type: TEXT/PLAIN; charset=US-ASCII

Is there any recommendation about what to do when a driver is probed
for a suspended device?  Probably most drivers don't bother to check
the device state; if they encounter errors because the device doesn't
respond the way they expect, the probe will simply fail.  (The USB
subsystem, for example, doesn't take this into account.)  One possible
answer is that this should be handled at the bus level -- the bus
subsystem could be responsible for setting a device to full power
before probing, or it could rely on individual device drivers doing
whatever they need.  It would be nicer if a common solution could be
found that would work uniformly for all devices and buses.  (As part
of such a solution, buses could have a standard policy that devices
with no driver should be left in a low-power state.)

A related problem is faced by USB drivers in a boot kernel.  The
current design relies on USB devices maintaining their state across a
suspend/resume, even suspend to disk.  This makes things difficult
when resuming from disk; the boot kernel has to realize that it
shouldn't disturb the state of any USB devices.  At the moment this
isn't handled very well.  For instance, it would be largely a matter
of luck if you could do STD with the image stored in a swap partition
on a USB storage device.

In fact, maybe it's a mistake to expect USB devices to maintain their
state across STD.  After all, devices on the motherboard aren't
expected to; it's generally accepted that drivers will restore
whatever state is necessary as part of their resume procedure.  Why
shouldn't USB devices behave the same way?

Alan Stern


--===============99054157751727256==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99054157751727256==--
