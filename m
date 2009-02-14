From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/9] PM: Fixes related to suspend and hibernation
	for 2.6.29
Date: Sat, 14 Feb 2009 01:57:39 +0100
Message-ID: <200902140157.40869.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following are fixes related to suspend and hibernation I have collected
over the last couple of weeks.  Some of them are in -mm.  I think they all are
2.6.29 material.

1/9 and 2/9 fix hibernation regression caused by the async boot changes,
I hope Greg will not object if they go through your tree.

3/9 fixes a long-standing hibernation issue that cause the resume partition
to become unuseable after two consecutive failing attempts to hibernate.

4/9 fixes build of kprobes.c with CONFIG_PM unset.

5/9 and 6/9 clean up memory freeing code used during hibernation.

7/9 fixes a bug related to the use of PM notifiers during hibernation with
the help of the user land interface.

8/9 and 9/9 fix the handling of consoles during suspend/hibernation.

Please add these patches to the suspend branch and push to Linus for 2.6.29.

Thanks,
Rafael


-- 
Everyone knows that debugging is twice as hard as writing a program
in the first place.  So if you're as clever as you can be when you write it,
how will you ever debug it? --- Brian Kernighan
