From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 00/38] power management / hibernate support for
	s390
Date: Thu, 04 Jun 2009 18:18:47 +0200
Message-ID: <20090604161847.513682672__7454.10926542736$1244138412$gmane$org@de.ibm.com>
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
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
List-Id: linux-pm@vger.kernel.org

Greetings,
this patch set implements hibernation support for s390. All s390
specific buses grow pm callbacks and all the s390 device drivers
are modified to make use of the callbacks. This allows to do

echo disk > /sys/power/state

to save the state of the running linux image to swap. A normal
ipl (alias boot) of the same kernel will detect the stored image
on swap and resume the save image. Works for guests under z/VM
and for LPARs.

The patches are meant to be applied on top of the s390 tree found
at
	git://git390.marist.edu/pub/scm/linux-2.6.git features

Have fun..
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
