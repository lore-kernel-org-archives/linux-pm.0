From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] MIPS build fix related to power management
	for 3.0
Date: Sat, 16 Jul 2011 23:50:50 +0200
Message-ID: <201107162350.51025.rjw__46854.522630065$1310853067$gmane$org@sisk.pl>
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
Cc: linux-mips@linux-mips.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a MIPS build fix related to PM for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes a build regression resulting from a missing conversion from using
a sysdev to using syscore_ops for PM/shutdown in the MIPS tree.


 arch/mips/kernel/i8259.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

----------

Rafael J. Wysocki (1):
      PM / MIPS: Convert i8259.c to using syscore_ops
