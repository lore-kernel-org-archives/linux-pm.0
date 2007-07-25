From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: power management in alsa
Date: Wed, 25 Jul 2007 18:41:50 +0000
Message-ID: <20070725184149.GA10173@ucw.cz>
References: <200707251436.59156.ak@suse.de> <s5hejiwwsfn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <s5hejiwwsfn.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-pm@lists.linux-foundation.org, Andi Kleen <ak@suse.de>, perex@suse.cz
List-Id: linux-pm@vger.kernel.org

Hi!

> > I noticed ALSA hda seems to only change PCI power management states
> > of the sound devices on suspend/resume. Is there a reason the device
> > cannot be automatically suspended when nobody has sound opened? 
> 
> I made once the automatic power-control patch for hd-audio, but it was
> possibly racy and a bit messy implementation, so I abandoned it.
> Since then, no one has worked on this issue.

IIRC that patch saved .3W, which is quite significant -- about half of
spinning harddrive. I'd say it is worth the effort.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
