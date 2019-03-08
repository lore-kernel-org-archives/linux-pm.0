From: Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/2] Fix various issue on CPU freq for Armada 37xx
Date: Fri,  8 Mar 2019 17:47:08 +0100
Message-ID: <20190308164710.10597-1-gregory.clement@bootlin.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Christian Neubert <christian.neubert.86@gmail.com>, Antoine Tenart <antoine.tenart@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hello,

A few weeks ago an issue was reported on the cpufreq driver, in the
meantime Christian Neubert got the same issue on a ambian kernel and
proposed a patch to fix it.

His fix seemed to address the issue seen, and I only added more context
about what was done.

Christian also reported an other issue about the way the frequency was
calculated. This issue is visible only when the default frequency was
low (600MHz). Based on this I proposed to no more use the CPU
frequency as base for the calculation but on the parent clock
frequency

Gregory

Christian Neubert (1):
  cpufreq: armada-37xx: fix clock parenting

Gregory CLEMENT (1):
  cpufreq: armada-37xx: fix frequency calculation for opp

 drivers/cpufreq/armada-37xx-cpufreq.c | 42 +++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 6 deletions(-)

-- 
2.20.1
