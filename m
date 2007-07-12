From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 0/2] PM: remove deprecated sysfs files and
	dpm_runtime_*
Date: Thu, 12 Jul 2007 16:53:43 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707121645550.2567-100000__19939.8316945464$1184273755$gmane$org@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pcmcia@lists.infradead.org, Dominik Brodowski <linux@dominikbrodowski.net>
List-Id: linux-pm@vger.kernel.org

According to feature-removal-schedule.txt, the old runtime PM 
mechanisms are scheduled for removal this month.  The following two 
patches implement the easy part of that removal: getting rid of the 
deprecated sysfs files and eliminating the dpm_runtime_* routines.

The only user of dpm_runtime_suspend() and dpm_runtime_resume() is 
drivers/pcmcia/ds.c.  I added local replacement routines in that source 
file, but I haven't been able to test them (this machine doesn't have 
PCMCIA).

Alan Stern
