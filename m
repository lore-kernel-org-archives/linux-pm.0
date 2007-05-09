From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Wed, 9 May 2007 10:17:17 +0200
Message-ID: <20070509081717.GA7741@elf.ucw.cz>
References: <200705080047.08319.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0705080949280.3217-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705080949280.3217-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> We give the user a chance to decide how this tradeoff should go when 
> entering hibernation.  Why not also give the user a chance to decide the 
> tradeoff during normal shutdown?
> 
> Yes, it violates the spec in the sense that we would be entering S4 
> without saving a memory image.  

I think you already replied to yourself :-).

There are more reasons, like we getting useless code paths to
debug. So far you demonstrated that S4-on-shutdown is probably
possible, and while violating specs, it should probably work.

What do you expect now? Me jumping with joy and implementing
S4-on-shutdown because it should be possible?

Now... if you feel very strongly about S4-on-shutdown, you may try to
create a patch. If it is not-too-ugly, and if it is really good for
something, we may merge it.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
