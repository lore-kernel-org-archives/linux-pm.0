From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management documentation fixes for 3.0
Date: Sun, 3 Jul 2011 22:20:56 +0200
Message-ID: <201107032220.56409.rjw__33998.5330509537$1309724556$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management documentation fixes for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

One of them makes documentation match the code again after a recent change
and it depends on the other one, which fixes a typo.


 Documentation/power/runtime_pm.txt |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

---------------

Kevin Hilman (1):
      PM: Documentation: fix typo: pm_runtime_idle_sync() doesn't exist.

Rafael J. Wysocki (1):
      PM / Runtime: Update documentation regarding driver removal
