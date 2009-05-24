From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM regression fix for 2.6.30
Date: Sun, 24 May 2009 23:02:16 +0200
Message-ID: <200905242302.16688.rjw__4636.71158436245$1243198997$gmane$org@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a power management fix for 2.6.30 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

This fixes the regression tracked as
http://bugzilla.kernel.org/show_bug.cgi?id=13245

 drivers/base/power/main.c |    4 ++++
 kernel/kexec.c            |    2 --
 kernel/power/disk.c       |   21 +++------------------
 kernel/power/main.c       |    7 +------
 4 files changed, 8 insertions(+), 26 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM: Do not hold dpm_list_mtx while disabling/enabling nonboot CPUs

Thanks,
Rafael
