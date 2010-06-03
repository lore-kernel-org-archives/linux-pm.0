From: Ingo Molnar <mingo@elte.hu>
Subject: suspend blockers & Android integration
Date: Thu, 3 Jun 2010 21:30:45 +0200
Message-ID: <20100603193045.GA7188__10016.5930380628$1275593527$gmane$org@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Felipe Balbi <felipe.balbi@nokia.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org


* tytso@mit.edu <tytso@mit.edu> wrote:

> [...] Not only has the source code been made available, but hundreds of 
> engineering hours have been made trying to accomodate the demands of LKML 
> --- and LKML has said no to suspend blockers/wakelocks.

I dont think you are being fair here, at all.

Firstly, the suspend-blockers feature is not being rejected (fixing and 
extending suspend is a worthwile goal), it's just that various different 
schemes have been proposed by the people who'll eventually have to maintain 
that code down the line.

Those reasons seem justified and they are based in praxis that have solved 
similar problems to what Android tries to solve.

Sadly the response from the Android team has been 100% uncompromising: either 
suspend blockers or nothing.

The thing is, if the insertion of 'hundreds of man hours' into discussing a 
feature was technical grounds for upstream inclusion then we'd today have a 
Linux kernel with:

 - STREAMS
 - a kABI
 - modularized ipv4
 - perfmon
 - two dozen CPU schedulers
 - zero-copy stupidly pushed to all the file APIs

... and IMO we'd be off much worse technically.

Lets realize it, Linux is an engineering effort that has literally cost about 
ten thousand man years. That's about a _85 million_ man hours. It takes effort 
to keep that kind of work valuable!

Also, why did the Android team start its contributions with such a difficult 
and controversial kernel feature?

There is absolutely _zero_ technical reason why the Android team should 
present this as as an all-or-nothing effort. Why not merge hw drivers first 
(with suspend blockers commented or stubbed out), to reduce the fork distance?

Really, i myself have controversial kernel features pending all the time. They 
dont go upstream for a few kernel releases - over a year sometimes - and 
sometimes they never go upstream.

But the fact that some feature of mine is pending doesnt give me the right to 
go away sulking, it doesnt mean i will block the whole flow of patches in 
retaliation (as you seem to suggest Google will now have the right to do) - i 
simply try to work it out.

Lets be reasonable and work it all out, ok?

Thanks,

	Ingo
