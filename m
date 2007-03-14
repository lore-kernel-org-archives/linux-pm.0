From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH 2/3] swsusp: Do not use page flags
Date: Wed, 14 Mar 2007 14:17:01 +1100
Message-ID: <45F7692D.3010709@yahoo.com.au>
References: <Pine.LNX.4.64.0702160212150.21862@schroedinger.engr.sgi.com>
	<200703131117.43818.rjw@sisk.pl> <45F67D9A.8020202@yahoo.com.au>
	<200703132220.35534.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703132220.35534.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-mm@kvack.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.osdl.org>, Johannes Berg <johannes@sipsolutions.net>, Christoph Lameter <clameter@engr.sgi.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Tuesday, 13 March 2007 11:31, Nick Piggin wrote:
> =

>>Rafael J. Wysocki wrote:
>>
>>>On Tuesday, 13 March 2007 10:23, Nick Piggin wrote:
>>>
>>
>>>>I wouldn't say that. You're creating an interface here that is going to=
 be
>>>>used outside swsusp. Users of that interface may not need locking now, =
but
>>>>that could cause problems down the line.
>>>
>>>
>>>I think we can add the locking when it's necessary.  For now, IMHO, it c=
ould be
>>>confusing to someone who doesn't know the locking is not needed.
>>
>>I don't know why it would confuse them. We just define the API to
>>guarantee the correct locking, and that means the locking _is_ needed.
> =

> =

> Even if there are no users that actually need the locking and probably ne=
ver
> will be?

Probably is the keyword.

Why would you *not* make this a sane API? Surely performance isn't the
reason? Nor complexity.

> For now, register_nosave_region() is to be called by architecture
> initialization code _only_ and there's no reason whatsoever why any
> architecture would need to call it concurrently from many places.
> =

> =

>>You don't have to care what the callers are doing. That's the beauty
>>of a sane API.
> =

> =

> Well, I don't think adding unneded infrastructure is a good thing.


But defining good APIs is a very good thing. And with my good API, the
lock is not unneeded.

>>>>But that's because you even use mark_nosave_pages in your implementatio=
n.
>>>>Mine uses the nosave regions directly.
>>>
>>>
>>>Well, I think we need two bits per page anyway, to mark free pages and
>>>pages allocated by swsusp, so using the nosave regions directly won't sa=
ve us
>>>much.
>>
>>Well I think it is a cleaner though.
> =

> =

> This is a matter of opinion, too ...


Well, as I'm not volunteering to maintain swsusp, if your opinion is that
your way is cleaner, I can't argue ;) So long as it stops wasting those page
flags then I'm happy.

However the register_nosave API really should use locking, I think. There
is absolutely no downside, AFAIKS.

-- =

SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com =
