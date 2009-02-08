From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state	interface
Date: Sun, 8 Feb 2009 22:06:58 +0100
Message-ID: <20090208210658.GF6369@elf.ucw.cz>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902072337.40046.rjw@sisk.pl>
	<20090208103355.GC14143@elf.ucw.cz>
	<200902081450.46584.rjw@sisk.pl>
	<20090208140404.GA22084@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090208140404.GA22084@bulgaria.corp.google.com>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!


> Being in suspend, where periodic user and kernel timers aren't running,
> and random userspace threads aren't possibly spinning, rather than just 
> being in idle in the lowest power possible state, represent a pretty 
> significant power savings.

If kernel timers fire too often, fix them. If user land spins, fix it,
or SIGSTOP.

And yes, autosleep is useful. That's why I done those "sleepy linux"
patches.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
