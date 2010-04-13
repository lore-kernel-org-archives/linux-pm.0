From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM / hibernate fix for 2.6.34
Date: Wed, 14 Apr 2010 01:23:02 +0200
Message-ID: <201004140123.03040.rjw__5325.57440824366$1271201018$gmane$org@sisk.pl>
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
Cc: Jiri Kosina <jkosina@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull hibernation fix for 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It makes the hibernate user space interface work when
CONFIG_DEBUG_BLOCK_EXT_DEVT is set.

 kernel/power/user.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---------------

Jiri Slaby (1):
      PM / Hibernate: user.c, fix SNAPSHOT_SET_SWAP_AREA handling
