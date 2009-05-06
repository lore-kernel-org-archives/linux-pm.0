From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/5] PM/Hibernate: Rework memory shrinking
Date: Thu, 7 May 2009 00:40:07 +0200
Message-ID: <200905070040.08561.rjw__30983.1125582152$1241650733$gmane$org@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Wu Fengguang <fengguang.wu@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The following patchset is an attempt to rework the memory shrinking mechanism
used during hibernation to make room for the image.  It is a work in progress
and most likely it's going to be modified, but it has been discussed recently
and I'd like to get comments on the current version.

[1/5] - disable the OOM kernel after freezing tasks (this will be dropped if
        it's verified that we can avoid the OOM killing by using
        __GFP_FS|__GFP_WAIT|__GFP_NORETRY|__GFP_NOWARN
        in the next patches).

[2/5] - drop memory shrinking from the suspend (to RAM) code path

[3/5] - move swsusp_shrink_memory() to snapshot.c

[4/5] - rework swsusp_shrink_memory() (to use memory allocations for applying
        memory pressure)

[5/5] - allocate image pages along with the shrinking.

Details are in the changelogs, please have a look and tell me what you think.

Best,
Rafael



-- 
Everyone knows that debugging is twice as hard as writing a program
in the first place.  So if you're as clever as you can be when you write it,
how will you ever debug it? --- Brian Kernighan
