From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Is it supposed to be ok to call del_gendisk
	while	userspace is frozen?
Date: Mon, 1 Mar 2010 07:35:08 +0100
Message-ID: <20100301063508.GA1455__33518.4059259065$1267425429$gmane$org@ucw.cz>
References: <20100223123321.GA1025@kernel.dk>
	<Pine.LNX.4.44L0.1002231016500.1507-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1002231016500.1507-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, linux-pm <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > This is a matter for Jens.  Is the bdi writeback task freezable?  If it
> > > is, should it be made unfreezable?
> > 
> > I'm not a big expect on what tasks should be freezable or not. As it
> > stands, the writeback tasks will attempt to freeze and thaw with the
> > system. I guess that screws the sync from resume call, since it's not
> > running and the sync will wait for it to retrieve and finish that work
> > item.
> > 
> > To the suspend experts - can we safely mark the writeback tasks as
> > non-freezable?
> 
> The reason for freezing those tasks is to avoid writebacks at random
> times during a system sleep transition, when the underlying device may
> already be suspended, right?

It is also there to avoid inconsistency between in-filesystem data and
snapshot in hibernation image.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
