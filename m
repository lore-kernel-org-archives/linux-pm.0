From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?utf-8?q?=5BSUSPECTED_SPAM=5D_Re=3A_Proposal_for_a_ne?=
 =?utf-8?q?w_algorithm_for=09reading_=26_writing_a_hibernation_image=2E?=
Date: Sun, 6 Jun 2010 15:57:20 +0200
Message-ID: <201006061557.20482.rjw__47071.2114045911$1275832676$gmane$org@sisk.pl>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<201006052121.45816.rjw@sisk.pl>
	<1275784828.17835.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275784828.17835.4.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: TuxOnIce-devel <tuxonice-devel@tuxonice.net>, Nigel Cunningham <ncunningham@crca.org.au>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Maxim Levitsky wrote:
> On Sat, 2010-06-05 at 21:21 +0200, Rafael J. Wysocki wrote: 
> > On Saturday 05 June 2010, Maxim Levitsky wrote:
> > > On Sat, 2010-06-05 at 20:45 +0200, Rafael J. Wysocki wrote: 
> > > > On Saturday 05 June 2010, Nigel Cunningham wrote:
> > > > > Hi again.
> > > > > 
> > > > > As I think about this more, I reckon we could run into problems at 
> > > > > resume time with reloading the image. Even if some bits aren't modified 
> > > > > as we're writing the image, they still might need to be atomically 
> > > > > restored. If we make the atomic restore part too small, we might not be 
> > > > > able to do that.
> > > > > 
> > > > > So perhaps the best thing would be to stick with the way TuxOnIce splits 
> > > > > the image at the moment (page cache / process pages vs 'rest'), but 
> > > > > using this faulting mechanism to ensure we do get all the pages that are 
> > > > > changed while writing the first part of the image.
> > > > 
> > > > I still don't quite understand why you insist on saving the page cache data
> > > > upfront and re-using the memory occupied by them for another purpose.  If you
> > > > dropped that requirement, I'd really have much less of a problem with the
> > > > TuxOnIce's approach.
> > > Because its the biggest advantage?
> > 
> > It isn't in fact.
> > 
> > > Really saving whole memory makes huge difference.
> > 
> > You don't have to save the _whole_ memory to get the same speed (you don't
> > do that anyway, but the amount of data you don't put into the image with
> > TuxOnIce is smaller).  Something like 80% would be just sufficient IMO and
> > then (a) the level of complications involved would drop significantly and (2)
> > you'd be able to use the image-reading code already in the kernel without
> > any modifications.  It really looks like a win-win to me, doesn't it?
> 
> 
> Well, in fact on modern systems its not possible to save 100% of ram
> even if we save it all because of video memory.
> Look I got 256MB of video ram, and when compiz is used I say most of it
> is used, and its isn't going to be magically preserved during suspend.
> So system still has to free about 256MB of memory before suspend (which
> means around 80% percent of ram is saved in best case :-) )

So how TuxOnIce helps here?

Rafael
