From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fix for 2.6.37
Date: Tue, 26 Oct 2010 23:37:20 +0200
Message-ID: <201010262337.20694.rjw__42693.2656010196$1288129565$gmane$org@sisk.pl>
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

Please pull a power management fix for 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes a lockdep warning in the core runtime PM code caused by a missing
nesting annotation.


 drivers/base/power/runtime.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---------------

Ming Lei (1):
      PM / Runtime: fix recursive locking warning of lockdep from rpm_resume()
