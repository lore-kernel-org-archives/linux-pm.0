From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] Fix forcedeth hibernate/wake-on-lan
	problems
Date: Sat, 31 May 2008 09:20:36 +0200
Message-ID: <20080531072036.GC5405__15070.1584214859$1212329955$gmane$org@ucw.cz>
References: <20080518125715.GA19229@yamamaya.is-a-geek.org>
	<20080525181329.GA5044@yamamaya.is-a-geek.org>
	<20080527062153.GA3651@yamamaya.is-a-geek.org>
	<200805271432.12881.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805271432.12881.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Ayaz Abdulla <aabdulla@nvidia.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Tobias Diedrich <ranma+kernel@tdiedrich.de>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Stephen Hemminger <shemminger@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > The platform_enable_wakeup() hook is still there, but unused.
> 
> The patches to support it (still) haven't been merged.
> 
> 
> > AFAICS this patch should solve the "'ethtool -s eth0 wol g' doesn't
> > suffice, I also have to write magic values into /proc/acpi/wakeup"
> > issue.
> 
> Yeah; under ACPI, PCI does not act like it does everywhere else.
> Nor does wakeup in general.
> 
> After sending patches to fix that for a couple years now, I'm
> well past being tired of doing that.  I suggest it's overdue for
> the ACPI team to get this part of their act together.

I'm afraid you expect too much from the acpi team. If you can't merge
patches yourself, perhaps someone interested (Tobias? me?) can push
them for you?
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
