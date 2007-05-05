From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] suspend/resume debugging: device filter
Date: Sat, 5 May 2007 12:08:55 +0200
Message-ID: <20070505100855.GC25704@elf.ucw.cz>
References: <20070125110501.GA25151@elte.hu> <20070126015536.GA14917@suse.de>
	<20070505092425.GA23125@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20070505092425.GA23125@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Here's a (compile tested only) patch that does this on a per-device 
> > basis, which is smaller, and should work just as well as your patch.
> > 
> > It creates a new file in the power/ directory for every device called 
> > "can_suspend".  Write a '0' to it to prevent that device from being 
> > suspended.
> > 
> > Does this work for you?
> 
> yeah, i was able to use this too to debug suspend/resume problems. But 
> i've added the check to the resume path too - for example sw-suspend 
> does a resume of devices during its suspend cycle, cutting off much of 
> the netconsole output.
> 
> which makes the can_suspend flag mis-named - perhaps rename it to 
> exclude_pm ?

debug_exclude_pm? I do not want people playing with it, then
complaining that they broke the suspend.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
