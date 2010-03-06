From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] More PM updates for 2.6.34
Date: Sun, 7 Mar 2010 00:17:51 +0100
Message-ID: <201003070017.51319.rjw__18076.2563286864$1267957979$gmane$org@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull more power management updates for 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

There are two patches in this set.  The first one is a missing documentation
update and the second one adds generic power management callbacks for the
subsystems that only need to execute device drivers' callbacks (embedded people
requested that and I think it's going to be immediately useful to them).


 Documentation/power/runtime_pm.txt |   93 ++++++++++++++
 drivers/base/power/Makefile        |    1 +
 drivers/base/power/generic_ops.c   |  233 ++++++++++++++++++++++++++++++++++++
 include/linux/pm.h                 |   51 +++++++-
 include/linux/pm_runtime.h         |    6 +
 5 files changed, 378 insertions(+), 6 deletions(-)

---------------

Rafael J. Wysocki (2):
      PM / Runtime: Document power.runtime_auto and related functions
      PM: Provide generic subsystem-level callbacks
