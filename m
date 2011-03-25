From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 25 Mar 2011 23:33:23 +0100
Message-ID: <201103252333.23880.rjw__2277.1420925439$1301092603$gmane$org@sisk.pl>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110325113048.GC29521@elte.hu>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Friday, March 25, 2011, Ingo Molnar wrote:
> 
> * Len Brown <lenb@kernel.org> wrote:
> 
> > > Thus from a maintenance POV APM has not been much of a drag on the x86 
> > > maintainer side. Sure, we do not test it, but that's the case with most of 
> > > the obsolete drivers in the kernel.
> > > 
> > > The principle is that as long as there's no ongoing drag, the cost of 
> > > carrying obsolete drivers is minimal - and the unknown cost of screwing 
> > > someone in a big way by removing hardware support is hard to measure 
> > > reliably. So we are cautious and err on the side of supporting too much 
> > > hardware.
> > 
> > I think this reasoning would apply in 2006, but that was 5 years ago.
> 
> I cited a few real examples:
> 
>  > > Beyond the lack of a upstream-visible feature-removal-schedule entry, we 
>  > > still have an Arcnet driver which hardware was obsoleted by Ethernet in the 
>  > > late 80s, and we still have i486 support and those are *much* older than 
>  > > APM.
> 
> So how does your reasoning not apply to those drivers? There's several which 
> are older than APM support.
> 
> We had this really big battle about x86/Voyager two years ago, which x86 
> subarchitecture literally had just a single user left, and the code was more 
> intrusive than APM. Even there after much flaming the eventual consensus was 
> that we'd accept it back if it was done cleanly, as part of the new-style 
> x86_platform code.
> 
> Given that APM fits into the current PM frameworks there's no such problem here 
> that i can see.

Well, it kind of does but not really. :-)

The main problem with APM is that nobody really works on it and I'm not sure
if there are any active users.  At least no one reports any problems with it,
which is kind of surprising, given the number of chages we've made in the PM
core for the last couple of years.  So quite likely it's just become
non-functional over time anyway, but we have no confirmation.

Thanks,
Rafael
