From: Pavel Machek <pavel@suse.cz>
Subject: Re: [Alsa-devel] swsusp regression (s2dsk) [Was: 2.6.18-rc2-mm1]
Date: Mon, 31 Jul 2006 16:03:05 +0200
Message-ID: <20060731140304.GA3399@elf.ucw.cz>
References: <20060727015639.9c89db57.akpm@osdl.org> <200607301128.04395.rjw@sisk.pl> <44CC8FD3.5030403@gmail.com> <200607301334.38704.rjw@sisk.pl> <s5hodv5an8u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932301AbWGaODU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hodv5an8u.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Jiri Slaby <jirislaby@gmail.com>, Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi!

> > If the driver is compiled in, its .suspend() routine gets called before the
> > suspend image is restored and puts the card in a state that confuses
> > the .resume() called after the image has been restored.
> > 
> > I think snd_emu10k1_suspend() should reset the device if state == PMSG_PRETHAW .
> 
> Hm, do we need such inconsitent behavior?  I mean, for most drivers,
> it doesn't matter whether it's built-in or a module: simply shutdown
> at suspend, and initialize at resume.

That's of course the other (and better) solution.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
