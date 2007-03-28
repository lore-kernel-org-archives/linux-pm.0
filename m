From: Maxim <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] [3/6] 2.6.21-rc4: known regressions
Date: Thu, 29 Mar 2007 00:26:18 +0200
Message-ID: <200703290026.18555.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703281238.57811.david-b@pacbell.net> <Pine.LNX.4.64.0703281336280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703281336280.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 22:42:00 Linus Torvalds wrote:
> 
> On Wed, 28 Mar 2007, David Brownell wrote:
> >
> > On Wednesday 28 March 2007 9:38 am, Linus Torvalds wrote:
> > 
> > > It's a *device*, dammit. It should save and resume like one (probably as a 
> > > system device). The "set_mode()" etc stuff is at a completely different 
> > > (higher) conceptual level.
> > 
> > Agreed, except about "probably as a system device".
> > 
> > Last I checked, there was no good reason to use sysdev suspend()/resume()
> > rather than platform_device suspend_late()/early_resume().  Which more
> > or less means no good reason to use sysdev in new code...
> 
> I won't disagree - it might well be much nicer to just show it in the 
> "real" device tree. I'm not 100% sure where in the tree it would go, 
> though. It should probably be "inside" the root entry, before any of the 
> PCI buses. It's generally what we've used those "system device" things 
> for, but I agree that it would be better to just make system devices show 
> up early on the regular device list than it is to have them be special 
> cases.
> 
> Bit I think that's a separate (and fairly small) issue compared to the 
> "don't use the clocksource infrastructure as a make-believe suspend/resume 
> mechanism" problem that Maxim's patch had.
> 
> (Maxim, don't take that the wrong way - I think your analysis and patch 
> were great, I just think another organization would be better)

Exactly, I agree completely
I said that my patch was a  temporary fix, and I agree that the best way is to create a new system device
and use its suspend/resume hooks to bring HPET back to life on resume.

> 
> > Also, making HPET use the legacy mode seems like a step backwards.
> 
> I don't think that's actually "legacy" in any sense but the interrupt 
> delivery, where the "legacy mode" bit is not so much that the HPET itself 
> is "legacy" but that it *replaces* legacy devices.
> 
> But I may have misunderstood the thing. I'm an old fart, so I know the old 
> timers much better than I know the new ones ;). Somebody feel free to hit 
> me with the clue-2x4.
> 
> 			Linus
> 

Best regards,
	Maxim Levitsky
