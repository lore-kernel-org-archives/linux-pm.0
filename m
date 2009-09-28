From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes for 2.6.32
Date: Tue, 29 Sep 2009 00:58:20 +0200
Message-ID: <200909290058.20509.rjw__11980.6730458096$1254178673$gmane$org@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

This removes the redundant second argument of pcmcia_socket_dev_suspend()
and, on top of that, fixes CardBus suspend/resume that has been broken
since 2.6.29.

 drivers/pcmcia/at91_cf.c        |    2 +-
 drivers/pcmcia/au1000_generic.c |    2 +-
 drivers/pcmcia/bfin_cf_pcmcia.c |    2 +-
 drivers/pcmcia/cs.c             |    2 +-
 drivers/pcmcia/i82092.c         |    2 +-
 drivers/pcmcia/i82365.c         |    2 +-
 drivers/pcmcia/m32r_cfc.c       |    2 +-
 drivers/pcmcia/m32r_pcc.c       |    2 +-
 drivers/pcmcia/m8xx_pcmcia.c    |    2 +-
 drivers/pcmcia/omap_cf.c        |    2 +-
 drivers/pcmcia/pd6729.c         |    2 +-
 drivers/pcmcia/pxa2xx_base.c    |    2 +-
 drivers/pcmcia/sa1100_generic.c |    2 +-
 drivers/pcmcia/sa1111_generic.c |    2 +-
 drivers/pcmcia/tcic.c           |    2 +-
 drivers/pcmcia/vrc4171_card.c   |    2 +-
 drivers/pcmcia/yenta_socket.c   |   88 +++++++++++++++++++++------------------
 include/pcmcia/ss.h             |    2 +-
 18 files changed, 65 insertions(+), 57 deletions(-)

---------------

Rafael J. Wysocki (2):
      PM / PCMCIA: Drop second argument of pcmcia_socket_dev_suspend()
      PM / yenta: Fix cardbus suspend/resume regression
