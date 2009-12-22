From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes and updates for 2.6.33
Date: Tue, 22 Dec 2009 23:03:05 +0100
Message-ID: <200912222303.05698.rjw__24505.035315133$1261519512$gmane$org@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes and updates for 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They include:

* Fix for commit f2511774863487e61b56a97da07ebf8dd61d7836
  (PM: Add initcall_debug style timing for suspend/resume)
  adding the timing instrumentation for devices that haven't been switched
  to struct dev_pm_ops yet.

* Total device suspend and resume time reporting.

* Runtime PM core fix from Alan Stern.

* Runtime PM enhancement allowing the core to call device type or device
  class callbacks if bus type callbacks are not defined.

* Runtime PM documentation update from Alan Stern.


 Documentation/power/runtime_pm.txt |  223 ++++++++++++++++++++++--------------
 drivers/base/power/main.c          |  128 +++++++++++++++++----
 drivers/base/power/runtime.c       |   45 +++++++
 3 files changed, 288 insertions(+), 108 deletions(-)

---------------

Alan Stern (2):
      PM: Use pm_runtime_put_sync in system resume
      PM: Runtime PM documentation update

Rafael J. Wysocki (3):
      PM: Make the initcall_debug style timing for suspend/resume complete
      PM: Measure device suspend and resume times
      PM / Runtime: Use device type and device class callbacks
