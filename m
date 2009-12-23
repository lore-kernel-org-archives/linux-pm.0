From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RFC: A proposal for power capping through forced
 idle in the Linux Kernel
Date: Wed, 23 Dec 2009 10:52:39 +0100
Message-ID: <20091223095239.GD24181__14032.213346991$1261562079$gmane$org@elf.ucw.cz>
References: <4352991a0912141511k7f9b8b79y767c693a4ff3bc2b@mail.gmail.com>
	<20091221085713.GA1622@ucw.cz>
	<4352991a0912221315y5ba409cbh26baa5937cdf2f76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4352991a0912221315y5ba409cbh26baa5937cdf2f76@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Salman Qazi <sqazi@google.com>
Cc: Michael Rubin <mrubin@google.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Taliver Heath <taliver@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > OTOH realtime people already have tools you could make good use of:
> > your power capping approach looks like 'high priority idle task that
> > needs to run for 2 seconds every 5 seconds' or something...
> >
> > Talk to rt people?
> 
> At the core of it, you are correct.  However, in our implementation it
> also avoids running when the system is already idle and operates at
> much finer granularities than seconds.

Seconds were examples, I suspect rt kernels need lower granularities,
to.

> Which specific tools are you referring to?  Real-time Linux as a whole
> is a trade off:  one gets predictable latency in exchange for some
> performance.  Any specific contacts that I should direct my inquiries
> to?

I guess Peter and Ingo (added to the Cc)....

Anyway, I guess that what you really want is to be able to change
priority of the idle threads, even making them realtime...
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
