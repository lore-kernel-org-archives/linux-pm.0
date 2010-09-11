From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes for 2.6.36
Date: Sat, 11 Sep 2010 22:47:15 +0200
Message-ID: <201009112247.15602.rjw__31390.8987831839$1284238136$gmane$org@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Colin Cross <ccross@android.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mark gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.36 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They include:

 * Device suspend error code path fix related to asynchronous suspend/resume
   from Colin Cross.

 * PM QoS fix from Mark Gross.

 * Hibernate fix affecting systems with lots of highmem.


 drivers/base/power/main.c |    1 +
 kernel/pm_qos_params.c    |    4 ++-
 kernel/power/snapshot.c   |   85 ++++++++++++++++++++++++++++++++++----------
 3 files changed, 69 insertions(+), 21 deletions(-)

---------------

Colin Cross (1):
      PM: Prevent waiting forever on asynchronous resume after failing suspend

Rafael J. Wysocki (1):
      PM / Hibernate: Avoid hitting OOM during preallocation of memory

mark gross (1):
      PM QoS: Correct pr_debug() misuse and improve parameter checks
