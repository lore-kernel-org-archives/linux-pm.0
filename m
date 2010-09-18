From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] opp: introduce library for
	device-specific	OPPs
Date: Sat, 18 Sep 2010 11:04:42 +0100
Message-ID: <20100918100442.GB22248__8800.37792162529$1284804361$gmane$org@opensource.wolfsonmicro.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917153643.GC29739@sirena.org.uk> <4C938EE2.1010307@ti.com>
	<20100917155937.GB29596@rakim.wolfsonmicro.main>
	<87hbhnq43x.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87hbhnq43x.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>, Len Brown <len.brown@intel.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Linus Walleij <linus.walleij@stericsson.com>, lkml <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 17, 2010 at 05:37:06PM -0700, Kevin Hilman wrote:
> [trimmed Cc list a bit, as vger bounced my last reply due to header too long]
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> > The enable/disable thing wasn't so noticable in the API itself, it was
> > in the data structures that I found it confusing - the core has a
> > different idea about what's going on with the system as a whole compared
> > to the decision that an individual device is taking.

> Can you clarify your confusion here?  I don't follow the problem you're
> raising.

The confusion is between the enable flag meaning that the operating
point is on the list that can be chosen from and it being the currently
active one.  It's clear once you understand what the API does but the
current naming makes that harder to grasp.

> As I write this, I agree with what Phil pointed out; that 'available' is
> probably the right name for this flag, instead of 'enabled.'

Yup, me too.

> > Sure, I get that bit.  What I meant was that I was expecting something
> > that would say that changes had been made to the enabled/disabled sets
> > and that it'd be a good idea to rescan, especially for cases where the
> > devices change their requirements but the OPPs need to be done over a
> > larger block.

> I guess you're thinking of notifiers, so if the list of available OPPs
> changes, a driver could (re)search to see if a more optimal OPP was
> available?

Yup, or at least some suggestion in the API for how this should be done.

> Certainly sounds possible, but not sure how useful in practice.  OPP
> change decisions are not very often, so any OPP database updates may not
> affect a device OPP change currently in progress, but would take effect
> the next time that device makes an OPP change.

Like I say, the main use case would be when the device itself is not
making the actual operating point decision but is feeding in to a wider
block - if the device implements the decision then it really shouldn't
need to notify itself about it, though I guess it might be handy.

> Either way, this is something that could easily be added if it seems
> useful.

My concern there would be divergent idioms for working with the API.
It'd seem better to start everyone off down the same path if we can
rather than have differences between platforms which make life harder
when moving between mulitple platforms.
