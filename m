From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.23] IBM X41 looses time after Suspend2Disk
Date: Mon, 29 Oct 2007 22:24:14 +0100
Message-ID: <20071029212414.GD3692__38815.715062856$1193693214$gmane$org@elf.ucw.cz>
References: <20071029201955.GA1955@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20071029201955.GA1955@titan.lahn.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Hi!

> I have an IBM X41 tablet pc running 2.6.23 with the following problem:
> Suspend2Ram work fine, but when I do a Suspend2Disk (echo disk >
> /sys/power/state), the notebook hangs showing the following lines:
>         Stopping tasks ... done.
>         Shrinking memory... done (49361 pages freed)
>         Freed 197444 kbytes in 0.64 seconds (308.50 MB/s)
>         Suspending console(s)
> 
> When I repeatedly press some keys or move the TrackPoint, the SwSusp
> continues and the notebook powers off.
> On reboot, the notebook resumes but hangs showing the following screen:
>         Stopping tasks ... done.
>         Loading image data pages (62483 pages) ... done
>         Read 249932 kbytes in 18.63 seconds (13.41 MB/s)
>         Suspending console(s)
> 
> Generating interrupts by pressing keys or moving the TrackPoints makes
> the resume continue. But after that, the notebook looses time, xterms
> don't get updated until I press a key, the beeper beeps until I press a
> key, etc.
> 
> Any idea what the problem might be?

Yep, I seen that before. Try "nohz=off".
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
