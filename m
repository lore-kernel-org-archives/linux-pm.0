From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 0/9] PM: Update global suspend and
	hibernation operations framework
Date: Sat, 30 Jun 2007 22:57:16 +0200
Message-ID: <200706302257.17556.rjw__10797.3517886878$1183237886$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

This series of patches implements changes that are possible/necessary/des=
irable
(IMO) after the introduction of the .set_target() method in 'struct pm_op=
s'
(the patch that introduces it is in -mm,
http://marc.info/?l=3Dlinux-mm-commits&m=3D118306698814722&w=3D2).

The patches make the following changes:
* make ACPI use the new .set_target() method in 'struct pm_ops'
* add an ACPI helper function for the devices to determine the power stat=
e
=A0 to put the device into
* move the definition of 'struct pm_ops' to <include/suspend.h>
* change the name of 'struct pm_ops' to 'struct platform_suspend_ops' and
  modify the names of some related functions and global variables accordi=
ngly
* modify 'struct platform_suspend_ops' so that .prepare() and .finish() d=
on't
  take arguments (.enter() still takes the state argument, because some
  platforms don't need to implement the other callbacks)
* make some functions normally defined in kernel/power/main.c be also def=
ined
  when CONFIG_PM is unset
* make suspend_ops be a static variable
* rework 'struct hibernation_ops' to add the new method analogous to
=A0 .set_target()
* rename 'struct hibernation_ops' to 'struct platform_hibernation_ops' (i=
n
  analogy with 'struct platform_suspend_ops')
The details are in the changelogs.

The series is on top of the current -mm (which is somewhat updated with r=
espect
to 2.6.22-rc6-mm1).  For convenience, there is a series of patches applic=
able
on top of 2.6.22-rc6-mm1, including the $subject patchset, at:
http://www.sisk.pl/kernel/patches/2.6.22-rc6-mm1/ .

Comments welcome.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
