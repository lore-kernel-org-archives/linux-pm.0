From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 14:17:36 -0700
Message-ID: <200703281417.38655.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703281238.57811.david-b@pacbell.net> <Pine.LNX.4.64.0703281336280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0703281336280.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, Maxim <maximlevitsky@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 1:42 pm, Linus Torvalds wrote:
> 
> I won't disagree - it might well be much nicer to just show it in the 
> "real" device tree. I'm not 100% sure where in the tree it would go, 
> though. It should probably be "inside" the root entry, before any of the 
> PCI buses. 

Mixing "inside" and "before" is a small linguistic clue about
one of the issues with driver model PM.  Off topic here; and
in terms of suspend/resume callback sequencing that answer
shouldn't matter much for HPET (as I understand things).


> It's generally what we've used those "system device" things  
> for, but I agree that it would be better to just make system devices show 
> up early on the regular device list than it is to have them be special 
> cases.

Yes -- where "platform_device" is a regular Joe-Sixpack kind of
device, but "sysdev" is a special case.


> Bit I think that's a separate (and fairly small) issue compared to the 
> "don't use the clocksource infrastructure as a make-believe suspend/resume 
> mechanism" problem that Maxim's patch had.

Agreed -- although isn't it the "clockevent" change which is at issue?

A "clockevent" thingie wraps various kinds of timer IRQs; the clocksource
is conceptually just a free run counter.  Clocksources have been around
for a while, with no particular problems.

It's clockevent sources have been the problem with dynamic tick solutions
all along, since they mask such chaos inside x86 hardware and interact
with so many different parts of the kernel.  ;)

- Dave


> (Maxim, don't take that the wrong way - I think your analysis and patch 
> were great, I just think another organization would be better)
