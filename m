From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/9] PM: Fixes related to suspend and
	hibernation for 2.6.29
Date: Fri, 20 Feb 2009 23:41:21 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902202337040.19156__19527.4266916842$1235191455$gmane$org@localhost.localdomain>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <200902140157.40869.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org


On Sat, 14 Feb 2009, Rafael J. Wysocki wrote:

> Hi Len,
> 
> The following are fixes related to suspend and hibernation I have collected
> over the last couple of weeks.  Some of them are in -mm.  I think they all are
> 2.6.29 material.
> 
> 1/9 and 2/9 fix hibernation regression caused by the async boot changes,
> I hope Greg will not object if they go through your tree.
> 
> 3/9 fixes a long-standing hibernation issue that cause the resume partition
> to become unuseable after two consecutive failing attempts to hibernate.
> 
> 4/9 fixes build of kprobes.c with CONFIG_PM unset.

looks like this one added power/ twice --
and looks like akpm sent a fixed version of this to linus already?

> 5/9 and 6/9 clean up memory freeing code used during hibernation.
> 
> 7/9 fixes a bug related to the use of PM notifiers during hibernation with
> the help of the user land interface.
> 
> 8/9 and 9/9 fix the handling of consoles during suspend/hibernation.
> 
> Please add these patches to the suspend branch and push to Linus for 2.6.29.

All except #4 are now on the suspend branch.
thanks,
--
Len Brown, Intel Open Source Technology Center
