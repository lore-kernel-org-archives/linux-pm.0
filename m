From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management Kconfig modifications for
	2.6.39
Date: Tue, 12 Apr 2011 22:15:28 +0200
Message-ID: <201104122215.28569.rjw__44002.0634131089$1302639583$gmane$org@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, Shriram Rajagopalan <rshriram@cs.ubc.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull the Kconfig modification introducing CONFIG_HIBERNATE_CALLBACKS and
the Xen patch depending on it from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus


 arch/powerpc/kernel/ibmebus.c |    6 +++---
 arch/x86/xen/Kconfig          |    1 +
 drivers/amba/bus.c            |    6 +++---
 drivers/base/platform.c       |    6 +++---
 drivers/base/power/main.c     |    8 ++++----
 drivers/pci/pci-driver.c      |    6 +++---
 drivers/xen/manage.c          |    6 +++---
 include/linux/suspend.h       |   11 +++--------
 kernel/power/Kconfig          |    6 +++++-
 9 files changed, 28 insertions(+), 28 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Hibernate: Introduce CONFIG_HIBERNATE_CALLBACKS

Shriram Rajagopalan (1):
      fix XEN_SAVE_RESTORE Kconfig dependencies
