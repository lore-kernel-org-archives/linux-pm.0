From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH -mm 0/8] PM: Rework struct pm_ops and
	related things (take 2)
Date: Tue, 26 Jun 2007 00:39:16 +0200
Message-ID: <200706260039.17530.rjw__12061.0516788021$1182811721$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706242239.05678.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

This is the second version of the patch series to rework pm_ops in order =
to
introduce the set_target() method etc.  This time I've takes some Dave's
comments into consideration and I've realized that a method similar to
set_target() is also needed for hibernation, so I've reworked that too, a=
 bit.

The following series of patches:
* introduces the .set_target() method in 'struct pm_ops' so that the plat=
form
=A0 code knows in advance what sleep state the system is going to enter (=
this
=A0 is urgently needed by at91 and should go into 2.6.22 as a bugfix)
* makes ACPI use .set_target()
* adds an ACPI helper function for the devices to determine the power sta=
te
  to put the device into
* moves the definition of 'struct pm_ops' to <include/suspend.h>
* changes the name of 'struct pm_ops' to 'struct platform_suspend_operati=
ons'
=A0 and modifies the names of some related functions and global variables
=A0 accordingly
* modifies 'struct platform_suspend_operations' so that .prepare() and
=A0 .finish() don't take arguments (.enter() still takes the state argume=
nt,=20
=A0 because some platforms don't need to implement the other callbacks)
* reworks 'struct hibernation_ops' to add the new method analogous to
  .set_target()
* renames 'struct hibernation_ops' to 'struct hibernation_platform_operat=
ions'
  (in analogy with 'struct platform_suspend_operations')
The details are in the changelogs.

The series have been compilation-tested on x86_64 and I'm going to compil=
e
it for all of the affected platforms.

Comments welcome.

Greetings,
Rafael


--=20
"Premature optimization is the root of all evil." - Donald Knuth
