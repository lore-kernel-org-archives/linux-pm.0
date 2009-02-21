From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 0/9] PM: Fixes related to suspend and
	hibernation for	2.6.29
Date: Sat, 21 Feb 2009 10:29:02 -0800
Message-ID: <20090221182902.GB12472__44575.552820652$1235241233$gmane$org@suse.de>
References: <200902140157.40869.rjw@sisk.pl>
	<alpine.LFD.2.00.0902202337040.19156@localhost.localdomain>
	<200902211038.42169.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902211038.42169.rjw@sisk.pl>
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
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu <mhiramat@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 21, 2009 at 10:38:40AM +0100, Rafael J. Wysocki wrote:
> On Saturday 21 February 2009, Len Brown wrote:
> > 
> > On Sat, 14 Feb 2009, Rafael J. Wysocki wrote:
> > 
> > > Hi Len,
> > > 
> > > The following are fixes related to suspend and hibernation I have collected
> > > over the last couple of weeks.  Some of them are in -mm.  I think they all are
> > > 2.6.29 material.
> > > 
> > > 1/9 and 2/9 fix hibernation regression caused by the async boot changes,
> > > I hope Greg will not object if they go through your tree.
> > > 
> > > 3/9 fixes a long-standing hibernation issue that cause the resume partition
> > > to become unuseable after two consecutive failing attempts to hibernate.
> > > 
> > > 4/9 fixes build of kprobes.c with CONFIG_PM unset.
> > 
> > looks like this one added power/ twice --
> 
> That was on purpose.
> 
> > and looks like akpm sent a fixed version of this to linus already?
> 
> Yes, he did.
> 
> > > 5/9 and 6/9 clean up memory freeing code used during hibernation.
> > > 
> > > 7/9 fixes a bug related to the use of PM notifiers during hibernation with
> > > the help of the user land interface.
> > > 
> > > 8/9 and 9/9 fix the handling of consoles during suspend/hibernation.
> > > 
> > > Please add these patches to the suspend branch and push to Linus for 2.6.29.
> > 
> > All except #4 are now on the suspend branch.
> 
> 1/9 and 2/9 are also in the Greg's tree, AFAICS.
> 
> Greg, do you intend to push them to Linus?  In that case I think it's better if
> Len drops them.

I was not planning to send them for .29, sorry I got confused.  I'll
drop them from my tree and Len can send them all to Linus now.

Is that ok?

thanks,

greg k-h
