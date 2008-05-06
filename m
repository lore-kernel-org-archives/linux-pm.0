From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] Freezer face lifting
Date: Wed, 7 May 2008 00:03:55 +0200
Message-ID: <200805070003.56387.rjw__4993.35779245502$1210112013$gmane$org@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Cedric Le Goater <clg@fr.ibm.com>, Ingo Molnar <mingo@elte.hu>, Paul Menage <menage@google.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Although the freezer is generally considered as a bad thing, it still is
being used for suspend and hibernation and will be used for these purposes in
the near future.  For this reason, it seems reasonable to try to reduce some
known problems with it.  The following two patches attempt to do that.

First, it is the known weakness of the freezer that it tries to distinguish
user space processes from kernel threads in a slightly artificial way.  The
first patch is intended to change that.

Second, in principle, the freezer can use the recently introduced TASK_KILLABLE
state to handle some cases that it couldn't have handled previously, which is
the purpose of the second patch.

Please review and tell me what you think.

Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
