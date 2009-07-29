From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM fixes for 2.6.31
Date: Thu, 30 Jul 2009 00:06:03 +0200
Message-ID: <200907300006.04751.rjw__2281.12439294836$1248905415$gmane$org@sisk.pl>
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
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-fsdevel@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull power management fixes for 2.6.31 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

This will fix two regressions, one related to the handling of the
ACPI SCI_EN bit during resume from suspend to RAM (machine with a
broken BIOS has to be blacklisted) and the other caused by
putting bdget() under a spinlock in the hibernation code.

 drivers/acpi/sleep.c |    8 ++++++++
 fs/block_dev.c       |   10 ++++++++++
 include/linux/fs.h   |    1 +
 mm/swapfile.c        |    4 ++--
 4 files changed, 21 insertions(+), 2 deletions(-)

---------------

Alan Jenkins (1):
      PM / Hibernate: Replace bdget call with simple atomic_inc of i_count

Bartlomiej Zolnierkiewicz (1):
      PM / ACPI: HP G7000 Notebook needs a SCI_EN resume quirk
