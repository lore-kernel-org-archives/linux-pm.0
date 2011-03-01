From: Pierre Tardy <tardyp@gmail.com>
Subject: [RFC,PATCHv3 0/3] sdhci runtime_pm implementation
Date: Tue,  1 Mar 2011 19:15:30 +0100
Message-ID: <cover.1298820825.git.tardyp__9841.52931855551$1299003420$gmane$org@gmail.com>
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
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org
Cc: Pierre Tardy <tardyp@gmail.com>
List-Id: linux-pm@vger.kernel.org

Please find sdhci runtime_pm implementation.

It uses clock gating fw as a tip to know when our chip is idle.
It implements wake up from card insertion/removal.

This is RFC, please dont merge yet. I really would like to have deep review
from PCI linux-pm guys.

Opens are: 

1/ Not sure if the pci configs in the driver in rpm_suspend/resume flow
 are not duplicate from what the core is doing.

2/ Wakeup from D3hot: I cannot find any driver that is implementing it in current upstream,
I'm not sure if I'm doing it the good way. 
We have the exact same issue for our not yet upstreamable usb-otg driver.
Not sure if this cannot be implemented generically in core.

version 1: was RFC and untested,
version 2: has been tested on intel medfield platform.
version 3: RFC, untested.
- Change runtime_pm initialization to match latest PCI framework scheme
- Added wake-up support

Pierre Tardy (2):
  mmc: sdhci: use ios->clock to know when sdhci is idle
  mmc: sdhci: handle wake-up from runtime_pm

Yunpeng Gao (1):
  mmc: sdhci-pci: Enable runtime PM support

 drivers/mmc/host/sdhci-pci.c |  117 +++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c     |   88 +++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h     |    5 ++
 include/linux/mmc/sdhci.h    |    3 +
 scripts/checkpatch.pl        |    6 +-
 5 files changed, 215 insertions(+), 4 deletions(-)
