From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hibernation considerations
Date: Wed, 1 Aug 2007 09:19:50 +0000
Message-ID: <20070801091949.GA4808__14281.5916835845$1186070654$gmane$org@ucw.cz>
References: <Pine.LNX.4.64.0707171319140.2467@asgard.lang.hm>
	<200707202302.07116.rjw@sisk.pl>
	<E1ICDNw-0008HC-00@dorka.pomaz.szeredi.hu>
	<200707212243.35602.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707212243.35602.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: david@lang.hm, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, miltonm@bga.com, ying.huang@intel.com, linux-pm@lists.linux-foundation.org, jbms@cmu.edu
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The problem with FUSE is related to the fact that the freezer can't
> > > freeze uninterruptible tasks and we said that perhaps we might avoid
> > > it if FUSE was made freezing-aware.  Still, no one has gone in this
> > > direction and I don't know of any plans to do that.
> > 
> > I thought we have fully explored this direction.  Lots of emails, and
> > an IRC session with Pavel.  Conclusion:
> 
> What am I missing in the following suggested solution?
> 
> 1) In the freezer code, we implement a new TIF_LATEFREEZE process flag, which, 
> when set, causes a  userspace process to be frozen with kernel threads 
> instead of with userspace ones. When freezing, we freezing !TIF_LATEFREEZE, 
> sync and then freeze TIF_LATEFREEZE and freezable kernel threads.
> 
> 2) In the fuse code, the PID of the process that will do the work gets passed 

The list of neccessary PIDs is not known to the kernel. FUSE servers
may depend on another parts of userland.



-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
