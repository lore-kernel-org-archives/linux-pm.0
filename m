From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Sat, 28 Apr 2007 00:25:43 +0200
Message-ID: <20070427222543.GF2994@elf.ucw.cz>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427145212.GO22250@elf.ucw.cz>
	<1177709523.4737.157.camel@nigel.suspend2.net>
	<20070427221234.GE2994@elf.ucw.cz>
	<1177712296.4737.182.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177712296.4737.182.camel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@nigel.suspend2.net>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > NAK. This slows down regular operation, at it is 30 lines for what
> > > > should have been one (or five).
> > > 
> > > Count them. It is one line (an if statement) plus seven lines of
> > > comment.
> > 
> > You count them. Hint... you'll need to read original patch.
> 
> Ah. You're assuming this is the only use of freezer_is_on().

Yes. You need quite good reason for hack like freezer_is_on(), and
this is not it.

> > > > Just place avenrun[0] = avenrun[1] = avenrun[2] = 0 at strategic place
> > > > if you feel strongly about this. Additional points for using Rafael's
> > > > "suspend done" notifier so that you don't have to modify suspend core.
> > > 
> > > =0 might not be right. If you did have a high load average prior to
> > > suspending, not delivering email would be the right thing to do.
> > 
> > Ok, so =0 is not right, but it is better than adding 30lines of junk
> > to the kernel.
> > 
> > NAK on this patch. Original behaviour is acceptable.
> 
> to someone who IIRC correctly recently said he doesn't even use the
> code.

If you want to work with me, learn how to write kernel code, learn
english, and learn how to behave.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
