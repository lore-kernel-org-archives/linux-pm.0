From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Tue, 3 Mar 2009 15:02:16 +0100
Message-ID: <20090303140215.GD5060@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902271507.14747.u.luckas@road.de>
	<20090227203252.GB1397@ucw.cz>
	<200903021453.19482.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903021453.19482.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: "swetland@google.com" <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > And introduce nasty interface, and probably slower too since open() is
> > > > time-critical and ioctl() is not? Or do you have benchmarks?
> > >
> > > No, just specualting as open() needs to do a directory lookup. It also
> > > needs to do book keeping. I'd be surprised if open was faster then ioctl.
> >
> > Unless you measure how much slower it is...
> >
> OK. Opening /dev/null 100000 times readonly takes 365 ms on my machine. 
> Opening it once and then, 100000 times writing 1 byte takes 32 ms.
> Why exactly did you think I had to provide numbers???

Arve said:

> >> I just checked my phone, and over a 24 hour awake time (370 hours
> >> uptime) period, it acquired about 5 million wakelocks (mostly for
> >> input events). If these were cache hits, and took as long as my
> >> benchmark did, that accounts for 20 seconds of overhead (0.023%
> >> of
> >> awake, 0.1% of not-idle (5.5h).

Ok. 20seconds vs. 200 seconds seems interesting.

OTOH... Android seems to do IPC for wakelock manipulation, and that's
way higher overhead than open() syscall, so perhaps it is not that
critical?

Hmm ...given that original interface was "open /sys file, write,
close", I can't believe wakelocks are so critical that they are worth
ugly interface.

> > > On the otherhand if you consider ioctl nasty, maybe write() is an option?
> >
> > You want sleepvetos to be automatically unlocked/freed on close and
> > process exit/kill, so neither write nor ioctl is the right interface.
> An application opens a device node and then writes 1s to take the lock and 0s 
> to release it.

For example doing binary 0/1 writes from shell is hard... 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
