From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 14:57:15 +0100
Message-ID: <20100610135714.GA27848__3579.48277746818$1276178566$gmane$org@sirena.org.uk>
References: <20100603193045.GA7188@elte.hu> <201006091140.28034.rjw@sisk.pl>
	<20100610080425.6f005dbb@notabene.brown>
	<201006101059.44411.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006101059.44411.rjw@sisk.pl>
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
Cc: Peter Zijlstra <peterz@infradead.org>, Felipe Contreras <felipe.contreras@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, david@lang.hm, tytso@mit.edu, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 10, 2010 at 10:59:43AM +0200, Rafael J. Wysocki wrote:

> So, for a phone-like system, where you'd generally want to simplify user space,
> having a "power manager" in the kernel seems to make sense to me.

I'm not clear where this requirement to simplify user space specifically
for phones comes from - phones do have pretty substantial software
stacks that aren't that far away to PCs.
