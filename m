From: Christoph Hellwig <hch@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 15:24:05 -0400
Message-ID: <20100606192405.GA7559__31552.0232114524$1275852313$gmane$org@infradead.org>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
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

On Sun, Jun 06, 2010 at 12:15:10PM -0700, Brian Swetland wrote:
> I was shocked when Greg pulled the binder driver and some of the other
> "generic" android drivers into staging, because it was always my
> assumption that nobody upstream would want them.  We did get some
> bugfixes for the binder driver (thanks!) but the general reaction was
> pretty much the same as yours here.  I then was relatively unsurprised
> when it was dropped (we find it useful, upstream finds it useless, not
> much else to say).
> 
> The various SoC peripheral drivers are, I suspect, much less
> contentious (modulo suspend blocker usage and any necessary kernel
> style cleanup).

Yes.  That's what makes me wonder about some parts of the discussion
here.  Getting the drivers for one or more of the android plattforms
in is not a problem.  I'd say it could have easily been done with the
manweeks spent arguing in this and related threads.

The much bigger issues is to get android userspace running on a more
or less vanilla kernel, that is withoutthe  binder, without the rather
interesting group ID based security hack^H^H^H^Hmodel, without the
suspend blocker userspace API and so on, and so on.

So for people who really care about running a mainline kernel on their
android device doing that part first on a generic ARM board in qemu
might be much better first step work.   On the other hand I've heard
that various hardware vendors or parties closed to them are rather
annoyed by their drivers beeing stuck in the android tree - but that
can be easily solved by getting removing the suspend blockers (at least
temporarily), cleaning up a few bits here and there and getting them in.

It's not rocket science to get support for ARM SOC number 1654 into the
mainline kernel.
