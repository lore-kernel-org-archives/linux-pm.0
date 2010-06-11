From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fix for 2.6.35
Date: Fri, 11 Jun 2010 22:14:40 +0200
Message-ID: <201006112214.40440.rjw__2840.38834875009$1276287517$gmane$org@sisk.pl>
References: <201006112210.25688.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006112210.25688.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, "H. Peter Anvin" <hpa@linux.intel.com>, Ondrej Zary <linux@rainbow-software.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Sorry for the duplicate, forgot to send to the lists.]

Hi Linus,

Please pull an x86 resume fix from

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

This fixes a nasty crash occuring during resume on boxes that
wake up with MWAIT disabled.


 arch/x86/include/asm/suspend_32.h |    2 ++
 arch/x86/include/asm/suspend_64.h |    2 ++
 arch/x86/power/cpu.c              |    4 ++++
 3 files changed, 8 insertions(+), 0 deletions(-)

---------------

Ondrej Zary (1):
      PM / x86: Save/restore MISC_ENABLE register
