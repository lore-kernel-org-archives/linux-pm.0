From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] cpufreq: build fixes
Date: Wed, 28 Jan 2015 14:16:52 +0100
Message-ID: <1422451015-390439-1-git-send-email-arnd@arndb.de>
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
To: linux-pm@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

These came out of running randconfig build tests on ARM. The three
patches are completely independent, so please apply what looks good.

The two s3c patches are for old bugs and should go through the
cpufreq tree.

The exynos bug only exists in the thermal-soc tree at the moment
and should get picked up by Eduardo with an Ack from the cpufreq
maintainers, or alternatively the bug should get fixed differently
if someone can come up with a better solution.

Arnd Bergmann (3):
  cpufreq: s3c: remove incorrect __init annotations
  cpufreq: s3c: remove last use of resume_clocks callback
  cpufreq: exynos: allow modular build

 drivers/cpufreq/Kconfig.arm          | 14 +++++++++-----
 drivers/cpufreq/exynos-cpufreq.h     |  6 +++---
 drivers/cpufreq/exynos4210-cpufreq.c |  1 +
 drivers/cpufreq/exynos4x12-cpufreq.c |  1 +
 drivers/cpufreq/exynos5250-cpufreq.c |  1 +
 drivers/cpufreq/s3c2416-cpufreq.c    |  4 ++--
 drivers/cpufreq/s3c24xx-cpufreq.c    | 10 +---------
 7 files changed, 18 insertions(+), 19 deletions(-)

-- 
2.1.0.rc2
