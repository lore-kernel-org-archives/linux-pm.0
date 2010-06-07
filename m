From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: suspend blockers & Android integration
Date: Mon, 07 Jun 2010 15:20:30 +0200
Message-ID: <1275916830.1645.566.camel__15217.1073867523$1275916986$gmane$org@laptop>
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
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2010-06-06 at 12:58 -0700, Brian Swetland wrote:
> Somebody will have to broker a deal with the frameworks/apps folks to
> get rid of the binder.  They like it a lot.  Of course if somebody
> built a drop-in replacement for the userspace side that didn't require
> a kernel driver, had the same performance characteristics, solved the
> same problems, etc, they could probably make an argument for it (or
> just provide it as a drop-in replacement for people who want a more
> "pure" linux underneath Android, even if we didn't pick it up). 

So what's up with this Binder stuff, from what I can see its just
yet-another-CORBA. Why does it need a kernel part at all, can't you
simply run with a user-space ORB instead?

I really don't get why people keep re-inventing CORBA, there's some
really nice (free) ORBs out there, like:

  http://www.cs.wustl.edu/~schmidt/TAO.html
