From: Shriram Rajagopalan <rshriram@cs.ubc.ca>
Subject: [PATCH 0/3] xen: Use PM/Hibernate events for
	save/restore/chkpt
Date: Sat, 19 Feb 2011 15:12:35 -0800
Message-ID: <1298157158-5421-1-git-send-email-rshriram__26444.2028747455$1298158031$gmane$org@cs.ubc.ca>
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
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, linux-pm@lists.linux-foundation.org, Iam Campbell <ian.campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

The current implementation of xen guest save/restore/checkpoint functionality
uses PM_SUSPEND and PM_RESUME events. This is not optimal when taking
checkpoints of a virtual machine (where the suspend hypercall returns
non-zero, requiring the devices and xenbus to just pickup from where they left
off instead of a complete teardown/reconnect to backend). 

The following set of patches modify this implementation to use Hibernate style
control flow (freeze/restore for save/restore and freeze/thaw for checkpoint,
which is merely a cancelled save akin to failed swsusp() ).

These patches are against Ian Campbell's PVHVM tree at
git://xenbits.xen.org/people/ianc/linux-2.6.git for-stefano/pvhvm

at commit 8a8d1bc753c4e2dda5f2890292d60c67d6ebb573
kernel version: 2.6.38-rc4

Save/Restore and Checkpoint functionality have been tested on PV and PV-HVM
Guest Domains. Patches have been run through checkpatch.pl.

Changes since last resend(s):
  - xenbus_pm_ops has static const qualifier..
  - The conditional macro CONFIG_HIBERNATION around the freeze/thaw/restore
     cases in pm_op and pm_noirq_op functions in drivers/base/power/main.c has
     been expanded to CONFIG_HIBERNATION || CONFIG_XEN_SAVE_RESTORE.
  - CONFIG_PM_SLEEP in drivers/xen/manage.c has been changed to
    CONFIG_XEN_SAVE_RESTORE


Kazuhiro SUZUKI (1):
  xen: xenbus PM events support

Shriram Rajagopalan (2):
  xen: use freeze/restore/thaw PM events for suspend/resume/chkpt
  PM: pm.h - Add comments about Xen save/restore/chkpt use case

 drivers/base/power/main.c                  |    8 ++++----
 drivers/xen/manage.c                       |   16 ++++++++--------
 drivers/xen/xenbus/xenbus_probe.c          |   12 ++++++++++--
 drivers/xen/xenbus/xenbus_probe.h          |    3 ++-
 drivers/xen/xenbus/xenbus_probe_frontend.c |   11 +++++++++--
 include/linux/pm.h                         |   19 +++++++++++++++++++
 include/xen/xenbus.h                       |    2 +-
 7 files changed, 53 insertions(+), 18 deletions(-)
