From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Hibernate fixes for 2.6.39
Date: Wed, 11 May 2011 21:54:42 +0200
Message-ID: <201105112154.42278.rjw__29298.494969453$1305143788$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alexandre Felipe Muller de Souza <alexandrefm@mandriva.com.br>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull three hibernate fixes for 2.6.39 and -stable from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

The first one fixes a recent regression, the other two fix problems
uncovered by the first one.  Since they all are -stable material and only
affect the "hybrid" suspend feature, I don't think there would be any advantage
from deferring them until the merge window opens.


 kernel/power/suspend.c |    4 ++--
 kernel/power/user.c    |    5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

---------------

Rafael J. Wysocki (3):
      PM: Fix warning in pm_restrict_gfp_mask() during SNAPSHOT_S2RAM ioctl
      PM / Hibernate: Make snapshot_release() restore GFP mask
      PM / Hibernate: Fix ioctl SNAPSHOT_S2RAM
