From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Sun, 16 May 2010 22:22:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005162219330.24400-100000__31580.9626867578$1274063046$gmane$org@netrider.rowland.org>
References: <4BF06489.1050200@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BF06489.1050200@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matt Reimer <mattjreimer@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 May 2010, Nigel Cunningham wrote:

> >> I object to the patch.
> >>
> >> Tell the patch it ought to exit once thawed, by all means.
> >
> > I'm not sure what you mean.  Care to explain?
> 
> I mean "Set up some sort of flag that it can look at once thawed at 
> resume time, and use that to tell it to exit at that point."

Doesn't the patch do exactly that?  The "flag" is set by virtue of the 
fact that this is part of del_gendisk -- which means the disk is being 
unregistered and hence the writeback thread will exit shortly.

> >> Make the patch unfreezeable to begin with, by all means.
> >
> > That wouldn't work.
> 
> Why not?

It would be nice to know exactly why.  Perhaps the underlying problem 
can be fixed.

> >> If you know a disk is going to be unregistered during resume,
> >
> > How do we check that, exactly?
> 
> Well, if you can figure out that you need to go down this path at this 
> point in the process, you must be able to apply the same logic to come 
> to the same conclusion earlier in the process.

That's not true.  You don't know that a device is going to be unplugged 
until it actually _is_ unplugged.

Alan Stern
