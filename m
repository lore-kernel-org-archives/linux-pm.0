From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.37-rc1+: hibernate regression,
	claims not enough swap space
Date: Thu, 18 Nov 2010 00:18:42 +0100
Message-ID: <201011180018.42858.rjw__21690.4425913983$1290036132$gmane$org@sisk.pl>
References: <20101114052138.GB2189@elf.ucw.cz> <201011162327.27454.rjw@sisk.pl>
	<20101117211917.GA394@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101117211917.GA394@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, November 17, 2010, Pavel Machek wrote:
> Hi!
> 
> > > > > ...but there's enough -- or at least it was enough to fit previous
> > > > > versions. 32-bit machine, so it has highmem.
> > > > > 
> > > > > System is in console mode, very lightly loaded.
> > > > > 
> > > > > Mem:   2054716k total,   736548k used,  1318168k free,    15368k buffers
> > > > > Swap:   779148k total,     2360k used,   776788k free,   546388k cached
> > > > 
> > > > Well, the swap is rather in short supply.  Below the 50% of RAM recommendation.
> > > 
> > > Well, but the biggest image we can write is not 50% of RAM, but 50% of
> > > lowmem... 
> > 
> > No, it is not.  It's been 50% of RAM for a couple of years now. :-)
> 
> 
> 
> 
> > > > > PM: thaw of devices complete after 539.577 msecs
> > > > > PM: writing image.
> > > > > PM: Free swap pages: 194166
> > > > > PM: Not enough free swap
> > > > > Restarting tasks ...
> > > > > 
> > > > > Aha, and it is the new default /sys/power/image_size .. setting it to
> > > > > 0 lets machine hibernate. I guess the new default is very wrong for
> > > > > highmem machine...
> > > > 
> > > > The old default did the wrong thing for everyone with sufficient swap (it made
> > > > the OOM code trigger every time while preparing to create an image), so I think
> > > > the new one it's better overall.
> > > 
> > > OOM? No... image_size of 0 should have written "as small image as
> > > possible"; slow, but should not OOM.
> > 
> > This is not how it works now.  We preallocate memory to create memory pressure,
> > so if image_size is 0, we need to preallocate until we run out of pages that
> > can be freed, which means OOM.
> 
> That's bad, right? Instead of killing 

I'm not sure what you mean.

> Anyway, it does not work at all.
> 
> root@amd:~# echo 300000000 > /sys/power/image_size
> root@amd:~# echo disk > /sys/power/state 
> -su: echo: write error: No space left on device
> 
> (And dmesg full of failed allocations).
> 
> I can write 400M there, and it fails, too.

Well, in that case your swap is smaller than the requested image size, isn't it?

There's a check in there that should catch that and it apparently doesn't work.

Do you have that dmesg by chance?

Rafael
