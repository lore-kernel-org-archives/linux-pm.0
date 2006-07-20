From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: [RFC] PowerOP Take 3, Intro 0/5
Date: Thu, 20 Jul 2006 23:47:24 +0400
Message-ID: <c55240ed0607201247n3cf57dc1k57218b8d994db5b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
Cc: patrick.mochel@intel.com, Matthew Locke <matt@nomadgs.com>, linux@dominikbrodowski.net, sampsa.fabritius@nokia.com
List-Id: linux-pm@vger.kernel.org

PowerOP is a system power parameter management API submitted for
discussion.

This patch set is a follow-up to the PowerOP/cpufreq integration
discussion in the PM summit back in April and the continued discussion
of the small PM group.  It should be considered a reference for further
discussion (hence the ifdefs scattered through out).  Esstentially it may
be seen as take 3 on PowerOP efforts presented by Todd Poynor back
in 2005. While the basic ideas remain the same (thus don't be surprised
if you get deja vu reading the text) PowerOP layer is divided into two
parts - arch independent PowerOP layer and arch dependent PowerOP
layer in attempt to address comments received by Todd on take 2.
Two new layers are presented in the PM architecture design as well.

                                                     user space
-----------------------------------------------------------------
   ----------          --------------------          kernel space
| CPU freq |<->|PowerOP sysfs|
   ----------          --------------------
     ^                       ^
     |                        |
     v                       v
 ----------------------------------------
| Arch Independent PowerOP|
 ----------------------------------------
                                                arch independent
------------------------------------------------------------------------
                                                arch specific
 ---------------------------------------
| Arch Dependent PowerOP |
 --------------------------------------
 ------------------------------
|         PM Core         |
 ------------------------------
 ---------------------------------
|     Clock/Voltage FW    |
 ---------------------------------

In the whole, PowerOP writes and reads power "operating points",
comprised of arbitrary values, called power parameters, that correspond
to registers, clocks, dividers, voltage regulators, etc. that may be
modified to set a basic power/performance point for the system.
Higher-layer power management software passes a platform-specific struct
of power parameters to a backend that makes the requested adjustments.

Arch dependent PowerOP layer defines a set of power parameters utilized
by the platform. Arch independent PowerOP layer provides interfaces for
both (various) higher-layer power management software and (various)
backends to talk to each other in terms defined by arch dependent PowerOP
layer.

>From the cpufreq point of view PowerOP in the whole can be thought of as a
layer below cpufreq that defines platform power parameters and provides
interface to change it. The main goal is to open up interfaces to operating
points comprised of arbitrary power parameters, as an extention to the
"cpu frequency" parameter that cpufreq is designed around.  It pushes the
hardware-level power parameter management down to a level that provide the
capability to deal with entire operating points as the basic unit of
system power
management for reasons described below.

PowerOP layer is intended to leave all power policy decisions to
higher layers in a power management software stack. Although, further
discussion is needed to define interaction of PM framework with drivers.

This work is aimed to extend existing infrastructure for embedded systems,
which often
have several parameters that can be set and the cpu frequency
abstraction specifies only part of the operating point that may be
managed from software.  For example, an XScale PXA27x could be
considered to have six basic power parameters (mainly cpu run mode and
memory and bus dividers) that for the most part should be set in tandem
to known good sets of values as validated by the silicon vendor.
Embedded systems typically handle more hardware clock manipulation
directly in Linux than do, for example, desktop/server systems based on
ACPI interfaces.  Desktop/server systems may also benefit from the
ability to select custom voltages, bus speeds, etc., although deviating
from values validated by the hardware vendor is risky and controversial.

An optional sysfs interface to create and activate operating points is
also submitted for discussion. It hasn't been changed since original Todd
patch.  This interface could be used in an actual power management stack,
or at least can serve as a starting point for discussing how to manage
operating points at the next higher layer in the power management
software stack.

This reference implementation is an example of integrating cpufreq and
PowerOP on the OMAP 1710.

Nowdays Linux has clock framework - well established interface to access
hw clocks and the layer which handles clocks interdependencies. Similar
voltage framework is on the way. Such combined clock/voltage framework
provides a good interface to get/set clock and voltage hw registers.

The arch dependent glue logic may be required to handle either
clock/voltages interdependencies (open question though) or some arch
specific actions required to take place in case of simultaneous coupled
clocks/voltage change (for example  what has to happen first).
New PM Core layer is designed to address this requirements.

To address comments received by Todd on take 2 arch independent PowerOP
layer designed in the way to allow different PM Core layers to be
registered with PowerOP.

Thanks,
Matt, Eugeny
