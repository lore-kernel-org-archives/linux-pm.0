From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fixes for 2.6.37
Date: Fri, 17 Dec 2010 14:52:35 +0100
Message-ID: <201012171452.35295.rjw__10165.5708662749$1292594067$gmane$org@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They include:

* Restoration of the old hibernate swap signature (I wanted to change it to
  avoid some potential problems, but it turned out that user space used the
  old signature and obviously didn't understand the new one).

* Fix for an ancient bug in the hibernate user interface from Takashi
  (the bug has been there forever, but we didn't have any code where it really
  mattered until very recently).

* Fix for a bug in pm_runtime_suspended() that prevents some devices from being
  suspended and resumed when they should, so it is potentially deadly.


 Documentation/power/runtime_pm.txt |    4 ++--
 include/linux/pm_runtime.h         |    3 ++-
 kernel/power/swap.c                |    2 +-
 kernel/power/user.c                |    2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

---------------

Rafael J. Wysocki (2):
      PM / Hibernate: Restore old swap signature to avoid user space breakage
      PM / Runtime: Fix pm_runtime_suspended()

Takashi Iwai (1):
      PM / Hibernate: Fix PM_POST_* notification with user-space suspend
