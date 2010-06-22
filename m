From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 18:07:04 -0700
Message-ID: <20100622010704.GA12795__49005.5232462057$1277168920$gmane$org@gvim.org>
References: <201006202350.27143.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1006202154260.29532-100000@netrider.rowland.org>
	<20100621061345.GF9735@gvim.org> <20100621121058.GF6199@thunk.org>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100621121058.GF6199@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, markgross@thegnar.org, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.linux-found>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 21, 2010 at 08:10:58AM -0400, tytso@mit.edu wrote:
> So where are we at this point?

The patches are in James Bottomly's tree.
 
> Discussion had completely died down for a while, and it's picked up
> again, but it's not clear to me that we're any closer to reaching
> consensus.

I thought we (linux community and Android) where ok with the plist /
pm-qos implementation of the building blocks needed to implement the
suspend blocker feature on top of a pm-qos request class (I think the
name was "interactive")  pretty much the exact same symantecs as the
suspend blocker thing, just with pm-qos kernel api's.
 
> There's been one proposal that we simply merge in a set of no-op
> inline functions for suspend blockers, just so we can get let the
> drivers go in (assuming that Greg K-H believes this is still a
> problem), but with an automatical removal of N months (N to be
> decided, say 9 or 12 or 18 months).

I'd rather see the re-tooling of pmqos happen.

> 
> My concern is that if we do that, we will have simply kicked the ball
> down the road for N months.  Another approach is to simply merge in
> no-op functions and not leave any kind of deprecation schedule.
> That's sort of an implicit admission of the fact that we may not reach
> consensus on this issue.  Or we could simply ship the patches as-is to
> Linus after he gets back from vacation and ask him for a thumbs up or
> thumbs down vote, which might settle things once and for all.
> 
> How do we go forward from here?
> 
put the pm_qos -plist update into linux-next?

--mgross
