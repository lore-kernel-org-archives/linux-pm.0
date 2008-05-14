From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend, followed by immediate resume
Date: Wed, 14 May 2008 16:42:53 +0200
Message-ID: <20080514144253.GB6260@ucw.cz>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080501214437.0ae618c5@osprey.hogchain.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi!

> I'm trying to get wake-on-lan working on the network driver I maintain
> (atl1), but I can't get my system to suspend to memory long enough to
> test it.  Seems that my system suspends and immediately wakes up again
> without any intervention on my part.  This is with kernel 2.6.25.1, but
> I've always encountered this phenomenon, going back to 2.6.21 when the
> driver was merged into mainline.  I've finally resolved to get to the
> bottom of it, and I'm hoping linux-pm can help.
> 
> To suspend, I execute
> 
> echo mem > /sys/power/state
> 
> and the system actually suspends (as far as I can tell), but within a
> few seconds it wakes up without any intervention on my part.  I've

Check /proc/acpi/wakeup?
						Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
