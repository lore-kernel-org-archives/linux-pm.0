From: Christoph Hellwig <hch@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 04:03:57 -0400
Message-ID: <20100607080357.GB15851__25908.9317326017$1275897922$gmane$org@infradead.org>
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
> Somebody will have to broker a deal with the frameworks/apps folks to
> get rid of the binder.  They like it a lot.  Of course if somebody
> built a drop-in replacement for the userspace side that didn't require
> a kernel driver, had the same performance characteristics, solved the
> same problems, etc, they could probably make an argument for it (or
> just provide it as a drop-in replacement for people who want a more
> "pure" linux underneath Android, even if we didn't pick it up).

This wasn't really directed at you, but rather about people talking
about running a mainline kernel on Android in this thread.  As I said
this is a lot more work then sorting out the drivers - with or without
suspend blockers.

> The group ID stuff works incredibly well for gating device access --
> we ensure that devices that need access from various processes end up
> with perms like 0660 root audio (say for a raw audio interface), and
> then we assure that processes which have the "may use audio hardware"
> permission are executed with audio as an additional group.  We ended
> up using the same model to control socket, raw socket, and bt socket
> access because at the time we could not find a reasonable way to grant
> or exclude such permissions on a process by process basis.
> Maintaining about 20-30 lines of diffs to make that work was not a bad
> tradeoff (and we don't expect those patches to go upstream).  If
> there's a way to accomplish this without patching the kernel, we're
> all ears.

I'd have to take a look again on how this is implemented in details.
If it's just overriding the capabilities it's really hard to do in
the current model as the capabilities aren't fine grained enough
currently, even with the existing per-file and per-process capabilities.
If it's mostly overriding regular unix file permissions it's easily
doable with ACLs, or in fact just with group ownership at the filesystem
level, without kernel hacks.
