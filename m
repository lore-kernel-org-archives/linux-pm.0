From: Christoph Lameter <clameter@sgi.com>
Subject: Re: 2.6.24-rc5-mm1 -- inconsistent {in-hardirq-W} ->
 {hardirq-on-W} usage -- pm-hibernate/9940 [HC0[0]:SC0[0]:HE1:SE1]
Date: Wed, 19 Dec 2007 12:02:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0712191158140.28180__37794.7533190765$1198095675$gmane$org@schroedinger.engr.sgi.com>
References: <a44ae5cd0712190517t7c80e15bv759fa5486dfca234@mail.gmail.com>
	<47693385.1010901@gmail.com> <1198089729.2716.45.camel@imap.mvista.com>
	<1198092200.2716.49.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1198092200.2716.49.camel@imap.mvista.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Daniel Walker <dwalker@mvista.com>
Cc: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Dec 2007, Daniel Walker wrote:

> > It looks like the swsusp_save() calls drain_all_pages() , which calls
> > on_each_cpu() .. On return on_each_cpu() unconditionally enables
> > interrupts so the rest of the resume process has interrupt enable
> > (which , it looks like, shouldn't happen) and then you get the lockdep()
> > warning due to the above..
> > 
> > Not sure if this has been found already, or not?

Hmmm... It will unconditionally enable interrupts regardless how we call 
this. We could explicity save and restore interrrupts in 
swsusp_save() I guess. Why is swsusp_save() disabling interrupts?

> > Should drain_all_pages() really be drain_local_pages() ?
> 
> It looks like it was drain_local_pages, but the following patch
> 
> page-allocator-clean-up-pcp-draining-functions.patch
> 
> Changes that in -mm .. I added Christoph Lameter to the CC since it's
> his patch ..

We could reexport drain_local_pages() again but then I do not understand 
why we would only drain the pages of this processor and not of all other
processors as well. It seems that software suspend intend was to flush 
them all right?
