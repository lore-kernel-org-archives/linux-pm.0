From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...)
Date: Tue, 8 May 2007 02:30:41 +0200
Message-ID: <20070508003041.GD18400@elf.ucw.cz>
References: <20070507204912.GC18400@elf.ucw.cz>
	<Pine.LNX.4.44L0.0705071725400.4301-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0705071725400.4301-100000@iolanthe.rowland.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> It says this near the start:
> 
>  * 		If you change
>  * your hardware while system is suspended... well, it was not good idea;
>  * but it will probably only crash.
> 
> with similar warnings elsewhere.
> 
> This appears to refer to confusion in the kernel after the image is 
> restored; it doesn't seem to mean that you could damage equipment or 
> electrocute yourself.

For electrocuting, see product manual :-). Basically, you have to
unplug PC from AC power physically in order to open it. shutdown -h
now is _not_ enough. For notebooks, remove battery, too.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
