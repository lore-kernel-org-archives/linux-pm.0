From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Two power management fixes for 2.6.39
Date: Thu, 21 Apr 2011 22:11:02 +0200
Message-ID: <201104212211.03185.rjw__3353.0282475569$1303416760$gmane$org@sisk.pl>
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
Cc: Ian Campbell <Ian.Campbell@eu.citrix.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two power management fixes for 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They fix bugs related to syscore_ops introduced earlier in this cycle.


 arch/x86/kernel/apm_32.c |    5 +++++
 drivers/base/syscore.c   |    2 ++
 drivers/xen/manage.c     |    9 ++++++++-
 kernel/kexec.c           |    7 +++++++
 kernel/power/hibernate.c |   10 ++++++++--
 kernel/power/suspend.c   |    5 ++++-
 6 files changed, 34 insertions(+), 4 deletions(-)

---------------

Rafael J. Wysocki (2):
      PM: Fix error code paths executed after failing syscore_suspend()
      PM: Add missing syscore_suspend() and syscore_resume() calls
