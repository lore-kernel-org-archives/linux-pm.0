From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Hibernate and PM QoS updates for 2.6.40
Date: Fri, 27 May 2011 23:25:40 +0200
Message-ID: <201105272325.40859.rjw__3341.02901765636$1306539882$gmane$org@sisk.pl>
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

Please pull more power management updates for 2.6.40 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

They are three hibernate patches that fix comments and remove an unused
architecture hook and a PM QoS fix that didn't make it into my first request.


 arch/frv/include/asm/suspend.h       |   20 ---
 arch/mips/include/asm/suspend.h      |    2 -
 arch/powerpc/include/asm/suspend.h   |    6 -
 arch/powerpc/kernel/swsusp.c         |    1 -
 arch/s390/include/asm/suspend.h      |   10 --
 arch/sh/include/asm/suspend.h        |    1 -
 arch/unicore32/include/asm/suspend.h |    1 -
 arch/x86/include/asm/suspend_32.h    |    2 -
 arch/x86/include/asm/suspend_64.h    |    5 -
 kernel/pm_qos_params.c               |   33 ++++--
 kernel/power/hibernate.c             |  220 +++++++++++++++++-----------------
 11 files changed, 134 insertions(+), 167 deletions(-)

---------------

Rafael J. Wysocki (4):
      PM / Hibernate: Update some comments in core hibernate code
      PM / Hibernate: Remove arch_prepare_suspend()
      PM / Hibernate: Update kerneldoc comments in hibernate.c
      PM: Fix PM QOS's user mode interface to work with ASCII input
