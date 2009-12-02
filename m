From: Mel Gorman <mel@csn.ul.ie>
Subject: Re: [PATCH] uswsusp: automatically free the in-memory
	image once	s2disk has finished with it
Date: Wed, 2 Dec 2009 22:07:18 +0000
Message-ID: <20091202220718.GI1457__888.484568759118$1259869703$gmane$org@csn.ul.ie>
References: <4B1575AC.6080904@tuffmail.co.uk> <20091201214529.GA1457@csn.ul.ie>
	<200912012253.08522.rjw@sisk.pl> <4B16545B.3090703@tuffmail.co.uk>
	<20091202122019.GD1457@csn.ul.ie> <4B16797C.3010304@tuffmail.co.uk>
	<20091202211107.GA20830@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091202211107.GA20830@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 02, 2009 at 10:11:07PM +0100, Pavel Machek wrote:
> On Wed 2009-12-02 14:28:12, Alan Jenkins wrote:
> > The original in-kernel suspend (swsusp) frees the in-memory hibernation
> > image before powering off the machine.  s2disk doesn't, so there is
> > _much_ less free memory when it tries to power off.
> > 
> > This is a gratuitous difference.  The userspace suspend interface
> > /dev/snapshot only allows the hibernation image to be read once.
> > Once the s2disk program has read the last page, we can free the entire
> > image.
> > 
> > This avoids a hang after writing the hibernation image which was
> > triggered by commit 5f8dcc21211a3d4e3a7a5ca366b469fb88117f61
> > "page-allocator: split per-cpu list into one-list-per-migrate-type":
> 
> Yes, you work around page-allocator hang. But is it right thing to do?
> 

What's wrong with it? The hang is likely because the allocator has no
memory to work with. The patch in question makes small changes to the
amount of available memory but it shouldn't matter on uni-core. Some
structures are slightly larger but it's extremely borderline. I'm at a
loss to explain actually why it makes a difference untill things were
extremely borderline to begin with.

> I mean... Power down should not be too memory-critical. Why can't new
> page allocator handle that?
> 

The allocator isn't new. I wouldn't have expected power-down to make any
allocation at all but clearly it is.

> (And yes, when page allocator is fixed we may want to do something
> like that, but...)
> 

At the moment, I'm not sure what needs fixing in there. There is no
memory and it gets stuck in a loop. I better stand up if I'm going to
pull something out of my ass :/


-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
