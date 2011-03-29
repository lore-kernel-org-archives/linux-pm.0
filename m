From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management Kconfig modification for
	2.6.39
Date: Tue, 29 Mar 2011 21:54:59 +0200
Message-ID: <201103292154.59567.rjw__19795.6203636297$1301428532$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, LKML <linux-kernel@vger.kernel.org>, Ian Campbell <Ian.Campbell@citrix.com>
List-Id: linux-pm@vger.kernel.org

[Forgot to CC the lists and interested people, sorry.]

Hi Linus,

Please pull a power management Kconfig modification for 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

It modifies power management core Kconfig options so that Xen save/restore
can select CONFIG_HIBERNATION without including the whole image creating and
saving code and the hibernate user space interfaces into the kernel.


 arch/x86/power/Makefile |    3 ++-
 include/linux/suspend.h |   15 +++++----------
 kernel/power/Kconfig    |    4 ++++
 kernel/power/Makefile   |    4 ++--
 kernel/power/main.c     |    2 +-
 kernel/power/power.h    |    6 +++---
 6 files changed, 17 insertions(+), 17 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Hibernate: Introduce CONFIG_HIBERNATE_INTERFACE
