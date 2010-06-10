From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: suspend blockers & Android integration
Date: Thu, 10 Jun 2010 20:01:36 +0100
Message-ID: <20100610190136.GD17945__15550.7878320806$1276196897$gmane$org@opensource.wolfsonmicro.com>
References: <20100603193045.GA7188@elte.hu> <201006101059.44411.rjw@sisk.pl>
	<20100610135714.GA27848@sirena.org.uk>
	<201006101746.47035.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201006101746.47035.rjw@sisk.pl>
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

On Thu, Jun 10, 2010 at 05:46:46PM +0200, Rafael J. Wysocki wrote:
> On Thursday, June 10, 2010, Mark Brown wrote:
> > On Thu, Jun 10, 2010 at 10:59:43AM +0200, Rafael J. Wysocki wrote:

> > > So, for a phone-like system, where you'd generally want to simplify user space,
> > > having a "power manager" in the kernel seems to make sense to me.

> > I'm not clear where this requirement to simplify user space specifically
> > for phones comes from

> This isn't a requirement, but something that IMO is reasonable.

> > - phones do have pretty substantial software stacks that aren't that far away
> > to PCs.

> That doesn't seem to be relevant here.

Sure, that's my point - you seem to be suggesting that phones have a
different requirement here.
