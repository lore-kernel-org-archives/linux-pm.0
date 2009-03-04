From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 4 Mar 2009 15:13:23 +0100
Message-ID: <20090304141323.GB16604@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200903021453.19482.u.luckas@road.de>
	<20090303140215.GD5060@elf.ucw.cz>
	<200903041500.06016.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903041500.06016.u.luckas@road.de>
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

On Wed 2009-03-04 15:00:01, Uli Luckas wrote:
> On Tuesday, 3. March 2009, Pavel Machek wrote:
> > Hi!
> >
> > > > > > And introduce nasty interface, and probably slower too since open()
> > > > > > is time-critical and ioctl() is not? Or do you have benchmarks?
> > > > >
> > > > > No, just specualting as open() needs to do a directory lookup. It
> > > > > also needs to do book keeping. I'd be surprised if open was faster
> > > > > then ioctl.
> > > >
> > > > Unless you measure how much slower it is...
> > >
> > > OK. Opening /dev/null 100000 times readonly takes 365 ms on my machine.
> > > Opening it once and then, 100000 times writing 1 byte takes 32 ms.
> > > Why exactly did you think I had to provide numbers???
> >
> > Arve said:
> > > >> I just checked my phone, and over a 24 hour awake time (370 hours
> > > >> uptime) period, it acquired about 5 million wakelocks (mostly for
> > > >> input events). If these were cache hits, and took as long as my
> > > >> benchmark did, that accounts for 20 seconds of overhead (0.023%
> > > >> of
> > > >> awake, 0.1% of not-idle (5.5h).
> >
> > Ok. 20seconds vs. 200 seconds seems interesting.
> >
> > OTOH... Android seems to do IPC for wakelock manipulation, and that's
> > way higher overhead than open() syscall, so perhaps it is not that
> > critical?
> >
> Is IPC (writing a byte through a pipe/socket) really more expensive than 
> open/close?

Given that on current android it is "send a byte to another process
that does open/write/close"... yes that looks more expensive than
single open.

> here is network packets. You just don't want to open/close a fd for every 
> network packet that you process. Neither for serial data, bluetooth 
> packets, ...

You mix userland and kernel users.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
