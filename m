From: Brian Swetland <swetland@google.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 16:37:07 -0700
Message-ID: <AANLkTikR1GyEgC2VLfi0GoSbDAs4xyt9hK1k6bOXtxtH__36145.0291857638$1275953883$gmane$org@mail.gmail.com>
References: <1275834706.7227.545.camel@mulgrave.site>
	<alpine.LFD.2.00.1006061725000.2933@localhost.localdomain>
	<1275844114.7227.552.camel@mulgrave.site>
	<20100606190525.GA20517@infradead.org>
	<AANLkTikKx-gXCGtNo3woHLCpBoEQ7hG9Jbiq3hwUTW_w@mail.gmail.com>
	<20100606192405.GA7559@infradead.org>
	<AANLkTikA0ihlbehyyN-zQ3mN4WmlZJYBSRTYV8SbDhSr@mail.gmail.com>
	<1275916830.1645.566.camel@laptop>
	<AANLkTik-0JRJTEbVkr4LUsnELRuqpmGYrRsMxVZDpz8C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik-0JRJTEbVkr4LUsnELRuqpmGYrRsMxVZDpz8C@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, hackbod@android.com, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 7, 2010 at 4:17 PM, Linus Walleij
<linus.ml.walleij@gmail.com> wrote:
>
> So I would really like to know from the Android people why the
> binder is in the kernel, after all. Could it *theoretically* be in
> userspace, on top of some unix domain sockets, running as a
> real-time scheduled daemon or whatever, still yielding the same
> performance? Or is there some discovered limitation with current
> interfaces, that everybody ought to know? Especially authors of
> D-Bus and TAO etc would be very interested in this I believe.
>
> It's not like I don't understand that it would be hard to move this
> thing to userspace, it's more that I'd like to know how you think it
> would be impacted by that.

Fundamentally, yes, you should be able to replicate the functionality
in userspace.  We considered this during 1.0 development, but it ended
up being a lot of risk (at the point when it was discussed) compared
to using the existing driver that we had.  You almost certainly would
need a central daemon to do some state and permission management as
well as track some of the refcounting, you could use EPIPE on local
sockets to detect remote process termination.  You could even just use
local sockets for high level control and use shared memory for actual
message transport to avoid copy-in-copy-out overhead (another binder
driver feature).

That said, the userspace environment was built up around the binder,
relies on it heavily for all ipc (except for dbus which we use for
bluez because it just hasn't been worth the headache to maintain
alternate ipc patches for bluez), and is performance sensitive (it's
possible that you could achieve similar performance with a suitably
clever userspace implementation making use of shared memory, of
course), and the frameworks/apps folks are happy with it as is (so
talking them into replacing it may be a nontrivial exercise).

I wouldn't mind not having to maintain the kernel driver (well, not
having Arve have to maintain the kernel driver...) but building a
pure-userspace replacement would be a pretty huge undertaking,
especially given all the other work we have just with general kernel
development, bringup, etc.

Since all binder comms in userspace bottlenecks through two small
libraries (one C++, one lighter weight C), in theory you could build a
drop-in replacement and then prove it out, verify correctness and
performance, and make the argument for replacing the existing
implementation.

Debugging binder implementation issues under a full system using many
binder services and patterns like "client A calls service B which
returns and object in service C", is a bit of a nightmare.  I try to
stay far away from it, myself.

Brian
