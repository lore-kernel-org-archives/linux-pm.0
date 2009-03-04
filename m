From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Wed, 4 Mar 2009 18:10:58 +0100
Message-ID: <20090304171058.GE18675@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200903041500.06016.u.luckas@road.de>
	<20090304141323.GB16604@elf.ucw.cz>
	<200903041534.02035.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200903041534.02035.u.luckas@road.de>
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

> > > here is network packets. You just don't want to open/close a fd for every
> > > network packet that you process. Neither for serial data, bluetooth
> > > packets, ...
> >
> > You mix userland and kernel users.

> No. I don't.
> The idea of wake locks was to hand locks over from a driver's interrupt all 
> the way to userspace. 
> This is done in an interlocked way to ensure that the device does not suspend 
> from the time of interrupt until userspace has handled the event that caused 
> the interrupt (e.g. A modem sending "RING" on the serial line).
> Basically, in a timerless wake lock implementation userspace has to take a 
> wake lock every time select returns.

Well... in case it is really performance critical, we may want new
syscalls.

Actually, given how deep change of semantics this is, new syscalls may
be good idea.

Or better yet eliminate polling from userspace apps and just avoid
suspending whenever userspace is running (like sleepy patches do).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
