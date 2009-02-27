From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Fri, 27 Feb 2009 11:00:37 +0100
Message-ID: <20090227100037.GB4582__2172.23591539568$1235728823$gmane$org@elf.ucw.cz>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090217142001.GB12378@bulgaria.corp.google.com>
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Arve said that the power state was equivalent in idle and suspend, but 
> > that they preferred suspend because it stopped any periodic timers. I'd 
> > be more interested in making sure that unnecessary timers aren't running 
> > than focusing on automatically entering system-wide suspend - Nokia have 
> > been managing this since 2005 with good results.
> 
> We'd totally agree that doing something about periodic timers would be a
> big win.  There's also the situation that the longest ARM linux can sit
> in idle right now is ~2s at a time (Arve can expand on the exact issue
> relating to a 32bit signed nanosecond value somewhere iirc), which we'd
> want to sort out as well.
> 
> Of course that still doesn't address userspace.  Aggressively going to
> suspend lets us compensate for userspace programs that do somewhat silly
> things (I agree that it would be best if they didn't but they do and
> getting *everyone* to write their userspace code to avoid spinning or
> avoid waking up on short-duration timers to poll is a losing battle).

Well, really? AFAICS, we can either

1) Android solution: let the polling code live, and modify everyone
that _really_ wants to run to use wakelocks.

2) Solution proposed here: fix the polling code.

IMNSHO 1) means modifying many applications, too... See android
marked, 50%+ apps request "keep system woke up" capability. Plus it
means modifying _good_ code, and leaving _bad_ code unfixed. So I'd
prefer 2). I believe ammount of work is pretty similar.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
