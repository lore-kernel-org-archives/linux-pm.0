From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v3 0/2]  Add cpufreq support for Armada 8K
Date: Tue, 11 Dec 2018 17:42:47 +0100
Message-ID: <20181211164249.26985-1-gregory.clement@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

this is the third version of a the series adding the cpufreq support
for the Marvell Armada 8K SoCs.

Gregory

Changelog:
v2 -> v3

 - Make the driver really modular (modprobe;modprobe -r;modprobe; is working)

 - Don't use anymore 100MHz as minimal frequency, but only max frequency/4

 - Fix remaining warning reported by checkpatch

 - Rework the registering of the opp

v1 -> v2:

 - Fix typos in MAINTAINERS (reported by Baruch Siach) and in
   armada-8k-cpufreq.c (reported by Thomas Petazzoni)

 - Fix indentation in Kconfig.arm  (reported by Thomas Petazzoni)

 - Use const for opps_div  (reported by Thomas Petazzoni)

 - Fix memory leak of opps_array  (reported by Thomas Petazzoni)

Gregory CLEMENT (2):
  MAINTAINERS: add new entries for Armada 8K cpufreq driver
  cpufreq: ap806: add cpufreq driver for Armada 8K

 MAINTAINERS                         |   1 +
 drivers/cpufreq/Kconfig.arm         |  11 ++
 drivers/cpufreq/Makefile            |   1 +
 drivers/cpufreq/armada-8k-cpufreq.c | 186 ++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 drivers/cpufreq/armada-8k-cpufreq.c

-- 
2.19.2
