From: Pierre Tardy <pierre.tardy@intel.com>
Subject: [PATCH v2 0/3] sdhci runtime_pm implementation using mmc
	clock gating fw
Date: Sun,  6 Feb 2011 19:02:47 +0100
Message-ID: <cover.1297014479.git.pierre.tardy__15651.4546870769$1297097664$gmane$org@intel.com>
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
To: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Pierre Tardy <pierre.tardy@intel.com>
List-Id: linux-pm@vger.kernel.org

Please find a simple sdhci runtime_pm implementation
that uses clock gating fw as a tip to know when 
our chip is idle.

Previous version was RFC and untested,
This version has been tested on intel medfield platform.

Pierre Tardy (2):
  mmc: put the led blinking code after clock ungating
  sdhci:v2:use ios->clock to know when sdhci is idle

Yunpeng Gao (1):
  sdhci-pci : Enable runtime PM support

 drivers/mmc/core/core.c      |    3 +-
 drivers/mmc/host/sdhci-pci.c |  124 ++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c     |   60 ++++++++++++++++++++
 drivers/mmc/host/sdhci.h     |    5 ++
 include/linux/mmc/sdhci.h    |    1 +
 5 files changed, 191 insertions(+), 2 deletions(-)

-- 
1.7.2.3

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
