From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management regression fix for 3.0
Date: Mon, 11 Jul 2011 21:41:14 +0200
Message-ID: <201107112141.14585.rjw__36832.3584007614$1310415421$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Colin Cross <ccross@android.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a power management regression fix for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes a regression introduced by the recent removal of sysdev_suspend().


 drivers/base/syscore.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

---------------

Colin Cross (1):
      PM: Reintroduce dropped call to check_wakeup_irqs
