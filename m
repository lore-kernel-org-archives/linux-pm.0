From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Sun, 30 Jul 2006 13:08:47 +0200
Message-ID: <20060730110847.GH1920@elf.ucw.cz>
References: <20060727015639.9c89db57.akpm@osdl.org> <200607300931.07679.rjw@sisk.pl> <44CC68EE.1080208@gmail.com> <200607301128.04395.rjw@sisk.pl> <44CC8FD3.5030403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932263AbWG3LJB@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <44CC8FD3.5030403@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-pm@osdl.org, alsa-devel@alsa-project.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi!

> >Please try to revert git-alsa.patch and see if the emu10k1-related problem
> >goes away.
> 
> Wow, it didn't helped, I find out there is a difference between in-kernel 
> and modules version of the driver. When compiled as modules 
> (loaded/unloaded) suspending (and resuming) is working ok (enabled higmem 
> and preempt back -- still no smp), when compiled in-kernel (see the config 
> diff below), it doesn't resume.

Yes, that sometimes happens. You could work around it by catching
PM_EVENT_PRETHAW message and resetting the hardware in this case. Or
just fix the resume routine.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
