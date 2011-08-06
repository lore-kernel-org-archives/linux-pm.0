From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Two power management fixes for 3.1
Date: Sat, 6 Aug 2011 21:48:44 +0200
Message-ID: <201108062148.45132.rjw__49393.5548970059$1312660088$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two power management fixes for 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

The first one fixes a mistake in (recently merged) pm_genpd_poweron() and
the second one makes the runtime PM framework be a bit more friendly to
driver writers.

Thanks!


 Documentation/power/runtime_pm.txt |   10 +++++-----
 drivers/base/power/domain.c        |    3 +--
 drivers/base/power/runtime.c       |   10 ++++++++--
 3 files changed, 14 insertions(+), 9 deletions(-)

---------------

Kevin Hilman (1):
      PM / Runtime: Allow _put_sync() from interrupts-disabled context

Rafael J. Wysocki (1):
      PM / Domains: Fix pm_genpd_poweron()
