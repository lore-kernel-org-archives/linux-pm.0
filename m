From: Markus Mayer <code@mmayer.net>
Subject: [PATCH v3 0/4] cpufreq: bmips-cpufreq: Add CPUfreq driver for Broadcom's BMIPS SoCs
Date: Tue,  7 Feb 2017 13:58:52 -0800
Message-ID: <20170207215856.8999-1-code@mmayer.net>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Ralf Baechle <ralf@linux-mips.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Markus Mayer <mmayer@broadcom.com>, MIPS Linux Kernel List <linux-mips@linux-mips.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

Sorry for the new iteration. I found two more simplifications, so here
goes. Only patch 3/4 has changed.

This series adds a CPUfreq driver for the BMIPS SoCs. In the first
iteration only BMIPS5xxx SoCs are supported.

This series is based on pm/linux-next.

The series is also available at
https://github.com/mmayer/linux/tree/bmips-cpufreq-v3

Changes since v2:
  - remove local variables freq and cpu_freq in bmips_cpufreq_get()
  - assign global variable "priv" directly in bmips_cpufreq_probe()
    rather than setting driver_data and then retrieving it from there
    to set priv in bmips_cpufreq_init()

Changes since v1:
  - based on pm/linux-next rather than 4.10-rc1
  - sanitized bmips_stb_defconfig by running "make savedefconfig"; this
    also lead to an additional patch (1/4), which contains non-CPUfreq
    related updates that "make savedefconfig" performed
  - use gobal variable to store driver data rather than policy->driver_data
  - got rid of some code as a result of using said global variable
  - kzalloc -> kmalloc
  - removed policy->freq_table = NULL;

Markus Mayer (4):
  MIPS: BMIPS: Update defconfig
  BMIPS: Enable prerequisites for CPUfreq in MIPS Kconfig.
  cpufreq: bmips-cpufreq: CPUfreq driver for Broadcom's BMIPS SoCs
  MIPS: BMIPS: enable CPUfreq

 arch/mips/Kconfig                     |   2 +
 arch/mips/configs/bmips_stb_defconfig |  16 +--
 drivers/cpufreq/Kconfig               |  10 ++
 drivers/cpufreq/Makefile              |   1 +
 drivers/cpufreq/bmips-cpufreq.c       | 188 ++++++++++++++++++++++++++++++++++
 5 files changed, 211 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/bmips-cpufreq.c

-- 
2.7.4
