From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/2] Farewell Armada 375 Z1 support
Date: Tue,  4 Nov 2014 13:00:37 -0300
Message-ID: <1415116839-4323-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Zhang Rui <rui.zhang@intel.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi all,

As we recently discussed [1], the Armada 375 Z1 stepping is no longer supported.

Once the 25 MHz reference clock patches are merged, watchdog and clocksource
will stop working properly [2]. Also, the ethernet driver for Armada 375 SoC
(mvpp2) never supported the Z1 stepping.

These two patches remove the thermal quirk needed for Z1, which currently is
the only piece that explicitly mentions Z1.

[1] http://www.spinics.net/lists/arm-kernel/msg374443.html
[2] http://www.spinics.net/lists/arm-kernel/msg371524.html

Ezequiel Garcia (2):
  thermal: armada: Remove support for A375-Z1 SoC
  ARM: mvebu: Remove thermal quirk for Z1 SoC

 .../devicetree/bindings/thermal/armada-thermal.txt |  8 ---
 arch/arm/mach-mvebu/board-v7.c                     | 66 +---------------------
 drivers/thermal/armada_thermal.c                   | 20 -------
 3 files changed, 1 insertion(+), 93 deletions(-)

-- 
2.1.0
