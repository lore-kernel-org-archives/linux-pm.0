From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v2 0/4] PXA cpufreq conversion to clock API
Date: Sat, 15 Oct 2016 21:57:26 +0200
Message-ID: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
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
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

This serie is a preparation to shift the cpufreq of pxa2xx platforms to clocks
API.

The first 3 patches are review and merge material :
 - patch 1/4 for Viresh and Rafael
 - patches 2/4 and 3/4 for me

The 4th on is for review but not merge, as the clock changes must be fully
reviewed and go in first as a prequisite

Robert Jarzmik (4):
  cpufreq: pxa: use generic platdev driver for device-tree
  ARM: dts: pxa: add pxa25x cpu operating points
  ARM: dts: pxa: add pxa27x cpu operating points
  cpufreq: pxa: convert to clock API

 arch/arm/boot/dts/pxa25x.dtsi        |  25 +++++
 arch/arm/boot/dts/pxa27x.dtsi        |  40 ++++++++
 drivers/cpufreq/Kconfig.arm          |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/pxa2xx-cpufreq.c     | 191 +++++++----------------------------
 5 files changed, 107 insertions(+), 153 deletions(-)

-- 
2.1.4
