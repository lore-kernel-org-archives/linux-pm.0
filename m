From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/27] cpufreq: Stop validating cpufreq table in drivers
Date: Mon, 26 Feb 2018 10:38:43 +0530
Message-ID: <cover.1519620578.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory Fong <gregory.0xf0-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi,

A patchset [1] sent last week already updated the cpufreq core to start
validating cpufreq table if the policy contains a valid
"policy->freq_table" pointer.

This series updates all such drivers to stop validating the cpufreq
table directly and let only the core handle it.

It depends on the previous series [1] and two cleanup patches [2][3] and
is rebased over 4.16-rc3.

It is already tested by the 0-day testing infrastructure and no issues
were reported.

--
viresh

[1] https://lkml.kernel.org/r/bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
[2] https://lkml.kernel.org/r/77d470741dab32c2076a35253b9c0c2f0136583b.1519293292.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
[3] https://lkml.kernel.org/r/6b737a9c285840b4b2036fa51b692ee835664ec8.1519358505.git.viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org

Viresh Kumar (27):
  cpufreq: imx6q: Find max freq from frequency table itself
  cpufreq: Don't validate cpufreq table from cpufreq_generic_init()
  cpufreq: acpi: Don't validate the frequency table twice
  cpufreq: arm_big_little: Don't validate the frequency table twice
  cpufreq: blackfin: Don't validate the frequency table twice
  cpufreq: brcmstb: Don't validate the frequency table twice
  cpufreq: cpufreq-dt: Don't validate the frequency table twice
  cpufreq: e_powersaver: Don't validate the frequency table twice
  cpufreq: elanfreq: Don't validate the frequency table twice
  cpufreq: ia64-acpi: Don't validate the frequency table twice
  cpufreq: longhaul: Don't validate the frequency table twice
  cpufreq: mediatek: Don't validate the frequency table twice
  cpufreq: p4-clockmod: Don't validate the frequency table twice
  cpufreq: powernow: Don't validate the frequency table twice
  cpufreq: powerenv: Don't validate the frequency table twice
  cpufreq: ppc_cbe: Don't validate the frequency table twice
  cpufreq: pxa: Don't validate the frequency table twice
  cpufreq: qoirq: Don't validate the frequency table twice
  cpufreq: s3c24xx: Don't validate the frequency table twice
  cpufreq: sc520: Don't validate the frequency table twice
  cpufreq: scpi: Don't validate the frequency table twice
  cpufreq: sfi: Don't validate the frequency table twice
  cpufreq: sh: Don't validate the frequency table twice
  cpufreq: sparc: Don't validate the frequency table twice
  cpufreq: speedstep: Don't validate the frequency table twice
  cpufreq: tegra186: Don't validate the frequency table twice
  cpufreq: Drop cpufreq_table_validate_and_show()

 Documentation/cpu-freq/core.txt        | 12 +++++-------
 Documentation/cpu-freq/cpu-drivers.txt |  6 ++----
 drivers/cpufreq/acpi-cpufreq.c         | 20 +++++++++++---------
 drivers/cpufreq/arm_big_little.c       |  9 +--------
 drivers/cpufreq/blackfin-cpufreq.c     |  3 ++-
 drivers/cpufreq/brcmstb-avs-cpufreq.c  |  6 +-----
 drivers/cpufreq/cpufreq-dt.c           |  8 +-------
 drivers/cpufreq/cpufreq.c              |  9 +--------
 drivers/cpufreq/e_powersaver.c         |  8 +-------
 drivers/cpufreq/elanfreq.c             |  3 ++-
 drivers/cpufreq/freq_table.c           | 14 --------------
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  7 +------
 drivers/cpufreq/imx6q-cpufreq.c        |  7 ++++---
 drivers/cpufreq/longhaul.c             |  3 ++-
 drivers/cpufreq/mediatek-cpufreq.c     | 11 +----------
 drivers/cpufreq/p4-clockmod.c          |  3 ++-
 drivers/cpufreq/powernow-k6.c          |  3 ++-
 drivers/cpufreq/powernow-k7.c          |  3 ++-
 drivers/cpufreq/powernow-k8.c          | 10 +---------
 drivers/cpufreq/powernv-cpufreq.c      | 11 +++--------
 drivers/cpufreq/ppc_cbe_cpufreq.c      |  5 ++---
 drivers/cpufreq/pxa2xx-cpufreq.c       |  4 ++--
 drivers/cpufreq/pxa3xx-cpufreq.c       |  4 +++-
 drivers/cpufreq/qoriq-cpufreq.c        | 13 ++-----------
 drivers/cpufreq/s3c24xx-cpufreq.c      |  5 +----
 drivers/cpufreq/sc520_freq.c           |  3 ++-
 drivers/cpufreq/scpi-cpufreq.c         | 10 +---------
 drivers/cpufreq/sfi-cpufreq.c          |  3 ++-
 drivers/cpufreq/sh-cpufreq.c           | 22 ++++++++++++----------
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  3 ++-
 drivers/cpufreq/sparc-us3-cpufreq.c    |  3 ++-
 drivers/cpufreq/speedstep-centrino.c   |  4 ++--
 drivers/cpufreq/speedstep-ich.c        |  4 +++-
 drivers/cpufreq/speedstep-smi.c        |  4 +++-
 drivers/cpufreq/tegra186-cpufreq.c     |  2 +-
 include/linux/cpufreq.h                |  2 --
 36 files changed, 85 insertions(+), 162 deletions(-)

-- 
2.15.0.194.g9af6a3dea062
