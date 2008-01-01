From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/4] PM: Do not destroy/create devices while
	suspended (rev. 2)
Date: Wed, 2 Jan 2008 00:32:44 +0100
Message-ID: <200801020032.45529.rjw__31429.2707633742$1199230932$gmane$org@sisk.pl>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Hi,

Some device drivers register CPU hotplug notifiers and use them to destro=
y
device objects when removing the corresponding CPUs and to create these o=
bjects
when adding the CPUs back.

Unfortunately, this is not the right thing to do during suspend/hibernati=
on,
since in that cases the CPU hotplug notifiers are called after suspending
devices and before resuming them, so the operations in question are carri=
ed
out on the objects representing suspended devices which shouldn't be
unregistered behing the PM core's back. =A0Although right now it usually =
doesn't
lead to any practical complications, it will predictably deadlock if
gregkh-driver-pm-acquire-device-locks-prior-to-suspending.patch is applie=
d.

The solution is to prevent drivers from removing/adding devices from with=
in
CPU hotplug notifiers during suspend/hibernation using the FROZEN bit
in the notifier's action argument.  However, this has to be done with car=
e,
since the devices objects related to the nonboot CPUs that failed to go o=
nline
during resume should not be present in the system.  For this reason, it s=
eems
reasonable to introduce a mechanism allowing drivers to ask the PM core t=
o
remove device objects corresponding to suspended devices on their behalf.

The first patch in the series introduces such a mechanism.  The remaining=
 three
patches modify the MSR, x86-64 MCE and cpuid drivers in accordance with t=
he
above approach.

Thanks,
Rafael
