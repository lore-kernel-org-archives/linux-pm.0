From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Sat, 26 Mar 2011 00:35:51 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1103260021410.28928__42.9401793100581$1301114310$gmane$org@x980>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu> <201103252333.23880.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <201103252333.23880.rjw@sisk.pl>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> >  > > Beyond the lack of a upstream-visible feature-removal-schedule entry, we 
> >  > > still have an Arcnet driver which hardware was obsoleted by Ethernet in the 
> >  > > late 80s, and we still have i486 support and those are *much* older than 
> >  > > APM.

> > So how does your reasoning not apply to those drivers? There's several which 
> > are older than APM support.

If we follow-through with the proposed cpuidle changes,
then we'll have to cut APM code.   The problem isn't cutting
the code, it is testing it.  I do have a couple of 15-year old
laptops which include APM support.  However, with ACPI disabled
to enable APM, they don't even boot the upstream kernel today.

> > We had this really big battle about x86/Voyager two years ago, which x86 
> > subarchitecture literally had just a single user left, and the code was more 
> > intrusive than APM. Even there after much flaming the eventual consensus was 
> > that we'd accept it back if it was done cleanly, as part of the new-style 
> > x86_platform code.
> > 
> > Given that APM fits into the current PM frameworks there's no such problem here 
> > that i can see.

Somebody was pushing for Voyager support in the kernel
and was energetic about maintaining it.

cheers,
-Len
