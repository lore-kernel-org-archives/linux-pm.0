From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Sun, 8 Feb 2009 23:57:00 +0100
Message-ID: <20090208225700.GA1390@ucw.cz>
References: <Pine.LNX.4.44L0.0902110955490.3056-100000@iolanthe.rowland.org>
	<200902111645.46843.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902111645.46843.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, u.luckas@road.de, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Wed 2009-02-11 16:45:46, Rafael J. Wysocki wrote:
> On Wednesday 11 February 2009, Alan Stern wrote:
> > On Tue, 10 Feb 2009, Brian Swetland wrote:
> > 
> > > [Pavel Machek <pavel@ucw.cz>]
> > > > > 
> > > > > wake_lock never blocks.
> > > > 
> > > > Wakelock is really bad name: it is not a lock and it does not protect
> > > > wake. I'd say we need better name here.
> > > 
> > > I agree with you here -- I've had this discussion with Arve previously,
> > > but have been unable to offer a compelling alternative name.  Anybody
> > > have a good idea?
> 
> Well, even "sleep lock" would have been better.
> 
> > delay_sleep or delaysleep?  block_sleep or blocksleep?  Any of the 
> > above with "sleep" replaced by "suspend"?
> 
> I also thought about "sleep stopper".  It reflects what the feature does. :-)

'caffeine' ? :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
