From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [git pull] cpupowerutils patches for 3.1-rc4
Date: Thu, 25 Aug 2011 09:26:55 +0200
Message-ID: <20110825072655.GA13872__18492.5060872503$1314257401$gmane$org@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Linus,

a few cpupower improvements for 3.1-rc4 are available in the git repository
at:

git://git.kernel.org/pub/scm/linux/kernel/git/brodo/cpupowerutils.git master

Please pull from that location. The diffstat and list of changes is below.

Thanks,
        Dominik


Amerigo Wang (1):
      cpupower: avoid using symlinks

Dave Jones (1):
      cpupower: fix Makefile typo

Dominik Brodowski (2):
      cpupower: make NLS truly optional
      cpupower: use man(1) when calling "cpupower help subcommand"

Thomas Renninger (4):
      cpupower: mperf monitor - Use TSC to calculate max frequency if possible
      cpupower: Do not show an empty Idle_Stats monitor if no idle driver is available
      cpupower: Better detect offlined CPUs
      cpupower: Make monitor command -c/--cpu aware

 tools/power/cpupower/Makefile                      |    7 +-
 tools/power/cpupower/debug/x86_64/Makefile         |    8 +-
 .../power/cpupower/debug/x86_64/centrino-decode.c  |    1 -
 .../cpupower/debug/x86_64/powernow-k8-decode.c     |    1 -
 tools/power/cpupower/man/cpupower-frequency-info.1 |    6 +-
 tools/power/cpupower/man/cpupower-frequency-set.1  |    8 +-
 tools/power/cpupower/man/cpupower.1                |   14 +-
 tools/power/cpupower/utils/builtin.h               |    7 -
 tools/power/cpupower/utils/cpufreq-info.c          |   42 +-----
 tools/power/cpupower/utils/cpufreq-set.c           |   29 +---
 tools/power/cpupower/utils/cpuidle-info.c          |   24 +---
 tools/power/cpupower/utils/cpupower-info.c         |   20 +--
 tools/power/cpupower/utils/cpupower-set.c          |   25 +---
 tools/power/cpupower/utils/cpupower.c              |   91 ++++++-----
 tools/power/cpupower/utils/helpers/helpers.h       |   12 ++
 tools/power/cpupower/utils/helpers/sysfs.c         |   50 ++++++
 tools/power/cpupower/utils/helpers/sysfs.h         |    2 +
 tools/power/cpupower/utils/helpers/topology.c      |    5 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |    2 +-
 .../cpupower/utils/idle_monitor/cpupower-monitor.c |   66 ++++----
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |  177 ++++++++++++++-----
 21 files changed, 308 insertions(+), 289 deletions(-)
 delete mode 120000 tools/power/cpupower/debug/x86_64/centrino-decode.c
 delete mode 120000 tools/power/cpupower/debug/x86_64/powernow-k8-decode.c
