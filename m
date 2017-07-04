From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal SoC management updates for v4.13-rc1 #1
Date: Tue, 4 Jul 2017 11:49:55 -0700
Message-ID: <20170704184952.GA18084@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rui,

Please pull the following changes to get the Thermal SoC updates
for 4.13-rc1. Here we have:

- Refactoring of cpucooling device driver to improve cpufreq data handling
- Small fixes on different drivers: IMX, hisilicon, and BCM.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 1fe3854a83b580727c9464b37b62ba77ead1d6f6:

  thermal: bcm2835: fix an error code in probe() (2017-06-30 16:46:11 -0700)

----------------------------------------------------------------
Arvind Yadav (2):
      thermal: imx: Handle return value of clk_prepare_enable
      thermal: hisilicon: Handle return value of clk_prepare_enable

Dan Carpenter (1):
      thermal: bcm2835: fix an error code in probe()

Viresh Kumar (18):
      thermal: cpu_cooling: Avoid accessing potentially freed structures
      thermal: cpu_cooling: rearrange globals
      thermal: cpu_cooling: Name cpufreq cooling devices as cpufreq_cdev
      thermal: cpu_cooling: replace cool_dev with cdev
      thermal: cpu_cooling: remove cpufreq_cooling_get_level()
      thermal: cpu_cooling: get rid of a variable in cpufreq_set_cur_state()
      thermal: cpu_cooling: use cpufreq_policy to register cooling device
      cpufreq: create cpufreq_table_count_valid_entries()
      thermal: cpu_cooling: store cpufreq policy
      thermal: cpu_cooling: OPPs are registered for all CPUs
      thermal: cpu_cooling: get rid of 'allowed_cpus'
      thermal: cpu_cooling: merge frequency and power tables
      thermal: cpu_cooling: create structure for idle time stats
      thermal: cpu_cooling: get_level() can't fail
      thermal: cpu_cooling: don't store cpu_dev in cpufreq_cdev
      thermal: cpu_cooling: 'freq' can't be zero in cpufreq_state2power()
      thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device
      thermal: cpu_cooling: Replace kmalloc with kmalloc_array

 drivers/cpufreq/arm_big_little.c                   |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq_stats.c                    |  13 +-
 drivers/cpufreq/dbx500-cpufreq.c                   |   2 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   3 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   1 -
 drivers/thermal/cpu_cooling.c                      | 609 +++++++++------------
 drivers/thermal/hisi_thermal.c                     |   5 +-
 drivers/thermal/imx_thermal.c                      |  27 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  22 +-
 include/linux/cpu_cooling.h                        |  32 +-
 include/linux/cpufreq.h                            |  14 +
 13 files changed, 325 insertions(+), 411 deletions(-)

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZW+NJAAoJEA6VkvSQfF5THz0P+gL/UuP3j9FGCrgtHPhhcU8X
rFac027BQI8n8j4VhKQQ+wmPzmllhmbpEdBw/96J9f/cW/cnP7X7hcgTsVKzndvC
QMfTM4IjE4zZpqlaSHfDPgl0UI+8W0C6eOWqmlU08v08tgBvAO/zSQDenWSGctsW
Hhw52ZwbDG2fY+GV/HuQBHkjoo3fbocFxJx9uaRCptyhOg5YenEOmQfzXSawY59S
vZBBtiRFxdBdkzSjNAHi3feX9XGNuRzCaP+wPNfRMkkSs/CWVw75lcPQTpmGpNXk
5vVh9k8W6GcpcGTWF2f+G47ZppEtL58vRIRQGbFrmebdiCLdvIQ3RRqme4OvD0Qq
XuTQnahf0qfW9eXuQ44kpI7chf+bFPME9UjyhlPy7ozPqUIzE9zh0anC3sAgPfDk
otXhEJ1YGGDlecx7ew6fIFEuCC1GdGceExKsJeYtzjai9l1ioJabZzQ6LYh1dRE4
T6YbcSTK/PTk7j+5SV1Oa9keBaO6u+/5APqiX+J2WmLgot0r3dCZe+JpvE2hWaPC
Nv5XSLeidyM6KYwjXMGl/N9LRudHthhJNq6eMu+Ga/DPoVbWak3Z2Acpxo26ZNGa
+eJY2rkDhJ27mnBT3cOI7MvfBu9SJK8MhddsBDfTXiXLWKh6lmiyR7IQ9dxd+h/W
GuEsUm6cWk3BwyascSFc
=XGcx
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
