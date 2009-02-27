From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 11:18:18 +0100
Message-ID: <20090227101818.GH4582__5911.67082679949$1235729893$gmane$org@elf.ucw.cz>
References: <200902191356.53584.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0902190956570.3012-100000@iolanthe.rowland.org>
	<20090222140311.GF1387@ucw.cz>
	<200902231504.27879.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902231504.27879.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2009-02-23 15:04:22, Oliver Neukum wrote:
> Am Sonntag 22 Februar 2009 15:03:11 schrieb Pavel Machek:
> > Hi!
> >
> > > > Again, the decision to trigger automatic suspend has to be based on
> > > > some well defined criteria and the (in)activity of devices seems to be
> > > > one of them.
> > >
> > > I don't know what criteria the system monitor would use.  It might have
> > > to be platform-specific.  The Android people seem to have a pretty good
> > > idea of what criteria will work for them.
> > >
> > > Inactivity of devices isn't always a good criterion.  There might be a
> > > background task which wakes up every few seconds to do something as
> > > long as the system is awake, thereby keeping some device always active.
> > > The activity from this background task shouldn't prevent an auto-sleep.
> >
> > Then we'd need a interface to mark such background task... and what is
> > reasonable use for such task, anyway? Either its job is neccessary, or
> > it should not waste power.
> 
> Why? We have decided that some tasks are more important than
> other tasks, to the point of starving some tasks. Posix real time
> already does that.
> 
> We can just as well have a class of tasks less important than power
> saving. They'd just run when power saving is not active for some other
> reason. Just like other such schemes we end up with the problem
> of priority inversion with locking.

Ok, I guess this could be interesting in some cases... maybe. What are
real examples of such tasks?

Note that this will be fairly hard to implement due to all the
priority inversions; so it better be pretty important.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
