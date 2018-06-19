From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/3] cpufreq: add AVS support for Armada 3700
Date: Tue, 19 Jun 2018 14:43:59 +0200
Message-ID: <20180619124402.902-1-gregory.clement@bootlin.com>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Hua Jing <jinghua@marvell.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>, Victor Gu <xigu@marvell.com>, Neta Zur Hershkovits <neta@marvell.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

Armada 37xx supports also Adaptive Voltage Scaling and this series
allow to us it.

In order to configure it, the drives needs to access a new set of
register which is documented in patch 1 and added in the dts in patch
3.

the first 2 patches should be merged through the cpufreq subsystem,
and I will take care of the 3rd patch once the binding will have been
validated.

Thanks,

Gregory CLEMENT (3):
  dt-bindings: marvell: Add documentation for the Armada 3700 AVS
    binding
  cpufreq: armada-37xx: Add AVS support
  arm64: dts: marvell: armada-37xx: add the node allowing AVS support

 .../bindings/arm/marvell/armada-37xx.txt      |  16 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   6 +
 drivers/cpufreq/armada-37xx-cpufreq.c         | 163 +++++++++++++++++-
 3 files changed, 182 insertions(+), 3 deletions(-)

-- 
2.17.1
