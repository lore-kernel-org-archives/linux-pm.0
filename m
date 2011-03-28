From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 23:19:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1103282309290.26754__21969.6735417985$1301348314$gmane$org@pobox.suse.cz>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1103281604040.26754@pobox.suse.cz>
	<20110328174542.GW21838@one.firstfloor.org>
	<4D90CC0B.8070105@zytor.com>
	<20110328182123.GX21838@one.firstfloor.org>
	<AANLkTimqE2YZCH5GonnqeHGGBwzggTymauS1KYuTsqOX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimqE2YZCH5GonnqeHGGBwzggTymauS1KYuTsqOX@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "H. Peter Anvin" <hpa@zytor.com>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 28 Mar 2011, Linus Torvalds wrote:

> > Phasing out APM idle at least would be reasonable.  resumably even if the old
> > laptops still work they are likely on AC because their batteries have
> > long died. So using a bit more power in idle shouldn't be a big
> > issue.
> 
> Agreed. Especially since I'm not at all convinced that APM CPU idling
> ever really worked in the first place.
> 
> And as you say, it's not a catastrophic failure even if we were to
> remove it, and even if it were to have mattered on those old laptops
> years ago. I think we can happily say "not worth worrying about" when
> it comes to APM_CPU_IDLE.
> 
> And shutdown, suspend and screensaver should all be much easier to
> continue to support - they shouldn't have any serious infrastructure
> issues.

APM_CPU_IDLE removal doesn't really sound as a disaster, yes. I doubt 
anyone would even notice.

So deprecating it altogether with planned Len's code reshuffling seems 
like reasonable aproach to me.

_SUSPEND, poweroff and probably _STANDBY are the parts I would care much 
more about.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
