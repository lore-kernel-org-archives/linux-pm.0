From: Pavel Machek <pavel@ucw.cz>
Subject: Re: T60 not coming out of suspend to RAM
Date: Fri, 25 Aug 2006 13:04:41 +0200
Message-ID: <20060825110441.GB8538@elf.ucw.cz>
References: <20060822103731.GC13782@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750771AbWHYLEw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060822103731.GC13782@mellanox.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-pm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> I'm running Linus' git tree on my thinkpad T60.
> It generally seems to work fine after suspend to disk.
> However, the system does not come out of suspend to ram,
> with screen staying blank. I'm looking for hints for debugging this.
> 
> If I set suspend/resume event tracing, I see this in dmesg
> after reboot:
> 
> dmesg -s 1000000 | grep 'hash matches'
>   hash matches drivers/base/power/resume.c:42
>   hash matches device serio2
> 
> serio2 seems to be the psmouse device:
> ls /sys/bus/serio/drivers/psmouse/
> bind bind_mode description serio0 serio2 unbind
> 
> Does this mean the mouse driver blocks the resume?
> 
> I've rebuilt psmouse as a module, unloaded it before suspend, and now
> I see the same behaviour but after reboot:
> dmesg -s 1000000 | grep 'hash matches'
>   hash matches drivers/base/power/resume.c:42
>   hash matches device i2c-9191
> 
> Which is somewhat weird because
> ls /sys/bus/i2c/devices
> does not list any i2c devices
> 
> I could continue disabling stuff - but I am looking in the
> correct place even? How do you debug resume issues?

Yes, disabling stuff is way to go. Just disable everything, and binary
search from there :-).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
