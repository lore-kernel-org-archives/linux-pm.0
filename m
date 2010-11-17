From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Wed, 17 Nov 2010 22:19:17 +0100
Message-ID: <20101117211917.GA394__22389.4380535514$1290028816$gmane$org@elf.ucw.cz>
References: <20101114052138.GB2189@elf.ucw.cz> <201011152326.44357.rjw@sisk.pl>
	<20101116052634.GA30449@elf.ucw.cz>
	<201011162327.27454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201011162327.27454.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > ...but there's enough -- or at least it was enough to fit previous
> > > > versions. 32-bit machine, so it has highmem.
> > > > 
> > > > System is in console mode, very lightly loaded.
> > > > 
> > > > Mem:   2054716k total,   736548k used,  1318168k free,    15368k buffers
> > > > Swap:   779148k total,     2360k used,   776788k free,   546388k cached
> > > 
> > > Well, the swap is rather in short supply.  Below the 50% of RAM recommendation.
> > 
> > Well, but the biggest image we can write is not 50% of RAM, but 50% of
> > lowmem... 
> 
> No, it is not.  It's been 50% of RAM for a couple of years now. :-)




> > > > PM: thaw of devices complete after 539.577 msecs
> > > > PM: writing image.
> > > > PM: Free swap pages: 194166
> > > > PM: Not enough free swap
> > > > Restarting tasks ...
> > > > 
> > > > Aha, and it is the new default /sys/power/image_size .. setting it to
> > > > 0 lets machine hibernate. I guess the new default is very wrong for
> > > > highmem machine...
> > > 
> > > The old default did the wrong thing for everyone with sufficient swap (it made
> > > the OOM code trigger every time while preparing to create an image), so I think
> > > the new one it's better overall.
> > 
> > OOM? No... image_size of 0 should have written "as small image as
> > possible"; slow, but should not OOM.
> 
> This is not how it works now.  We preallocate memory to create memory pressure,
> so if image_size is 0, we need to preallocate until we run out of pages that
> can be freed, which means OOM.

That's bad, right? Instead of killing 

Anyway, it does not work at all.

root@amd:~# echo 300000000 > /sys/power/image_size
root@amd:~# echo disk > /sys/power/state 
-su: echo: write error: No space left on device

(And dmesg full of failed allocations).

I can write 400M there, and it fails, too.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
