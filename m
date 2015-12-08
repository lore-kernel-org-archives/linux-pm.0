From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v5 00/11] cpufreq: Introduce ST's CPUFreq driver
Date: Tue,  8 Dec 2015 14:31:53 +0000
Message-ID: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
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
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, kernel@stlinux.com, linux-pm@vger.kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, Lee Jones <lee.jones@linaro.org>, ajitpal.singh@st.com, maxime.coquelin@st.com
List-Id: linux-pm@vger.kernel.org

This is a re-write of the original submission, hence why the
change-log is omitted.  Basically almost everything has changed.
We are now using the new OPP framework and generic bindings
written by Viresh.

There are 'ARM' patches in the set which are not necessarily
related to CPUFreq, but are required to get it to work. Anyone
who is not interested in general STi DT changes can safely
ignore these.

Lee Jones (11):
  ARM: multi_v7_defconfig: Enable ST's PWM driver
  ARM: multi_v7_defconfig: Enable ST's Power Reset driver
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  ARM: STi: STiH407: Provide generic (safe) DVFS configuration
  ARM: STi: STiH407: Provide CPU with clocking information
  ARM: STi: STiH407: Link CPU with its voltage supply
  ARM: STi: STiH407: Provide CPU with a means to look-up Major number
  ARM: STi: Register CPUFreq device
  cpufreq: st: Provide runtime initialised driver for ST's platforms
  dt: cpufreq: st: Provide bindings for ST's CPUFreq implementation
  MAINTAINERS: Add ST's CPUFreq driver to the STI file list

 .../devicetree/bindings/cpufreq/cpufreq-st.txt     |  91 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/stih407-family.dtsi              |  20 ++
 arch/arm/configs/multi_v7_defconfig                |   5 +-
 arch/arm/mach-sti/Makefile                         |   2 +-
 arch/arm/mach-sti/board-dt.c                       |   3 +-
 arch/arm/mach-sti/{platsmp.c => cpu.c}             |  17 +-
 arch/arm/mach-sti/{smp.h => cpu.h}                 |   1 +
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/sti-cpufreq.c                      | 296 +++++++++++++++++++++
 11 files changed, 438 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-st.txt
 rename arch/arm/mach-sti/{platsmp.c => cpu.c} (93%)
 rename arch/arm/mach-sti/{smp.h => cpu.h} (93%)
 create mode 100644 drivers/cpufreq/sti-cpufreq.c

-- 
1.9.1
