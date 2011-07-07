From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fix for 3.0
Date: Thu, 7 Jul 2011 22:11:29 +0200
Message-ID: <201107072211.29206.rjw__2920.07219181887$1310069563$gmane$org@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a power management fix for 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes an old bug, but such that causes a BUG_ON() to trigger and it is
-stable material.


 kernel/power/snapshot.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM / Hibernate: Fix free_unnecessary_pages()
