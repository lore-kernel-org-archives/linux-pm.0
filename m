From: David Brownell <david-b@pacbell.net>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 11:40:34 -0700 (PDT)
Message-ID: <768161.83147.qm__49854.8569078141$1275936316$gmane$org@web180312.mail.gq1.yahoo.com>
References: <1275916830.1645.566.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275916830.1645.566.camel@laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org



--- On Mon, 6/7/10, Peter Zijlstra <peterz@infradead.org> wrote:
> So what's up with this Binder stuff, from what I can see
> its just
> yet-another-CORBA. Why does it need a kernel part at all,
> can't you
> simply run with a user-space ORB instead?
> 
> I really don't get why people keep re-inventing CORBA,


That made me laugh.  Do you realize that one
of the earliest objections to CORBA was "why do
people keep re-inventing RPC" ...  :)

(Simple answer:  the existing stuff didn't solve
enough of the right problems ... and it was easier
(in a political sense) to come up with something
new than to try fixing DCE or ONC (or whatever).
Similar answers may still apply ... last I looked
at CORBA, it didn't standardize desktop integration
(or cell-phone equivalents), and the pure user-space
versions suffered slowdowns when looking up object
bindings.


> there's some really nice (free) ORBs out there,
