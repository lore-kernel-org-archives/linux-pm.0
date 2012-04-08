From: Kevin Cernekee <cernekee@gmail.com>
Subject: [RFC] Runtime PM for host controllers
Date: Sun, 8 Apr 2012 15:08:35 -0700
Message-ID: <CAJiQ=7D8QbV45euE1VN0ENpCMUESMMgeUr6gKwK3g+8-PUyTcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

In embedded applications, there are a number of situations in which it
is useful to completely disable a host controller in order to conserve
power.  Some typical scenarios include:

1) A SATA controller is present, but there are no disks attached.
Clock-gating the SATA PHY saves a great deal of power, with the
tradeoff that the controller will no longer be able to detect
hotplugging on the (e)SATA connector.  The user/application is willing
to forego the possibility that a disk will be hotplugged, in order to
realize the power savings.

2) Similar to #1, except there IS a disk attached.  Maybe even
mounted.  But the user/application knows that it will not need to
access the disk any time soon, so it would like to put that part of
the system to sleep.

One such case occurs on PVRs: the user presses the "power off" button
to put the PVR into a non-interactive standby mode.  The TV screen
goes black, yet the OS needs to be kept running for various reasons:
program guide downloads, network bridging/routing, general
housekeeping, etc.  But the HDD can be safely spun down, and the SATA
interface can be put into power save mode until such time that it is
needed again.

It is possible that the various Linux-based NAS devices may also want
to implement this sort of feature, to conserve power after several
hours/days of inactivity.  For many home users, it might make sense
for a NAS appliance to enter a low power state during periods of
limited usage (nighttime), but remain active on the LAN (replying to
ARPs and sending NetBIOS advertisements) so that new requests could be
serviced with a few seconds' notice.

For both NAS and PVR, the root filesystem is typically on flash, not on the HDD.

PVRs in particular are subject to increasingly strict Energy Star /
European CoC rules, so saving even a few hundred milliwatts in standby
mode is critical.

3) Cases #1 and #2, applied to other hotpluggable interfaces like USB,
MMC/SD, or (less commonly) PCIe.

The USB scenario could include situations where the USB *HCI host
controllers can be safely disabled because the physical interface has
been switched to USB device (gadget/OTG) mode.  Or disabled through a
configuration menu to conserve power - especially on a mobile phone.

It could also occur in the case of NAS devices that use external USB
drives instead of SATA drives.

4) A network interface is present, but the user/application knows that
networking will not be needed in the host's current state.  So it can
run "ifconfig eth0 down" and then put the controller and PHY into a
low-power state.


FWIW, these "extra" power save features are usually implemented in
proprietary ways by each SoC manufacturer.  They are not always part
of the general AHCI/EHCI/SDHCI/... specification.  In some cases the
official specification does provide for certain power save modes, but
more extensive savings can be achieved by clock-gating or power-gating
the entire hardware block.  It is probably best to assume they will
always need to be handled by the clk_* functions, or something
similar.


Looking through Linus' head of tree, I see:

USB runtime PM seems to focus on the individual USB devices, and does
not allow for dynamically suspending the entire host controller
AFAICT.

USB used to allow writing "suspend" to the power/control file, but
that no longer seems to be the case as of 2.6.32.  In general I don't
see any facility where the application can explicitly tell the PM core
to suspend a device (incurring a potential loss of functionality, such
as hot plug/unplug detection).

libata has some limited support for runtime PM on a per-port basis,
but on my ahci_platform controller, both ports show up as "active" and
do not seem to want to autosuspend.  One has a HDD attached; the other
is unconnected.  I do not see a way to tell libata to suspend the
whole controller, or even freeze a single port, from userland.

MMC/SD seems to be in better shape with respect to "opportunistically"
suspending the controller if it is idle for 50ms, except the design
still assumes that the hardware is able to detect card
insertion/removal through some other mechanism.  From commit
66fd8ad51:

"For Medfield, the host controller's card detect mechanism is
supplanted by an always-on GPIO which provides for card detect
wake-up."

This is not feasible on all systems, so for systems that lack this
"side channel," it would be necessary to provide a way for userland to
indicate whether it is really OK to suspend the controller and
potentially lose the ability to detect card plug/unplug events.

Several ethernet drivers (such as e1000e) allow autosuspend via
runtime PM if the interface is down.  This is probably about the best
we could hope for on a network adapter.  Although it may be worth
thinking about what to do for cases like ethtool ioctls, which could
cause problems if they result in register accesses to a clock-gated
device.  Is it better to let each driver handle the problem in its own
way, or should the net/core/ code be made aware of runtime PM?


So, my questions are:

a) Is SATA/USB/MMC host controller suspension something that can be
accomplished within the existing runtime PM framework?

b) If not, what is the best way to modify the runtime PM framework so
that it can support these use cases?

c) Is this something you would even want in mainline?

d) Or should I just go back to using "rmmod"?


Thanks in advance for your input.
