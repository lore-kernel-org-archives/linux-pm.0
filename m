From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.24-rc5-mm1 -- inconsistent {in-hardirq-W} ->
	{hardirq-on-W} usage -- pm-hibernate/9940 [HC0[0]:SC0[0]:HE1:SE1]
Date: Thu, 20 Dec 2007 00:29:30 +0100
Message-ID: <200712200029.31709.rjw__24226.5750108801$1198107243$gmane$org@sisk.pl>
References: <a44ae5cd0712190517t7c80e15bv759fa5486dfca234@mail.gmail.com>
	<1198092200.2716.49.camel@imap.mvista.com>
	<Pine.LNX.4.64.0712191158140.28180@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0712191158140.28180@schroedinger.engr.sgi.com>
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
To: Christoph Lameter <clameter@sgi.com>
Cc: Daniel Walker <dwalker@mvista.com>, Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 19 of December 2007, Christoph Lameter wrote:
> On Wed, 19 Dec 2007, Daniel Walker wrote:
> 
> > > It looks like the swsusp_save() calls drain_all_pages() , which calls
> > > on_each_cpu() .. On return on_each_cpu() unconditionally enables
> > > interrupts so the rest of the resume process has interrupt enable
> > > (which , it looks like, shouldn't happen) and then you get the lockdep()
> > > warning due to the above..
> > > 
> > > Not sure if this has been found already, or not?
> 
> Hmmm... It will unconditionally enable interrupts regardless how we call 
> this. We could explicity save and restore interrrupts in 
> swsusp_save() I guess. Why is swsusp_save() disabling interrupts?

Actually, it's called with interrupts disabled, because it's job is to create
the hibernation image.  At this point everything is off except for the CPU
running swsusp_save().
 
> > > Should drain_all_pages() really be drain_local_pages() ?
> > 
> > It looks like it was drain_local_pages, but the following patch
> > 
> > page-allocator-clean-up-pcp-draining-functions.patch
> > 
> > Changes that in -mm .. I added Christoph Lameter to the CC since it's
> > his patch ..
> 
> We could reexport drain_local_pages() again but then I do not understand 
> why we would only drain the pages of this processor and not of all other
> processors as well. It seems that software suspend intend was to flush 
> them all right?

Well, not exactly.  We are on one CPU at this point, the others have been
disabled.
