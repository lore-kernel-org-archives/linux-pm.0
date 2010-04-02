From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM / freezer fixes for 2.6.34
Date: Fri, 2 Apr 2010 21:10:25 +0200
Message-ID: <201004022110.25658.rjw__20236.7969709032$1270235416$gmane$org@sisk.pl>
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
Cc: Oren Ladaan <orenl@cs.columbia.edu>, Xiaotian Feng <dfeng@redhat.com>, LKML <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two freezer fixes for 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

The first one fixes the problem that processes frozen by the cgroup freezer
are thawed during resume, although they shouldn't, and the second one makes
the freezer avoid showing the state of the tasks that didn't refuse to freeze.


 include/linux/freezer.h |    7 +++++--
 kernel/cgroup_freezer.c |    9 ++++++---
 kernel/power/process.c  |    5 ++---
 3 files changed, 13 insertions(+), 8 deletions(-)

---------------

Matt Helsley (1):
      Freezer: Fix buggy resume test for tasks frozen with cgroup freezer

Xiaotian Feng (1):
      Freezer: Only show the state of tasks refusing to freeze
