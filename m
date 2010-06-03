From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 03 Jun 2010 17:41:41 +0200
Message-ID: <1275579701.27810.36036.camel__27224.8957110152$1275579743$gmane$org@twins>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603163307.721b1c23@notabene.brown>
	<AANLkTikuf6bKVHoGRTjrM_2kPtZqUM6J76Z0hNUQxT_3@mail.gmail.com>
	<20100603142150.GB13179@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100603142150.GB13179@thunk.org>
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
Cc: Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-06-03 at 10:21 -0400, tytso@mit.edu wrote:

> And let's be blunt.  If in the future the Android team (which I'm not
> a member of) decides that they have invested more engineering time
> than they can justify from a business perspective, the next time
> someone starts whining on a blog, or on Slashdot, or at a conference,
> about how "OMG!  Google is forking the kernel!!!", or "Google is
> making the lives of device driver writers for the embedded world
> difficult", it will now be possible from a political point of view to
> point and the hundreds, if not thousands, of e-mail messages of LKML
> developers wanting to redesign this effort and saying "Nyet!  Nyet!
> Nyet!" to the original patchset, to point out that Google has a made
> an effort, and gone far beyond what is required by the GPL.  Not only
> has the source code been made available, but hundreds of engineering
> hours have been made trying to accomodate the demands of LKML --- and
> LKML has said no to suspend blockers/wakelocks.


In the spirit of being blunt, so what?

We say no for good technical reasons. Also when did it become sensible
to push features after they were shipped?

It never works to develop stuff like this out-of-tree and then push for
inclusion. You always get to rewrite (at least 3 times).

If Google indeed decides it doesn't want to play upstream, then sad. But
I don't see how we would be unjust in complaining about it.

There is more to our community than the letter of the GPL, and you
should know that. So I really don't see the point of your argument (was
there one besides the management gibberish?).
