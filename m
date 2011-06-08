From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fixes for 3.0
Date: Thu, 9 Jun 2011 00:17:28 +0200
Message-ID: <201106090017.28999.rjw__15078.2694960528$1307571577$gmane$org@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two power management fixes for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

One of them is a build fix and the second one fixes an embarassing mistake
in common power management clocks manipulation code.


 drivers/base/power/clock_ops.c |   16 ++++++++--------
 drivers/pci/intel-iommu.c      |    2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

---------------

Rafael J. Wysocki (2):
      PM / Intel IOMMU: Fix init_iommu_pm_ops() for CONFIG_PM unset
      PM / Runtime: Fix loops in pm_runtime_clk_notify()
