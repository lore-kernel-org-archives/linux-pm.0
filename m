From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Fri, 4 Jun 2010 02:08:03 -0700
Message-ID: <AANLkTinphtxn-8pGTYv_mBxKFMa7jU8i1yNbHrs50Vzl__17856.7961710089$1275642621$gmane$org@mail.gmail.com>
References: <20100603193045.GA7188@elte.hu>
	<AANLkTinsOF3wnxsruR0TvjBAQcHks4tf0ay_sM2xB_p4@mail.gmail.com>
	<20100604075722.GA15181@elte.hu>
	<AANLkTiksGnpL8tkcc5eScWHrGoijyZNUwZik5lXmU_TS@mail.gmail.com>
	<20100604085513.GE15181@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100604085513.GE15181@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 4, 2010 at 1:55 AM, Ingo Molnar <mingo@elte.hu> wrote:
> * Brian Swetland <swetland@google.com> wrote:
>> > After basically two years of growing your fork (and some attempts to get
>> > your drivers into drivers/staging/ - from where they have meanwhile
>> > dropped out again) you re-started with the worst possible thing to merge:
>> > a big and difficult kernel feature affecting many subsystems. Why?
>>
>> Because a large number of our drivers depend on it.
>
> So why not put in some stub or so? Auto-suspend/suspend-blockers is a feature,
> and drivers ought to be able to work without a feature as well. Keep the
> suspend-blocker changes in the android tree initially, and get the main body
> of changes out first, and establish a flow of timely changes. That reduces
> your maintenance burden and increases trust for future changes - a win-win
> situation.

The impression I got from previous discussions was that upstream did
not want things that were built conditionally around APIs that did not
exist in mainline nor stub implementations for things that were not
agreed upon.

We could easily either #if defined(CONFIG_SUSPEND_BLOCKERS) or submit
a suspend_blockers.h that just makes everything a no-op, if that's an
acceptable transition vehicle.  I didn't think either were an option
open to us.

> In any case, this is not to suggest that the suspend-blocker bits are
> 'impossible' to merge. I just say that if you start with your most difficult
> feature you should not be surprised to be on the receiving end of a 1000+
> mails flamewar on lkml ;-)

Yeah, I do understand that we're not making it easy for ourselves
here.  I think we hit the point where Rafael and Matthew signed off on
things and thought "aha, linux-pm maintainers are happy, now we're
getting somewhere" only to realize the light at the end of the tunnel
was a bit further out than we anticipated ^^

Brian
