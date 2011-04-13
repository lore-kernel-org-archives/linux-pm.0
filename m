From: Mike Frysinger <vapier@gentoo.org>
Subject: freezer: should barriers be smp ?
Date: Wed, 13 Apr 2011 02:14:39 -0400
Message-ID: <BANLkTi=F-C-vwX4PGGfbkdTBw3OWL-twfg__41587.8434818753$1302711105$gmane$org@mail.gmail.com>
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
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

when we suspend/resume Blackfin SMP systems, we notice that the
freezer code runs on multiple cores.  this is of course what you want
-- freeze processes in parallel.  however, the code only uses non-smp
based barriers which causes us problems ... our cores need software
support to keep caches in sync, so our smp barriers do just that.  but
the non-smp barriers do not, and so the frozen/thawed processes
randomly get stuck in the wrong task state.

thinking about it, shouldnt the freezer code be using smp barriers ?
the point is to make sure that the updates are seen across all cores
are not just the current one ?
-mike
