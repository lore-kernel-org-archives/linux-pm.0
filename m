From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 17:46:46 +0200
Message-ID: <201006101746.47035.rjw__38761.0723417767$1276185142$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu> <201006101059.44411.rjw@sisk.pl>
	<20100610135714.GA27848@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100610135714.GA27848@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Felipe Contreras <felipe.contreras@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, david@lang.hm, tytso@mit.edu, Brian Swetland <swetland@google.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, June 10, 2010, Mark Brown wrote:
> On Thu, Jun 10, 2010 at 10:59:43AM +0200, Rafael J. Wysocki wrote:
> 
> > So, for a phone-like system, where you'd generally want to simplify user space,
> > having a "power manager" in the kernel seems to make sense to me.
> 
> I'm not clear where this requirement to simplify user space specifically
> for phones comes from

This isn't a requirement, but something that IMO is reasonable.

> - phones do have pretty substantial software stacks that aren't that far away
> to PCs.

That doesn't seem to be relevant here.

Rafael
