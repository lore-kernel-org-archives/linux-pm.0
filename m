From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management build fix for 3.1
Date: Wed, 17 Aug 2011 20:41:48 +0200
Message-ID: <201108172041.48394.rjw__12582.2618989789$1313606479$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a power management build fix for 3.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-fixes

This makes the new generic PM domains code build correctly
if CONFIG_PM_RUNTIME is unset.

Thanks!


 drivers/base/power/domain.c |   30 +++++++++++++++---------------
 include/linux/pm_domain.h   |   10 +++++++---
 kernel/power/Kconfig        |    4 ++++
 3 files changed, 26 insertions(+), 18 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Domains: Fix build for CONFIG_PM_RUNTIME unset
