From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Is it supposed to be ok to call del_gendisk
	while	userspace is frozen?
Date: Thu, 4 Mar 2010 14:53:37 +0100
Message-ID: <20100304135337.GC12191__27290.8276216642$1267710898$gmane$org@atrey.karlin.mff.cuni.cz>
References: <20100303215056.GB2579@ucw.cz>
	<Pine.LNX.4.44L0.1003031720530.1380-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1003031720530.1380-100000@iolanthe.rowland.org>
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

> > journalling assumptions broken: commit block is there, but previous
> > blocks are not intact. Data loss.
> > 
> > ...and that was the first I could think about. Lets not do
> >  this. Barriers were invented for a reason.
> 
> Very well.  Then we still need a solution to the original problem:  
> Devices sometimes need to be unregistered during resume, but
> del_gendisk() blocks on the writeback thread, which is frozen until
> after the resume finishes.  How do you suggest this be fixed?

Avoid unregistering device during resume. Instead, return errors until
resume is done and you can call del_gendisk? 
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
