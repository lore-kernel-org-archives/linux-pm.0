From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 10 Mar 2008 11:00:08 +0100
Message-ID: <20080310100008.GA9520__10218.6966375031$1205147483$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org>
	<20080303231033.GB15255@one.firstfloor.org>
	<20080304040048.GA31562@codemonkey.org.uk>
	<20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
	<924EFEDD5F540B4284297C4DC59F3DEEA77031@orsmsx423.amr.corp.intel.com>
	<20080305070201.0d16cd40@mjolnir.drzeus.cx>
	<20080305094023.6486ebdf@mjolnir.drzeus.cx>
	<20080306092730.4412d085@mjolnir.drzeus.cx>
	<20080309151659.63d54f38@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080309151659.63d54f38@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, linux-pm@lists.linux-foundation.org, Lee Revell <rlrevell@joe-job.com>
List-Id: linux-pm@vger.kernel.org

On Sun 2008-03-09 15:16:59, Pierre Ossman wrote:
> I'm beginning to think this is a lost cause. I've tried several variants, all without satisfactory results.
> 
> In case anyone else has any more ideas, I'll detail what I've found influences the noise:
> 
> 1. C state
> 
> This is the big one. There is no noise as long as C3 is avoided (processor.max_cstate).
> 
> 2. uhci_hcd driver
> 
> USB is somehow involved in this problem. Unloading the uhci_hcd driver almost entirely kills the noise on a 1000 HZ NO_HZ kernel. On a 100 HZ, no NO_HZ kernel, the effect is very small, but still there.

USB keeps processor out of C3 in many cases.

> 4. Battery and AC
> 
> The noise increases with the battery present and also when the AC supply is removed.
>

On battery, some machines swap C3 for "secret" C4, which is slower but
saves power.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
