From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH v3 0/5] xen: Use PM/Hibernate events for
	save/restore/chkpt
Date: Fri, 11 Mar 2011 21:06:16 -0800
Message-ID: <1299906376-30843-1-git-send-email-rshriram__21897.137622773$1299906648$gmane$org@cs.ubc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: xen-devel@lists.xensource.com
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

The current implementation of xen guest save/restore/checkpoint functionality
uses PM_SUSPEND and PM_RESUME events. This is not optimal when taking
checkpoints of a virtual machine (where the suspend hypercall returns
non-zero, requiring the devices and xenbus to just pickup from where they left
off instead of a complete teardown/reconnect to backend). 

The following set of patches modify this implementation to use Hibernate style
control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
which is merely a cancelled save akin to failed swsusp() ).

These patches are against a merged tree based on linux-next branches from 
Stefano Stabellini and Rafael J. Wysocki.

Changes since last resend(s):
  - Introduce a new user visible symbol HIBERNATION_INTERFACE and
    hide the HIBERNATION symbol. As per earlier discussions, 
    XEN_SAVE_RESTORE could "select" HIBERNATION yet be able to hide the
    sysfs interfaces exposed by hibernation subsystem.

Disabling unnecessary code (if HIBERNATION_INTERFACE) is not
selected, requires a moving around a lot of code. Simply skipping 
snapshot.c, user.c etc from the compile does not help as these files have global
functions and variables, that are being used from elsewhere in the kernel. 
I have currently used #ifs to disable the sysfs interface when user visible
hibernation is disabled, but there is still some code bloat left.

Kazuhiro SUZUKI (1):
  xen: xenbus PM events support

Shriram Rajagopalan (4):
  xen: use freeze/restore/thaw PM events for suspend/resume/chkpt
  PM: pm.h - Add comments about Xen save/restore/chkpt use case
  PM: Add visible HIBERNATION_INTERFACE and hide HIBERNATION
  xen: fix XEN_SAVE_RESTORE Kconfig dependencies

 arch/x86/xen/Kconfig                       |    1 +
 drivers/xen/manage.c                       |   16 ++++++++--------
 drivers/xen/xenbus/xenbus_probe.c          |   12 ++++++++++--
 drivers/xen/xenbus/xenbus_probe.h          |    3 ++-
 drivers/xen/xenbus/xenbus_probe_frontend.c |   11 +++++++++--
 include/linux/pm.h                         |   19 +++++++++++++++++++
 include/xen/xenbus.h                       |    2 +-
 kernel/power/Kconfig                       |   11 ++++++++---
 kernel/power/hibernate.c                   |    8 ++++++++
 kernel/power/main.c                        |    2 +-
 kernel/power/user.c                        |    2 ++
 11 files changed, 69 insertions(+), 18 deletions(-)
