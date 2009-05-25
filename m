From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Mon, 25 May 2009 23:43:23 +0200
Message-ID: <200905252343.23744.rjw__7342.04730620167$1243287838$gmane$org@sisk.pl>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905090143.10980.rjw@sisk.pl>
	<1243245907.16743.101.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1243245907.16743.101.camel@nigel-laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@tuxonice.net
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 25 May 2009, Nigel Cunningham wrote:
> Hi.

Hi,

> On Sat, 2009-05-09 at 01:43 +0200, Rafael J. Wysocki wrote:
> > > On Sat, 2009-05-09 at 00:46 +0200, Rafael J. Wysocki wrote:
> > > > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > > > On Fri, 2009-05-08 at 16:11 +0200, Rafael J. Wysocki wrote:
> > > > > > On Friday 08 May 2009, Nigel Cunningham wrote:
> > > > > And the code includes some fundamental differences. I freeze processes
> > > > > and prepare the whole image before saving anything or doing an atomic
> > > > > copy whereas you just free memory before doing the atomic copy. You save
> > > > > everything in one part whereas I save the image in two parts.
> > > > 
> > > > IMO the differences are not that fundamental.  The whole problem boils down
> > > > to using the same data structures for memory management and I think we can
> > > > reach an agreement here.
> > > 
> > > I think we might be able to agree on using the same data structures, but
> > > I'm not so sure about algorithms - I think you're underestimating the
> > > differences here.
> > 
> > Well, which algorithms do you have in mind in particular?
> 
> Sorry for the slow reply - just starting to catch up after time away.

NP

> The main difference is the order of doing things. TuxOnIce prepares the
> image after freezing processes and before the atomic copy. It doesn't
> just do that so that it can store a complete image of memory. It also
> does it because once processes are frozen, the only thing that's going
> to allocate storage is TuxOnIce,

This is quite strong statement.  Is it provable?

> and the only things that are going to allocate RAM are TuxOnIce and the
> drivers' suspend routines.

Hmm.  What about kernel threads that are not frozen?

> The drivers' routines are pretty consistent - once you've seen how much is
> used for one invocation, you can add a small margin and call that the
> allowance to use for all future invocations. The amount of memory used
> by the hibernation code is also entirely predictable - once you know the
> characteristics of the system as it stands (ie with processes frozen),
> you know how much you're going to need for the atomic copy and for doing
> I/O. If you find that something is too big, all you need to do is thaw
> kernel threads and free some memory until you fit within constraints or
> (heaven forbid!) find that you're not getting anyway and so want to give
> up on hibernating all together.
> 
> If, on the other hand, you do the drivers suspend etc and then look to
> see what state you're in, well you might need to thaw drivers etc in
> order to free memory before trying again. It's more expensive. Right now
> you're just giving up in that case - yes, you could retry too instead of
> giving up completely, but it's better IMHO to seek to get things right
> before suspending drivers.
> 
> Oh, before I forget to mention and you ask - how to know what allowance
> for the drivers? I use a sysfs entry - the user then just needs to see
> what's needed on their first attempt, set up a means of putting that
> value in the sysfs file in future (eg /etc/hibernate/tuxonice.conf) and
> then forget about it.

OK, this is reasonable.

Still, I think your approach is based on some assumptions that need to be
verified, so that either we are 100% sure they are satisfied, or we have some
safeguards in place in case they aren't.

Best,
Rafael
