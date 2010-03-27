From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Sat, 27 Mar 2010 08:02:07 +0100
Message-ID: <20100327070207.GQ18689__27187.5830287629$1269673412$gmane$org@elf.ucw.cz>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<20100324204259.GA6423@elf.ucw.cz> <4BAA86E8.5090108@gmail.com>
	<201003252314.33256.rjw@sisk.pl> <4BAC7FC3.50405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4BAC7FC3.50405@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri 2010-03-26 10:34:59, Jiri Slaby wrote:
> On 03/25/2010 11:14 PM, Rafael J. Wysocki wrote:
> > On Wednesday 24 March 2010, Jiri Slaby wrote:
> >> On 03/24/2010 09:42 PM, Pavel Machek wrote:
> >>>> +	if (test_bit(TODO_CLOSED, to_do_flags))
> >>>> +		return -EIO;
> >>>> +
> >>>> +	to_do_buf = buf;
> >>>> +	wmb();
> >>>> +	set_bit(TODO_WORK, to_do_flags);
> >>>> +	wake_up_interruptible(&to_do_wait);
> >>>
> >>> Uhuh, open-coded barriers... these need to be commented, and I guess
> >>> you just should not play this kind of trickery.
> >>
> >> It's just to ensure the to_do_buf store is not reordered with the
> >> set_bit. I wanted to avoid locks as too heavy tools here.
> > 
> > No, please use them, at least in a prototype version.
> > 
> > We can always optimize things out later, but doing optimizations upfront
> > doesn't really work well from my experience.
> > 
> > So, if you'd use a lock somewhere, please use it, or maybe use a completion if
> > that fits the design better.
> 
> That's it, I don't think a lock is appropriate here (I didn't even think
> of that) -- I don't know what to lock (OK, I see it, but it's not that
> clear). There is no potential for race per se, I only need to disable
> reordering (which locks do as a side-effect). I need the steps to be
> done in the A-B order where there is a barrier appropriate. Here, A is
> store to to_do_buf, B is set_bit. It's I set to_do_buf, flag that it may
> be used, the consumer will see the flag and use to_do_buf, in this
> order.

Could you just use same locking user.c uses? It does not really do any
magic...
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
