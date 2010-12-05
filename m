From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Regression] firewire_ohci causes system resume to fail
Date: Sun, 5 Dec 2010 15:42:31 +0100
Message-ID: <201012051542.31826.rjw__25273.8813324415$1291560489$gmane$org@sisk.pl>
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
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

There is a regression I can reproduce 100% of the time on a AMD-based desktop
box that resume from hibernation (or suspend) fails because of the firewire_ohci
module.  The box just hangs when firewire_ohci resume runs, apparently, and it
is sufficient to do:

# echo devices > /sys/power/pm_test
# echo disk > /sys/power/state

to reproduce the issue.

It definitely works with 2.6.34, but it fails with 2.6.37-rc4+ (latest mainline).
I haven't tested the kernels in between, but I'm going to do that later today
or some time next week.

If you have any idea about what may be the reason, please let me know.

Thanks,
Rafael
