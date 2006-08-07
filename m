From: Jason Lunz <lunz@gehennom.net>
Subject: Re: swsusp regression [Was: 2.6.18-rc3-mm2]
Date: Mon, 7 Aug 2006 12:23:24 -0400
Message-ID: <20060807162322.GA17564@knob.reflex>
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <44D707B6.20501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932206AbWHGQXh@vger.kernel.org>
In-Reply-To: <44D707B6.20501@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, andre@linux-ide.org, pavel@suse.cz, linux-pm@osdl.org, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In gmane.linux.kernel, you wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/
>
> I tried it and guess what :)... swsusp doesn't work :@.
>
> This time I was able to dump process states with sysrq-t:
> http://www.fi.muni.cz/~xslaby/sklad/ide2.gif
>
> My guess is ide2/2.0 dies (hpt370 driver), since last thing kernel prints is 
> suspending device 2.0

Does it go away if you revert this?
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc3/2.6.18-rc3-mm2/broken-out/ide-reprogram-disk-pio-timings-on-resume.patch

That should only affect resume, not suspend, but it does mess around
with ide power management. Is this maybe happening on the *second*
suspend?

> -hdc: ATAPI 63X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
> +hdc: ATAPI CD-ROM drive, 0kB Cache, UDMA(33)

This looks suspicious. -mm does have several ide-fix-hpt3xx patches.

Jason
