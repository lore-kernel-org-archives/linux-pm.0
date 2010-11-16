From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] More power management fixes for 2.6.37
Date: Wed, 17 Nov 2010 00:11:45 +0100
Message-ID: <201011170011.46080.rjw__49971.5777267285$1289949291$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a few more power management fixes for 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They include:

* Fix for an embarassing bug in PM QoS.

* Change disabling the OPPs API on configurations that don't support OPPs.

* PM core modification allowing devices to be unregistered during late
  suspend and early resume (you've seen it already).


 Documentation/power/opp.txt |    3 +++
 drivers/base/power/main.c   |   34 ++++++++++++++++++++++++++++++----
 kernel/pm_qos_params.c      |    4 ++--
 kernel/power/Kconfig        |    4 ++++
 4 files changed, 39 insertions(+), 6 deletions(-)

---------------

Colin Cross (1):
      PM / PM QoS: Fix reversed min and max

Mark Brown (1):
      PM / OPP: Hide OPP configuration when SoCs do not provide an implementation

Rafael J. Wysocki (1):
      PM: Allow devices to be removed during late suspend and early resume
