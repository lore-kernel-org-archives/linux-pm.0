From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [Resend][PATCH] PM: Fix dependencies of
	CONFIG_SUSPEND and CONFIG_HIBERNATION (updated)
Date: Mon, 6 Aug 2007 13:56:22 +0200
Message-ID: <200708061356.23030.rjw__7208.16725302047$1186400895$gmane$org@sisk.pl>
References: <200708051906.22865.rjw@sisk.pl>
	<1186398917.28655.69.camel@johannes.berg>
	<20070806113644.GA1790@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070806113644.GA1790@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

On Monday, 6 August 2007 13:36, Pavel Machek wrote:
> On Mon 2007-08-06 13:15:17, Johannes Berg wrote:
> > On Mon, 2007-08-06 at 12:26 +0200, Pavel Machek wrote:
> > 
> > > Well, so that it does not bitrot? This is few bytes, I'd say, and I
> > > believe we have too many config options already.
> > 
> > This is not an option the user is ever going to see. I think I'd
> > prefer
> 
> Ok, option that users can't set is probably not evil.
> 
> > having two new per-ARCH config symbols though:
> > config SUSPEND_UP_POSSIBLE
> > 	depends on ARCH_SUSPEND_UP_POSSIBLE
> > 
> > and then the architecture gets to define that when it can suspend.
> 
> Looks like a plan.

Hmm, why don't we do the $subject change first (the advantage if it is that
the patch is ready) and then move the necessary definitions to the arch level?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
