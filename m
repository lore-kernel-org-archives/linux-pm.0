From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Wed, 9 Jun 2010 11:40:27 +0200
Message-ID: <201006091140.28034.rjw__22155.0778755502$1276076487$gmane$org@sisk.pl>
References: <20100603193045.GA7188@elte.hu>
	<alpine.LFD.2.00.1006082042020.4506@i5.linux-foundation.org>
	<AANLkTino9hnqao9402dR543MIlf66qYYjxrknHrxd39o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTino9hnqao9402dR543MIlf66qYYjxrknHrxd39o@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: david@lang.hm, Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 09 June 2010, Felipe Contreras wrote:
> On Wed, Jun 9, 2010 at 6:46 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > On Tue, 8 Jun 2010, david@lang.hm wrote:
> >>
> >> having suspend blockers inside the kernel adds significant complexity, it's
> >> worth it only if the complexity buys you enough. In this case the question is
> >> if the suspend blockers would extend the sleep time enough more to matter. As
> >> per my other e-mail, this is an area with rapidly diminishing returns as the
> >> sleep times get longer.
> >
> > Well, the counter-argument that nobody seems to have brought up is that
> > suspend blockers exist, are real code, and end up being shipped in a lot
> > of machines.
> >
> > That's a _big_ argument in favour of them. Certainly much bigger than
> > arguing against them based on some complexity-arguments for an alternative
> > that hasn't seen any testing at all.
> >
> > IOW, I would seriously hope that this discussion was more about real code
> > that _exists_ and does what people need. It seems to have degenerated into
> > something else.
> >
> > Because in the end, "code talks, bullshit walks". People can complain and
> > suggest alternatives all they want, but you can't just argue. At some
> > point you need to show the code that actually solves the problem.
> 
> That's assuming there is an actual problem, which according to all the
> embedded people except android, there is not.

Yes, there is, but they've decided to ignore it.

> And if there is indeed such a problem (probably not big), it might be
> solved properly by the time suspend blockers are merged, or few
> releases after.

Not quite.  Have you followed all of the discussion, actually?

> Whatever the solution (or workaround) is, it would be nice if it could
> be used by more than just android people, and it would also be nice to
> do it without introducing user-space API that *nobody* likes and might
> be quickly deprecated.

I agree with Linus and I don't have that much of a problem with the API that
people seem to have.  In fact the much-hated user space API is just a char
device driver with 3 ioctls (that can be extended in future if need be) and
the kernel API is acceptable to me.  Yes, there is some overlap between it
and PM QoS, but IMhO that overlap may be reduced over time (eg. by
using PM QoS requirements to implement suspend blockers). 

To me, the question boils down to whether or not we're able to persuade the
Android people to use any other approach (eg. by demonstrating that something
else is actually better), because even if we invent a brilliant new approach,
but Android ends up using its old one anyway, the net result will be as though
we haven't done anything useful.

Rafael
