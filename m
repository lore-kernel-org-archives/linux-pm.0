From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Hibernate fixes for 2.6.37
Date: Tue, 7 Dec 2010 00:47:45 +0100
Message-ID: <201012070047.45335.rjw__47483.8779693984$1291679377$gmane$org@sisk.pl>
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
Cc: Ondrej Zary <linux@rainbow-software.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Hugh Dickins <hughd@google.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull two hibernate fixes for 2.6.37 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

They include:

* Fix for a regression that may lead to post-resume memory corruption and unfortunately
  made it into -stable kernels.

* Fix related to image compression (that will be new in 2.6.37).


 include/linux/gfp.h      |    4 +-
 kernel/power/hibernate.c |   22 ++++++++++--------
 kernel/power/suspend.c   |    5 +--
 kernel/power/swap.c      |   53 +++++++++++++++++++++++++++++++++-------------
 kernel/power/user.c      |    2 +
 mm/page_alloc.c          |   19 ++++++++++------
 6 files changed, 68 insertions(+), 37 deletions(-)

---------------

Bojan Smojver (1):
      PM / Hibernate: Use async I/O when reading compressed hibernation image

Rafael J. Wysocki (1):
      PM / Hibernate: Fix memory corruption related to swap
