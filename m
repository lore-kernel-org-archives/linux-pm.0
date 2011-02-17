From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Hibernate fix for 2.6.38
Date: Fri, 18 Feb 2011 00:30:54 +0100
Message-ID: <201102180030.55000.rjw__1700.53738770566$1297985624$gmane$org@sisk.pl>
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

Please pull a hibernate fix for 2.6.38 (and stable) from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes an old bug, but such that it can make a later BUG_ON() trigger, so
it's rather serious.


 kernel/power/snapshot.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

---------------

Stanislaw Gruszka (1):
      PM / Hibernate: Return error code when alloc_image_page() fails
