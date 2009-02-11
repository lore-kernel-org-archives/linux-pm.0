From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 11 Feb 2009 22:37:51 +0100
Message-ID: <20090211213751.GB605@elf.ucw.cz>
References: <20090211044736.GB9980@bulgaria.corp.google.com>
	<Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
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
Cc: Brian Swetland <swetland@google.com>, ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed 2009-02-11 09:58:23, Alan Stern wrote:
> On Tue, 10 Feb 2009, Brian Swetland wrote:
> 
> > [Pavel Machek <pavel@ucw.cz>]
> > > > 
> > > > wake_lock never blocks.
> > > 
> > > Wakelock is really bad name: it is not a lock and it does not protect
> > > wake. I'd say we need better name here.
> > 
> > I agree with you here -- I've had this discussion with Arve previously,
> > but have been unable to offer a compelling alternative name.  Anybody
> > have a good idea?
> 
> delay_sleep or delaysleep?  block_sleep or blocksleep?  Any of the 
> above with "sleep" replaced by "suspend"?

Actually "sleep_veto" sounded best.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
