From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 13:33:57 +0100
Message-ID: <20100609123356.GA7340__5700.66048899225$1276087017$gmane$org@sirena.org.uk>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
	<20100606192405.GA7559@infradead.org>
	<AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 06, 2010 at 12:58:10PM -0700, Brian Swetland wrote:
> On Sun, Jun 6, 2010 at 12:24 PM, Christoph Hellwig <hch@infradead.org> wrote:

> > On the other hand I've heard
> > that various hardware vendors or parties closed to them are rather
> > annoyed by their drivers beeing stuck in the android tree - but that
> > can be easily solved by getting removing the suspend blockers (at least
> > temporarily), cleaning up a few bits here and there and getting them in.

> This continues to baffle me.  If we (Google) are such a headache, why
> not just route around us.  The drivers we've written are GPLv2, the
> source is out there for anyone who wants it, etc.  The drivers other
> people have written we have no control over at all. From my point of
> view it'd be an annoyance if somebody took the code we wrote, modified
> it heavily, and pushed it upstream, but fundamentally I can't stop
> that from happening other than by pushing it upstream myself, first.

AFAICT this is purely down to the fact that the vendors producing
Android devices are using the kernel which is shipped with whatever
release they are using so people doing drivers end up getting locked in
to an older kernel with old APIs (independant of Android specifics) and
don't have the resource to redo things for upstream.  Suspend blockers
are one more API update in there, but general kernel development creates
far more.

I was looking at this just today and one thing that it occurs to me
might help is if when you guys rebase your work against upstream you
were to tag the results - at the minute the only "release" Android
kernels are those included in full stack releases so providing more
hints that other kernel versions could be substituted in may help.
