From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 20:21:23 +0200
Message-ID: <20110328182123.GX21838__13807.0939145566$1301339085$gmane$org@one.firstfloor.org>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1103281604040.26754@pobox.suse.cz>
	<20110328174542.GW21838@one.firstfloor.org>
	<4D90CC0B.8070105@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4D90CC0B.8070105@zytor.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

> Or we phase out the APM effort by only supporting it for poweroff, for
> example.

Phasing out APM idle at least would be reasonable.  resumably even if the old 
laptops still work they are likely on AC because their batteries have
long died. So using a bit more power in idle shouldn't be a big
issue.

Not sure about suspend, screen saver etc. I suppose those could
be kept as frozen legacy features. At least until someone else
wants to redesign those parts too.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
