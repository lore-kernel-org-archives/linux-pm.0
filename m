From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Fri, 4 Jun 2010 13:52:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006041351280.1794-100000__24574.4600579657$1275674094$gmane$org@iolanthe.rowland.org>
References: <1275664778.4596.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275664778.4596.1.camel@maxim-laptop>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 Jun 2010, Maxim Levitsky wrote:

> On Fri, 2010-06-04 at 10:59 -0400, Alan Stern wrote: 
> > On Fri, 4 Jun 2010, Maxim Levitsky wrote:
> > 
> > > On Thu, 2010-03-04 at 14:53 +0100, Pavel Machek wrote: 
> > > > Hi!
> > > > 
> > > > > > journalling assumptions broken: commit block is there, but previous
> > > > > > blocks are not intact. Data loss.
> > > > > > 
> > > > > > ...and that was the first I could think about. Lets not do
> > > > > >  this. Barriers were invented for a reason.
> > > > > 
> > > > > Very well.  Then we still need a solution to the original problem:  
> > > > > Devices sometimes need to be unregistered during resume, but
> > > > > del_gendisk() blocks on the writeback thread, which is frozen until
> > > > > after the resume finishes.  How do you suggest this be fixed?
> > > > 
> > > > Avoid unregistering device during resume. Instead, return errors until
> > > > resume is done and you can call del_gendisk? 
> > > 
> > > This won't help ether. The same driver needs to unregister perfectly
> > > working device on suspend, because the user might replace the card
> > > during suspend and fool the os.
> > > There is a setting, CONFIG_MMC_UNSAFE_RESUME and I use it, but it isn't
> > > default.
> > 
> > People have generally agreed that the best answer is to have 
> > del_gendisk always thaw the writeback thread.
> Now the question is how to do that? :-)

Here's a start:

	http://marc.info/?l=linux-kernel&m=127378922620074&w=2

It's not quite right, because it needs to make the writeback thread
unfreezable before thawing it.

Alan Stern
