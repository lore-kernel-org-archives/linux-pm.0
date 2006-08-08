From: Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 01:53:52 +0200
Message-ID: <20060808235352.GA4751@elf.ucw.cz>
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <suspend2-devel-bounces@lists.suspend2.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com>
List-Unsubscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=unsubscribe>
List-Archive: <http://lists.suspend2.net/lurker/list/suspend2-devel.html>
List-Post: <mailto:suspend2-devel@lists.suspend2.net>
List-Help: <mailto:suspend2-devel-request@lists.suspend2.net?subject=help>
List-Subscribe: <http://lists.suspend2.net/mailman/listinfo/suspend2-devel>,
	<mailto:suspend2-devel-request@lists.suspend2.net?subject=subscribe>
Sender: suspend2-devel-bounces@lists.suspend2.net
Errors-To: suspend2-devel-bounces@lists.suspend2.net
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-pm@osdl.org, LKML <linux-kernel@vger.kernel.org>, Suspend2-devel@lists.suspend2.net, ncunningham@linuxmail.org
List-Id: linux-pm@vger.kernel.org

Hi!

> A few months ago, I installed suspend2 on my laptop.  It worked great for
> a few days, when suddenly my laptop started to get very hot and the fan
> costantly went off, and then I started getting these:

I take it as "if I keep it for a week powered off, it will not do
this".

> ---
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Temperature above threshold
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Temperature above threshold
> 
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU0: Running in modulated clock mode
> 
> Message from syslogd@localhost at Tue Aug  8 16:08:53 2006 ...
> localhost kernel: CPU1: Running in modulated clock mode
> ---

P4 has thermal protection, so you are actually safe.

Nigel is right, this is acpi problem, but I guess we can help it.  Do
you have /proc/acpi/fan? Do you have /proc/acpi/ibm/fan? Can you try
playing with them?

And yes, this should go into bugzilla.kernel.org.

> Recently, I've decided to try out swsusp.  Well, it has been working fine
> for almost a week now.  But unfortunately, I just started to have my fan
> go off constantly, and I'm getting the above messages again (hence why
> the date on the messages is today). Checking out the temp, it's going into
> the high 70C. That's not too bad, but it only happens when suspending
> every night instead of shutting down.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
