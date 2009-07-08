From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes for 2.6.31
Date: Wed, 8 Jul 2009 13:44:45 +0200
Message-ID: <200907081344.46581.rjw__31209.2908112847$1247053566$gmane$org@sisk.pl>
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
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, pm list <linux-pm@lists.linux-foundation.org>, Peter Chubb <peterc@nicta.com.au>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

This will fix a regression introduced by the recent arch/x86/power/cpu_(32|64)
unification (http://bugzilla.kernel.org/show_bug.cgi?id=13661) and a bug
in drivers/base/power/main.c causing suspend to fail when it should succeed.

 arch/x86/power/Makefile   |    2 +-
 drivers/base/power/main.c |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

---------------

Peter Chubb (1):
      x86: Fix resume from suspend when CONFIG_CC_STACKPROTECTOR

Sebastian Ott (1):
      PM: Clear -EAGAIN in dpm_prepare
