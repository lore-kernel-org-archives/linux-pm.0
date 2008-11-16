From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Suspend regression in 2.6.25.18
Date: Sun, 16 Nov 2008 14:04:22 +0100
Message-ID: <200811161404.23072.rjw__41832.2273799733$1226840567$gmane$org@sisk.pl>
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
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Thomas,

Your commit

commit ffa4da2a25bb4ac08f710ac99827baf48a8f8d57
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Sep 3 21:37:08 2008 +0000

    clockevents: prevent multiple init/shutdown

    commit 9c17bcda991000351cb2373f78be7e4b1c44caa3 upstream

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

is reported to cause a resume regression on Lenovo x60, x41 and x61 (probably
other Lenovo boxes are affected as well) with 2.6.25.18.  At the same time, the
2.6.27.y kernels are reported to work correctly for the affected users.

Can you please try to identify the updstream commits that fix the problem on
these boxes?

Thanks,
Rafael
