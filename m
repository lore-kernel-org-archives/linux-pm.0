From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM update for 2.6.30
Date: Mon, 20 Apr 2009 02:56:16 +0200
Message-ID: <200904200256.17028.rjw__32191.1143175841$1240189319$gmane$org@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk>
	<alpine.LFD.2.00.0904191357280.12867@localhost.localdomain>
	<20090419200330.GA16002@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090419200330.GA16002@flint.arm.linux.org.uk>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Russell King <rmk+lkml@arm.linux.org.uk>, pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull a power management update for 2.6.30 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

This fixes the ARM breakage caused by the recent reordering of suspend code.

 drivers/acpi/sleep.c    |    8 ++++----
 include/linux/suspend.h |   36 ++++++++++++++++++++++++++----------
 kernel/power/main.c     |   24 +++++++++++++++++-------
 3 files changed, 47 insertions(+), 21 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM/Suspend: Introduce two new platform callbacks to avoid breakage


Thanks,
Rafael
