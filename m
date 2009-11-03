From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes for 2.6.32
Date: Tue, 3 Nov 2009 12:36:12 +0100
Message-ID: <200911031236.12094.rjw__11992.5955696546$1257248138$gmane$org@sisk.pl>
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
Cc: "Stephen J. Gowdy" <gowdy@cern.ch>, Jose Marino <braket@hotmail.com>, LKML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, pm list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

This includes the following changes:

* The fix for http://bugzilla.kernel.org/show_bug.cgi?id=14334 (yenta resume
  regression from 2.6.31).

* Hibernation fixes from Jiri Slaby.  Two of these patches fix long standing
  bugs, but in my opinion they are simple enough to go into 2.6.32.  The third
  one is a two-liner complementing one of the fixes.

* PM core error code path fix from Romit Dasgupta.

* Removal of some run-time PM debug messages creating too much noise from
  Pavel (the run-time PM framework is a new feature in 2.6.32 and this is
  just a refinement of it).


 drivers/base/power/main.c     |    1 +
 drivers/base/power/runtime.c  |    4 --
 drivers/pcmcia/cs.c           |   69 +++++++++++++++++++++++++---------------
 drivers/pcmcia/yenta_socket.c |   12 ++++++-
 include/pcmcia/ss.h           |    4 ++
 kernel/power/hibernate.c      |   11 +++++--
 kernel/power/swap.c           |   43 +++++++++++++------------
 7 files changed, 89 insertions(+), 55 deletions(-)

---------------

Jiri Slaby (3):
      PM / Hibernate: Fix blkdev refleaks
      PM / Hibernate: Fix error handling in save_image()
      PM / Hibernate: Add newline to load_image() fail path

Pavel Machek (1):
      PM: Remove some debug messages producing too much noise

Rafael J. Wysocki (1):
      PM / yenta: Split resume into early and late parts (rev. 4)

Romit Dasgupta (1):
      PM: Fix warning on suspend errors
