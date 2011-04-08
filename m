From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 8 Apr 2011 08:25:06 +0200
Message-ID: <20110408062506.GB1596__18782.2816581049$1302244126$gmane$org@ucw.cz>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu> <201103252333.23880.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201103252333.23880.rjw@sisk.pl>
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

Hi!

> > So how does your reasoning not apply to those drivers? There's several which 
> > are older than APM support.
> > 
> > We had this really big battle about x86/Voyager two years ago, which x86 
> > subarchitecture literally had just a single user left, and the code was more 
> > intrusive than APM. Even there after much flaming the eventual consensus was 
> > that we'd accept it back if it was done cleanly, as part of the new-style 
> > x86_platform code.
> > 
> > Given that APM fits into the current PM frameworks there's no such problem here 
> > that i can see.
> 
> Well, it kind of does but not really. :-)
> 
> The main problem with APM is that nobody really works on it and I'm not sure
> if there are any active users.  At least no one reports any problems with it,
> which is kind of surprising, given the number of chages we've made in the PM
> core for the last couple of years.  So quite likely it's just become
> non-functional over time anyway, but we have no confirmation.

It was working ok last time I tried -- cca 6/2010.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
