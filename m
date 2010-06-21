From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 13:22:34 +0100
Message-ID: <20100621132234.5eb880b0@lxorguk.ukuu.org.uk>
References: <201006202350.27143.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1006202154260.29532-100000@netrider.rowland.org>
	<20100621061345.GF9735@gvim.org> <20100621121058.GF6199@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: tytso@mit.edu
Cc: mark gross <640e9920@gmail.com>, markgross@thegnar.org, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

> There's been one proposal that we simply merge in a set of no-op
> inline functions for suspend blockers, just so we can get let the
> drivers go in (assuming that Greg K-H believes this is still a
> problem), but with an automatical removal of N months (N to be
> decided, say 9 or 12 or 18 months).

If you automatically remove the suspend blocker wrappers in 12 months
then you can keep the drivers in tree.

The drivers are generally not a problem (ok some of them like the binder
are interesting little trips) its just those hooks, and we'd all benefit
somewhat even if the only bit google are patching back in are their hooks.

> down the road for N months.  Another approach is to simply merge in
> no-op functions and not leave any kind of deprecation schedule.
> That's sort of an implicit admission of the fact that we may not reach
> consensus on this issue.  Or we could simply ship the patches as-is to

Very bad precedent. What happens when every other vendor does the same ?
Keep the upstream code clean. 

> Linus after he gets back from vacation and ask him for a thumbs up or
> thumbs down vote, which might settle things once and for all.

You seem desperate to just throw it at Linus - you have been all along
before the discussion, during it and now: but I don't understand why ?
It's as if you don't want progress to be made by other means ?

> How do we go forward from here?

PM QoS seems to be evolving nicely.

As for merging stuff - if its new code then it should get submitted with
the hooks left out anyway, just as all the other vendors are doing with
weird little custom hooks of their own. The hooks can still easily be
patched back in as a tiny easy to maintain vendor patch.

This works - the code still gets updated and seen by people, only the
little hook patch has to be maintained and generally it looks after
itself except for the odd .rej when something changes right up by the
merge point.

Alan
