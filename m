From: Markus Mayer <code@mmayer.net>
Subject: [PATCH 0/2] brcmstb-avs-cpufreq changes
Date: Wed, 18 Apr 2018 08:56:41 -0700
Message-ID: <20180418155643.36464-1-code@mmayer.net>
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
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Brian Norris <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Markus Mayer <mmayer@broadcom.com>, Power Management List <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

These changes are based on v4.17-rc1. The two patches are unrelated.

Patch 1/2 removes unused code that was only useful during driver
development and that has been disabled by default for a long time.

Patch 2/2 allows the driver to detect if the system supports SCMI cpufreq

Jim Quinlan (1):
  cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if supported

Markus Mayer (1):
  cpufreq: brcmstb-avs-cpufreq: remove development debug support

 drivers/cpufreq/Kconfig.arm           |  10 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 339 ++--------------------------------
 2 files changed, 17 insertions(+), 332 deletions(-)

-- 
2.7.4
