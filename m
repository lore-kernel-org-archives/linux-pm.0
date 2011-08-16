From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 0/1] [patch 0/1] include storage keys in
	hibernation image
Date: Tue, 16 Aug 2011 16:14:41 +0200
Message-ID: <20110816141441.898339466__11936.0215882354$1313504300$gmane$org@de.ibm.com>
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
To: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Jiri
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Version 2 of the storage key patch for hibernation on s390.
I've added the following changes as you requested:
1) moved the s390 specific code to arch/s390/kernel/suspend.c
2) introduced CONFIG_ARCH_SAVE_PAGE_KEYS and added a select to
   the main s390 Kconfig file
3) added the empty default functions to include/linux/suspend.h

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
